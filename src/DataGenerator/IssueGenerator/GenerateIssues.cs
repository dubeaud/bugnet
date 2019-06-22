using System;
using System.Collections.Generic;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using IssueGenerator.Helpers;
using BugNET.Entities;
using BugNET.BLL;

namespace IssueGenerator
{
    [TestClass]
    public class GenerateIssues
    {
        /// <summary>
        /// Number of issues to create
        /// </summary>
        const int CNST_NumIssues = 1000;

        public DateTime GetRandomDate()
        {
            TimeSpan timeSpan = DateTime.Today - DateTime.Today.AddMonths(-2);
            var randomTest = new Random();
            TimeSpan newSpan = new TimeSpan(0, randomTest.Next(0, (int)timeSpan.TotalMinutes), 0);
            DateTime newDate = DateTime.Today + newSpan;
            return newDate;
        }

        private int RandomNumber(int min, int max)
        {
            Random random = new Random();
            return random.Next(min, max);
        }
        
        [TestMethod]
        public void CreateRandomIssues()
        {                        

            List<Project> ps = ProjectManager.GetAllProjects();
            if (ps.Count > 0) {

                Project p = ps[1];

                int StartIssueCount = IssueManager.GetByProjectId(p.Id).Count;

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

                    DateTime date = GetRandomDate();

                    Issue iss = new Issue(){ 
                        Id =  0, 
                        ProjectId = p.Id,
                        Title = RandomStrings.RandomString(30),
                        Description = RandomStrings.RandomString(250),
                        CategoryId = c.Id, 
                        PriorityId = pr.Id, 
                        StatusId = st.Id, 
                        IssueTypeId = isst.Id,
                        MilestoneId = ms.Id, 
                        AffectedMilestoneId = ms.Id, 
                        ResolutionId = res.Id,
                        CreatorUserName = createdby,
                        LastUpdateUserName = createdby,
                        OwnerUserName = assigned,
                        AssignedUserName = assigned,
                        DateCreated = date,
                        LastUpdate = date,
                        DueDate = GetRandomDate(),
                        Disabled = false,
                        TimeLogged = RandomNumber(1, 24),
                        Votes = 0
                         
                    };
                    try
                    {

                        IssueManager.SaveOrUpdate(iss);
                    }
                    catch (Exception ex)
                    {
                        Console.WriteLine(ex.Message);
                    }
                }

                int EndIssueCount = IssueManager.GetByProjectId(p.Id).Count;

                // Did we create only CNST_SmallIssues issues?
                Assert.IsTrue(EndIssueCount == StartIssueCount + CNST_NumIssues);
            }
        }
    }
}
