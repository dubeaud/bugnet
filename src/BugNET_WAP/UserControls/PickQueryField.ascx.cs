namespace BugNET.UserControls
{
	using System;
	using System.Data;
    using System.Web.UI.WebControls;
    using BugNET.BLL;
    using BugNET.Entities;

	/// <summary>
    ///	 This user control displays the query clause used in the QueryDetail.aspx page.
	/// </summary>
	public partial class PickQueryField : System.Web.UI.UserControl
	{
		#region Web Form Designer generated code
		override protected void OnInit(EventArgs e)
		{
			//
			// CODEGEN: This call is required by the ASP.NET Web Form Designer.
			//
			InitializeComponent();
			base.OnInit(e);
		}
		
		/// <summary>
		///		Required method for Designer support - do not modify
		///		the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{

		}
		#endregion

        /// <summary>
        /// The ProjectId property is used to retrieve the proper status, milestone,
        /// and priority values for the current project.
        /// </summary>
        /// <value>The project id.</value>
		public int ProjectId 
		{
			get 
			{
				if (ViewState["ProjectId"] == null)
					return 0;
				else
					return (int)ViewState["ProjectId"];
			}
			set {ViewState["ProjectId"] = value; }
		}

         /// <summary>
        /// Identify whether each control is a custom field builder.
        /// </summary>
        /// <value><c>true</c> if [custom field query]; otherwise, <c>false</c>.</value>
        public bool CustomFieldQuery
        {
            get
            {
                if (ViewState["CustomFieldQuery"] == null)
                    return false;
                else
                    return (bool)ViewState["CustomFieldQuery"];
            }
            set { ViewState["CustomFieldQuery"] = value; }
        }

        /// <summary>
        /// When the user changes the selected field type, show the corresponding list
        /// of possible values.
        /// </summary>
        /// <param name="s">The s.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
		protected void dropFieldSelectedIndexChanged(Object s, EventArgs e) 
		{
			dropValue.Items.Clear();
			switch (dropField.SelectedValue) 
			{
                case "IssueId":
                    dropValue.Visible = false;
                    txtValue.Visible = true;
                    DateValue.Visible = false;
                    break;
                case "IssueTitle":
                    dropValue.Visible = false;
                    txtValue.Visible = true;
                    DateValue.Visible = false;
                    break;
                case "IssueDescription":
                    dropValue.Visible = false;
                    txtValue.Visible = true;
                    DateValue.Visible = false;
                    break;
                case "IssueVotes":
                    dropValue.Visible = false;
                    txtValue.Visible = true;
                    DateValue.Visible = false;
                    break;
				case "IssuePriorityId" :
					dropValue.Visible = true;
					txtValue.Visible = false;
					dropValue.DataSource = PriorityManager.GetByProjectId(ProjectId);
					dropValue.DataTextField = "Name";
					dropValue.DataValueField = "Id";
                    DateValue.Visible = false;
					break;
				case "IssueTypeId":
					dropValue.Visible = true;
					txtValue.Visible = false;
					dropValue.DataSource = IssueTypeManager.GetByProjectId(ProjectId);
					dropValue.DataTextField = "Name";
					dropValue.DataValueField = "Id";
                    DateValue.Visible = false;
					break;
				case "IssueMilestoneId" :
					dropValue.Visible = true;
					txtValue.Visible = false;
					dropValue.DataSource = MilestoneManager.GetByProjectId(ProjectId);
					dropValue.DataTextField = "Name";
					dropValue.DataValueField = "Id";
                    DateValue.Visible = false;
					break;
                case "IssueAffectedMilestoneId":
                    dropValue.Visible = true;
                    txtValue.Visible = false;
                    dropValue.DataSource = MilestoneManager.GetByProjectId(ProjectId);
                    dropValue.DataTextField = "Name";
                    dropValue.DataValueField = "Id";
                    break;
                case "IssueResolutionId":
                    dropValue.Visible = true;
                    txtValue.Visible = false;
                    dropValue.DataSource = ResolutionManager.GetByProjectId(ProjectId);
                    dropValue.DataTextField = "Name";
                    dropValue.DataValueField = "Id";
                    DateValue.Visible = false;
                    break;
				case "IssueCategoryId" :
					dropValue.Visible = true;
					txtValue.Visible = false;
					CategoryTree objCats = new CategoryTree();
					dropValue.DataSource = objCats.GetCategoryTreeByProjectId(ProjectId);
					dropValue.DataTextField = "Name";
					dropValue.DataValueField = "Id";
                    DateValue.Visible = false;
					break;
				case "IssueStatusId" :
					dropValue.Visible = true;
					txtValue.Visible = false;
					dropValue.DataSource = StatusManager.GetByProjectId(ProjectId);
					dropValue.DataTextField = "Name";
					dropValue.DataValueField = "Id";
                    DateValue.Visible = false;
					break;
				case "IssueAssignedUserId" :
					dropValue.Visible = true;
					txtValue.Visible = false;                  
					dropValue.DataSource = UserManager.GetUsersByProjectId(ProjectId);
					dropValue.DataTextField = "DisplayName";
					dropValue.DataValueField = "Id";
                    DateValue.Visible = false;
					break;
				case "IssueOwnerUserId" :
					dropValue.Visible = true;
					txtValue.Visible = false;
					dropValue.DataSource = UserManager.GetUsersByProjectId(ProjectId);
					dropValue.DataTextField = "DisplayName";
					dropValue.DataValueField = "Id";
					break;
				case "IssueCreatorUserId" :
					dropValue.Visible = true;
					txtValue.Visible = false;
					dropValue.DataSource = UserManager.GetUsersByProjectId(ProjectId);
					dropValue.DataTextField = "DisplayName";
					dropValue.DataValueField = "Id";
                    DateValue.Visible = false;
					break;
                case "DateCreated":
                    dropValue.Visible = false;
                    txtValue.Visible = false;
                    DateValue.Visible = true;
                    break;
                case "LastUpdate":
                    dropValue.Visible = false;
                    txtValue.Visible = false;
                    DateValue.Visible = true;
                    break;
                case "IssueDueDate":
                    dropValue.Visible = false;
                    txtValue.Visible = false;
                    DateValue.Visible = true;
                    break;
                case "CustomFieldName":
                    dropValue.Visible = false;
                    txtValue.Visible = true;  //show the text value field. Not needed.
                    if (CustomFieldManager.GetByProjectId(ProjectId).Count > 0 )
                    { 
                        dropField.DataSource = CustomFieldManager.GetByProjectId(ProjectId);
                        dropField.DataTextField = "Name";
                        dropField.DataValueField = "Name";
                        dropField.DataBind();// bind to the new datasource.
                        dropField.Items.Add("--Reset Fields--");
                        dropField.Items.Insert(0, new ListItem("-- Select Custom Field --","0"));
                        CustomFieldQuery = true;
                    } 
                    break;
				default :
                    if (dropField.SelectedItem.Text.Equals("-- Select Custom Field --".ToString()))
                        return;
                    // The user decides to reset the fields
                    if (dropField.SelectedItem.Text.Equals("--Reset Fields--".ToString()))
                    {
                        dropField.DataSource = null;
                        dropField.DataSource = RequiredFieldManager.GetRequiredFields();
                        dropField.DataTextField = "Name";
                        dropField.DataValueField = "Value";
                        dropField.DataBind();
                        CustomFieldQuery = false;
                    }
                    //RW Once the list is populated with any varying type of name,
                    //we just default to this case, because we know it is not a standard field.	
                    else
                    {
                        //check the type of this custom field and load the appropriate values.
                        CustomField cf = CustomFieldManager.GetByProjectId(ProjectId).Find(delegate(CustomField  c) { return c.Name == dropField.SelectedValue; });
                        if (cf == null)
                            return;

                        if (cf.FieldType == Common.CustomFieldType.DropDownList)
                        {
                            txtValue.Visible = false;
                            dropValue.Visible = true;
                            dropValue.DataSource = CustomFieldSelectionManager.GetByCustomFieldId(cf.Id);
                            dropValue.DataTextField = "Name";
                            dropValue.DataValueField = "Value";
                        }
                        else if (cf.FieldType == Common.CustomFieldType.Date)
                        {
                            dropValue.Visible = false;
                            txtValue.Visible = false;
                            DateValue.Visible = true;
                        }
                        else
                        {
                            dropValue.Visible = false;
                            txtValue.Visible = true;
                            DateValue.Visible = false;
                        }
                    }
					break;
			}
            try{
			    dropValue.DataBind();
            }catch{}
		}

        /// <summary>
        /// This property represents the AND, OR, AND NOT, OR NOT values. Notice
        /// that we check whether the posted value actually exists in the drop down list.
        ///  We do this to prevent SQL Injection Attacks.
        /// </summary>
        /// <value>The boolean operator.</value>
		public string BooleanOperator 
		{
			get 
			{
				if (dropBooleanOperator.Items.FindByValue(dropBooleanOperator.SelectedValue) == null)
					throw new Exception( "Invalid Boolean Operator" );

				return dropBooleanOperator.SelectedValue;
			}
		}

        /// <summary>
        /// This property represents the name of the field. Notice
        /// that we check whether the posted value actually exists in the drop down list.
        /// We do this to prevent SQL Injection Attacks.
        /// </summary>
        /// <value>The name of the field.</value>
		public string FieldName 
		{
			get 
			{
				if (dropField.Items.FindByValue(dropField.SelectedValue) == null)
					throw new Exception( "Invalid Field Name" );

				return dropField.SelectedValue;
			}
		}

        /// <summary>
        /// This property represents the type of comparison. Notice
        /// that we check whether the posted value actually exists in the drop down list.
        /// We do this to prevent SQL Injection Attacks.
        /// </summary>
        /// <value>The comparison operator.</value>
		public string ComparisonOperator 
		{
			get 
			{
				if (dropComparisonOperator.Items.FindByValue(dropComparisonOperator.SelectedValue) == null)
					throw new Exception( "Invalid Comparison Operator" );

				return dropComparisonOperator.SelectedValue;
			}
		}

        /// <summary>
        /// Gets the field value.
        /// </summary>
        /// <value>The field value.</value>
		public string FieldValue 
		{
			get 
			{

				switch (dropField.SelectedValue) 
				{
					case "IssueCategoryId":
					case "IssuePriorityId":
					case "IssueTypeId":
					case "IssueStatusId":
					case "IssueMilestoneId":
					case "IssueAssignedUserId":
					case "IssueOwnerUserId":
					case "IssueCreatorUserId":
					case "IssueResolutionId":
					case "IssueAffectedMilestoneId":
						return dropValue.SelectedValue; 
                    case "LastUpdate":
                    case "DateCreated":
                    case "IssueDueDate":
                        return DateValue.SelectedValue != null ? ((DateTime)DateValue.SelectedValue).ToShortDateString() : string.Empty; 
					default:
                        if (CustomFieldQuery)
                        {
                            CustomField cf = CustomFieldManager.GetByProjectId(ProjectId).Find(delegate(CustomField  c) { return c.Name == dropField.SelectedValue; });
                            if (cf.FieldType == Common.CustomFieldType.DropDownList)
                                return dropValue.SelectedValue;
                        }
                        return txtValue.Text;

				}

			}
		}



        /// <summary>
        /// Gets the type of the data.
        /// </summary>
        /// <value>The type of the data.</value>
		public SqlDbType DataType 
		{
			get 
			{

				switch (dropField.SelectedValue) 
				{
					case "IssueId":
					case "IssueCategoryId":
					case "IssuePriorityId":
					case "IssueStatusId":
					case "IssueMilestoneId":
					case "IssueTypeId":
					case "IssueResolutionId":
					case "IssueAffectedMilestoneId":
                        return SqlDbType.Int;
					case "IssueAssignedUserId":
					case "IssueOwnerUserId":
					case "IssueCreatorUserId":
                        return SqlDbType.NVarChar;
					case "DateCreated":
                    case "LastUpdate":
                    case "IssueDueDate":
						return SqlDbType.DateTime;
					default:
						return SqlDbType.NVarChar;
				}

			}
		}

        /// <summary>
        /// This property contains represents the SQL clause used when building the query.
        /// </summary>
        /// <value>The query clause.</value>
		public QueryClause QueryClause 
		{
			get 
			{
				if (dropField.SelectedValue == "0" && BooleanOperator.Trim().Equals(")"))
                    return new QueryClause(BooleanOperator, "", "", "", SqlDbType.NVarChar, false);
                else if (dropField.SelectedValue == "0")
                    return null;

                return new QueryClause(BooleanOperator, FieldName, ComparisonOperator, FieldValue, DataType, CustomFieldQuery);
			}
            set
            {
                dropBooleanOperator.SelectedValue = value.BooleanOperator;
                dropComparisonOperator.SelectedValue = value.ComparisonOperator;
                if (value.CustomFieldQuery)
                {
                    dropField.DataSource = CustomFieldManager.GetByProjectId(ProjectId);
                    dropField.DataTextField = "Name";
                    dropField.DataValueField = "Name";
                    dropField.DataBind();// bind to the new datasource.
                    dropField.Items.Add("--Reset Fields--");
                    dropField.Items.Insert(0, new ListItem("-- Select Custom Field --", "0"));
                    CustomFieldQuery = true;
                }
                dropField.SelectedValue = value.FieldName;
                CustomFieldQuery = value.CustomFieldQuery;
                txtValue.Text = value.FieldValue;
                try
                {

                    dropValue.SelectedValue = value.FieldValue;
                }
                catch { }
                dropFieldSelectedIndexChanged(this, new EventArgs());

            }
		}


        /// <summary>
        /// This method clears the list of field values.
        /// </summary>
		public void Clear() 
		{
			dropBooleanOperator.SelectedIndex = -1;
			dropField.SelectedIndex = -1;
			dropComparisonOperator.SelectedIndex = -1;
			dropValue.Items.Clear();
			txtValue.Text = String.Empty;
			dropValue.Visible = true;
			txtValue.Visible = false;
		}

        /// <summary>
        /// Handles the PreRender event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void Page_PreRender(object sender, System.EventArgs e)
        {
            //hide votes column if issue voting is disabled
            if (!ProjectManager.GetProjectById(ProjectId).AllowIssueVoting)
                dropField.Items.Remove(dropField.Items.FindByValue("IssueVotes"));

            if(CustomFieldManager.GetByProjectId(ProjectId).Count == 0)
                dropField.Items.Remove("CustomFieldName");

        }


	
	}
}
