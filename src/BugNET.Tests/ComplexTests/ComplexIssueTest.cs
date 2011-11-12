using System;
using System.Collections.Generic;
using BugNET.BLL;
using BugNET.Entities;
using BugNET.Tests.Helpers;
using NUnit.Framework;

namespace BugNET.Tests
{
    /// <summary>
    /// Complex and intricate Issue Unit Tests
    /// </summary>
    [Category("Business Logic Layer - Complex Test")]
    [TestFixture]
    public class ComplexIssueTest : TestCaseWithLog4NetSupport
    {
        /// <summary>
        /// CONSTANT: Number of issues to create
        /// </summary>
        const int CNST_NumIssues = 100;


        /// <summary>
        /// Creates CNST_NumIssues random issues and verifies. 
        /// Then it deletes the created issues, one-by-one, and verifies.
        /// </summary>
        [Test]
        public void TestCreateRandomNewIssueVerifyThenDelete()
        {
            
            // Davin, please advise if I have gone overboard with the asserts
            int StartIssueCount = -1;
            List<Issue> TestIssues = new List<Issue>();

            List<Project> ps = ProjectManager.GetAllProjects();

            // Sub test
            // Check if the system is ocnfigured
            Assert.IsTrue(ps.Count > 0, "ProjectManager.GetAllProjects() returned nothing");

            // Now get the number of issues in the first project so we can test this later
            // asset passed so we dont need an "if (ps.count > 0)"
            Project p = ps[0];
            StartIssueCount = IssueManager.GetByProjectId(p.Id).Count;

            // Now generate CNST_NumIssues random issues and return them
            TestIssues = RandomIssueCreator.CreateRandomIssues("From Unit Test ", DateTime.Now.ToString() + " Unit Test TestCreateRandomNewIssueVerifyThenDelete() Random Data=", CNST_NumIssues);

            // Sub test
            // Ok verify that we created at least one issue
            Assert.IsTrue(TestIssues.Count > 0, "No Issues were randomly created ");

            // There is now one or more issue present. 
            // Since all issues were created in the same project, we use the first
            // projectID
            int pid = TestIssues[0].ProjectId;

            // Get the number of issues in the first project now.
            int EndIssueCount = IssueManager.GetByProjectId(pid).Count;

            // Sub Test
            // Did we create only CNST_SmallIssues issues?
            string strAssert = string.Format("The test did not create {0} Issues. StartCount={1} EndCount={2}", CNST_NumIssues.ToString(), StartIssueCount.ToString(), EndIssueCount.ToString());
            Assert.IsTrue(EndIssueCount == StartIssueCount + CNST_NumIssues, strAssert);

            // Verify the same issues are in the database
            Issue tstIssue;
            foreach (Issue iss in TestIssues)
            {
                // Retrieve the same Issue.ID from the database
                tstIssue = IssueManager.GetById(iss.Id);

                // Sub Tests
                // Now check it
                //
                // Cant i use reflection?

                Assert.IsTrue(tstIssue.Title == iss.Title);
                Assert.IsTrue(tstIssue.Description == iss.Description);


                Assert.IsTrue(tstIssue.Id == iss.Id);
                Assert.IsTrue(tstIssue.IsClosed == iss.IsClosed);
                Assert.IsTrue(tstIssue.IssueTypeId == iss.IssueTypeId);
                Assert.IsTrue(tstIssue.IssueTypeImageUrl == iss.IssueTypeImageUrl);
                Assert.IsTrue(tstIssue.IssueTypeName == iss.IssueTypeName);
                Assert.IsTrue(tstIssue.LastUpdate == iss.LastUpdate);
                Assert.IsTrue(tstIssue.LastUpdateDisplayName == iss.LastUpdateDisplayName);
                Assert.IsTrue(tstIssue.LastUpdateUserName == iss.LastUpdateUserName);
                Assert.IsTrue(tstIssue.MilestoneDueDate == iss.MilestoneDueDate);
                Assert.IsTrue(tstIssue.MilestoneId == iss.MilestoneId);

                Assert.IsTrue(tstIssue.AffectedMilestoneId == iss.AffectedMilestoneId);
                Assert.IsTrue(tstIssue.AffectedMilestoneImageUrl == iss.AffectedMilestoneImageUrl);
                Assert.IsTrue(tstIssue.AffectedMilestoneName == iss.AffectedMilestoneName);

            }

            // Delete Issues
            foreach (Issue iss in TestIssues)
            {
                IssueManager.Delete(iss.Id);
            }


            // Get the number of issues in the first project now.
            int AfterDeleteIssueCount = IssueManager.GetByProjectId(pid).Count;

            // Sub Test
            // Are they gone?
            strAssert = string.Format("The test did not delete {0} Issues. StartCount={1} AfterDeleteIssueCount={2}", CNST_NumIssues.ToString(), StartIssueCount.ToString(), AfterDeleteIssueCount.ToString());
            Assert.IsTrue(EndIssueCount - CNST_NumIssues == AfterDeleteIssueCount, strAssert);

            // we can now test each one to see if it gone if we like ... not implemented yet


        }


    }
}
