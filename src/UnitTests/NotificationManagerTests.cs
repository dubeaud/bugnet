using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using NUnit.Framework;
using BugNET.BusinessLogicLayer;
using BugNET.BusinessLogicLayer.Notifications;
using log4net;
using log4net.Config;
using log4net.Appender;

namespace BugNET.UnitTests
{

    /// <summary>
    /// Notification Manager Tests
    /// </summary>
    [Category("Business Logic Layer")]
    [TestFixture]
    public class NotificationManagerTests
    {
        /// <summary>
        /// Configures the log4 net.
        /// </summary>
        [TestFixtureSetUp]
        public void ConfigureLog4Net()
        {
            XmlConfigurator.Configure();
        }

        /// <summary>
        /// Log4s the net configuration loaded.
        /// </summary>
        [Test]
        public void Log4NetConfigurationLoaded()
        {
            IAppender[] appenders = LogManager.GetRepository().GetAppenders();
            ICollection appenderNames = appenders.Select(appender => appender.Name).ToArray();
            Assert.Contains("AdoNetAppender", appenderNames);
        }

        /// <summary>
        /// Tests the notification manager is single instance.
        /// </summary>
        [Test]
        public void TestNotificationManagerIsSingleInstance()
        {
            Assert.AreSame(NotificationManager.Instance, NotificationManager.Instance);
        }

        /// <summary>
        /// Tests the notification types are initialized.
        /// </summary>
        [Test]
        public void TestNotificationTypesAreInitialized()
        {
            List<INotificationType> notificationTypes = NotificationManager.Instance.GetNotificationTypes();
            ICollection notificationTypeNames = notificationTypes.Select(notificationType => notificationType.Name).ToArray();

            Assert.Contains("Email", notificationTypeNames);
        }   
    }
}
