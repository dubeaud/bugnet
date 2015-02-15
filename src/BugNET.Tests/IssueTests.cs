using System;
using System.Collections.Generic;
using System.Data;
using BugNET.BLL;
using BugNET.Entities;
using NUnit.Framework;

namespace BugNET.Tests
{
    /// <summary>
    /// Issue Unit Tests
    /// </summary>
    [Category("Business Logic Layer")]
    [TestFixture]
    public class IssueTests : TestCaseWithLog4NetSupport
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
        /// Tests the get issue by id.
        /// </summary>
        [Test]
        public void TestGetIssueById()
        {
            Issue i = IssueManager.GetById(IssueId);
            Assert.IsNotNull(i);
        }

        /// <summary>
        /// Tests the get issues by project id.
        /// </summary>
        [Test]
        public void TestGetIssuesByProjectId()
        {
            List<Issue> issues = IssueManager.GetByProjectId(ProjectId);
            Assert.IsTrue(issues.Count > 0);  
        }

        /// <summary>
        /// Tests the delete issue.
        /// </summary>
        [Test]
        public void TestDeleteIssue()
        {
            bool result = IssueManager.Delete(IssueId);
            Assert.IsTrue(result,"No changes were made to the issue");

            Issue issue = IssueManager.GetById(IssueId);
            Assert.IsTrue(issue.Disabled);
        }


        [Test]
        public void TestCreateNewIssueClean()
        {
            Issue issue = new Issue()
            {
                Id = 0,
                ProjectId = 95,
                Title = "This is an issue added from the unit test",
                Description = "This is a new description",
                CategoryId = 409,
                CategoryName = "Category 4",
                PriorityId = 12,
                PriorityName = "High",
                StatusId = 27,
                StatusName = "New Status",
                IssueTypeId = 18,
                IssueTypeName = "Task",
                AssignedDisplayName = "Davin Dubeau",
                AssignedUserId = Guid.Empty,
                AssignedUserName = "Admin",
                MilestoneId = 35,
                MilestoneName = "Release 1",
                AffectedMilestoneId = 35,
                AffectedMilestoneName = "Release 1",
                Visibility = 0,
                TimeLogged = 0,
                Estimation = 34,
                Progress = 55,
                Disabled = false,
                Votes = 1,
                CreatorDisplayName ="Davin Dubeau",
                CreatorUserId = Guid.Empty,
                CreatorUserName = "admin",
                DateCreated = DateTime.Now,
                OwnerDisplayName ="Davin Dubeau",
                OwnerUserId = Guid.Empty,
                OwnerUserName = "admin",
                LastUpdate = DateTime.Now,
                LastUpdateDisplayName ="Davin Dubeau",
                LastUpdateUserName = "admin",
                DueDate = DateTime.MinValue
            };

            //Issue newIssue = new Issue(0, ProjectId, string.Empty, string.Empty, "This is an issue added from the unit test", "This is a new description",
            //    409, "Category 4", 12, "High",
            //    string.Empty, 27, "New Status", string.Empty, 18,
            //    "Task", string.Empty,7, "Fixed", string.Empty,
            //    "admin","Davin Dubeau", Guid.Empty, "Davin Dubeau",
            //    "admin", Guid.Empty,  "Davin Dubeau", "admin", Guid.Empty, DateTime.Now,
            //    35, "Release 1", string.Empty, null, 35, "Release 1",
            //    string.Empty, 0,
            //    0, 0, DateTime.MinValue, DateTime.MinValue, "admin", "Davin Dubeau",
            //    25, false, 0);

            IssueManager.SaveOrUpdate(issue);
            Assert.IsTrue(issue.Id != 0);
            Issue FetchedIssue = IssueManager.GetById(issue.Id);
            Assert.IsNotNull(FetchedIssue);

        }

        /// <summary>
        /// Tests the get issue count by project and category.
        /// </summary>
        [Test]
        public void TestGetIssueCountByProjectAndCategory()
        {
            Assert.IsTrue(IssueManager.GetCountByProjectAndCategoryId(ProjectId, CategoryId) == 31);
        }

        /// <summary>
        /// Tests the get issue type count by project.
        /// </summary>
        [Test]
        public void TestGetIssueTypeCountByProject()
        {
            Assert.IsTrue(IssueManager.GetTypeCountByProjectId(ProjectId).Count > 0);
        }

        /// <summary>
        /// Tests the get issue unscheduled milestone count by project.
        /// </summary>
        [Test]
        public void TestGetIssueUnscheduledMilestoneCountByProject()
        {
            Assert.IsTrue(IssueManager.GetUnscheduledMilestoneCountByProjectId(ProjectId) > 0);
        }

        /// <summary>
        /// Tests the get open issues.
        /// </summary>
        [Test]
        public void TestGetOpenIssues()
        {
            Assert.IsTrue(IssueManager.GetOpenIssues(ProjectId).Count > 0);
        }

        /// <summary>
        /// Tests the get issue changes.
        /// </summary>
        [Test]
        public void TestGetIssueChanges()
        {
            Issue issue1 = IssueManager.GetById(IssueId);
            Issue issue2 = IssueManager.GetById(IssueId);
            issue1.Title = "this title has changed";
            issue1.CategoryId = 476;

            List<IssueHistory> changes = IssueManager.GetIssueChanges(issue2, issue1);
            Assert.IsTrue(changes.Count == 2);
        }

        /// <summary>
        /// Tests the perform query.
        /// </summary>
        [Test]
        public void TestPerformQuery()
        {
            List<QueryClause> clauses = new List<QueryClause>();

            QueryClause q = new QueryClause()
            {
                BooleanOperator = "OR",
                ComparisonOperator = "=",
                DataType = SqlDbType.Int,
                FieldName = "IssueCategoryId",
                FieldValue = null

            };    
            clauses.Add(q);

            q = new QueryClause()
            {
                BooleanOperator = "AND",
                ComparisonOperator = "<>",
                DataType = SqlDbType.Int,
                FieldName = "IssueStatusId",
                FieldValue = "3"

            };

            clauses.Add(q);

            List<Issue> results = IssueManager.PerformQuery(clauses, 96);

            foreach (Issue result in results)
                Console.WriteLine("Id: {1}; Title: {0}", result.Title, result.Id);

            Assert.IsTrue(results.Count > 0);

        }

        /// <summary>
        /// Tests the perform query with custom fields.
        /// </summary>
        [Test]
        public void TestPerformQueryWithCustomFields()
        {
            List<QueryClause> clauses = new List<QueryClause>();

            QueryClause q = new QueryClause()
            {
                BooleanOperator = "AND",
                ComparisonOperator = "=",
                DataType = SqlDbType.Int,
                FieldName = "IssueStatusId",
                FieldValue = "16"

            };        
            clauses.Add(q);

            q = new QueryClause()
            {
                BooleanOperator = "AND",
                ComparisonOperator = "=",
                DataType = SqlDbType.NVarChar,
                FieldName = "Browser",
                FieldValue = "2",
                CustomFieldId = 1
            };   

            clauses.Add(q);

            List<Issue> results = IssueManager.PerformQuery(clauses, 95);

            foreach (Issue result in results)
                Console.WriteLine("Id: {1}; Title: {0}", result.Title, result.Id);

            Assert.IsTrue(results.Count > 0);


        }

    }
}
