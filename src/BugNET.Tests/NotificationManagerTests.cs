using System.Collections;
using System.Collections.Generic;
using System.Linq;
using BugNET.BLL.Notifications;
using NUnit.Framework;

namespace BugNET.Tests
{

    /// <summary>
    /// Notification Manager Tests
    /// </summary>
    [Category("Business Logic Layer")]
    [TestFixture]
    public class NotificationManagerTests : TestCaseWithLog4NetSupport
    {
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
