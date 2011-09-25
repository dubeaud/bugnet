using System.ServiceModel;
using BugNET.Services;
using BugNET.Services.DataContracts;
using NUnit.Framework;

namespace BugNET.Tests
{
    [Category("Services")]
    [TestFixture]
    public class ServiceTests
    {
        private IBugNetService service;

        /// <summary>
        /// Tests the service initialization.
        /// </summary>
        [TestFixtureSetUp]
        public void Init()
        {
            BasicHttpBinding binding = new BasicHttpBinding();
            //binding.Security.Message.ClientCredentialType = MessageCredentialType.UserName;

            //EndpointAddress endpointAddress = new EndpointAddress("http://localhost:8732/Design_Time_Addresses/BugNET.Services/BugNetServices/");
            EndpointAddress endpointAddress = new EndpointAddress("http://localhost/BugNet/BugNetServices.svc/json");

            ChannelFactory<IBugNetService> factory = new ChannelFactory<IBugNetService>(binding,endpointAddress);

            //factory.Credentials.UserName.UserName = "admin";
            //factory.Credentials.UserName.Password = "password";
            service = factory.CreateChannel();

            Assert.IsNotNull(service);
        }

        /// <summary>
        /// Tests the get issue by id.
        /// </summary>
        [Test]
        public void TestGetIssueById()
        {
            IssueContract issue =  service.GetIssueById(24);
            Assert.IsNotNull(issue);
        }



    }
}
;