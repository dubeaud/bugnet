using BugNET.BLL;
using BugNET.Entities;
using NUnit.Framework;

namespace BugNET.Tests
{
    /// <summary>
    /// Unit Tests for Projects
    /// </summary>
    [Category("Business Logic Layer")]
    [TestFixture]
    public class ProjectTests
    {
        private int ProjectId;
        private int IssueId;
        private int CategoryId;
        private int IssueTypeId;
         
        /// <summary>
        /// Inits this instance.
        /// </summary>
        [SetUp]
        public void Init()
        {
            ProjectId = 96;
            IssueId = 24;
            CategoryId = 469;
            IssueTypeId = 9;
        }

        /// <summary>
        /// Tests the get project by id.
        /// </summary>
        [Test]
        public void TestGetProjectById()
        {
            Project p = ProjectManager.GetById(ProjectId);
            Assert.IsNotNull(p);
        }

        /// <summary>
        /// Tests the create new project.
        /// </summary>
        [Test]
        public void TestCreateNewProject()
        {
            Project p = new Project()
            {
               Name = "New Project Name",
               Disabled = false,
               Description = "This is a unit test project"


            };
        }

        /// <summary>
        /// Tests the delete project.
        /// </summary>
        [Test]
        public void TestDeleteProject()
        {

        }

        /// <summary>
        /// Tests the get public project.
        /// </summary>
        [Test]
        public void TestGetPublicProject()
        {
            Assert.IsTrue(ProjectManager.GetPublicProjects().Count > 0);
        }


    }
}
