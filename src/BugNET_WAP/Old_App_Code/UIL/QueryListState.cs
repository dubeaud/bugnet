using System;

namespace BugNET.UserInterfaceLayer
{
    /// <summary>
    /// Class to save the state of the QueryList page. An object of this class is saved in the session
    /// so that the QueryList page state can be restored. 
    /// </summary>
    [Serializable]
    public class QueryListState
    {
        private int _QueryId;
        private int _ProjectId;
        private int _IssueListPageIndex;
        private string _SortField;
        private bool _SortAscending;
        private int _PageSize;


        /// <summary>
        /// Gets or sets the query id.
        /// </summary>
        /// <value>The query id.</value>
        public int QueryId
        {
            get { return _QueryId; }
            set { _QueryId = value; }
        }
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