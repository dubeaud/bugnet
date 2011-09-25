using System;
using System.Collections;
using System.Collections.Generic;
using System.Reflection;
using System.Web;
using log4net;

namespace BugNET.BLL.Notifications
{
    /// <summary>
    /// 
    /// </summary>
    public sealed class NotificationManager
    {
        private static readonly ILog Log = LogManager.GetLogger(typeof(NotificationManager));
        private static readonly NotificationManager instance = new NotificationManager();       
        private List<INotificationType> _NotificationPlugins = null;
        private string _Username;
        private string _UserDisplayName;
        private string _Subject;
        private string _BodyText;
		private EmailFormatType _EmailFormatType;

        // What is being currently notified, and what is awaiting notification.  
        private static Queue<NotificationContext> _NotificationQueue = new Queue<NotificationContext>();


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
            get
            {
                return instance;
            }
        }

        /// <summary>
        /// Gets the notification types.
        /// </summary>
        /// <value>The notification types.</value>
        public List<INotificationType> GetNotificationTypes() { return _NotificationPlugins; }

        /// <summary>
        /// Loads the notification types from the current assembly.
        /// </summary>
        private void LoadNotificationTypes()
        {
            _NotificationPlugins = new List<INotificationType>();
            Assembly asm = this.GetType().Assembly;

            foreach (Type t in asm.GetTypes())
            {
                foreach (Type iface in t.GetInterfaces())
                {
                    if (iface.Equals(typeof(INotificationType)))
                    {
                        try
                        {
                            INotificationType notificationType = (INotificationType)Activator.CreateInstance(t);
                            _NotificationPlugins.Add(notificationType);
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
        }

        /// <summary>
        /// Recurses the loaded notification plugins and if enabled will send the notifications using the plugin.
        /// </summary>
        /// <param name="username">The username.</param>
        /// <param name="subject">The subject.</param>
        /// <param name="bodyText">The body text.</param>
        public void SendNotification(string username, string subject, string bodyText)
        {
            SendNotification(username, subject, bodyText, string.Empty);
        }

        /// <summary>
        /// Sends the notification.
        /// </summary>
        /// <param name="username">The username.</param>
        /// <param name="subject">The subject.</param>
        /// <param name="bodyText">The body text.</param>
        /// <param name="userDisplayName">Display name of the user.</param>
        public void SendNotification(string username, string subject, string bodyText, string userDisplayName)
        {
            if (string.IsNullOrEmpty(username))
                throw new ArgumentNullException("username");

            if (string.IsNullOrEmpty(subject))
                throw new ArgumentNullException("subject");

            if (string.IsNullOrEmpty(bodyText))
                throw new ArgumentNullException("bodyText");

            _UserDisplayName = userDisplayName;
            _Username = username;
            _Subject = subject;
            _BodyText = bodyText;

            // _NotificationQueue must be protected with Locks
            lock (_NotificationQueue)
            {

                // En-queue notification into the send queue
                _NotificationQueue.Enqueue(new NotificationContext(_Username, _Subject, _BodyText, _EmailFormatType, _UserDisplayName));

                // If we only have one notification in the queue we will need to start a new thread
                if (_NotificationQueue.Count > 1)
                {

                    // Create and Start a New Thread
                    (new System.Threading.Thread(() =>
                    {

                        // Get the First Notification that need sending from the queue
                        NotificationContext NotificationToSend = null;
                        lock (_NotificationQueue)
                        {
                            NotificationToSend = _NotificationQueue.Dequeue();
                        }

                        // Whilst we still have queued notifications to send, we stay in this thread sending them
                        while (NotificationToSend != null)
                        {

                            // In The Thread Send The Notification
                            foreach (INotificationType nt in _NotificationPlugins)
                            {
                                //if plugin is enabled globally though application settings
                                if (nt.Enabled)
                                    nt.SendNotification(NotificationToSend);
                            }

                            // Sleep for 10 seconds, enable the line below to test the queuing of notifications is working correctly
                            //Thread.Sleep(10000);

                            // We attempt to get the next Notification that need sending from the queue
                            lock (_NotificationQueue)
                            {

                                // Get a new NotificationToSend if we can, otherwise reset
                                if (_NotificationQueue.Count > 0)
                                    NotificationToSend = _NotificationQueue.Dequeue();
                                else
                                    NotificationToSend = null;

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
        /// <param name="emailFormatType">Type of the email format.</param>
        /// <param name="path">The path.</param>
        /// <returns></returns>
        public string LoadEmailNotificationTemplate(string templateName, EmailFormatType emailFormatType)
        {
            string templateKey = (_EmailFormatType == EmailFormatType.Text) ? "" : "HTML";

            string template = LoadNotificationTemplate(string.Concat(templateName, templateKey));
            
            //load template path from host settings
            HostSettingManager mgr = new HostSettingManager();
            string path = mgr.TemplatePath;

            return XmlXslTransform.LoadEmailXslTemplate(template,path);
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
        public string GenerateNotificationContent(string template, Dictionary<string, object> data)
        {
            System.IO.StringWriter writer = new System.IO.StringWriter();
            using (System.Xml.XmlWriter xml = new System.Xml.XmlTextWriter(writer))
            {
                xml.WriteStartElement("root");

                foreach (DictionaryEntry de in HostSettingManager.GetHostSettings())
                    xml.WriteElementString(string.Concat("HostSetting_", de.Key), de.Value.ToString());

                foreach (var item in data.Keys)
                {
                    if (typeof(IToXml).IsAssignableFrom(data[item].GetType()))
                    {
                        IToXml iXml = (IToXml)data[item];
                        xml.WriteRaw(iXml.ToXml());
                    }
                    else if (item.StartsWith("RawXml"))
                    {
                        xml.WriteRaw(data[item].ToString());
                    }
                    else
                    {
                        xml.WriteElementString(item,data[item].ToString());
                    }
                }

                xml.WriteEndElement();

                return XmlXslTransform.Transform(writer.ToString(), template);
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
            if (string.IsNullOrEmpty(notificationType))
                throw new ArgumentNullException("notificationType");

            string[] notificationTypes = HostSettingManager.GetHostSetting("EnabledNotificationTypes").Split(';');
            foreach (string s in notificationTypes)
            {
                if (s.Equals(notificationType))
                    return true;
            }
            return false;
        }
    }
}
