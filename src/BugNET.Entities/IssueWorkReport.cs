using System;
using BugNET.Common;

namespace BugNET.Entities
{
	/// <summary>
	/// WorkReport Class
	/// </summary>
	public class IssueWorkReport
	{
		#region Private Variables
		private int _Id;
		private int _IssueId;
		private string _Comment;
		private int _IssueCommentId;
		private string _CreatorUserName;
        private string _CreatorDisplayName;
		private Guid _CreatorUserId;
		private decimal _Duration;
		private DateTime _WorkDate;
		#endregion

		#region Constructors


     
		public IssueWorkReport(int id, int issueId, Guid creatorUserId, DateTime reportDate, decimal duration, int issueCommentId, string comment, string creatorUserName,string creatorDisplayName)
		{
			_Id					= id;
			_IssueId			= issueId;
			_Comment			= comment;
			_IssueCommentId		= issueCommentId;
			_CreatorUserId		= creatorUserId;
			_WorkDate			= reportDate;
			_Duration			= duration;
			_CreatorUserName	= creatorUserName;
            _CreatorDisplayName = creatorDisplayName;
		}



        /// <summary>
        /// Initializes a new instance of the <see cref="IssueWorkReport"/> class.
        /// </summary>
        /// <param name="issueId">The issue id.</param>
        /// <param name="reportDate">The report date.</param>
        /// <param name="duration">The duration.</param>
        /// <param name="comment">The comment.</param>
        /// <param name="creatorUserName">Name of the creator user.</param>
		public IssueWorkReport(int issueId, DateTime reportDate, decimal duration, string comment, string creatorUserName)
			:this(Globals.NewId,issueId,Guid.Empty, reportDate,duration, Globals.NewId, comment, creatorUserName, String.Empty)
		{}
		#endregion

		#region Properties
        /// <summary>
        /// Gets the id.
        /// </summary>
        /// <value>The id.</value>
		public int Id 
		{
			get {return _Id;}
            set { _Id = value; }
		}
        /// <summary>
        /// Gets the bug id.
        /// </summary>
        /// <value>The bug id.</value>
		public int IssueId 
		{
			get {return _IssueId;}
		}
        /// <summary>
        /// Gets the duration.
        /// </summary>
        /// <value>The duration.</value>
		public decimal Duration
		{
			get {return _Duration;}
		}
        /// <summary>
        /// Gets the comment text.
        /// </summary>
        /// <value>The comment text.</value>
		public string CommentText 
		{
			get {return _Comment;}
		}
        /// <summary>
        /// Gets the comment id.
        /// </summary>
        /// <value>The comment id.</value>
		public int CommentId 
		{
			get {return _IssueCommentId;}
            set { _IssueCommentId = value; }
		}

        /// <summary>
        /// Gets the report date.
        /// </summary>
        /// <value>The report date.</value>
		public DateTime WorkDate
		{
			get {return _WorkDate;}
		}
        /// <summary>
        /// Gets the name of the creator user.
        /// </summary>
        /// <value>The name of the creator user.</value>
		public string CreatorUserName
		{
			get {return _CreatorUserName;}
		}

        /// <summary>
        /// Gets the display name of the creator.
        /// </summary>
        /// <value>The display name of the creator.</value>
        public string CreatorDisplayName
        {
            get { return _CreatorDisplayName; }
        }
        /// <summary>
        /// Gets the creator id.
        /// </summary>
        /// <value>The creator id.</value>
		public Guid CreatorUserId 
		{
			get {return _CreatorUserId;}
		}
        
		#endregion

	
	}
}
