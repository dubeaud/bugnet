using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using BugNET.BLL;
using BugNET.Common;
using BugNET.Entities;
using BugNET.UserInterfaceLayer;

namespace BugNET.UserControls
{
    /// <summary>
    ///    Display Issues grid
    /// </summary>
    public partial class DisplayIssues : UserControl
    {
        /// <summary>
        /// Datasource 
        /// </summary>
        private List<Issue> _dataSource;

        /// <summary>
        /// Event that fires on a data bind
        /// </summary>
        public event EventHandler RebindCommand;

        /// <summary>
        /// Array of issue columns
        /// </summary>
        private string[] _arrIssueColumns = new[] { "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22" };

        //store amount of fixed search columns due to bad string above
        private const int FIXED_COLUMNS = 22;

        /// <summary>
        /// Handles the Init event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void Page_Init(object sender, EventArgs e)
        {
            if (Page.User.Identity.IsAuthenticated)
            {
                var projectId = Request.QueryString.Get("pid", 0);

                if (projectId > 0)
                {
                    var columns = UserManager.GetSelectedIssueColumnsByUserName(Security.GetUserName(), projectId);

                    if (!string.IsNullOrEmpty(columns))
                        _arrIssueColumns = columns.Trim().Split();
                }
                else //if it is myIssues and not a specific project
                {
                    if (!string.IsNullOrEmpty(WebProfile.Current.SelectedIssueColumns))
                        _arrIssueColumns = WebProfile.Current.SelectedIssueColumns.Trim().Split();
                }
            }
            else
            {
                var httpCookie = Request.Cookies[Globals.ISSUE_COLUMNS];

                if (httpCookie != null)
                {
                    if (httpCookie.Value != String.Empty)
                        _arrIssueColumns = httpCookie.Value.Split();
                }
            }
        }

        /// <summary>
        /// Sets the RSS  URL.
        /// </summary>
        /// <value>The RSS  URL.</value>
        public string RssUrl
        {
            set { lnkRSS.NavigateUrl = value; }
        }

        /// <summary>
        /// Gets or sets the data source.
        /// </summary>
        /// <value>The data source.</value>
        public List<Issue> DataSource
        {
            get { return _dataSource; }
            set { _dataSource = value; }
        }

        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        /// <summary>
        /// Binds a data source to the invoked server control and all its child controls.
        /// </summary>
        public new void DataBind()
        {
            //Private issue check
            DataSource = IssueManager.StripPrivateIssuesForRequestor(DataSource, Security.GetUserName()).ToList();

            if (DataSource.Count > 0)
            {
                gvIssues.Visible = true;
                pager.Visible = true;
                ScrollPanel.Visible = true;
                OptionsContainerPanel.Visible = true;

                var pId = Request.QueryString.Get("pid", -1);

                //get custom fields for project
                if (pId > Globals.NEW_ID)
                {
                    var customFields = CustomFieldManager.GetByProjectId(pId);

                    var nrColumns = FIXED_COLUMNS;
                    //checks if its initial load to add custom controls and checkboxes
                    if (gvIssues.Columns.Count <= nrColumns + 1)
                    {
                        var firstIssue = DataSource[0];

                        //if there is custom fields add them
                        if (firstIssue.IssueCustomFields.Count > 0)
                        {
                            foreach (var value in firstIssue.IssueCustomFields)
                            {
                                //increments nr of columns
                                nrColumns++;

                                //create checkbox item
                                var lstValue = new ListItem(value.FieldName, nrColumns.ToString());

                                //find custom controls that has been checked and check them
                                var selected = Array.IndexOf(_arrIssueColumns, nrColumns.ToString()) >= 0;
                                if (selected)
                                    lstValue.Selected = true;

                                //add item to checkbox list
                                lstIssueColumns.Items.Add(lstValue);

                                //create column for custom control
                                var tf = new TemplateField { HeaderText = value.FieldName, SortExpression = value.DatabaseFieldName.Replace(" ", "[]") };
                                tf.HeaderStyle.Wrap = false;
                                gvIssues.Columns.Add(tf);
                            }
                        }
                    }
                }

                DisplayColumns();
                SelectColumnsPanel.Visible = true;
                lblResults.Visible = false;

                if (ShowProjectColumn)
                {
                    gvIssues.Columns[0].Visible = false;
                    LeftButtonContainerPanel.Visible = false;
                }
                else
                {
                    gvIssues.Columns[4].Visible = false;
                    lstIssueColumns.Items.Remove(lstIssueColumns.Items.FindByValue("4"));

                    var projectId = _dataSource[0].ProjectId;

                    //hide votes column if issue voting is disabled
                    if (!ProjectManager.GetById(projectId).AllowIssueVoting)
                    {
                        gvIssues.Columns[4].Visible = false;
                        lstIssueColumns.Items.Remove(lstIssueColumns.Items.FindByValue("4"));
                    }

                    if (Page.User.Identity.IsAuthenticated && UserManager.HasPermission(projectId, Common.Permission.EditIssue.ToString()))
                    {
                        LeftButtonContainerPanel.Visible = true;

                        // performance enhancement
                        // WRH 2012-04-06
                        // only load these if the user has permission to do so
                        var categories = new CategoryTree();
                        dropCategory.DataSource = categories.GetCategoryTreeByProjectId(projectId);
                        dropCategory.DataBind();
                        dropMilestone.DataSource = MilestoneManager.GetByProjectId(projectId);
                        dropMilestone.DataBind();
                        dropAffectedMilestone.DataSource = dropMilestone.DataSource;
                        dropAffectedMilestone.DataBind();
                        dropOwner.DataSource = UserManager.GetUsersByProjectId(projectId);
                        dropOwner.DataBind();
                        dropPriority.DataSource = PriorityManager.GetByProjectId(projectId);
                        dropPriority.DataBind();
                        dropStatus.DataSource = StatusManager.GetByProjectId(projectId);
                        dropStatus.DataBind();
                        dropType.DataSource = IssueTypeManager.GetByProjectId(projectId);
                        dropType.DataBind();
                        dropAssigned.DataSource = UserManager.GetUsersByProjectId(projectId);
                        dropAssigned.DataBind();
                        dropResolution.DataSource = ResolutionManager.GetByProjectId(projectId);
                        dropResolution.DataBind();
                        chkDueDateReset.Checked = false;
                    }
                    else
                    {
                        //hide selection column for unauthenticated users 
                        gvIssues.Columns[0].Visible = false;
                        LeftButtonContainerPanel.Visible = false;
                    }
                }

                foreach (var item in _arrIssueColumns.Select(colIndex => lstIssueColumns.Items.FindByValue(colIndex)).Where(item => item != null))
                {
                    item.Selected = true;
                }

                gvIssues.DataSource = DataSource;
                gvIssues.DataBind();
            }
            else
            {
                ScrollPanel.Visible = false;
                OptionsContainerPanel.Visible = false;
                lblResults.Visible = true;
                gvIssues.Visible = false;
                pager.Visible = false;
            }

        }

        /// <summary>
        /// Handles the Click event of the ExportExcelButton control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void ExportExcelButton_Click(object sender, EventArgs e)
        {
            var currentPage = CurrentPageIndex;
            var currentPageSize = PageSize;

            pager.PageSize = 10000000;
            gvIssues.PageIndex = 1;

            GridViewExportUtil.Export(DateTime.Today.ToString("yyyyMMdd") + "-Issues.xls", gvIssues);

            CurrentPageIndex = currentPage;
            pager.PageSize = currentPageSize;
        }

        /// <summary>
        /// Displays the columns.
        /// </summary>
        private void DisplayColumns()
        {
            // Hide all the DataGrid columns
            for (var index = 4; index < gvIssues.Columns.Count; index++)
                gvIssues.Columns[index].Visible = false;

            // Display columns based on the _arrIssueColumns array (retrieved from cookie)
            foreach (var colIndex in _arrIssueColumns)
            {
                //ensure custom field exist for this project
                if (Int32.Parse(colIndex) < gvIssues.Columns.Count)
                    gvIssues.Columns[Int32.Parse(colIndex)].Visible = true;
            }
        }

        /// <summary>
        /// Handles the Click event of the SaveIssues control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void SaveIssues_Click(object sender, EventArgs e)
        {
            //TODO: Ajax progress bar when this is running;
            var ids = GetSelectedIssueIds();

            if (ids.Length > 0)
            {
                //prune out all values that must not change
                var customFieldValues = ctlCustomFields.Values;

                for (var i = customFieldValues.Count - 1; i >= 0; i--)
                {
                    var value = customFieldValues[i];
                    if (string.IsNullOrEmpty(value.Value))
                    {
                        customFieldValues.RemoveAt(i);
                    }
                }

                foreach (var s in ids.Split(new[] { ',' }))
                {
                    int issueId;

                    if (!int.TryParse(s, out issueId))
                        throw new Exception(string.Format(LoggingManager.GetErrorMessageResource("InvalidIssueId"), s));

                    var issue = IssueManager.GetById(issueId);

                    if (issue == null) continue;

                    if (DueDate.SelectedValue != null)
                    {
                        var dueDate = (DateTime)DueDate.SelectedValue;

                        if (dueDate != null)
                        issue.DueDate = dueDate;
                    }

                    if (chkDueDateReset.Checked)
                    {
                        issue.DueDate = DateTime.MinValue;
                    }

                    issue.CategoryId = dropCategory.SelectedValue != 0 ? dropCategory.SelectedValue : issue.CategoryId;
                    issue.CategoryName = dropCategory.SelectedValue != 0 ? dropCategory.SelectedText : issue.CategoryName;

                    issue.MilestoneId = dropMilestone.SelectedValue != 0 ? dropMilestone.SelectedValue : issue.MilestoneId;
                    issue.MilestoneName = dropMilestone.SelectedValue != 0 ? dropMilestone.SelectedText : issue.MilestoneName;

                    issue.IssueTypeId = dropType.SelectedValue != 0 ? dropType.SelectedValue : issue.IssueTypeId;
                    issue.IssueTypeName = dropType.SelectedValue != 0 ? dropType.SelectedText : issue.IssueTypeName;

                    issue.PriorityId = dropPriority.SelectedValue != 0 ? dropPriority.SelectedValue : issue.PriorityId;
                    issue.PriorityName = dropPriority.SelectedValue != 0 ? dropPriority.SelectedText : issue.PriorityName;

                    issue.AssignedDisplayName = dropAssigned.SelectedValue != string.Empty ? dropAssigned.SelectedText : issue.AssignedDisplayName;
                    issue.AssignedUserName = dropAssigned.SelectedValue != string.Empty ? dropAssigned.SelectedValue : issue.AssignedUserName;

                    issue.OwnerDisplayName = dropOwner.SelectedValue != string.Empty ? dropOwner.SelectedText : issue.OwnerDisplayName;
                    issue.OwnerUserName = dropOwner.SelectedValue != string.Empty ? dropOwner.SelectedValue : issue.OwnerUserName;

                    issue.AffectedMilestoneId = dropAffectedMilestone.SelectedValue != 0 ? dropAffectedMilestone.SelectedValue : issue.AffectedMilestoneId;
                    issue.AffectedMilestoneName = dropAffectedMilestone.SelectedValue != 0 ? dropAffectedMilestone.SelectedText : issue.AffectedMilestoneName;

                    issue.ResolutionId = dropResolution.SelectedValue != 0 ? dropResolution.SelectedValue : issue.ResolutionId;
                    issue.ResolutionName = dropResolution.SelectedValue != 0 ? dropResolution.SelectedText : issue.ResolutionName;

                    issue.StatusId = dropStatus.SelectedValue != 0 ? dropStatus.SelectedValue : issue.StatusId;
                    issue.StatusName = dropStatus.SelectedValue != 0 ? dropStatus.SelectedText : issue.StatusName;

                    issue.LastUpdateDisplayName = Security.GetDisplayName();
                    issue.LastUpdateUserName = Security.GetUserName();
                    issue.LastUpdate = DateTime.Now;

                    IssueManager.SaveOrUpdate(issue);
                    CustomFieldManager.SaveCustomFieldValues(issue.Id, customFieldValues);
                }
            }

            OnRebindCommand(EventArgs.Empty);
        }
        /// <summary>
        /// Gets the selected issues.
        /// </summary>
        /// <returns></returns>
        private string GetSelectedIssueIds()
        {
            var ids = string.Empty;

            foreach (GridViewRow gvr in gvIssues.Rows)
            {
                if (gvr.RowType != DataControlRowType.DataRow) continue;

                if (!((CheckBox)gvr.Cells[0].Controls[1]).Checked) continue;
                var dataKey = gvIssues.DataKeys[gvr.RowIndex];
                if (dataKey != null) ids += dataKey.Value + ",";
            }
            return ids.EndsWith(",") ? ids.TrimEnd(new[] { ',' }) : ids;
        }

        /// <summary>
        /// Saves the click.
        /// </summary>
        /// <param name="s">The s.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void SaveClick(Object s, EventArgs e)
        {
            var strIssueColumns = lstIssueColumns.Items.Cast<ListItem>().Where(item => item.Selected).Aggregate(" 0", (current, item) => current + (" " + item.Value));

            strIssueColumns = strIssueColumns.Trim();

            _arrIssueColumns = strIssueColumns.Split();

            if (Page.User.Identity.IsAuthenticated)
            {
                var projectId = Request.Get("pid", 0);

                if (projectId > 0)
                {
                    UserManager.SetSelectedIssueColumnsByUserName(Security.GetUserName(), projectId, strIssueColumns.Trim());
                }
                else //if it is MyIssue and not a specific project
                {
                    WebProfile.Current.SelectedIssueColumns = strIssueColumns.Trim();
                    WebProfile.Current.Save();
                }
            }
            else
            {
                var httpCookie = new HttpCookie(Globals.ISSUE_COLUMNS) { Path = "/", Expires = DateTime.MaxValue, Value = strIssueColumns };

                Response.Cookies.Add(httpCookie);
            }

            OnRebindCommand(EventArgs.Empty);
        }

        /// <summary>
        /// Raises the rebind command event.
        /// </summary>
        /// <param name="e">The <see cref="T:System.EventArgs"/> instance containing the event data.</param>
        void OnRebindCommand(EventArgs e)
        {
            if (RebindCommand != null)
                RebindCommand(this, e);
        }

        /// <summary>
        /// Gets or sets the index of the current page.
        /// </summary>
        /// <value>The index of the current page.</value>
        public int CurrentPageIndex
        {
            get { return gvIssues.PageIndex; }
            set { gvIssues.PageIndex = value; }
        }

        /// <summary>
        /// Gets or sets a value indicating whether [show project column].
        /// </summary>
        /// <value><c>true</c> if [show project column]; otherwise, <c>false</c>.</value>
        public bool ShowProjectColumn
        {
            get { return ViewState.Get("ShowProjectColumn", false); }
            set { ViewState.Set("ShowProjectColumn", value); }
        }

        /// <summary>
        /// Gets or sets the sort field.
        /// </summary>
        /// <value>The sort field.</value>
        public string SortField
        {
            get { return ViewState.Get("SortField", String.Empty); }
            set
            {
                if (value == SortField) SortAscending = !SortAscending;
                ViewState.Set("SortField", value);
            }
        }

        /// <summary>
        /// Gets or sets a value indicating whether [sort ascending].
        /// </summary>
        /// <value><c>true</c> if [sort ascending]; otherwise, <c>false</c>.</value>
        public bool SortAscending
        {
            get { return ViewState.Get("SortAscending", false); }
            set { ViewState.Set("SortAscending", value); }
        }

        /// <summary>
        /// Gets or sets a value indicating whether [sort ascending].
        /// </summary>
        /// <value><c>true</c> if [sort ascending]; otherwise, <c>false</c>.</value>
        public string SortString
        {
            get { return ViewState.Get("SortString", string.Empty); }
            set { ViewState.Set("SortString", value); }
        }

        /// <summary>
        /// Gets or sets the size of the page.
        /// </summary>
        /// <value>The size of the page.</value>
        public int PageSize
        {
            get { return pager.PageSize; }
            set { pager.PageSize = value; }
        }

        /// <summary>
        /// Handles the PreRender event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void Page_PreRender(object sender, EventArgs e)
        {
            if (gvIssues.HeaderRow != null)
                gvIssues.HeaderRow.TableSection = TableRowSection.TableHeader;
        }

        /// <summary>
        /// Handles the RowDataBound event of the gvIssues control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="T:System.Web.UI.WebControls.GridViewRowEventArgs"/> instance containing the event data.</param>
        protected void gvIssues_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType != DataControlRowType.DataRow) return;
            var issue = e.Row.DataItem as Issue;

            if (issue == null) return;

            // set the custom field values
            var i = FIXED_COLUMNS + 1;

            foreach (var value in issue.IssueCustomFields.Select(customFieldValue => customFieldValue.FieldValue))
            {
                e.Row.Cells[i].Text = value;

                // this is not an ideal method to replace user custom field names with the display name.
                // if a value is stored in any other custom field with the same name as the user then it will be replaced with the display name.
                if(!string.IsNullOrWhiteSpace(value))
                {
                    var name = UserManager.GetUserDisplayName(value);
                    e.Row.Cells[i].Text = name;
                }

                DateTime dt;
                if(DateTime.TryParse(value, out dt))
                {
                    e.Row.Cells[i].Text = dt.ToShortDateString();
                }
                else if (value.Trim().ToLower().StartsWith("http"))
                {
                    e.Row.Cells[i].Text = string.Format("<a href='{0}' target='_blank'>{0}</a>", value);
                }

                i++;
            }

            e.Row.FindControl("PrivateIssue").Visible = issue.Visibility != 0;

            ((HtmlControl)e.Row.FindControl("AssignedUser")).Attributes.Add("title", "Id: " + issue.AssignedUser.Id + Environment.NewLine + 
                                                                                     "UserName: " + issue.AssignedUser.UserName + Environment.NewLine +
                                                                                     "DisplayName: " + issue.AssignedUser.DisplayName);
            ((HtmlControl)e.Row.FindControl("ProgressBar")).Attributes.CssStyle.Add("width", issue.Progress + "%");
            ((HtmlControl)e.Row.FindControl("ProgressBar")).Attributes.Add("aria-valuenow", issue.Progress.ToString());
        }

        /// <summary>
        /// Handles the Sorting event of the gvIssues control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="T:System.Web.UI.WebControls.GridViewSortEventArgs"/> instance containing the event data.</param>
        protected void gvIssues_Sorting(object sender, GridViewSortEventArgs e)
        {
            SortString = e.SortExpression;
            gvIssues.SortField = e.SortExpression;
            OnRebindCommand(EventArgs.Empty);
        }

        /// <summary>
        /// Handles the PageIndexChanging event of the gvIssues control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="T:System.Web.UI.WebControls.GridViewPageEventArgs"/> instance containing the event data.</param>
        protected void gvIssues_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvIssues.PageIndex = e.NewPageIndex; // needed for server side paging
            OnRebindCommand(EventArgs.Empty);
        }

        protected string GetDueDate(object dataItem)
        {
            var issue = (Issue)dataItem;
            if (issue.DueDate == DateTime.MinValue)
                return GetLocalResourceObject("None").ToString();
            else
                return issue.DueDate.ToShortDateString();
        }
    }
}
