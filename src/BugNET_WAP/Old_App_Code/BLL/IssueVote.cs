using System;
using System.Collections.Generic;
using System.Web;
using log4net;
using BugNET.DataAccessLayer;

namespace BugNET.BusinessLogicLayer
{
    public class IssueVote
    {
        private int _IssueId;
		private int _Id;
		private string _VoteUsername;
        private static readonly ILog Log = LogManager.GetLogger(typeof(IssueVote));


        /// <summary>
        /// Initializes a new instance of the <see cref="IssueVote"/> class.
        /// </summary>
        /// <param name="id">The id.</param>
        /// <param name="issueId">The issue id.</param>
        /// <param name="voteUsername">The vote username.</param>
		public IssueVote(int id, int issueId, string voteUsername)
		{
			_Id = id;
			_IssueId = issueId;
			_VoteUsername = voteUsername;
		}

        /// <summary>
        /// Initializes a new instance of the <see cref="IssueVote"/> class.
        /// </summary>
        /// <param name="issueId">The issue id.</param>
        /// <param name="voteUsername">The vote username.</param>
		public IssueVote(int issueId,string voteUsername) : 
			this(Globals.NewId,issueId,voteUsername){}


        /// <summary>
        /// Initializes a new instance of the <see cref="IssueVote"/> class.
        /// </summary>
		public IssueVote(){}


        /// <summary>
        /// Gets the id.
        /// </summary>
        /// <value>The id.</value>
        public int Id
        {
            get { return _Id; }
        }

        /// <summary>
        /// Gets or sets the issue id.
        /// </summary>
        /// <value>The issue id.</value>
        public int IssueId
        {
            get { return _IssueId; }
            set
            {
                if (value <= DefaultValues.GetIssueIdMinValue())
                    throw (new ArgumentOutOfRangeException("value"));
                _IssueId = value;
            }
        }

        /// <summary>
        /// Gets the notification username.
        /// </summary>
        /// <value>The notification username.</value>
        public string VoteUsername
        {
            get
            {
                if (_VoteUsername == null || _VoteUsername.Length == 0)
                    return string.Empty;
                else
                    return _VoteUsername;
            }
        }


        /// <summary>
        /// Saves this instance.
        /// </summary>
        /// <returns></returns>
        public bool Save()
        {
            int TempId = DataProviderManager.Provider.CreateNewIssueVote(this);
            if (TempId > 0)
            {
                _Id = TempId;
                return true;
            }
            else
                return false;
        }


        /// <summary>
        /// Determines whether [has user voted] [the specified issue id].
        /// </summary>
        /// <param name="issueId">The issue id.</param>
        /// <param name="username">The username.</param>
        /// <returns>
        /// 	<c>true</c> if [has user voted] [the specified issue id]; otherwise, <c>false</c>.
        /// </returns>
        public static bool HasUserVoted(int issueId, string username)
        {
            if (issueId <= Globals.NewId)
                throw (new ArgumentOutOfRangeException("issueId"));
            if (string.IsNullOrEmpty(username))
                throw new ArgumentNullException("username");

            return DataProviderManager.Provider.HasUserVoted(issueId, username);
        }

    }
}
