using System;
using BugNET.Common;

namespace BugNET.Entities
{
    public class IssueVote
    {
        private int _IssueId;
		private int _Id;
		private string _VoteUsername;
       // private static readonly ILog Log = LogManager.GetLogger(typeof(IssueVote));


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
            set { _Id = value; }
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


        

    }
}
