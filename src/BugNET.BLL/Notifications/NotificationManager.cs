using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Web;
using BugNET.Common;
using log4net;

namespace BugNET.BLL.Notifications
{
    /// <summary>
    /// 
    /// </summary>
    public class NotificationManager
    {
        private static readonly ILog Log = LogManager.GetLogger(typeof(NotificationManager));
        private static NotificationManager _instance;       
        private List<INotificationType> _notificationPlugins;

        // What is being currently notified, and what is awaiting notification.  
        private static readonly Queue<NotificationContext> NotificationQueue = new Queue<NotificationContext>();

        /// <summary>
        /// Initializes a new instance of the <see cref="NotificationManager"/> class.
        /// </summary>
        private NotificationManager()
        {
            LoadNotificationTypes();
        }

        /// <summary>
        /// Gets the instance.
        /// </summary>
        /// <value>The instance.</value>
        public static NotificationManager Instance
        {
            get { return _instance ?? (_instance = new NotificationManager()); }
        }

        /// <summary>
        /// Gets the notification types.
        /// </summary>
        /// <value>The notification types.</value>
        public List<INotificationType> GetNotificationTypes() { return _notificationPlugins; }

        /// <summary>
        /// Loads the notification types from the current assembly.
        /// </summary>
        private void LoadNotificationTypes()
        {
            _notificationPlugins = new List<INotificationType>();
            var asm = GetType().Assembly;

            foreach (var t in asm.GetTypes())
            {
                foreach (var iface in t.GetInterfaces())
                {
                    if (!iface.Equals(typeof (INotificationType))) continue;

                    try
                    {
                        var notificationType = (INotificationType)Activator.CreateInstance(t);
                        _notificationPlugins.Add(notificationType);
                        if (Log.IsDebugEnabled) Log.DebugFormat("Type: {0} Enabled: {1}", notificationType.Name, notificationType.Enabled);      
                        break;
                    }
                    catch (Exception ex) 
                    {
                        if (Log.IsErrorEnabled) Log.Error(string.Format(LoggingManager.GetErrorMessageResource("CouldNotLoadNotificationType"), t.FullName),ex);
                    }
                }
            }
        }

        ///public void SendNotification(string username, string subject, string bodyText, string userDisplayName)
        /// <summary>
        /// Sends the notification.
        /// </summary>
        /// <param name="notificationContext"></param>
        public void SendNotification(NotificationContext notificationContext)
        {
            if (string.IsNullOrEmpty(notificationContext.Username)) throw new ArgumentException("Unable send notification username cannot be null or empty.");
            if (string.IsNullOrEmpty(notificationContext.Subject)) throw new ArgumentException("Unable send notification subject cannot be null or empty.");
            if (string.IsNullOrEmpty(notificationContext.BodyText)) throw new ArgumentException("Unable send notification body text cannot be null or empty.");

            // _NotificationQueue must be protected with Locks
            lock (NotificationQueue)
            {

                // En-queue notification into the send queue
                NotificationQueue.Enqueue(notificationContext);

                // If we only have one notification in the queue we will need to start a new thread
                if (NotificationQueue.Count > 1)
                {

                    // Create and Start a New Thread
                    (new System.Threading.Thread(() =>
                    {

                        // Get the First Notification that need sending from the queue
                        NotificationContext notificationToSend;
                        lock (NotificationQueue)
                        {
                            notificationToSend = NotificationQueue.Dequeue();
                        }

                        // Whilst we still have queued notifications to send, we stay in this thread sending them
                        while (notificationToSend != null)
                        {
                            // In The Thread Send The Notification
                            foreach (var nt in _notificationPlugins.Where(nt => nt.Enabled))
                            {
                                nt.SendNotification(notificationToSend);
                            }

                            // Sleep for 10 seconds, enable the line below to test the queuing of notifications is working correctly
                            //Thread.Sleep(10000);

                            // We attempt to get the next Notification that need sending from the queue
                            lock (NotificationQueue)
                            {

                                // Get a new NotificationToSend if we can, otherwise reset
                                notificationToSend = NotificationQueue.Count > 0 ? NotificationQueue.Dequeue() : null;

                            }
                        }
                    }
                    )).Start();

                }
            }

        }

        /// <summary>
        /// Loads the notification template.
        /// </summary>
        /// <param name="templateName">Name of the template.</param>
        /// <param name="emailFormat"></param>
        /// <returns></returns>
        public string LoadEmailNotificationTemplate(string templateName, EmailFormatType emailFormat)
        {
            var templateKey = (emailFormat == EmailFormatType.Text) ? "" : "HTML";
            var template = LoadNotificationTemplate(string.Concat(templateName, templateKey));
            
            //load template path from host settings
            var path = HostSettingManager.TemplatePath;

            return XmlXslTransform.LoadEmailXslTemplate(template, path);
        }

        /// <summary>
        /// Loads the notification template.
        /// </summary>
        /// <param name="templateName">Name of the template.</param>
        /// <returns></returns>
        public string LoadNotificationTemplate(string templateName)
        {
            return HttpContext.GetGlobalResourceObject("Notifications", templateName) as string;
        }

        /// <summary>
        /// Generates the content of the notification.
        /// </summary>
        /// <param name="template">The template.</param>
        /// <param name="data">The data.</param>
        /// <returns></returns>
        public static string GenerateNotificationContent(string template, Dictionary<string, object> data)
        {
            using(var writer = new System.IO.StringWriter())
            {
                using (System.Xml.XmlWriter xml = new System.Xml.XmlTextWriter(writer))
                {
                    xml.WriteStartElement("root");

                    foreach (DictionaryEntry de in HostSettingManager.GetHostSettings())
                        xml.WriteElementString(string.Concat("HostSetting_", de.Key), de.Value.ToString());

                    foreach (var item in data.Keys)
                    {
                        if (item.StartsWith("RawXml"))
                        {
                            xml.WriteRaw(data[item].ToString());
                        }
                        else if (item.GetType().IsClass)
                        {
                            xml.WriteRaw(data[item].ToXml());
                        }
                        else
                        {
                            xml.WriteElementString(item, data[item].ToString());
                        }
                    }

                    xml.WriteEndElement();

                    return XmlXslTransform.Transform(writer.ToString(), template);
                }   
            }
        }
		
		/// <summary>
        /// Determines whether [is notification type enabled] [the specified notification type].
        /// </summary>
        /// <param name="notificationType">Type of the notification.</param>
        /// <returns>
        /// 	<c>true</c> if [is notification type enabled] [the specified notification type]; otherwise, <c>false</c>.
        /// </returns>
        public static bool IsNotificationTypeEnabled(string notificationType)
        {
            if (string.IsNullOrEmpty(notificationType)) throw new ArgumentNullException("notificationType");

            var notificationTypes = HostSettingManager.Get(HostSettingNames.EnabledNotificationTypes).Split(';');
		    return notificationTypes.Any(s => s.Equals(notificationType));
        }
    }
}
