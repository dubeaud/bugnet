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

        /// <summary>
        /// Loads the notification template.
        /// </summary>
        /// <param name="templateName">Name of the template.</param>
        /// <param name="emailFormat"></param>
        /// <returns></returns>
        public static string LoadEmailNotificationTemplate(string templateName, EmailFormatType emailFormat)
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
        public static string LoadNotificationTemplate(string templateName)
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
    }
}
