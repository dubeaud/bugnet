using System;
using System.Collections.Generic;
using System.ServiceModel.Activation;
using BugNET.BLL;
using BugNET.Entities;
using BugNET.Services.DataContracts;
using BugNET.Services.Translators;
using System.Security.Permissions;

namespace BugNET.Services
{
    /// <summary>
    /// Service layer for BugNET
    /// </summary>
    [AspNetCompatibilityRequirements(RequirementsMode = AspNetCompatibilityRequirementsMode.Allowed)]
    public class BugNetServices : IBugNetService
    {
        
        #region IBugNetService Members

        /// <summary>
        /// Gets the issue by id.
        /// </summary>
        /// <param name="id">The id.</param>
        /// <returns></returns>
        public IssueContract GetIssueById(int id)
        {
            if(id <= 0 )
                throw new ArgumentOutOfRangeException("id");

            //TODO: Check authorization
            
            Issue i = IssueManager.GetIssueById(id);
            return IssueTranslator.ToIssueContract(i);
        }

        /// <summary>
        /// Gets the issues by project id.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public List<IssueContract> GetIssuesByProjectId(int projectId)
        {
            if (projectId <= 0)
                throw new ArgumentOutOfRangeException("projectId");


            //TODO: Check authorization

            List<IssueContract> returnIssues = new List<IssueContract>();

            List<Issue> issues = IssueManager.GetIssuesByProjectId(projectId);
            foreach (Issue i in issues)
                returnIssues.Add(IssueTranslator.ToIssueContract(i));

            return returnIssues;
        }

        /// <summary>
        /// Saves the issue.
        /// </summary>
        /// <param name="issue">The issue.</param>
        /// <returns></returns>
        public bool SaveIssue(IssueContract issue)
        {
            if (issue == null)
                throw new ArgumentNullException("issue");

            //TODO: Check authorization

            Issue issueToSave = IssueTranslator.ToIssue(issue);
            return IssueManager.SaveIssue(issueToSave);
        }

        /// <summary>
        /// Deletes the issue.
        /// </summary>
        /// <param name="issueId">The issue id.</param>
        /// <returns></returns>
        public bool DeleteIssue(int issueId)
        {
            if (issueId <= 0)
                throw new ArgumentOutOfRangeException("issueId");

            //TODO: Check the users security to perform this action
            System.ServiceModel.ServiceSecurityContext securityContext = System.ServiceModel.ServiceSecurityContext.Current;
            //securityContext.PrimaryIdentity.Name

            //IPrincipal principal = Thread.CurrentPrincipal.Identity.Name; 
            //principal.Identity.Name;

            return IssueManager.DeleteIssue(issueId);
        }

        #endregion


        /// <summary>
        /// Gets the categories by project id.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public List<JsTreeNode> GetCategoriesByProjectId(string projectId)
        {
            if (string.IsNullOrEmpty(projectId))
                throw new ArgumentNullException("projectId");

            //TODO: Check authorization

            int ProjectId = int.Parse(projectId);
            List<Category> categories = CategoryManager.GetRootCategoriesByProjectId(ProjectId);

            //if (context.User.Identity == null || !context.User.Identity.IsAuthenticated || (!ITUser.HasPermission(context.User.Identity.Name, ProjectId, Globals.Permission.ADMIN_EDIT_PROJECT.ToString()) && !ITUser.IsInRole(context.User.Identity.Name, 0, Globals.SuperUserRole)))
            //    throw new System.Security.SecurityException("Access Denied");


            List<JsTreeNode> nodes = new List<JsTreeNode>();
            PopulateNodes(categories, nodes);
 
            return nodes;
        }

        /// <summary>
        /// Populates the nodes.
        /// </summary>
        /// <param name="list">The list.</param>
        /// <param name="nodes">The nodes.</param>
        private void PopulateNodes(List<Category> list, List<JsTreeNode> nodes)
        {

            foreach (Category c in list)
            {
                JsTreeNode cnode = new JsTreeNode();
                cnode.attr = new Attributes();
                cnode.attr.id = Convert.ToString(c.Id);
                cnode.attr.rel = "cat" + Convert.ToString(c.Id);
                cnode.data = new Data();
                cnode.data.title = Convert.ToString(c.Name);
                cnode.data.icon = "../../images/plugin.gif";
                //cnode.attributes.mdata = "{ draggable : true, max_children : 100, max_depth : 100 }";

                nodes.Add(cnode);

                if (c.ChildCount > 0)
                {

                    PopulateSubLevel(c.Id, cnode);
                }
            }
        }

        /// <summary>
        /// Populates the sub level.
        /// </summary>
        /// <param name="parentid">The parentid.</param>
        /// <param name="parentNode">The parent node.</param>
        private void PopulateSubLevel(int parentid, JsTreeNode parentNode)
        {
            PopulateNodes(CategoryManager.GetChildCategoriesByCategoryId(parentid), parentNode.children);
        }
    }
    
}
