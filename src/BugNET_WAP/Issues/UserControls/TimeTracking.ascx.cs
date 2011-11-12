using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web.UI.WebControls;
using BugNET.BLL;
using BugNET.Common;
using BugNET.Entities;
using BugNET.UserInterfaceLayer;

namespace BugNET.Issues.UserControls
{
    public partial class TimeTracking : System.Web.UI.UserControl, IIssueTab
    {
        private double _total;

        protected TimeTracking()
        {
            ProjectId = 0;
            IssueId = 0;
        }

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
        /// Gets or sets the issue id.
        /// </summary>
        /// <value>The issue id.</value>
        public int IssueId
        {
            get { return ViewState.Get("IssueId", 0); }
            set { ViewState.Set("IssueId", value); }
        }

        /// <summary>
        /// Gets or sets the project id.
        /// </summary>
        /// <value>The project id.</value>
        public int ProjectId
        {
            get { return ViewState.Get("ProjectId", 0); }
            set { ViewState.Set("ProjectId", value); }
        }

        /// <summary>
        /// Initializes this instance.
        /// </summary>
        public void Initialize()
        {
            TimeEntriesDataGrid.Columns[0].HeaderText = GetLocalResourceObject("TimeEntriesDataGrid.WorkDateHeader.Text").ToString();
            TimeEntriesDataGrid.Columns[1].HeaderText = GetLocalResourceObject("TimeEntriesDataGrid.DurationHeader.Text").ToString();
            TimeEntriesDataGrid.Columns[2].HeaderText = GetLocalResourceObject("TimeEntriesDataGrid.CreatorHeader.Text").ToString();
            TimeEntriesDataGrid.Columns[3].HeaderText = GetLocalResourceObject("TimeEntriesDataGrid.CommentHeader.Text").ToString();

            BindTimeEntries();

            if (!Page.User.Identity.IsAuthenticated || !UserManager.HasPermission(ProjectId, Globals.Permission.AddTimeEntry.ToString()))
                AddTimeEntryPanel.Visible = false;

            if (!Page.User.Identity.IsAuthenticated || !UserManager.HasPermission(ProjectId, Globals.Permission.DeleteTimeEntry.ToString()))
                TimeEntriesDataGrid.Columns[4].Visible = false;
        }

        #endregion

        /// <summary>
        /// Binds the work reports.
        /// </summary>
        private void BindTimeEntries()
        {
            //System.Globalization.NumberFormatInfo nfi = System.Globalization.CultureInfo.CurrentCulture.NumberFormat;
            const double minimum = 0;

            RangeValidator1.MinimumValue = minimum.ToString();
            RangeValidator1.CultureInvariantValues = true;

            TimeEntryDate.SelectedValue = DateTime.Today;
            cpTimeEntry.ValueToCompare = DateTime.Today.ToShortDateString();

            var workReports = IssueWorkReportManager.GetByIssueId(IssueId);

            if (workReports == null || workReports.Count == 0)
            {
                TimeEntryLabel.Text = GetLocalResourceObject("NoTimeEntries").ToString();
                TimeEntryLabel.Visible = true;
                TimeEntriesDataGrid.Visible = false;
            }
            else
            {
                _total = 0;
                TimeEntriesDataGrid.Visible = true;
                TimeEntryLabel.Visible = false;
                TimeEntriesDataGrid.DataSource = workReports;
                TimeEntriesDataGrid.DataBind();
            }
        }

        /// <summary>
        /// Handles the Click event of the cmdAddBugTimeEntry control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void AddTimeEntry_Click(object sender, EventArgs e)
        {
            if (DurationTextBox.Text.Trim().Length == 0) return;

            var selectedWorkDate = TimeEntryDate.SelectedValue == null
                                       ? DateTime.MinValue
                                       : (DateTime) TimeEntryDate.SelectedValue;
            var workDuration = Convert.ToDecimal(DurationTextBox.Text);

            var workReport = new IssueWorkReport
                                 {
                                     CommentText = CommentHtmlEditor.Text.Trim(), 
                                     CreatorUserName = Context.User.Identity.Name, 
                                     Duration = workDuration, 
                                     IssueId = IssueId, 
                                     WorkDate = selectedWorkDate
                                 };

            IssueWorkReportManager.SaveOrUpdate(workReport);

            var history = new IssueHistory
                              {
                                  IssueId = IssueId,
                                  CreatedUserName = Security.GetUserName(),
                                  DateChanged = DateTime.Now,
                                  FieldChanged = ResourceStrings.GetGlobalResource(GlobalResources.SharedResources, "TimeLogged", "Time Logged"),
                                  OldValue = string.Empty,
                                  NewValue = DurationTextBox.Text.Trim()
                              };

            IssueHistoryManager.SaveOrUpdate(history);

            var changes = new List<IssueHistory> {history};

            IssueNotificationManager.SendIssueNotifications(IssueId, changes);

            CommentHtmlEditor.Text = string.Empty;

            DurationTextBox.Text = string.Empty;

            BindTimeEntries();
        }

        /// <summary>
        /// Handles the ItemCommand event of the TimeEntriesDataGrid control.
        /// </summary>
        /// <param name="source">The source of the event.</param>
        /// <param name="e">The <see cref="T:System.Web.UI.WebControls.DataGridCommandEventArgs"/> instance containing the event data.</param>
        protected void TimeEntriesDataGrid_ItemCommand(object source, System.Web.UI.WebControls.DataGridCommandEventArgs e)
        {
            var id = Convert.ToInt32(e.CommandArgument);

            if (!IssueWorkReportManager.Delete(id)) return;

            var history = new IssueHistory
                              {
                                  IssueId = IssueId,
                                  CreatedUserName = Security.GetUserName(),
                                  DateChanged = DateTime.Now,
                                  FieldChanged = ResourceStrings.GetGlobalResource(GlobalResources.SharedResources, "TimeLogged", "Time Logged"),
                                  OldValue = string.Empty,
                                  NewValue = ResourceStrings.GetGlobalResource(GlobalResources.SharedResources, "Deleted", "Deleted")
                              };

            IssueHistoryManager.SaveOrUpdate(history);

            var changes = new List<IssueHistory> {history};

            IssueNotificationManager.SendIssueNotifications(IssueId, changes);

            BindTimeEntries();
        }

        /// <summary>
        /// Handles the ItemDataBound event of the TimeEntriesDataGrid control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="T:System.Web.UI.WebControls.DataGridItemEventArgs"/> instance containing the event data.</param>
        protected void TimeEntriesDataGridItemDataBound(object sender, DataGridItemEventArgs e)
        {
            var delete = string.Format("return confirm('{0}');", GetLocalResourceObject("DeleteTimeEntry"));

            switch (e.Item.ItemType)
            {
                case ListItemType.Item:
                case ListItemType.AlternatingItem:
                    _total += Convert.ToDouble(e.Item.Cells[1].Text);
                    ((ImageButton)e.Item.FindControl("cmdDelete")).OnClientClick = delete;
                    break;
                case ListItemType.Footer:
                    //Use the footer to display the summary row.
                    e.Item.Cells[0].Text = ResourceStrings.GetGlobalResource(GlobalResources.SharedResources, "TotalHours", "Total Hours");
                    e.Item.Cells[0].Attributes.Add("align", "left");
                    e.Item.Cells[0].Style.Add("font-weight", "bold");
                    e.Item.Cells[0].Style.Add("padding-top", "10px");
                    e.Item.Cells[0].Style.Add("border-top", "1px solid #999");
                    e.Item.Cells[1].Attributes.Add("align", "right");
                    e.Item.Cells[1].Style.Add("border-top", "1px solid #999");
                    e.Item.Cells[1].Style.Add("padding-top", "10px");
                    e.Item.Cells[1].Text = _total.ToString();
                    e.Item.Cells[2].Style.Add("border-top", "1px solid #999");
                    e.Item.Cells[3].Style.Add("border-top", "1px solid #999");
                    e.Item.Cells[4].Style.Add("border-top", "1px solid #999");
                    break;
            }

        }
    }
}