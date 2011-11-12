using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel.Activation;
using BugNET.BLL;
using BugNET.Common;
using BugNET.Entities;
using BugNET.Services.DataContracts;
using BugNET.Services.Translators;

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
            
            var i = IssueManager.GetById(id);
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

            var issues = IssueManager.GetByProjectId(projectId);

            return issues.Select(IssueTranslator.ToIssueContract).ToList();
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

            var issueToSave = IssueTranslator.ToIssue(issue);
            return IssueManager.SaveOrUpdate(issueToSave);
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
            //securityContext.PrimaryIdentity.Name

            //IPrincipal principal = Thread.CurrentPrincipal.Identity.Name; 
            //principal.Identity.Name;

            return IssueManager.Delete(issueId);
        }

        #endregion


        /// <summary>
        /// Gets the categories by project id.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public List<JsTreeNode> GetCategoriesByProjectId(string projectId)
        {
            if (string.IsNullOrEmpty(projectId)) throw new ArgumentNullException("projectId");
            if (!projectId.Is<int>()) throw new ArgumentNullException("projectId");

            // TODO: Check authorization
            // if (context.User.Identity == null || !context.User.Identity.IsAuthenticated || (!ITUser.HasPermission(context.User.Identity.Name, ProjectId, Globals.Permission.ADMIN_EDIT_PROJECT.ToString()) && !ITUser.IsInRole(context.User.Identity.Name, 0, Globals.SuperUserRole)))
            //    throw new System.Security.SecurityException("Access Denied");

            var validProjectId = int.Parse(projectId);
            var categories = CategoryManager.GetRootCategoriesByProjectId(validProjectId);

            var nodes = new List<JsTreeNode>();
            PopulateNodes(categories, nodes);
 
            return nodes;
        }

        /// <summary>
        /// Populates the nodes.
        /// </summary>
        /// <param name="list">The list.</param>
        /// <param name="nodes">The nodes.</param>
        private void PopulateNodes(IEnumerable<Category> list, ICollection<JsTreeNode> nodes)
        {

            foreach (var c in list)
            {
                var cnode = new JsTreeNode
                                {
                                    attr =
                                        new Attributes
                                            {id = Convert.ToString(c.Id), rel = "cat" + Convert.ToString(c.Id)},
                                    data = new Data {title = Convert.ToString(c.Name), icon = "../../images/plugin.gif"}
                                };
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
