using System;
using System.Collections.Generic;
using BugNET.BLL;
using BugNET.Common;
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

                int StartIssueCount = IssueManager.GetByProjectId(p.Id).Count;

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

                    var issue = new Issue
                    {
                        ProjectId = p.Id,
                        Id = Globals.NEW_ID,
                        Title = preTitle + RandomStrings.RandomString(30),
                        CreatorUserName = createdby,
                        DateCreated = DateTime.Now,
                        Description = preDescription + RandomStrings.RandomString(250),
                        DueDate = DateTime.MinValue,
                        IssueTypeId = isst.Id,
                        AffectedMilestoneId = ms.Id,
                        AssignedUserName = assigned,
                        CategoryId = c.Id,
                        MilestoneId = ms.Id,
                        OwnerUserName = createdby,
                        PriorityId = pr.Id,
                        ResolutionId = res.Id,
                        StatusId = st.Id,
                        Estimation = 0,
                        Visibility = 1
                    };

                    IssueManager.SaveOrUpdate(issue);

                    // To return to the unit tests
                    outputIssues.Add(issue);
                }

            }
            return outputIssues;

        }
    }
}