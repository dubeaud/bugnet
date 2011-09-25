using System;
using System.Text;
using System.Collections.Generic;
using System.Linq;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using BugNET.BusinessLogicLayer;
using IssueGenerator.Helpers;

namespace IssueGenerator
{
    [TestClass]
    public class GenerateIssues
    {
        /// <summary>
        /// Number of issues to create
        /// </summary>
        const int CNST_NumIssues = 1000;

        
        [TestMethod]
        public void CreateRandomIssues()
        {                        

            List<Project> ps = Project.GetAllProjects();
            if (ps.Count > 0) {

                Project p = ps[0];

                int StartIssueCount = Issue.GetIssuesByProjectId(p.Id).Count;

                RandomProjectData prand = new RandomProjectData(p);

                for (int i = 0; i < CNST_NumIssues; i++)
                {
                    // Get Random yet valid data for the current project
                    Category c = prand.GetCategory();
                    Milestone ms = prand.GetMilestone();
                    Status st = prand.GetStatus();
                    Priority pr = prand.GetPriority();
                    IssueType isst = prand.GetIssueType();
                    Resolution res = prand.GetResolution();

                    string assigned = prand.GetUsername();
                    // creator is also the owner
                    string createdby = prand.GetUsername();

                    Issue iss = new Issue(0, p.Id, RandomStrings.RandomString(30), RandomStrings.RandomString(250), c.Id, pr.Id, st.Id, isst.Id,
                        ms.Id, ms.Id, res.Id,createdby , assigned, createdby, 0, 1, DateTime.MinValue);
                    iss.Save();
                }

                int EndIssueCount = Issue.GetIssuesByProjectId(p.Id).Count;

                // Did we create only CNST_SmallIssues issues?
                Assert.IsTrue(EndIssueCount == StartIssueCount + CNST_NumIssues);
            }
        }
    }
}
