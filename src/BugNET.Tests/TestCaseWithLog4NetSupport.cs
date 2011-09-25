using NUnit.Framework;
using log4net.Config;

namespace BugNET.Tests
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
