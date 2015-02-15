using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using NUnit.Framework;
using log4net;
using log4net.Config;
using log4net.Appender;

namespace BugNET.UnitTests
{
    /// <summary>
    /// 
    /// </summary>
    [Category("Logging")]
    [TestFixture]
    public class LoggingTests : TestCaseWithLog4NetSupport
    {
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
    }
}
