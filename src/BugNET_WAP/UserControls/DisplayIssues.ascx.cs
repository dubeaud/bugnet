using System.Linq;

namespace BugNET.UserControls
{
    using System;
    using System.Collections.Generic;
    using System.Web.UI;
    using System.Web.UI.HtmlControls;
    using System.Web.UI.WebControls;
    using BugNET.BLL;
    using BugNET.Common;
    using BugNET.Entities;
    using BugNET.UserInterfaceLayer;

    /// <summary>
	///	Display Issues grid
	/// </summary>
	public partial class DisplayIssues : UserControl
	{
        /// <summary>
        /// Datasource 
        /// </summary>
		private List<Issue> _DataSource;
        /// <summary>
        /// Event that fires on a databind
        /// </summary>
		public event EventHandler RebindCommand;
        /// <summary>
        /// Array of issue columns
        /// </summary>
        private string[] _arrIssueColumns = new string[] { "4", "5", "6", "7", "8", "9", "10","11","12","13","14","15","16","17","18","19","20","21", "22"};

        //store amount of fixed search columns due to bad string above
        public const int FixedColumns = 22;
        //stores total amount of columns (fixed and custom)
        //private int nrColumns = FixedColumns;

        /// <summary>
        /// Handles the Init event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void Page_Init(object sender, System.EventArgs e)
        {
            if (Page.User.Identity.IsAuthenticated)
            {
                string columns = null;
                int projectId;
                if (Int32.TryParse(Request.QueryString["pid"], out projectId))
                {
                    columns = UserManager.GetSelectedIssueColumnsByUserName(Security.GetUserName(), projectId);

                    if (!string.IsNullOrEmpty(columns))
                        _arrIssueColumns = columns.Trim().Split();
                }
                //if it is myIssues and not a specific project
                else
                {
                    if (!string.IsNullOrEmpty(WebProfile.Current.SelectedIssueColumns))
                    _arrIssueColumns = WebProfile.Current.SelectedIssueColumns.Trim().Split();
                }
            }
            else
            {
                if ((Request.Cookies[Globals.ISSUE_COLUMNS] != null) && (Request.Cookies[Globals.ISSUE_COLUMNS].Value != String.Empty))
                    _arrIssueColumns = Request.Cookies[Globals.ISSUE_COLUMNS].Value.Split();
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
			get { return _DataSource; }
			set { _DataSource = value; }
		}

        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void Page_Load(object sender, System.EventArgs e)
        {
  
        }

        /// <summary>
        /// Binds a data source to the invoked server control and all its child controls.
        /// </summary>
        public void DataBind() 
		{
			if(this.DataSource.Count > 0)
			{
                if (!string.IsNullOrEmpty(gvIssues.SortField))
                {
                   _DataSource.Sort(new ObjectComparer<Issue>(gvIssues.SortField, true));
                }

				gvIssues.Visible = true;
                pager.Visible = true;
                ScrollPanel.Visible = true;
                
                int pId = -1;
                if (Request.QueryString["pid"] != null)
                    pId = Int32.Parse(Request.QueryString["pid"]);

                //get custom fields for project
                if (pId != -1)
                {
                    List<CustomField> customFields = CustomFieldManager.GetByProjectId(pId);

                    int nrColumns = FixedColumns;
                    //checks if its initial load to add custom controls and checkboxes
                    if (gvIssues.Columns.Count <= nrColumns + 1)
                    {
                        //if there is custom fields add them
                        if (customFields.Count > 0)
                        {
                            //ctlCustomFields.DataSource = customFields;
                           // ctlCustomFields.DataBind();

                            foreach (CustomField value in customFields)
                            {
                                //increments nr of columns
                                nrColumns++;

                                //create checkbox item
                                ListItem lstValue = new ListItem(value.Name, nrColumns.ToString());

                                //find custom controls that has been checked and check them
                                bool selected = Array.IndexOf(_arrIssueColumns, nrColumns.ToString()) >= 0;
                                if (selected)
                                    lstValue.Selected = true;

                                //add item to checkbox list
                                lstIssueColumns.Items.Add(lstValue);

                                //create column for custom control
                                TemplateField tf = new TemplateField();
                                tf.HeaderText = value.Name;
                                //tf.SortExpression = value.Name;
                                gvIssues.Columns.Add(tf);

                            }
                        }

                    }
                }

                DisplayColumns();
                SelectColumnsPanel.Visible = true;
				lblResults.Visible=false;

                if (ShowProjectColumn)
                {
                    gvIssues.Columns[0].Visible = false;
                    LeftButtonContainerPanel.Visible = false;
                }
                else
                {
                    gvIssues.Columns[4].Visible = false;
                    lstIssueColumns.Items.Remove(lstIssueColumns.Items.FindByValue("4"));

                    int projectId = ((Issue)_DataSource[0]).ProjectId;

                    //hide votes column if issue voting is disabled
                    if (!ProjectManager.GetById(projectId).AllowIssueVoting)
                    {
                        gvIssues.Columns[4].Visible = false;
                        lstIssueColumns.Items.Remove(lstIssueColumns.Items.FindByValue("4"));
                    }


                    if (Page.User.Identity.IsAuthenticated && UserManager.HasPermission(projectId, Globals.Permission.EditIssue.ToString()))
                    {
                        LeftButtonContainerPanel.Visible = true;
                    }
                    else
                    {
                        //hide selection column for unauthenticated users 
                        gvIssues.Columns[0].Visible = false;
                        LeftButtonContainerPanel.Visible = false;
                    }

                    CategoryTree categories = new CategoryTree();
                    dropCategory.DataSource = categories.GetCategoryTreeByProjectId(projectId);
                    dropCategory.DataBind();
                    dropMilestone.DataSource = MilestoneManager.GetByProjectId(projectId);
                    dropMilestone.DataBind();
                    dropAffectedMilestone.DataSource = MilestoneManager.GetByProjectId(projectId);
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
                }

                foreach (string colIndex in _arrIssueColumns)
                {
                    ListItem item = lstIssueColumns.Items.FindByValue(colIndex);
                    if (item != null)
                        item.Selected = true;
                }

                gvIssues.DataSource = this.DataSource;
                gvIssues.DataBind();

                InsertCustomFieldData();

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
        /// Retrieves and inserts custom field values
        /// </summary>
        private void InsertCustomFieldData()
        {
            //if there exist custom fields
            if (gvIssues.Columns.Count > FixedColumns)
            {
                foreach (GridViewRow row in gvIssues.Rows)
                {
                    //get issue id from grid
                    int id = (int)gvIssues.DataKeys[row.RowIndex].Value;
                    //get custom controls assigned to that issue
                    List<CustomField> customFieldValues = CustomFieldManager.GetByIssueId(id);

                    //for every custom control add relevant value (make use of const value)
                    for (int i = FixedColumns + 1; i <= gvIssues.Columns.Count - 1; i++)
                    {
                        CustomField value = customFieldValues[i - (FixedColumns + 1)];
                        row.Cells[i].Text = value.Value;
                    }
                }
            }
        }

        /// <summary>
        /// Handles the Click event of the ExportExcelButton control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void ExportExcelButton_Click(object sender, EventArgs e)
        {
            GridViewExportUtil.Export("Issues.xls", this.gvIssues);
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
            //foreach (var colIndex in _arrIssueColumns)
            //    gvIssues.Columns[Int32.Parse(colIndex)].Visible = true;
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

                    if(!int.TryParse(s, out issueId))
                        throw new Exception(string.Format(LoggingManager.GetErrorMessageResource("InvalidIssueId"), s));

                    var issue = IssueManager.GetById(issueId);

                    if (issue == null) continue;

                    var dueDate = DateTime.MinValue;

                    if(DueDate.SelectedValue != null)
                        dueDate = (DateTime)DueDate.SelectedValue;

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

                    issue.DueDate = dueDate;

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

                 if (((CheckBox)gvr.Cells[0].Controls[1]).Checked)
                 {
                     var dataKey = gvIssues.DataKeys[gvr.RowIndex];
                     if (dataKey != null) ids += dataKey.Value + ",";
                 }
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
                int projectId;
                if (Int32.TryParse(Request.QueryString["pid"], out projectId))
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
                Response.Cookies[Globals.ISSUE_COLUMNS].Value = strIssueColumns;
                Response.Cookies[Globals.ISSUE_COLUMNS].Path = "/";
                Response.Cookies[Globals.ISSUE_COLUMNS].Expires = DateTime.MaxValue;
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
            get
            {
                object o = ViewState["ShowProjectColumn"];
                if (o == null)
                {
                    return false;
                }
                return (bool)o;
            }
            set
            {
                ViewState["ShowProjectColumn"] = value;
            }

        }

        /// <summary>
        /// Gets or sets the sort field.
        /// </summary>
        /// <value>The sort field.</value>
		public string SortField 
		{
			get 
			{
				object o = ViewState["SortField"];
				if (o == null) 
				{
					return String.Empty;
				}
				return (string)o;
			}
    
			set 
			{
				if (value == SortField) 
				{
					// same as current sort file, toggle sort direction
					SortAscending = !SortAscending;
				}
				ViewState["SortField"] = value;
			}
		}

        /// <summary>
        /// Gets or sets a value indicating whether [sort ascending].
        /// </summary>
        /// <value><c>true</c> if [sort ascending]; otherwise, <c>false</c>.</value>
		public bool SortAscending 
		{
			get 
			{
				object o = ViewState["SortAscending"];
				if (o == null) 
				{
					return true;
				}
				return (bool)o;
			}
    
			set 
			{
				ViewState["SortAscending"] = value;
			}
		}

        /// <summary>
        /// Gets or sets the size of the page.
        /// </summary>
        /// <value>The size of the page.</value>
        public int PageSize
        {
            get { return pager.PageSize; }
            set
            {
                pager.PageSize = value;
            }      
        }

        /// <summary>
        /// Handles the PreRender event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void Page_PreRender(object sender, EventArgs e)
        {
            if(gvIssues.HeaderRow !=null)
                gvIssues.HeaderRow.TableSection = TableRowSection.TableHeader;
        }

        /// <summary>
        /// Handles the RowDataBound event of the gvIssues control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="T:System.Web.UI.WebControls.GridViewRowEventArgs"/> instance containing the event data.</param>
        protected void gvIssues_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes.Add("onmouseover", "this.style.background='#F7F7EC'");

                if (e.Row.RowState == DataControlRowState.Normal)
                    e.Row.Attributes.Add("onmouseout", "this.style.background=''");
                else if (e.Row.RowState == DataControlRowState.Alternate)
                    e.Row.Attributes.Add("onmouseout", "this.style.background='#fafafa'");
 
                Issue b = ((Issue)e.Row.DataItem);

                //Private issue check
                if (b.Visibility == (int)Globals.IssueVisibility.Private && b.AssignedDisplayName != Security.GetUserName() && b.CreatorDisplayName != Security.GetUserName() && (!UserManager.IsInRole(Globals.SUPER_USER_ROLE) || !UserManager.IsInRole(Globals.ProjectAdminRole)))
                    e.Row.Visible = false;

                e.Row.FindControl("imgPrivate").Visible = b.Visibility == 0 ? false : true;

                double warnPeriod = 7; //TODO: Add this to be configurable in the users profile
                bool isDue = b.DueDate <= DateTime.Now.AddDays(warnPeriod) && b.DueDate > DateTime.MinValue;
                bool noOwner = b.AssignedUserId == Guid.Empty;
                //if (noOwner || isDue)
                //{
                //    e.Row.Attributes.Add("style", "background-color:#ffdddc");
                //    e.Row.Attributes.Add("onmouseout", "this.style.background='#ffdddc'");
                //}
                ((HtmlControl)e.Row.FindControl("ProgressBar")).Attributes.CssStyle.Add("width", b.Progress.ToString() + "%"); 
            }
        }
   
        /// <summary>
        /// Handles the Sorting event of the gvIssues control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="T:System.Web.UI.WebControls.GridViewSortEventArgs"/> instance containing the event data.</param>
        protected void gvIssues_Sorting(object sender, GridViewSortEventArgs e)
        {
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
            gvIssues.PageIndex = e.NewPageIndex;
            OnRebindCommand(EventArgs.Empty);
        }
   
    }
}
