using BugNET.DAL;
using NUnit.Framework;

namespace BugNET.Tests
{
    /// <summary>
    /// Data Access Helper Tests
    /// </summary>
    [Category("Data Access Layer")]
    [TestFixture]
    public class DataProviderTests
    {
        /// <summary>
        /// Tests the data access layer is single instance.
        /// </summary>
        [Test]
        public void TestDataProviderIsSingleInstance()
        {
            Assert.AreSame(DataProviderManager.Provider, DataProviderManager.Provider);
        }       
    }
}
