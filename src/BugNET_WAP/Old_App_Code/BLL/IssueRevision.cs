using System;
using System.Data;
using BugNET.DataAccessLayer;
using System.Collections.Generic;


namespace BugNET.BusinessLogicLayer
{
    /// <summary>
    /// Entity object for issue revision
    /// </summary>
    public class IssueRevision
    {
       #region Private Variables
        private int _IssueId;
        private int _Revision;
        private string _Author;
        private string _Message;
        private string _Repository;
        private string _RevisionDate;
        private DateTime _DateCreated;
        private int _Id;
        #endregion

       #region Constructors
       /// <summary>
       /// Initializes a new instance of the <see cref="IssueRevision"/> class.
       /// </summary>
       /// <param name="revision">The revision.</param>
       /// <param name="issueId">The issue id.</param>
       /// <param name="author">The author.</param>
       /// <param name="message">The message.</param>
       /// <param name="repository">The repository.</param>
       /// <param name="revisionDate">The revision date.</param>
       public IssueRevision(int revision,int issueId, string author, string message, string repository, string revisionDate)
           : this(Globals.NewId,issueId, revision, author, message, repository, revisionDate, DateTime.MinValue)
       {}

       /// <summary>
       /// Initializes a new instance of the <see cref="IssueRevision"/> class.
       /// </summary>
       /// <param name="id">The id.</param>
       /// <param name="issueId">The issue id.</param>
       /// <param name="revision">The revision.</param>
       /// <param name="author">The author.</param>
       /// <param name="message">The message.</param>
       /// <param name="repository">The repository.</param>
       /// <param name="revisionDate">The revision date.</param>
       /// <param name="dateCreated">The date created.</param>
       public IssueRevision(int id, int issueId,int revision, string author, string message, string repository, string revisionDate, DateTime dateCreated)
       {
           _Id = id;
           _IssueId = issueId; 
           _Revision = revision;
           _Author = author;
           _Message = message;
           _Repository = repository;
           _RevisionDate = revisionDate;
           _DateCreated = dateCreated;
       }
       #endregion

       #region Properties
       /// <summary>
       /// Gets or sets the issue id.
       /// </summary>
       /// <value>The issue id.</value>
        public int IssueId 
        {
            get { return _IssueId; }
            set { _IssueId = value; }
        }

        /// <summary>
        /// Gets or sets the revision.
        /// </summary>
        /// <value>The revision.</value>
        public int Revision 
        {
            get { return _Revision; }
            set { _Revision = value; }
        }

        /// <summary>
        /// Gets or sets the author.
        /// </summary>
        /// <value>The author.</value>
        public string Author 
        { 
            get { return _Author; } 
            set { _Author = value; } 
        }

        /// <summary>
        /// Gets or sets the message.
        /// </summary>
        /// <value>The message.</value>
        public string Message 
        { 
            get { return _Message; } 
            set { _Message = value; } 
        }

        /// <summary>
        /// Gets or sets the id.
        /// </summary>
        /// <value>The id.</value>
        public int Id 
        { 
            get { return _Id; }
            set { _Id = value; }
        }
        /// <summary>
        /// Gets or sets the repository.
        /// </summary>
        /// <value>The repository.</value>
        public string Repository 
        { 
            get { return _Repository; } 
            set { _Repository = value; } 
        }

        /// <summary>
        /// Gets or sets the revision date.
        /// </summary>
        /// <value>The revision date.</value>
        public string RevisionDate 
        { 
            get { return _RevisionDate; } 
            set { _RevisionDate = value; } 
        }

        /// <summary>
        /// Gets or sets the date created.
        /// </summary>
        /// <value>The date created.</value>
        public DateTime DateCreated 
        { 
            get { return _DateCreated; } 
            set { _DateCreated = value; }
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
                int TempId = DataProviderManager.Provider.CreateNewIssueRevision(this);
                if (TempId > Globals.NewId)
                {
                    _Id = TempId;
                    return true;
                }
                else
                    return false;
            }
            return true;
        }
        #endregion

       #region Static Methods
        /// <summary>
        /// Gets the issue revisions by issue id.
        /// </summary>
        /// <param name="issueId">The issue id.</param>
        /// <returns></returns>
        public static List<IssueRevision> GetIssueRevisionsByIssueId(int issueId)
        {
            return DataProviderManager.Provider.GetIssueRevisionsByIssueId(issueId);
        }



        /// <summary>
        /// Deletes the issue revision by id.
        /// </summary>
        /// <param name="issueRevisionId">The issue revision id.</param>
        /// <returns></returns>
        public static bool DeleteIssueRevisionById(int issueRevisionId)
        {
            return DataProviderManager.Provider.DeleteIssueRevision(issueRevisionId);
        }
        #endregion
    }
}
