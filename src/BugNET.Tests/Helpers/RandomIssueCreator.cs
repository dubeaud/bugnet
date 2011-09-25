using System;
using System.Collections.Generic;
using BugNET.BLL;
using BugNET.Entities;

namespace BugNET.Tests.Helpers
{
    class RandomIssueCreator
    {
        public static List<Issue> CreateRandomIssues(string preTitle, string preDescription, int numIssues)
        {
            List<Issue> outputIssues = new List<Issue>();
            List<Project> ps = ProjectManager.GetAllProjects();
            if (ps.Count > 0)
            {

                Project p = ps[0];

                int StartIssueCount = IssueManager.GetIssuesByProjectId(p.Id).Count;

                RandomProjectData prand = new RandomProjectData(p);

                for (int i = 0; i < numIssues; i++)
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

                    Issue iss = new Issue(0, p.Id, preTitle + RandomStrings.RandomString(30), preDescription + RandomStrings.RandomString(250), c.Id, pr.Id, st.Id, isst.Id,
                        ms.Id, ms.Id, res.Id, createdby, assigned, createdby, 0, 1, DateTime.MinValue);
                    IssueManager.SaveIssue(iss);

                    // To return to the unit tests
                    outputIssues.Add(iss);
                }

            }
            return outputIssues;

        }
    }
}