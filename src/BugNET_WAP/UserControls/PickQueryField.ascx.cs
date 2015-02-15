using System;
using System.Data;
using System.Web.UI.WebControls;
using BugNET.BLL;
using BugNET.Common;
using BugNET.Entities;

namespace BugNET.UserControls
{
    /// <summary>
    ///	 This user control displays the query clause used in the QueryDetail.aspx page.
    /// </summary>
    public partial class PickQueryField : System.Web.UI.UserControl
    {
        /// <summary>
        /// The ProjectId property is used to retrieve the proper status, milestone,
        /// and priority values for the current project.
        /// </summary>
        /// <value>The project id.</value>
        public int ProjectId
        {
            get
            {
                if (ViewState["ProjectId"] == null) return 0;
                return (int)ViewState["ProjectId"];
            }
            set { ViewState["ProjectId"] = value; }
        }

        /// <summary>
        /// The custom field id.
        /// </summary>
        /// <returns>The id of the custom field selected, otherwise null</returns>
        public int? CustomFieldId
        {
            get { return ViewState.Get<int?>("CustomFieldId", null); }
            set { ViewState.Set("CustomFieldId", value); }
        }

        /// <summary>
        /// Identify whether each control is a custom field builder.
        /// </summary>
        /// <value><c>true</c> if [custom field query]; otherwise, <c>false</c>.</value>
        public bool CustomFieldSelected
        {
            get { return ViewState.Get("CustomFieldSelected", false); }
            set { ViewState.Set("CustomFieldSelected", value); }
        }

        ValidationDataType CustomFieldDataType
        {
            get { return ViewState.Get("CustomFieldDataType", ValidationDataType.String); }
            set { ViewState.Set("CustomFieldDataType", value); }
        }

        /// <summary>
        /// This property represents the AND, OR, AND NOT, OR NOT values. Notice
        /// that we check whether the posted value actually exists in the drop down list.
        ///  We do this to prevent SQL Injection Attacks.
        /// </summary>
        /// <value>The Boolean operator.</value>
        public string BooleanOperator
        {
            get
            {
                if (dropBooleanOperator.Items.FindByValue(dropBooleanOperator.SelectedValue) == null)
                    throw new Exception("Invalid Boolean Operator");

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
                    throw new Exception("Invalid Field Name");

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
                    throw new Exception("Invalid Comparison Operator");

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
                    case "LastUpdateAsDate":
                    case "DateCreatedAsDate":
                    case "IssueDueDate":
                        return DateValue.SelectedValue != null ? ((DateTime)DateValue.SelectedValue).ToString("yyyy-MM-dd") : string.Empty;
                    default:
                        if (CustomFieldSelected)
                        {
                            var cf = CustomFieldManager.GetByProjectId(ProjectId).Find(c => c.Name == dropField.SelectedValue);

                            if (cf != null)
                            {
                                CustomFieldId = cf.Id;

                                if (cf.FieldType == CustomFieldType.DropDownList || cf.FieldType == CustomFieldType.YesNo)
                                    return dropValue.SelectedValue;

                                if (cf.FieldType == CustomFieldType.Date)
                                    return DateValue.SelectedValue != null ? ((DateTime)DateValue.SelectedValue).ToString("yyyy-MM-dd") : string.Empty;  
                            }
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
                    case "IssueProgress":
                        return SqlDbType.Int;
                    case "IssueEstimation":
                    case "TimeLogged":
                        return SqlDbType.Decimal;
                    case "IssueAssignedUserId":
                    case "IssueOwnerUserId":
                    case "IssueCreatorUserId":
                        return SqlDbType.NVarChar;
                    case "DateCreatedAsDate":
                    case "LastUpdateAsDate":
                    case "IssueDueDate":
                        return SqlDbType.DateTime;
                    default:

                        if (CustomFieldId.HasValue)
                        {
                            switch (CustomFieldDataType)
                            {
                                case ValidationDataType.String:
                                    return SqlDbType.NVarChar;
                                case ValidationDataType.Integer:
                                    return SqlDbType.Int;
                                case ValidationDataType.Double:
                                    return SqlDbType.Float;
                                case ValidationDataType.Date:
                                    return SqlDbType.DateTime;
                                case ValidationDataType.Currency:
                                    return SqlDbType.Money;
                                default:
                                    return SqlDbType.NVarChar;
                            }
                        }

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
                    return new QueryClause(BooleanOperator, "", "", "", SqlDbType.NVarChar);

                var fieldName = FieldName;

                if (fieldName.ToLower().Equals("issueid"))
                {
                    fieldName = "iv.[IssueId]";
                }

                if (fieldName.ToLower().Equals("projectid"))
                {
                    fieldName = "iv.[ProjectId]";
                }

                return dropField.SelectedValue == "0" ?
                    null :
                    new QueryClause(BooleanOperator, fieldName, ComparisonOperator, FieldValue, DataType, CustomFieldId);
            }
            set
            {
                if (value == null) return;

                dropBooleanOperator.SelectedValue = value.BooleanOperator;
                dropComparisonOperator.SelectedValue = value.ComparisonOperator;

                if (value.CustomFieldQuery)
                {
                    dropField.DataSource = CustomFieldManager.GetByProjectId(ProjectId);
                    dropField.DataTextField = "Name";
                    dropField.DataValueField = "Name";
                    dropField.DataBind();// bind to the new data source.
                    dropField.Items.Add(GetGlobalResourceObject("SharedResources", "DropDown_ResetFields").ToString());
                    dropField.Items.Insert(0, new ListItem(GetGlobalResourceObject("SharedResources", "DropDown_SelectCustomField").ToString(), "0"));
                    CustomFieldSelected = true;
                }

                // need to be set to true if we are setting the values otherwise the value property would be read only
                txtValue.Visible = true;
                DateValue.Visible = true;
                dropField.Visible = true;

                dropField.SelectedValue = value.FieldName;
                CustomFieldId = value.CustomFieldId;
                txtValue.Text = value.FieldValue;

                if (value.CustomFieldId.HasValue)
                {
                    var cf = CustomFieldManager.GetById(value.CustomFieldId.Value);
                    CustomFieldDataType = cf.DataType;
                }

                try
                {
                    dropValue.SelectedValue = value.FieldValue;

                    if(value.DataType == SqlDbType.DateTime || value.CustomFieldQuery)
                    {
                        if (value.FieldValue.Is<DateTime>())
                        {
                            DateValue.SelectedValue = value.FieldValue.To<DateTime>();
                        }
                    }
                }
                catch (Exception) { }

                dropFieldSelectedIndexChanged(this, new EventArgs());

            }
        }

        /// <summary>
        /// Handles the PreRender event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void Page_PreRender(object sender, EventArgs e)
        {
            //hide votes column if issue voting is disabled
            if (!ProjectManager.GetById(ProjectId).AllowIssueVoting)
                dropField.Items.Remove(dropField.Items.FindByValue("IssueVotes"));

            if (CustomFieldManager.GetByProjectId(ProjectId).Count == 0)
                dropField.Items.Remove("CustomFieldName");

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

            dropValue.Visible = false;
            txtValue.Visible = false;
            DateValue.Visible = false;

            switch (dropField.SelectedValue)
            {
                case "IssueId":
                case "IssueTitle":
                case "IssueDescription":
                case "IssueVotes":
                case "IssueProgress":
                case "IssueEstimation":
                case "TimeLogged":
                    txtValue.Visible = true;
                    break;
                case "IssuePriorityId":
                    dropValue.Visible = true;

                    dropValue.DataSource = PriorityManager.GetByProjectId(ProjectId);
                    dropValue.DataTextField = "Name";
                    dropValue.DataValueField = "Id";
                    break;
                case "IssueTypeId":
                    dropValue.Visible = true;

                    dropValue.DataSource = IssueTypeManager.GetByProjectId(ProjectId);
                    dropValue.DataTextField = "Name";
                    dropValue.DataValueField = "Id";
                    break;
                case "IssueMilestoneId":
                    dropValue.Visible = true;

                    dropValue.DataSource = MilestoneManager.GetByProjectId(ProjectId);
                    dropValue.DataTextField = "Name";
                    dropValue.DataValueField = "Id";
                    break;
                case "IssueAffectedMilestoneId":
                    dropValue.Visible = true;

                    dropValue.DataSource = MilestoneManager.GetByProjectId(ProjectId);
                    dropValue.DataTextField = "Name";
                    dropValue.DataValueField = "Id";
                    break;
                case "IssueResolutionId":
                    dropValue.Visible = true;

                    dropValue.DataSource = ResolutionManager.GetByProjectId(ProjectId);
                    dropValue.DataTextField = "Name";
                    dropValue.DataValueField = "Id";
                    break;
                case "IssueCategoryId":
                    dropValue.Visible = true;

                    var objCats = new CategoryTree();
                    dropValue.DataSource = objCats.GetCategoryTreeByProjectId(ProjectId);
                    dropValue.DataTextField = "Name";
                    dropValue.DataValueField = "Id";

                    break;
                case "IssueStatusId":
                    dropValue.Visible = true;

                    dropValue.DataSource = StatusManager.GetByProjectId(ProjectId);
                    dropValue.DataTextField = "Name";
                    dropValue.DataValueField = "Id";
                    break;
                case "IssueAssignedUserId":
                    dropValue.Visible = true;

                    dropValue.DataSource = UserManager.GetUsersByProjectId(ProjectId);
                    dropValue.DataTextField = "DisplayName";
                    dropValue.DataValueField = "Id";
                    break;
                case "IssueOwnerUserId":
                    dropValue.Visible = true;
                    txtValue.Visible = false;
                    dropValue.DataSource = UserManager.GetUsersByProjectId(ProjectId);
                    dropValue.DataTextField = "DisplayName";
                    dropValue.DataValueField = "Id";
                    break;
                case "IssueCreatorUserId":
                    dropValue.Visible = true;

                    dropValue.DataSource = UserManager.GetUsersByProjectId(ProjectId);
                    dropValue.DataTextField = "DisplayName";
                    dropValue.DataValueField = "Id";
                    break;
                case "DateCreatedAsDate":
                case "LastUpdateAsDate":
                case "IssueDueDate":
                    DateValue.Visible = true;
                    break;
                case "CustomFieldName":

                    dropValue.Visible = false;
                    txtValue.Visible = true;  //show the text value field. Not needed.
                    CustomFieldSelected = true;

                    if (CustomFieldManager.GetByProjectId(ProjectId).Count > 0)
                    {
                        dropField.DataSource = CustomFieldManager.GetByProjectId(ProjectId);
                        dropField.DataTextField = "Name";
                        dropField.DataValueField = "Name";
                        dropField.DataBind();// bind to the new data source.
                        dropField.Items.Add(GetGlobalResourceObject("SharedResources", "DropDown_ResetFields").ToString());
                        dropField.Items.Insert(0, new ListItem(GetGlobalResourceObject("SharedResources", "DropDown_SelectCustomField").ToString(), "0"));
                    }
                    break;
                default:
                    if (dropField.SelectedItem.Text.Equals(GetGlobalResourceObject("SharedResources", "DropDown_SelectCustomField").ToString())) return;

                    // The user decides to reset the fields
                    if (dropField.SelectedItem.Text.Equals(GetGlobalResourceObject("SharedResources", "DropDown_ResetFields").ToString()))
                    {
                        dropField.DataSource = null;
                        dropField.DataSource = RequiredFieldManager.GetRequiredFields();
                        dropField.DataTextField = "Name";
                        dropField.DataValueField = "Value";
                        dropField.DataBind();
                    }

                    //RW Once the list is populated with any varying type of name,
                    //we just default to this case, because we know it is not a standard field.	
                    else
                    {
                        //check the type of this custom field and load the appropriate values.
                        var cf = CustomFieldManager.GetByProjectId(ProjectId).Find(c => c.Name == dropField.SelectedValue);

                        if (cf == null) return;

                        CustomFieldSelected = true;
                        CustomFieldId = cf.Id;
                        CustomFieldDataType = cf.DataType;

                        switch (cf.FieldType)
                        {
                            case CustomFieldType.DropDownList:
                                dropValue.Visible = true;
                                dropValue.DataSource = CustomFieldSelectionManager.GetByCustomFieldId(cf.Id);
                                dropValue.DataTextField = "Name";
                                dropValue.DataValueField = "Value";
                                break;
                            case CustomFieldType.Date:
                                DateValue.Visible = true;
                                break;
                            case CustomFieldType.YesNo:
                                dropValue.Visible = true;
                                dropValue.Items.Add(new ListItem(GetGlobalResourceObject("SharedResources", "DropDown_SelectOne").ToString()));
                                dropValue.Items.Add(new ListItem(GetGlobalResourceObject("SharedResources", "Yes").ToString(), Boolean.TrueString));
                                dropValue.Items.Add(new ListItem(GetGlobalResourceObject("SharedResources", "No").ToString(), Boolean.FalseString));
                                break;
                            default:
                                txtValue.Visible = true;
                                break;
                        }
                    }
                    break;
            }
            try
            {
                dropValue.DataBind();
            }
            catch { }
        }

    }
}
