using System.Collections.Generic;
using System.ServiceModel;
using System.ServiceModel.Web;
using BugNET.Entities;
using BugNET.Services.DataContracts;
using System.Security.Permissions;

namespace BugNET.Services
{
   
   [ServiceContract(Namespace = "http://bugnetproject.com/2011/06/v1")]
   
    public interface IBugNetService
    {
        #region Issue Methods
        /// <summary>
        /// Gets the issue by id.
        /// </summary>
        /// <param name="id">The id.</param>
        /// <returns></returns>
        [OperationContract]
        IssueContract GetIssueById(int id);

        /// <summary>
        /// Gets the issues by project id.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        [OperationContract]
        List<IssueContract> GetIssuesByProjectId(int projectId);

        /// <summary>
        /// Saves the issue.
        /// </summary>
        /// <param name="issue">The issue.</param>
        /// <returns></returns>
        [OperationContract]
        bool SaveIssue(IssueContract issue);

        /// <summary>
        /// Deletes the issue.
        /// </summary>
        /// <param name="issueId">The issue id.</param>
        /// <returns></returns>
        [OperationContract]
        bool DeleteIssue(int issueId);

     
        #endregion

        /// <summary>
        /// Gets the categories by project id.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        [OperationContract]
        [WebGet(UriTemplate = "GetProjectCategories/{projectId}",BodyStyle = WebMessageBodyStyle.Bare, ResponseFormat = WebMessageFormat.Json)]  
        List<JsTreeNode> GetCategoriesByProjectId(string projectId);
    
    }

    
}
