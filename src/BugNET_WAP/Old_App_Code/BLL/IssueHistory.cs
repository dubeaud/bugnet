using System;
using BugNET.DataAccessLayer;
using BugNET.BusinessLogicLayer.Notifications;
using System.Collections;
using System.Collections.Generic;

namespace BugNET.BusinessLogicLayer
{
    /// <summary>
    /// Issue History
    /// </summary>
    public class IssueHistory : IToXml
    {
        #region Private Variables
        private int _Id;
        private int _IssueId;
        private string _CreatedUserName;
        private string _FieldChanged;
        private string _OldValue;
        private string _NewValue;
        private DateTime _DateChanged;
        private string _CreatorDisplayName;
        #endregion

        #region Constructors

        public IssueHistory() { }

        /// <summary>
        /// Initializes a new instance of the <see cref="BugHistory"/> class.
        /// </summary>
        /// <param name="id">The id.</param>
        /// <param name="issueId">The issue id.</param>
        /// <param name="createdUserName">Name of the created user.</param>
        /// <param name="creatorDisplayName">Display name of the creator.</param>
        /// <param name="fieldChanged">The field changed.</param>
        /// <param name="oldValue">The old value.</param>
        /// <param name="newValue">The new value.</param>
        /// <param name="dateChanged">The date changed.</param>
        public IssueHistory(int id, int issueId, string createdUserName, string creatorDisplayName, string fieldChanged, string oldValue, string newValue, DateTime dateChanged)
        {
            _Id = id;
            _IssueId = issueId;
            _CreatedUserName = createdUserName;
            _CreatorDisplayName = creatorDisplayName;
            _FieldChanged = fieldChanged;
            _OldValue = oldValue;
            _NewValue = newValue;
            _DateChanged = dateChanged;
        }
        /// <summary>
        /// Initializes a new instance of the <see cref="BugHistory"/> class.
        /// </summary>
        /// <param name="bugId">The bug id.</param>
        /// <param name="createdUserName">Name of the created user.</param>
        /// <param name="fieldChanged">The field changed.</param>
        /// <param name="oldValue">The old value.</param>
        /// <param name="newValue">The new value.</param>
        public IssueHistory(int issueId, string createdUserName, string fieldChanged, string oldValue, string newValue)
            : this
            (
            Globals.NewId,
            issueId,
            createdUserName,
            string.Empty,
            fieldChanged,
            oldValue,
            newValue,
            DateTime.Now
            )
        { }
        /// <summary>
        /// Initializes a new instance of the <see cref="BugHistory"/> class.
        /// </summary>
        //public IssueHistory(){}
        #endregion

        #region Properties

        /// <summary>
        /// Gets the id.
        /// </summary>
        /// <value>The id.</value>
        public int Id
        {
            get { return _Id; }
            set { } // needed for xml serialization
        }

        /// <summary>
        /// Gets the bug id.
        /// </summary>
        /// <value>The bug id.</value>
        public int IssueId
        {
            get { return _IssueId; }
            set { } // needed for xml serialization
        }

        /// <summary>
        /// Gets the name of the created user.
        /// </summary>
        /// <value>The name of the created user.</value>
        public string CreatedUserName
        {
            get { return _CreatedUserName; }
            set { } // needed for xml serialization
        }
        /// <summary>
        /// Gets the field changed.
        /// </summary>
        /// <value>The field changed.</value>
        public string FieldChanged
        {
            get { return _FieldChanged; }
            set { } // needed for xml serialization
        }

        /// <summary>
        /// Gets the old value.
        /// </summary>
        /// <value>The old value.</value>
        public string OldValue
        {
            get { return _OldValue; }
            set { } // needed for xml serialization
        }
        /// <summary>
        /// Gets the new value.
        /// </summary>
        /// <value>The new value.</value>
        public string NewValue
        {
            get { return _NewValue; }
            set { } // needed for xml serialization
        }
        /// <summary>
        /// Gets the date changed.
        /// </summary>
        /// <value>The date changed.</value>
        public DateTime DateChanged
        {
            get { return _DateChanged; }
            set { } // needed for xml serialization
        }

        /// <summary>
        /// Gets the display name of the creator.
        /// </summary>
        /// <value>The display name of the creator.</value>
        public string CreatorDisplayName
        {
            get { return (_CreatorDisplayName == null || _CreatorDisplayName.Length == 0) ? string.Empty : _CreatorDisplayName; }
            set { } // needed for xml serialization
        }
        #endregion

        #region Instance Methods
        /// <summary>
        /// Saves this instance.
        /// </summary>
        /// <returns></returns>
        public bool Save()
        {
            if (_Id <= Globals.NewId)
            {
                int TempId = DataProviderManager.Provider.CreateNewIssueHistory(this);
                if (TempId > 0)
                {
                    _Id = TempId;
                    return true;
                }
                else
                    return false;
            }
            else
                return false;
        }
        #endregion

        #region Static Methods
        /// <summary>
        /// Gets the BugHistory by bug id.
        /// </summary>
        /// <param name="bugId">The bug id.</param>
        /// <returns></returns>
        public static List<IssueHistory> GetIssueHistoryByIssueId(int issueId)
        {
            if (issueId <= Globals.NewId)
                throw (new ArgumentOutOfRangeException("issueId"));

            return DataProviderManager.Provider.GetIssueHistoryByIssueId(issueId);
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
        public static List<IssueHistory> PerformQuery(int issueID, List<QueryClause> QueryClauses)
        {
            if (issueID < 0)
                throw new ArgumentOutOfRangeException("projectID must be bigger than 0");
            QueryClauses.Add(new QueryClause("AND", "IssueID", "=", issueID.ToString(), System.Data.SqlDbType.Int, false));

            return PerformQuery(QueryClauses);
        }

        /// <summary>
        /// Stewart Moss
        /// Apr 14 2010 8:30 pm
        /// 
        /// Performs any query containing any number of query clauses
        /// WARNING! Will expose the entire IssueHistory table, regardless of 
        /// project level privledges. 
        /// </summary>        
        /// <param name="QueryClauses"></param>
        /// <returns></returns>
        public static List<IssueHistory> PerformQuery(List<QueryClause> QueryClauses)
        {
            if (QueryClauses == null)
                throw new ArgumentNullException("QueryClauses");

            List<IssueHistory> lst = new List<IssueHistory>();
            DataProviderManager.Provider.PerformGenericQuery<IssueHistory>(ref lst, QueryClauses, @"SELECT DISTINCT a.*, c.ProjectID as ProjectID, b.UserName as CreatorUserName, b.UserName as CreatorDisplayName from BugNet_IssueHistory as a, aspnet_Users as b, BugNet_Issues as d, BugNet_Projects as c  WHERE c.ProjectId=d.ProjectId AND d.IssueID=a.IssueID AND a.UserId=b.UserID AND ( 1=1 ", @" ) ORDER BY IssueHistoryId DESC");

            return lst;
        }
        #endregion


        #region IToXml Members

        public string ToXml()
        {
            XmlSerializeService<IssueHistory> service = new XmlSerializeService<IssueHistory>();
            return service.ToXml(this);
        }

        #endregion
    }


}
