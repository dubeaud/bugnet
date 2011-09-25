using System;

namespace BugNET.Entities
{
	/// <Summary>
	/// Summary description for RelatedIssue.
	/// </Summary>
	public class RelatedIssue
	{
		#region Private Variables
            private int _IssueId;
            private string _Title;
            private DateTime _DateCreated;
            private string _Status;
            private string _Resolution;
		#endregion
		
		#region Constructors
            /// <summary>
            /// Initializes a new instance of the <see cref="RelatedIssue"/> class.
            /// </summary>
            /// <param name="issueId">The bug id.</param>
            /// <param name="title">The title.</param>
            /// <param name="dateCreated">The reported date.</param>
            /// <Summary>
            /// Initializes a new instance of the <see cref="RelatedIssue"/> class.
            /// </Summary>
            public RelatedIssue(int issueId, string title,string status,string resolution, DateTime dateCreated)
            {
                _IssueId          = issueId;
                _Title        = title;
                _DateCreated    = dateCreated;
                _Status = status;
                _Resolution = resolution;
            }
		#endregion

        /// <Summary>
        /// Gets the reported date.
        /// </Summary>
        /// <value>The reported date.</value>
        public DateTime DateCreated
        {
            get { return _DateCreated; }
        }


        /// <Summary>
        /// Gets the bug id.
        /// </Summary>
        /// <value>The bug id.</value>
        public int IssueId
        {
            get { return (_IssueId); }
        }

        /// <summary>
        /// Gets the status.
        /// </summary>
        /// <value>The status.</value>
        public string Status
        {
            get { return _Status;}
        }

        /// <summary>
        /// Gets the resolution.
        /// </summary>
        /// <value>The resolution.</value>
        public string Resolution
        {
            get { return _Resolution; }
        }

        /// <Summary>
        /// Gets or sets the Summary.
        /// </Summary>
        /// <value>The Summary.</value>
        public string Title
        {
            get
            {
                if (_Title == null || _Title.Length == 0)
                    return string.Empty;
                else
                    return _Title;
            }
            set { _Title = value; }
        }
       

		
	}
}
