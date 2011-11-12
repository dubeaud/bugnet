using System;
using System.Collections.Generic;
using System.Data;
using System.Security.Permissions;
using System.Threading;
using System.Web.Script.Serialization;
using System.Web.Script.Services;
using System.Web.Services;
using BugNET.BLL;
using BugNET.Common;
using BugNET.Entities;
using BugNET;

namespace BugNET.Webservices
{
    /// <summary>
    /// Summary description for BugNetServices
    /// </summary>
    [WebService(Namespace = "http://bugnetproject.com/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [ScriptService]
    public class BugNetServices : LogInWebService
    {
        
        /// <summary>
        /// Creates the new issue revision.
        /// </summary>
        /// <param name="revision">The revision.</param>
        /// <param name="issueId">The issue id.</param>
        /// <param name="repository">The repository.</param>
        /// <param name="revisionAuthor">The revision author.</param>
        /// <param name="revisionDate">The revision date.</param>
        /// <param name="revisionMessage">The revision message.</param>
        /// <returns>The new id of the revision</returns>
        [PrincipalPermission(SecurityAction.Demand, Authenticated = true)]
        [WebMethod(EnableSession = true)]
        public bool CreateNewIssueRevision(int revision, int issueId, string repository, string revisionAuthor, string revisionDate, string revisionMessage)
        {
            if (issueId <= 0) throw new ArgumentOutOfRangeException("issueId");

            var projectId = IssueManager.GetById(issueId).ProjectId;

            //authentication checks against user access to project
            if (ProjectManager.GetById(projectId).AccessType == Globals.ProjectAccessType.Private && !ProjectManager.IsUserProjectMember(UserName, projectId))
                throw new UnauthorizedAccessException(string.Format(LoggingManager.GetErrorMessageResource("ProjectAccessDenied"), UserName)); 

            var issueRevision = new IssueRevision() 
                                    {
                                        Revision = revision, IssueId = issueId, 
                                        Author = revisionAuthor, Message = revisionMessage, Repository = repository, 
                                        RevisionDate = revisionDate
                                    };
            return IssueRevisionManager.SaveOrUpdate(issueRevision);
        }

        /// <summary>
        /// Creates the new issue attachment.
        /// </summary>
        /// <param name="issueId">The issue id.</param>
        /// <param name="creatorUserName">Name of the creator user.</param>
        /// <param name="fileName">Name of the file.</param>
        /// <param name="contentType">Type of the content.</param>
        /// <param name="attachment">The attachment.</param>
        /// <param name="size">The size.</param>
        /// <param name="description">The description.</param>
        /// <returns></returns>
        [PrincipalPermission(SecurityAction.Demand, Authenticated = true)]
        [WebMethod(EnableSession = true)]
        public bool CreateNewIssueAttachment(int issueId, string creatorUserName, string fileName, string contentType, byte[] attachment, int size, string description)
        {
            if (issueId <= 0) throw new ArgumentOutOfRangeException("issueId");

            var projectId = IssueManager.GetById(issueId).ProjectId;

            //authentication checks against user access to project
            if (ProjectManager.GetById(projectId).AccessType == Globals.ProjectAccessType.Private && !ProjectManager.IsUserProjectMember(UserName, projectId))
                throw new UnauthorizedAccessException(string.Format(LoggingManager.GetErrorMessageResource("ProjectAccessDenied"), UserName));

            var issueAttachment = new IssueAttachment
            {
                Id = Globals.NEW_ID,
                Attachment = attachment,
                Description = description,
                DateCreated = DateTime.Now,
                ContentType = contentType,
                CreatorDisplayName = string.Empty,
                CreatorUserName = creatorUserName,
                FileName = fileName,
                IssueId = issueId,
                Size = size
            };

            return IssueAttachmentManager.SaveOrUpdate(issueAttachment);
        }


        /// <summary>
        /// Changes the tree node.
        /// </summary>
        /// <param name="categoryId">The category id.</param>
        /// <param name="name">The name.</param>
        [PrincipalPermission(SecurityAction.Demand, Authenticated = true)]
        [WebMethod]
        public void RenameCategory(string categoryId, string name)
        {
            if (string.IsNullOrEmpty(categoryId) || Convert.ToInt32(categoryId) == 0)
                return;
            if (string.IsNullOrEmpty(categoryId))
                throw new ArgumentNullException("categoryId");
            if (string.IsNullOrEmpty(name))
                throw new ArgumentNullException("name");
            //if (string.IsNullOrEmpty(oldText))
            //    throw new ArgumentNullException("oldText");

            Category c = CategoryManager.GetById(Convert.ToInt32(categoryId));
            if (c != null)
            {
                string UserName = Thread.CurrentPrincipal.Identity.Name;
                if (!UserManager.IsInRole(UserName, c.ProjectId, Globals.ProjectAdminRole) && !UserManager.IsInRole(UserName, 0, Globals.SUPER_USER_ROLE))
                    throw new UnauthorizedAccessException(LoggingManager.GetErrorMessageResource("AccessDenied"));

                c.Name = name;
                CategoryManager.SaveOrUpdate(c);
            }

        }

        /// <summary>
        /// Moves the node.
        /// </summary>
        /// <param name="categoryId">The category id.</param>
        /// <param name="oldParentId">The old parent id.</param>
        /// <param name="newParentId">The new parent id.</param>
        [PrincipalPermission(SecurityAction.Demand, Authenticated = true)]
        [WebMethod]
        public void MoveCategory(string categoryId, string oldParentId, string newParentId)
        {          
            if (string.IsNullOrEmpty(categoryId))
                throw new ArgumentNullException("categoryId");
            if (string.IsNullOrEmpty(oldParentId))
                throw new ArgumentNullException("oldParentId");
            if (string.IsNullOrEmpty(newParentId))
                throw new ArgumentNullException("newParentId");
         

            Category c = CategoryManager.GetById(Convert.ToInt32(categoryId));
            if (c != null)
            {
                string UserName = Thread.CurrentPrincipal.Identity.Name;

                if (!UserManager.IsInRole(UserName, c.ProjectId, Globals.ProjectAdminRole) && !UserManager.IsInRole(UserName, 0, Globals.SUPER_USER_ROLE))
                    throw new UnauthorizedAccessException(LoggingManager.GetErrorMessageResource("AccessDenied"));

                c.ParentCategoryId = Convert.ToInt32(newParentId);
                CategoryManager.SaveOrUpdate(c);
            }

        }

        /// <summary>
        /// Gets the categories.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public string GetCategories(string projectId)
        {
            if (string.IsNullOrEmpty(projectId))
                throw new ArgumentNullException("projectId");

            int ProjectId = int.Parse(projectId);
            List<Category> categories = CategoryManager.GetRootCategoriesByProjectId(ProjectId);

            //if (context.User.Identity == null || !context.User.Identity.IsAuthenticated || (!ITUser.HasPermission(context.User.Identity.Name, ProjectId, Globals.Permission.ADMIN_EDIT_PROJECT.ToString()) && !ITUser.IsInRole(context.User.Identity.Name, 0, Globals.SuperUserRole)))
            //    throw new System.Security.SecurityException("Access Denied");


            List<JsTreeNode> nodes = new List<JsTreeNode>();
            PopulateNodes(categories, nodes);
            JavaScriptSerializer js = new JavaScriptSerializer();
            return js.Serialize(nodes);
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
      
        /// <summary>
        /// Adds the Category.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <param name="name">The name.</param>
        /// <param name="parentCategoryId">The parent Category id.</param>
        /// <returns>Id value of the created Category</returns>
        [PrincipalPermission(SecurityAction.Demand, Authenticated = true)]
        [WebMethod(EnableSession = true)]
        public int AddCategory(string projectId, string name, string parentCategoryId)
        {  
            if (string.IsNullOrEmpty(projectId)) throw new ArgumentNullException("projectId");
            if (string.IsNullOrEmpty(name)) throw new ArgumentNullException("name");
            if (string.IsNullOrEmpty(parentCategoryId)) throw new ArgumentNullException("parentCategoryId");

            var validParojectId = 0;
            var validParentCategoryId = 0;

            if(projectId.Is<int>()) validParojectId = int.Parse(projectId);
            if(parentCategoryId.Is<int>()) validParentCategoryId = int.Parse(parentCategoryId);

            var userName = Thread.CurrentPrincipal.Identity.Name; 

            if (!UserManager.IsInRole(userName, Convert.ToInt32(projectId), Globals.ProjectAdminRole) && !UserManager.IsInRole(userName, 0, Globals.SUPER_USER_ROLE))
                throw new UnauthorizedAccessException(LoggingManager.GetErrorMessageResource("AccessDenied"));

            var entity = new Category { ProjectId = validParojectId, ParentCategoryId = validParentCategoryId, Name = name, ChildCount = 0 };
            CategoryManager.SaveOrUpdate(entity);
            return entity.Id;
        }

        /// <summary>
        /// Deletes the Category.
        /// </summary>
        /// <param name="categoryId">The category id.</param>
        [PrincipalPermission(SecurityAction.Demand, Authenticated = true)]
        [WebMethod(EnableSession = true)]
        public void DeleteCategory(string categoryId)
        {
            if (string.IsNullOrEmpty(categoryId))
                throw new ArgumentNullException("categoryId");

            Category c = CategoryManager.GetById(Convert.ToInt32(categoryId));
            if (c != null)
            {
                string UserName = Thread.CurrentPrincipal.Identity.Name;

                if (!UserManager.IsInRole(UserName, c.ProjectId, Globals.ProjectAdminRole) && !UserManager.IsInRole(UserName, 0, Globals.SUPER_USER_ROLE))
                    throw new UnauthorizedAccessException(LoggingManager.GetErrorMessageResource("AccessDenied"));

                if (c.ChildCount > 0)
                    DeleteChildCategoriesByCategoryId(c.Id);

                CategoryManager.Delete(Convert.ToInt32(categoryId));
            }
        }

        /// <summary>
        /// Deletes the child categories by category id.
        /// </summary>
        /// <param name="categoryId">The category id.</param>
        private void DeleteChildCategoriesByCategoryId(int categoryId)
        {
            if (categoryId <= 0)
                throw new ArgumentOutOfRangeException("categoryId");

            Category c = CategoryManager.GetById(categoryId);

            foreach(Category childCategory in CategoryManager.GetChildCategoriesByCategoryId(c.Id))
                CategoryManager.Delete(childCategory.Id);
            
            if (c.ChildCount > 0)
                DeleteChildCategoriesByCategoryId(c.Id);
                  
        }


        #region Methods for BugnetExplorer

        /// <summary>
        /// Returns all resolutions for a project
        /// </summary>
        /// <param name="ProjectId">id of project</param>
        /// <returns>Array of resolutionnames</returns>
        [PrincipalPermission(SecurityAction.Demand, Authenticated = true)]
        [WebMethod(EnableSession = true)]
        public String[] GetResolutions(int ProjectId)
        {
            if (ProjectManager.GetById(ProjectId).AccessType == Globals.ProjectAccessType.Private && !ProjectManager.IsUserProjectMember(UserName, ProjectId))
                throw new UnauthorizedAccessException(string.Format(LoggingManager.GetErrorMessageResource("ProjectAccessDenied"), UserName)); 

            List<Resolution> resolutions = ResolutionManager.GetByProjectId(ProjectId);
            List<String> returnval = new List<String>();
            foreach (Resolution item in resolutions)
            {
                returnval.Add(item.Name.ToString());
            }
            return returnval.ToArray();
        }

        /// <summary>
        /// List of all project milestones
        /// </summary>
        /// <param name="ProjectId">project id</param>
        /// <returns>Array of all milestone names</returns>
        [PrincipalPermission(SecurityAction.Demand, Authenticated = true)]
        [WebMethod(EnableSession = true)]
        public String[] GetMilestones(int ProjectId)
        {
            if (ProjectManager.GetById(ProjectId).AccessType == Globals.ProjectAccessType.Private && !ProjectManager.IsUserProjectMember(UserName, ProjectId))
                throw new UnauthorizedAccessException(string.Format(LoggingManager.GetErrorMessageResource("ProjectAccessDenied"), UserName)); 

            List<Milestone> milestones = MilestoneManager.GetByProjectId(ProjectId);
            List<String> returnval = new List<String>();
            foreach (Milestone item in milestones)
            {
                returnval.Add(item.Name.ToString());
            }
            return returnval.ToArray();

        }

        /// <summary>
        /// List all Issuetypes of a project
        /// </summary>
        /// <param name="ProjectId">project id</param>
        /// <returns>Array of all issue type names</returns>
        [PrincipalPermission(SecurityAction.Demand, Authenticated = true)]
        [WebMethod(EnableSession = true)]
        public String[] GetIssueTypes(int ProjectId)
        {
            if (ProjectManager.GetById(ProjectId).AccessType == Globals.ProjectAccessType.Private && !ProjectManager.IsUserProjectMember(UserName, ProjectId))
                throw new UnauthorizedAccessException(string.Format(LoggingManager.GetErrorMessageResource("ProjectAccessDenied"), UserName));

            List<IssueType> issuetypes = IssueTypeManager.GetByProjectId(ProjectId);
            List<String> returnval = new List<String>();
            foreach (IssueType item in issuetypes)
            {
                returnval.Add(item.Name.ToString());
            }
            return returnval.ToArray();
        }

        /// <summary>
        /// List of all priorities in a project
        /// </summary>
        /// <param name="ProjectId">project id</param>
        /// <returns>Array of all priority names</returns>
        [PrincipalPermission(SecurityAction.Demand, Authenticated = true)]
        [WebMethod(EnableSession = true)]
        public String[] GetPriorities(int ProjectId)
        {
            if (ProjectManager.GetById(ProjectId).AccessType == Globals.ProjectAccessType.Private && !ProjectManager.IsUserProjectMember(UserName, ProjectId))
                throw new UnauthorizedAccessException(string.Format(LoggingManager.GetErrorMessageResource("ProjectAccessDenied"), UserName)); 

            List<Priority> priorites = PriorityManager.GetByProjectId(ProjectId);
            List<String> returnval = new List<String>();
            foreach (Priority item in priorites)
            {
                returnval.Add(item.Name.ToString());
            }
            return returnval.ToArray();
        }

        /// <summary>
        /// List of all categories in a project
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns>Array of all category names</returns>
        //[PrincipalPermission(SecurityAction.Demand, Authenticated = true)]
        //[WebMethod(EnableSession = true)]
        //public String[] GetCategories(int projectId)
        //{
        //    if (Project.GetById(projectId).AccessType == Globals.ProjectAccessType.Private && !Project.IsUserProjectMember(UserName, projectId))
        //        throw new UnauthorizedAccessException(string.Format(Logging.GetErrorMessageResource("ProjectAccessDenied"), UserName)); 

        //    CategoryTree categoriyTree = new CategoryTree();
        //    List<Category> categories = categoriyTree.GetCategoryTreeByProjectId(projectId);
        //    List<String> returnval = new List<String>();
        //    foreach (Category item in categories)
        //    {
        //        returnval.Add(item.Name.ToString());
        //    }
        //    return returnval.ToArray();
        //}

        /// <summary>
        /// List of all status in a project
        /// </summary>
        /// <param name="ProjectId">project id</param>
        /// <returns>Array of all status names</returns>
        [PrincipalPermission(SecurityAction.Demand, Authenticated = true)]
        [WebMethod(EnableSession = true)]
        public String[] GetStatus(int ProjectId)
        {
            if (ProjectManager.GetById(ProjectId).AccessType == Globals.ProjectAccessType.Private && !ProjectManager.IsUserProjectMember(UserName, ProjectId))
                throw new UnauthorizedAccessException(string.Format(LoggingManager.GetErrorMessageResource("ProjectAccessDenied"), UserName)); 

            List<Status> statuslist = StatusManager.GetByProjectId(ProjectId);
            List<String> returnval = new List<String>();
            foreach (Status item in statuslist)
            {
                returnval.Add(item.Name.ToString());
            }
            return returnval.ToArray();
        }


        /// <summary>
        /// Returns the internal ID of a ProjectCode
        /// </summary>
        /// <param name="ProjectCode">Named ProjectCode</param>
        /// <returns>Project ID</returns>
        [PrincipalPermission(SecurityAction.Demand, Authenticated = true)]
        [WebMethod(EnableSession = true)]
        public int GetProjectId(string ProjectCode)
        {
            Project project = ProjectManager.GetByCode(ProjectCode);
            if (project.AccessType == Globals.ProjectAccessType.Private && !ProjectManager.IsUserProjectMember(UserName, project.Id))
                throw new UnauthorizedAccessException(string.Format(LoggingManager.GetErrorMessageResource("ProjectAccessDenied"), UserName)); 

            return project.Id;
        }

        /// <summary>
        /// Gets the project issues.
        /// </summary>
        /// <param name="ProjectId">The project id.</param>
        /// <param name="Filter">The filter.</param>
        /// <returns></returns>
        [PrincipalPermission(SecurityAction.Demand, Authenticated = true)]
        [WebMethod(EnableSession = true)]
        public object[] GetProjectIssues(int ProjectId, string Filter)
        {
            if (ProjectManager.GetById(ProjectId).AccessType == Globals.ProjectAccessType.Private && !ProjectManager.IsUserProjectMember(UserName, ProjectId))
                throw new UnauthorizedAccessException(string.Format(LoggingManager.GetErrorMessageResource("ProjectAccessDenied"), UserName)); 

            List<Issue> issues;
            QueryClause q;
            List<QueryClause> queryClauses = new List<QueryClause>();
            string BooleanOperator = "AND";

            if (Filter.Trim() == "")
            {
                // Return all Issues
                issues = IssueManager.GetByProjectId(ProjectId);
            }
            else
            {
                foreach (string item in Filter.Split('&'))
                {
                    if (item.StartsWith("status=", StringComparison.CurrentCultureIgnoreCase))
                    {
                        if (item.EndsWith("=notclosed", StringComparison.CurrentCultureIgnoreCase))
                        {
                            List<Status> status = StatusManager.GetByProjectId(ProjectId).FindAll(delegate(Status s) { return s.IsClosedState == true; });
                            foreach (Status st in status)
                            {
                                q = new QueryClause(BooleanOperator, "IssueStatusId", "<>", st.Id.ToString(), SqlDbType.Int, false);
                                queryClauses.Add(q);
                            }
                        }
                        else if (item.EndsWith("=new", StringComparison.CurrentCultureIgnoreCase))
                        {
                            q = new QueryClause(BooleanOperator, "AssignedUsername", "=", "none", SqlDbType.NVarChar, false);
                            queryClauses.Add(q);
                            List<Status> status = StatusManager.GetByProjectId(ProjectId).FindAll(delegate(Status s) { return s.IsClosedState == true; });
                            foreach (Status st in status)
                            {
                                q = new QueryClause(BooleanOperator, "IssueStatusId", "<>", st.Id.ToString(), SqlDbType.Int, false);
                                queryClauses.Add(q);
                            }
                        }
                    }
                    else if (item.StartsWith("owner=", StringComparison.CurrentCultureIgnoreCase))
                    {
                        q = new QueryClause(BooleanOperator, "OwnerUsername", "=", item.Substring(item.IndexOf('=') + 1, item.Length - item.IndexOf('=') - 1).ToString(), SqlDbType.NVarChar, false);
                        queryClauses.Add(q);
                    }
                    else if (item.StartsWith("reporter=", StringComparison.CurrentCultureIgnoreCase))
                    {
                        q = new QueryClause(BooleanOperator, "CreatorUsername", "=", item.Substring(item.IndexOf('=') + 1, item.Length - item.IndexOf('=') - 1).ToString(), SqlDbType.NVarChar, false);
                        queryClauses.Add(q);
                    }
                    else if (item.StartsWith("assigned=", StringComparison.CurrentCultureIgnoreCase))
                    {
                        q = new QueryClause(BooleanOperator, "AssignedUsername", "=", item.Substring(item.IndexOf('=') + 1, item.Length - item.IndexOf('=') - 1).ToString(), SqlDbType.NVarChar, false);
                        queryClauses.Add(q);
                    }
                }
                issues = IssueManager.PerformQuery(queryClauses, ProjectId);
            }

            List<Object> issueList = new List<Object>();
            Object[] issueitem;
            foreach (Issue item in issues)
            {
                issueitem = new Object[13];
                issueitem[0] = item.Id;
                issueitem[1] = item.DateCreated;
                issueitem[2] = item.LastUpdate;
                issueitem[3] = item.StatusName;
                issueitem[4] = item.Description;
                issueitem[5] = item.CreatorUserName;
                issueitem[6] = item.ResolutionName;
                issueitem[7] = item.CategoryName;
                issueitem[8] = item.Title;
                issueitem[9] = item.PriorityName;
                issueitem[10] = item.MilestoneName;
                issueitem[11] = item.OwnerUserName;
                issueitem[12] = item.IssueTypeName;
                issueList.Add(issueitem);
            }
            return issueList.ToArray();
        }


        #endregion

       

    }
}
