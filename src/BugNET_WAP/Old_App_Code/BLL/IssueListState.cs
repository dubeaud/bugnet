using System;

namespace BugNET.BusinessLogicLayer
{
    /// <summary>
    /// Class to save the state of the IssueList page. An object of this class is saved in the session
    /// so that the IssueList page state can be restored. 
    /// </summary>
    [Serializable]
	public class IssueListState
	{
		private string _ViewIssues;
		private int _ProjectId;
		private int _IssueListPageIndex;
        private string _SortField;
        private bool _SortAscending;
        private int _PageSize;

        /// <summary>
        /// Gets or sets the size of the page.
        /// </summary>
        /// <value>The size of the page.</value>
        public int PageSize
        {
            get { return _PageSize; }
            set { _PageSize = value; }
        }

        /// <summary>
        /// Gets or sets the sort field.
        /// </summary>
        /// <value>The sort field.</value>
        public string SortField
        {
            get { return _SortField; }
            set { _SortField = value; }
        }


        /// <summary>
        /// Gets or sets a value indicating whether [sort ascending].
        /// </summary>
        /// <value><c>true</c> if [sort ascending]; otherwise, <c>false</c>.</value>
        public bool SortAscending
        {
            get { return _SortAscending; }
            set { _SortAscending = value; }
        }

        /// <summary>
        /// Gets or sets the view issues.
        /// </summary>
        /// <value>The view issues.</value>
		public string ViewIssues
		{
			get { return _ViewIssues; }
			set { _ViewIssues = value; }
		}

        /// <summary>
        /// Gets or sets the project id.
        /// </summary>
        /// <value>The project id.</value>
		public int ProjectId
		{
			get { return _ProjectId; }
			set { _ProjectId = value; }
		}

        /// <summary>
        /// Gets or sets the index of the issue list page.
        /// </summary>
        /// <value>The index of the issue list page.</value>
		public int IssueListPageIndex
		{
			get { return _IssueListPageIndex; }
			set { _IssueListPageIndex = value; }
		}
	}
}