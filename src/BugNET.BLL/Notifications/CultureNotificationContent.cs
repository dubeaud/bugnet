using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Threading;

namespace BugNET.BLL.Notifications
{
    public class CultureNotificationContent
    {
        private string _currentCulture;

        /// <summary>
        /// The current Culture code for the content being loaded
        /// </summary>
        public string CultureString { get; internal set; }

        /// <summary>
        /// The loaded contents
        /// </summary>
        public IList<CultureContent> CultureContents { get; set; }

        public CultureNotificationContent()
        {
            CultureContents = new List<CultureContent>();
        }

        /// <summary>
        /// Load the notification content based on the culture
        /// </summary>
        /// <param name="cultureString">The culture to load the content for</param>
        /// <param name="contentKeys">The content keys (these would be the Name value in resource files)</param>
        /// <returns></returns>
        public CultureNotificationContent LoadContent(string cultureString, params string[] contentKeys)
        {
            if (string.IsNullOrWhiteSpace(cultureString)) throw new ArgumentNullException("cultureString");
            if (contentKeys == null) throw new ArgumentNullException("contentKeys");

            CultureString = cultureString;

            SetCultureThread();

            var item = new CultureNotificationContent{CultureString = cultureString};

            foreach (var key in contentKeys)
            {
                var content = item.CultureContents.FirstOrDefault(p => p.CultureString == cultureString && p.ContentKey == key);

                if (content != null) continue;

                var contentString = NotificationManager.LoadNotificationTemplate(key);

                if (contentString.EndsWith(".xslt"))
                {
                    contentString = NotificationManager.LoadXsltNotificationTemplate(contentString);
                }

                item.CultureContents.Add(new CultureContent
                    {
                        ContentKey = key,
                        CultureString = cultureString,
                        Content = contentString
                    });
            }

            ResetCultureThread();

            return item;
        }

        private void SetCultureThread()
        {
            // store the current culture
            _currentCulture = Thread.CurrentThread.CurrentUICulture.Name;

            // no culture string use what is configured
            if (string.IsNullOrWhiteSpace(CultureString)) return;

            // if the same as current no change needed
            if (_currentCulture.ToLower() == CultureString.ToLower()) return;

            // set the culture to the string
            Thread.CurrentThread.CurrentUICulture = CultureInfo.CreateSpecificCulture(CultureString);
        }

        private void ResetCultureThread()
        {
            // set the culture to the original setting
            Thread.CurrentThread.CurrentUICulture = CultureInfo.CreateSpecificCulture(_currentCulture);
        }
    }
}