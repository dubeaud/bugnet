using System;
using System.Collections.Generic;
using BugNET.BLL;
using BugNET.Entities;
using BugNET.UserInterfaceLayer;

namespace BugNET.Issues.UserControls
{
    public partial class History : System.Web.UI.UserControl, IIssueTab
    {
        private int _IssueId = 0;
        private int _ProjectId = 0;

      
        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        #region IIssueTab Members

        /// <summary>
        /// Gets or sets the bug id.
        /// </summary>
        /// <value>The bug id.</value>
        public int IssueId
        {
            get { return _IssueId; }
            set { _IssueId = value; }
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
        /// Initializes this instance.
        /// </summary>
        public void Initialize()
        {
            BindHistory();
        }

        #endregion

        /// <summary>
        /// Binds the history.
        /// </summary>
        private void BindHistory()
        {
            HistoryDataGrid.Columns[0].HeaderText = GetLocalResourceObject("HistoryDataGrid.DateModifiedHeader.Text").ToString();
            HistoryDataGrid.Columns[1].HeaderText = GetLocalResourceObject("HistoryDataGrid.CreatorHeader.Text").ToString();
            HistoryDataGrid.Columns[2].HeaderText = GetLocalResourceObject("HistoryDataGrid.FieldChangedHeader.Text").ToString();
            HistoryDataGrid.Columns[3].HeaderText = GetLocalResourceObject("HistoryDataGrid.OldValueHeader.Text").ToString();
            HistoryDataGrid.Columns[4].HeaderText = GetLocalResourceObject("HistoryDataGrid.NewValueHeader.Text").ToString();

            List<IssueHistory> history = IssueHistoryManager.GetIssueHistoryByIssueId(IssueId);

            if (history.Count == 0)
            {
                lblHistory.Text = GetLocalResourceObject("NoHistory").ToString();
                lblHistory.Visible = true;
            }
            else
            {
                HistoryDataGrid.DataSource = history;
                HistoryDataGrid.DataBind();
            }
        }

    }
}