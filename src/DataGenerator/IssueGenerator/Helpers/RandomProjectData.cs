using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using BugNET.BusinessLogicLayer;
using System.Web.Security;
using BugNET.Providers.MembershipProviders;

namespace IssueGenerator.Helpers
{
    /// <summary>
    /// Returns random data about supplied Project parameters
    /// </summary>
    class RandomProjectData
    {
        private Random rng;
        private Project p;

        public RandomProjectData(Project proj)
        {
            rng = new Random();
            setProject(proj);
        }

        public void setProject(Project proj)
        {
            p = proj;
        }

        /// <summary>
        /// Returns a valid random username.
        /// </summary>
        /// <param name="projectid"></param>
        /// <returns>username</returns>
        public string GetUsername()
        {
            List<ITUser> usrs = ITUser.GetUsersByProjectId(p.Id);
            return usrs[rng.Next(0, usrs.Count)].UserName;          
        }

             
        /// <summary>
        /// Returns a valid project category.
        /// </summary>
        /// <param name="p">A Project</param>
        /// <returns>category</returns>
        public Category GetCategory()
        {
            List<Category> cats = Category.GetCategoriesByProjectId(p.Id);
            return cats[rng.Next(0, cats.Count)];
        }

        /// <summary>
        /// Returns a valid project Milestone.
        /// </summary>
        /// <param name="p">A Project</param>
        /// <returns>Random Milestone</returns>
        public Milestone GetMilestone()
        {
            List<Milestone> miles = Milestone.GetMilestoneByProjectId(p.Id);
            return miles[rng.Next(0, miles.Count)];
        }

        /// <summary>
        /// Returns a valid project Priority.
        /// </summary>
        /// <param name="p">A Project</param>
        /// <returns>Random Priority</returns>
        public Priority GetPriority()
        {
            List<Priority> prs = Priority.GetPrioritiesByProjectId(p.Id);
            return prs[rng.Next(0, prs.Count)];
        }

        /// <summary>
        /// Returns a valid project IssueType.
        /// </summary>
        /// <param name="p">A Project</param>
        /// <returns>Random IssueType</returns>
        public IssueType GetIssueType()
        {
            List<IssueType> IssueTypes = IssueType.GetIssueTypesByProjectId(p.Id);
            return IssueTypes[rng.Next(0, IssueTypes.Count)];
        }


        /// <summary>
        /// Returns a valid project Resolution.
        /// </summary>
        /// <param name="p">A Project</param>
        /// <returns>Random Resolution</returns>
        public Resolution GetResolution()
        {
            List<Resolution> Resolutions = Resolution.GetResolutionsByProjectId(p.Id);
            return Resolutions[rng.Next(0, Resolutions.Count)];
        }


        /// <summary>
        /// Returns a valid project Status.
        /// </summary>
        /// <param name="p">A Project</param>
        /// <returns>Random Status</returns>
        public Status GetStatus()
        {
            List<Status> Statuses = Status.GetStatusByProjectId(p.Id);
            return Statuses[rng.Next(0, Statuses.Count)];
        }



    }
}
