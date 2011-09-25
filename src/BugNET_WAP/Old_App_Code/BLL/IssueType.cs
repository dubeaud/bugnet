using System;
using BugNET.DataAccessLayer;
using System.Collections.Generic;

namespace BugNET.BusinessLogicLayer
{
	/// <summary>
	/// IssueType Business Object.
	/// </summary>
	public class IssueType
	{
		#region Private Variables
			private int _Id;
			private string _Name;
            private int _SortOrder;
            private int _ProjectId;
			private string _ImageUrl;
		#endregion

		#region Constructors

            /// <summary>
            /// Initializes a new instance of the <see cref="IssueType"/> class.
            /// </summary>
            /// <param name="projectId">The project id.</param>
            /// <param name="name">The name.</param>
            /// <param name="imageUrl">The image URL.</param>
            public IssueType(int projectId, string name,string imageUrl)
                : this(Globals.NewId, projectId, name, -1, imageUrl)
				{}

            /// <summary>
            /// Initializes a new instance of the <see cref="IssueType"/> class.
            /// </summary>
            /// <param name="id">The id.</param>
            /// <param name="projectId">The project id.</param>
            /// <param name="name">The name.</param>
            /// <param name="sortOrder">The sort order.</param>
            /// <param name="imageUrl">The image URL.</param>
			public IssueType(int id,int projectId,string name,int sortOrder,string imageUrl)
			{
				_Id = id;
                _ProjectId = projectId;
				_Name = name;
                _SortOrder = sortOrder;
				_ImageUrl = imageUrl;
			}
		#endregion

		#region Properties
            /// <summary>
            /// Gets the id.
            /// </summary>
            /// <value>The id.</value>
			public int Id
			{
				get{return _Id;}
			}

            /// <summary>
            /// Gets or sets the name.
            /// </summary>
            /// <value>The name.</value>
            public string Name
            {
                get
                {
                    if (_Name == null || _Name.Length == 0)
                        return string.Empty;
                    else
                        return _Name;
                }
                set { _Name = value; }
            }

            /// <summary>
            /// Gets or sets the sort order.
            /// </summary>
            /// <value>The sort order.</value>
            public int SortOrder
            {
                get { return _SortOrder; }
                set { _SortOrder = value; }
            }

            /// <summary>
            /// Gets or sets the project id.
            /// </summary>
            /// <value>The project id.</value>
            public int ProjectId
            {
                get { return _ProjectId; }
                set
                {
                    if (value <= Globals.NewId)
                        throw (new ArgumentOutOfRangeException("value"));
                    _ProjectId = value;
                }
            }

            /// <summary>
            /// Gets the image URL.
            /// </summary>
            /// <value>The image URL.</value>
            public string ImageUrl
            {
                get
                {
                    if (_ImageUrl == null || _ImageUrl.Length == 0)
                        return string.Empty;
                    else
                        return _ImageUrl;
                }
                set
                {
                    _ImageUrl = value;
                }
            }
		#endregion

        #region Instance Methods

            /// <summary>
            /// Saves this instance.
            /// </summary>
            /// <returns></returns>
            public bool Save()
            {

                if (Id <= Globals.NewId)
                {

                    int TempId = DataProviderManager.Provider.CreateNewIssueType(this);
                    if (TempId > 0)
                    {
                        _Id = TempId;
                        return true;
                    }
                    else
                        return false;
                }
                else
                {
                    return DataProviderManager.Provider.UpdateIssueType(this);
                }

            }
            #endregion

        #region Static Methods
            /// <summary>
            /// Gets the IssueType by id.
            /// </summary>
            /// <param name="IssueTypeId">The IssueType id.</param>
            /// <returns></returns>
			public static IssueType GetIssueTypeById(int issueTypeId)
			{
				if (issueTypeId <= Globals.NewId )
					throw (new ArgumentOutOfRangeException("issueTypeId"));

                return DataProviderManager.Provider.GetIssueTypeById(issueTypeId);
			}

            /// <summary>
            /// Deletes the type of the issue.
            /// </summary>
            /// <param name="issueTypeId">The issue type id.</param>
            /// <returns></returns>
            public static bool DeleteIssueType(int issueTypeId)
            {
                if (issueTypeId <= Globals.NewId)
                    throw (new ArgumentOutOfRangeException("issueTypeId"));

                return DataProviderManager.Provider.DeleteIssueType(issueTypeId);
            }

            /// <summary>
            /// Gets the issue type by project id.
            /// </summary>
            /// <param name="projectId">The project id.</param>
            /// <returns></returns>
            public static List<IssueType> GetIssueTypesByProjectId(int projectId)
            {
                if (projectId <= Globals.NewId)
                    throw (new ArgumentOutOfRangeException("projectId"));

                return DataProviderManager.Provider.GetIssueTypesByProjectId(projectId);
            }

            /// <summary>
            /// Stewart Moss
            /// Apr 14 2010 
            /// 
            /// Performs a query containing any number of query clauses on a certain projectID
            /// </summary>
            /// <param name="issueId"></param>
            /// <param name="QueryClauses"></param>
            /// <returns></returns>
            public static List<IssueType> PerformQuery(int projectID, List<QueryClause> QueryClauses)
            {
                if (projectID < 0)
                    throw new ArgumentOutOfRangeException("projectID must be bigger than 0");
                QueryClauses.Add(new QueryClause("AND", "ProjectID", "=", projectID.ToString(), System.Data.SqlDbType.Int, false));

                return PerformQuery(QueryClauses);
            }

            /// <summary>
            /// Stewart Moss
            /// Apr 14 2010 8:30 pm
            /// 
            /// Performs any query containing any number of query clauses
            /// WARNING! Will expose the entire IssueType table, regardless of 
            /// project level privledges. (thats why its private for now)
            /// </summary>        
            /// <param name="QueryClauses"></param>
            /// <returns></returns>
            private static List<IssueType> PerformQuery(List<QueryClause> QueryClauses)
            {
                if (QueryClauses == null)
                    throw new ArgumentNullException("QueryClauses");

                List<IssueType> lst = new List<IssueType>();
                DataProviderManager.Provider.PerformGenericQuery<IssueType>(ref lst, QueryClauses, @"SELECT a.*, b.ProjectName as ProjectName from BugNet_ProjectIssueTypes as a, BugNet_Projects as b  WHERE a.ProjectID=b.ProjectID ", @" ORDER BY a.ProjectID, a.IssueTypeID ASC");

                return lst;
            }


 
 
          
		#endregion
	}
}
