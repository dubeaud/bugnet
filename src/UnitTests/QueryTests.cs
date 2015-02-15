using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using NUnit.Framework;
using BugNET.BusinessLogicLayer;
using log4net;
using log4net.Config;
using log4net.Appender;

namespace BugNET.UnitTests
{
    /// <summary>
    /// Query Tests
    /// </summary>
    [Category("Business Logic Layer")]
    [TestFixture]
    public class QueryTests : TestCaseWithLog4NetSupport
    {
        private int ProjectId; 
        /// <summary>
        /// Setups this instance.
        /// </summary>
        [SetUp]
        public void Setup()
        {
            ProjectId = 95; //Test Project
            Query testQuery;

            //delete query if it exists
            testQuery = Query.GetQueriesByUsername("Admin", ProjectId).Find(query => query.Name == "Unit Test Query");
            if (testQuery != null)
                Query.DeleteQuery(testQuery.Id);

            testQuery = Query.GetQueriesByUsername("Admin", ProjectId).Find(query => query.Name == "Unit Test Query Update");
            if (testQuery != null)
                Query.DeleteQuery(testQuery.Id);
           
        }

        /// <summary>
        /// Tests the saved query with no custom fields.
        /// </summary>
        [Test]
        public void TestSavedQueryWithNoCustomFields()
        {
            List<QueryClause> queryClauses = new List<QueryClause>();
            queryClauses.Add(new QueryClause("AND", "IssueAssignedUserId", "=", "4446c3a3-2713-4ae9-9306-709a93a7151b", System.Data.SqlDbType.NVarChar, false));
            queryClauses.Add(new QueryClause("AND", "IssueStatusId", "=", "17", System.Data.SqlDbType.Int, false));

            List<Issue> result = Issue.PerformQuery(ProjectId, queryClauses);
            Assert.AreEqual(4, result.Count);
        }

        /// <summary>
        /// Tests the saved or query with no custom fields.
        /// </summary>
        [Test]
        public void TestSavedOrQueryWithNoCustomFields()
        {
            List<QueryClause> queryClauses = new List<QueryClause>();
            queryClauses.Add(new QueryClause("AND", "IssueAssignedUserId", "=", "4446c3a3-2713-4ae9-9306-709a93a7151b", System.Data.SqlDbType.NVarChar, false));
            queryClauses.Add(new QueryClause("OR", "IssueStatusId", "=", "17", System.Data.SqlDbType.Int, false));

            List<Issue> result = Issue.PerformQuery(ProjectId, queryClauses);
            Assert.AreEqual(10, result.Count);
        }

        /// <summary>
        /// Tests the saved AND query custom fields.
        /// </summary>
        [Test]
        public void TestSavedQueryCustomFields()
        {
            List<QueryClause> queryClauses = new List<QueryClause>();
            queryClauses.Add(new QueryClause("AND", "IssueAssignedUserId", "=", "4446c3a3-2713-4ae9-9306-709a93a7151b", System.Data.SqlDbType.NVarChar, false));
            queryClauses.Add(new QueryClause("AND", "Browser", "=", "2", System.Data.SqlDbType.NVarChar, true));

            List<Issue> result = Issue.PerformQuery(ProjectId, queryClauses);
            Assert.AreEqual(2, result.Count);
        }

        /// <summary>
        /// Tests the saved OR query custom fields.
        /// </summary>
        [Test]
        public void TestSavedOrQueryCustomFields()
        {
            List<QueryClause> queryClauses = new List<QueryClause>();
            queryClauses.Add(new QueryClause("AND", "IssueAssignedUserId", "=", "4446c3a3-2713-4ae9-9306-709a93a7151b", System.Data.SqlDbType.NVarChar, false));
            queryClauses.Add(new QueryClause("OR", "Browser", "=", "2", System.Data.SqlDbType.NVarChar, true));

            List<Issue> result = Issue.PerformQuery(ProjectId, queryClauses);
            Assert.AreEqual(6, result.Count);
        }

        /// <summary>
        /// Tests the saved OR query custom fields.
        /// </summary>
        [Test]
        public void TestCreateQuery()
        {
            Query testQuery;

            List<QueryClause> queryClauses = new List<QueryClause>();
            queryClauses.Add(new QueryClause("AND", "IssueAssignedUserId", "=", "4446c3a3-2713-4ae9-9306-709a93a7151b", System.Data.SqlDbType.NVarChar, false));
            queryClauses.Add(new QueryClause("OR", "Browser", "=", "2", System.Data.SqlDbType.NVarChar, true));

            Query.SaveQuery("admin", ProjectId, "Unit Test Query", false, queryClauses);
            
            testQuery = Query.GetQueriesByUsername("Admin", ProjectId).Find(query => query.Name == "Unit Test Query");         
            testQuery = Query.GetQueryById(testQuery.Id);

            Assert.IsNotNull(testQuery);
            Assert.AreEqual(2, testQuery.Clauses.Count);

            //TODO: get queries by username does not return the query clauses....but probably should (its used to populate the drop down list)
        }

        /// <summary>
        /// Tests the delete query.
        /// </summary>
        [Test]
        public void TestDeleteQuery()
        {
            List<QueryClause> queryClauses = new List<QueryClause>();
            queryClauses.Add(new QueryClause("AND", "IssueAssignedUserId", "=", "4446c3a3-2713-4ae9-9306-709a93a7151b", System.Data.SqlDbType.NVarChar, false));
            queryClauses.Add(new QueryClause("OR", "Browser", "=", "2", System.Data.SqlDbType.NVarChar, true));

            Query.SaveQuery("admin", ProjectId, "Unit Test Query Delete", false, queryClauses);
            Query testQuery = Query.GetQueriesByUsername("Admin", ProjectId).Find(query => query.Name == "Unit Test Query Delete");
            Query.DeleteQuery(testQuery.Id);
            testQuery = Query.GetQueriesByUsername("Admin", ProjectId).Find(query => query.Name == "Unit Test Query Delete");

            Assert.IsNull(testQuery);
        }

        /// <summary>
        /// Tests the update query.
        /// </summary>
        [Test]
        public void TestUpdateQuery()
        {
            List<QueryClause> queryClauses = new List<QueryClause>();
            queryClauses.Add(new QueryClause("AND", "IssueAssignedUserId", "=", "4446c3a3-2713-4ae9-9306-709a93a7151b", System.Data.SqlDbType.NVarChar, false));
            queryClauses.Add(new QueryClause("OR", "Browser", "=", "2", System.Data.SqlDbType.NVarChar, true));

            Query.SaveQuery("admin", ProjectId, "Unit Test Query", false, queryClauses);
            Query testQuery = Query.GetQueriesByUsername("Admin", ProjectId).Find(query => query.Name == "Unit Test Query");
            testQuery = Query.GetQueryById(testQuery.Id);
            testQuery.Clauses.Add(new QueryClause("AND", "IssueStatusId", "=", "27", System.Data.SqlDbType.Int, false));
            bool result = Query.UpdateQuery(testQuery.Id, "Admin", ProjectId, "Unit Test Query Update",false, testQuery.Clauses);
            testQuery = Query.GetQueriesByUsername("Admin", ProjectId).Find(query => query.Name == "Unit Test Query Update");
            testQuery = Query.GetQueryById(testQuery.Id);

            Assert.AreEqual(3, testQuery.Clauses.Count);

        }

    }
}
