using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using NUnit.Framework;
using log4net.Config;

namespace BugNET.UnitTests
{
    public class TestCaseWithLog4NetSupport
    {
        [TestFixtureSetUp]
        public void ConfigureLog4Net()
        {
            XmlConfigurator.Configure();
        }
    }
}
