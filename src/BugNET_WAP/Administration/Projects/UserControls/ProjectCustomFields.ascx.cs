namespace BugNET.Administration.Projects.UserControls
{
    using System;
    using System.Collections.Generic;
    using System.Web.UI;
    using System.Web.UI.HtmlControls;
    using System.Web.UI.WebControls;
    using BugNET.BLL;
    using BugNET.Entities;
    using BugNET.UserInterfaceLayer;
    /// <summary>
    /// 
    /// </summary>
    public partial class ProjectCustomFields : System.Web.UI.UserControl, IEditProjectControl
    {
        protected System.Web.UI.WebControls.DataGrid grdSelectionValues;

        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="T:System.EventArgs"/> instance containing the event data.</param>
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        #region Web Form Designer generated code
        /// <summary>
        /// Raises the <see cref="E:System.Web.UI.Control.Init"></see> event.
        /// </summary>
        /// <param name="e">An <see cref="T:System.EventArgs"></see> object that contains the event data.</param>
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
            this.grdCustomFields.DeleteCommand += new System.Web.UI.WebControls.DataGridCommandEventHandler(this.DeleteCustomField);
            this.grdCustomFields.ItemDataBound += new System.Web.UI.WebControls.DataGridItemEventHandler(this.grdCustomFields_ItemDataBound);
            this.grdCustomFields.ItemCommand += new DataGridCommandEventHandler(grdCustomFields_ItemCommand);
        }

        /// <summary>
        /// Handles the ItemCreated event of the grdCustomFields control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.DataGridItemEventArgs"/> instance containing the event data.</param>
        protected void grdCustomFields_ItemCreated(object sender, System.Web.UI.WebControls.DataGridItemEventArgs e)
        {
            grdSelectionValues = (DataGrid)e.Item.FindControl("grdSelectionValues");
            if (null != grdSelectionValues)
            {
                grdSelectionValues.ItemDataBound += new DataGridItemEventHandler(this.grdSelectionValues_ItemDataBound);
                grdSelectionValues.ItemCommand += new DataGridCommandEventHandler(this.grdSelectionValues_ItemCommand);
                grdSelectionValues.CancelCommand += new DataGridCommandEventHandler(this.grdSelectionValues_CancelCommand);
                grdSelectionValues.EditCommand += new DataGridCommandEventHandler(this.grdSelectionValues_Edit);
                grdSelectionValues.UpdateCommand += new DataGridCommandEventHandler(this.grdSelectionValues_Update);
            }
        }

        /// <summary>
        /// Handles the ItemCommand event of the grdCustomFields control.
        /// </summary>
        /// <param name="source">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.DataGridCommandEventArgs"/> instance containing the event data.</param>
        protected void grdCustomFields_ItemCommand(object source, DataGridCommandEventArgs e)
        {
            //switch(e.CommandName)
            //{
            //    case "Expand":
            //        PlaceHolder ChildRows = (PlaceHolder)e.Item.Cells[grdCustomFields.Columns.Count - 1].FindControl("ChildRows");
                    
            //        ImageButton imgbtnExpand = (ImageButton)e.Item.Cells[0].FindControl("imgbtnExpand");

            //        if (imgbtnExpand.ImageUrl == "~/images/plus.gif")
            //        {
            //            imgbtnExpand.ImageUrl = "~/images/minus.gif";
            //            ChildRows.Visible = true;
            //        }
            //        else
            //        {
            //            imgbtnExpand.ImageUrl = "~/images/plus.gif";
            //            ChildRows.Visible = false;
            //        }

            //        break;
            //}
        }

        #endregion

        private int _ProjectId = -1;

        #region IEditProjectControl Members

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
        /// Updates this instance.
        /// </summary>
        /// <returns></returns>
        public bool Update()
        {
            return true;
        }

        /// <summary>
        /// Gets a value indicating whether [show save button].
        /// </summary>
        /// <value><c>true</c> if [show save button]; otherwise, <c>false</c>.</value>
        public bool ShowSaveButton
        {
            get { return false; }
        }
      
        /// <summary>
        /// Initializes this instance.
        /// </summary>
        public void Initialize()
        {
            dropDataType.DataSource = Enum.GetNames(typeof(ValidationDataType));
            dropDataType.DataBind();
            BindCustomFields();
        }

        #endregion

        /// <summary>
        /// Binds the custom fields.
        /// </summary>
        void BindCustomFields()
        {
            //check if we are editing the subgrid - needed to fire updatecommand on the nested grid.
            if (ViewState["EditingSubGrid"] == null)
            {
                grdCustomFields.DataSource = CustomFieldManager.GetCustomFieldsByProjectId(ProjectId);
                grdCustomFields.DataKeyField = "Id";
                grdCustomFields.DataBind();

                if (grdCustomFields.Items.Count == 0)
                    grdCustomFields.Visible = false;
                else
                    grdCustomFields.Visible = true;
            }
        }


        /// <summary>
        /// Handles the ItemDataBound event of the grdSelectionValues control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.DataGridItemEventArgs"/> instance containing the event data.</param>
        protected void grdSelectionValues_ItemDataBound(object sender, System.Web.UI.WebControls.DataGridItemEventArgs e)
        {
            Control container = e.Item;
            ListItemType itemType = e.Item.ItemType;

            if (itemType == ListItemType.Item || itemType == ListItemType.AlternatingItem)
            {
                if (e.Item.DataItem == null)
                {
                    return;
                }
                CustomFieldSelection cfs = (CustomFieldSelection)e.Item.DataItem;
                System.Web.UI.WebControls.Button btnDelete;
                btnDelete = (System.Web.UI.WebControls.Button)e.Item.FindControl("btnDelete");
                if (btnDelete != null)
                {                  
                    string message = string.Format(GetLocalResourceObject("ConfirmCustomFieldSelectionDelete").ToString(), cfs.Name);
                    btnDelete.Attributes.Add("onclick", String.Format("return confirm('{0}');", message));
                }
            }
            else if (itemType == ListItemType.Footer)
            {
                if (this.ViewState["CustomFieldId"] != null)
                {
                    Button btnAddSelectionValue = (Button)e.Item.FindControl("btnAddSelectionValue");
                    RequiredFieldValidator val1 = (RequiredFieldValidator)e.Item.FindControl("RequiredFieldValidator1");
                    RequiredFieldValidator val2 = (RequiredFieldValidator)e.Item.FindControl("RequiredFieldValidator2");
                    if(val1!= null & val2 !=null)
                    {
                        val1.ValidationGroup = "AddSelection" + this.ViewState["CustomFieldId"].ToString();
                        val2.ValidationGroup = "AddSelection" + this.ViewState["CustomFieldId"].ToString();
                    }

                    if (btnAddSelectionValue != null)
                    {
                        btnAddSelectionValue.ValidationGroup = "AddSelection" + this.ViewState["CustomFieldId"].ToString();
                        btnAddSelectionValue.CommandArgument =this.ViewState["CustomFieldId"].ToString();
                    }
                }
                this.ViewState["CustomFieldId"] = null;
            }
           
        }

        /// <summary>
        /// Handles the Edit event of the dg2 control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.DataGridCommandEventArgs"/> instance containing the event data.</param>
        protected void grdSelectionValues_Edit(object sender, DataGridCommandEventArgs e)
        {
            lblError.Text = String.Empty;
            Label lblCustomFieldId = (Label)e.Item.FindControl("lblCustomFieldId");

            if (lblCustomFieldId != null)
            {
                foreach (DataGridItem item in grdCustomFields.Items)
                {
                    DataGrid grdSelectionValues = (DataGrid)item.FindControl("grdSelectionValues");
                    grdSelectionValues.ShowFooter = false;
                    grdSelectionValues.EditItemIndex = -1;
                    if (lblCustomFieldId.Text == item.Cells[0].Text)
                    {
                        if (null != grdSelectionValues)
                        {
                            grdSelectionValues.EditItemIndex = e.Item.ItemIndex;
                            //set a property to say we are editing the subgrid,
                            //rebinding the master grid will not fire the update command
                            ViewState["EditingSubGrid"] = true;
                        }
                    }
                    
                }
            }
       
            BindCustomFieldSelections();

        }

        /// <summary>
        /// Handles the ItemCommand event of the grdSelectionValues control.
        /// </summary>
        /// <param name="source">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.DataGridCommandEventArgs"/> instance containing the event data.</param>
        protected void grdSelectionValues_ItemCommand(object source, System.Web.UI.WebControls.DataGridCommandEventArgs e)
        {
            CustomFieldSelection  cfs;
            int itemIndex = e.Item.ItemIndex;
            int itemId;
            switch (e.CommandName)
            {
                case "up":
                    //move row up
                    if (itemIndex == 0)
                        return;
                    itemId = Convert.ToInt32(e.Item.Cells[0].Text);
                    cfs = CustomFieldSelectionManager.GetCustomFieldSelectionById(itemId);
                    cfs.SortOrder -= 1;
                    CustomFieldSelectionManager.SaveCustomFieldSelection(cfs);
                    break;
                case "down":
                    //move row down
                    if (itemIndex == ((DataGrid)source).Items.Count - 1)
                        return;
                    itemId = Convert.ToInt32(e.Item.Cells[0].Text);
                    cfs = CustomFieldSelectionManager.GetCustomFieldSelectionById(itemId);
                    cfs.SortOrder += 1;
                    CustomFieldSelectionManager.SaveCustomFieldSelection(cfs);
                    break;
                case "add":
                    if (Page.IsValid)
                    {
                        TextBox txtAddSelectionName = (TextBox)e.Item.FindControl("txtAddSelectionName");
                        TextBox txtAddSelectionValue = (TextBox)e.Item.FindControl("txtAddSelectionValue");
                       
                        cfs = new CustomFieldSelection(Convert.ToInt32(e.CommandArgument),
                            txtAddSelectionName.Text.Trim(), 
                            txtAddSelectionValue.Text.Trim());
                        CustomFieldSelectionManager.SaveCustomFieldSelection(cfs);
                       
                    }
                    break;
            }
             
            BindCustomFieldSelections();
        }

        /// <summary>
        /// Handles the CancelCommand event of the grdSelectionValues control.
        /// </summary>
        /// <param name="source">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.DataGridCommandEventArgs"/> instance containing the event data.</param>
        protected void grdSelectionValues_CancelCommand(object source, System.Web.UI.WebControls.DataGridCommandEventArgs e)
        {
            lblError.Text = String.Empty;
            foreach (DataGridItem item in grdCustomFields.Items)
            {
                DataGrid grdSelectionValues = (DataGrid)item.FindControl("grdSelectionValues");
                if (null != grdSelectionValues)
                {
                    grdSelectionValues.ShowFooter = true;
                    grdSelectionValues.EditItemIndex = -1;
                }
            }
            ViewState["EditingSubGrid"] = null;
            BindCustomFieldSelections();
            BindCustomFields();
        }

        /// <summary>
        /// Handles the UpdateCommand event of the grdSelectionValues control.
        /// </summary>
        /// <param name="source">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.DataGridCommandEventArgs"/> instance containing the event data.</param>
        protected void grdSelectionValues_Update(object source, DataGridCommandEventArgs e)
        {
            lblError.Text = String.Empty;
            if (ListItemType.EditItem == e.Item.ItemType)
            {
                TextBox txtName =  (TextBox)e.Item.FindControl("txtEditSelectionName");
                TextBox txtValue = (TextBox)e.Item.FindControl("txtEditSelectionValue");
                if (txtName != null && txtValue != null)
                {
                    int customFieldSelectionId = (int)((DataGrid)source).DataKeys[e.Item.ItemIndex];
                    
                    CustomFieldSelection cfs = CustomFieldSelectionManager.GetCustomFieldSelectionById(customFieldSelectionId);
                    cfs.Name = txtName.Text.Trim();
                    cfs.Value = txtValue.Text.Trim();
                    CustomFieldSelectionManager.SaveCustomFieldSelection(cfs);

                    lblError.Text = String.Empty;

                    foreach (DataGridItem item in grdCustomFields.Items)
                    {
                        DataGrid grdSelectionValues = (DataGrid)item.FindControl("grdSelectionValues");
                        if (null != grdSelectionValues)
                        {
                            grdSelectionValues.ShowFooter = true;
                            grdSelectionValues.EditItemIndex = -1;
                            BindCustomFieldSelections();
                        }
                    }
                }
                ViewState["EditingSubGrid"] = null;
                BindCustomFields();
            }
        }

        /// <summary>
        /// Binds the custom field selections.
        /// </summary>
        private void BindCustomFieldSelections()
        {
            foreach (DataGridItem item in grdCustomFields.Items)
            {
                DataGrid grdSelectionValues = (DataGrid)item.FindControl("grdSelectionValues");
                if (null != grdSelectionValues)
                {
                    grdSelectionValues.DataSource = GetCustomFieldSelections(Convert.ToInt32(item.Cells[0].Text.Trim()));
                    grdSelectionValues.DataKeyField = "Id";
                    grdSelectionValues.DataBind();
                }
            }
        }

        /// <summary>
        /// Handles the Edit event of the grdCustomFields control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.DataGridCommandEventArgs"/> instance containing the event data.</param>
        protected void grdCustomFields_Edit(object sender, DataGridCommandEventArgs e)
        {           
            grdCustomFields.EditItemIndex = e.Item.ItemIndex;
            grdCustomFields.DataBind();
        }

        /// <summary>
        /// Handles the Cancel event of the grdStatus control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.DataGridCommandEventArgs"/> instance containing the event data.</param>
        protected void grdCustomFields_Cancel(object sender, DataGridCommandEventArgs e)
        {
            grdCustomFields.EditItemIndex = -1;
            grdCustomFields.DataBind();
        }

        /// <summary>
        /// Gets the custom field selections.
        /// </summary>
        /// <param name="customFieldId">The custom field id.</param>
        /// <returns></returns>
        protected List<CustomFieldSelection> GetCustomFieldSelections(int customFieldId)
        {
            return CustomFieldSelectionManager.GetCustomFieldsSelectionsByCustomFieldId(customFieldId);
        }

        /// <summary>
        /// Handles the Click event of the lnkAddCustomField control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="T:System.EventArgs"/> instance containing the event data.</param>
        protected void lnkAddCustomField_Click(object sender, EventArgs e)
        {
            string NewName = txtName.Text.Trim();

            if (NewName == String.Empty)
                return;

            ValidationDataType DataType = (ValidationDataType)Enum.Parse(typeof(ValidationDataType), dropDataType.SelectedValue);
            CustomField.CustomFieldType FieldType = (CustomField.CustomFieldType)Enum.Parse(typeof(CustomField.CustomFieldType), rblCustomFieldType.SelectedValue);
            bool required = chkRequired.Checked;

            CustomField newCustomField = new CustomField(ProjectId, NewName, DataType, required, FieldType);
            if (CustomFieldManager.SaveCustomField(newCustomField))
            {
                txtName.Text = "";
                dropDataType.SelectedIndex = 0;
                chkRequired.Checked = false;
                BindCustomFields();
            }
            else
            {
                lblError.Text = LoggingManager.GetErrorMessageResource("SaveCustomFieldError");
            }
        }

        /// <summary>
        /// Deletes the custom field.
        /// </summary>
        /// <param name="s">The s.</param>
        /// <param name="e">The <see cref="T:System.Web.UI.WebControls.DataGridCommandEventArgs"/> instance containing the event data.</param>
        void DeleteCustomField(Object s, DataGridCommandEventArgs e)
        {
            int customFieldId = (int)grdCustomFields.DataKeys[e.Item.ItemIndex];

            if (!CustomFieldManager.DeleteCustomField(customFieldId))
                lblError.Text = LoggingManager.GetErrorMessageResource("DeleteCustomFieldError");
            else
                BindCustomFields();
        }

        /// <summary>
        /// Handles the Update event of the grdCustomFields control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.DataGridCommandEventArgs"/> instance containing the event data.</param>
        protected void grdCustomFields_Update(object sender, DataGridCommandEventArgs e)
        {
            CustomField cf = CustomFieldManager.GetCustomFieldById(Convert.ToInt32(grdCustomFields.DataKeys[e.Item.ItemIndex]));
            TextBox txtCustomFieldName = (TextBox)e.Item.FindControl("txtCustomFieldName");
            DropDownList customFieldType = (DropDownList)e.Item.FindControl("dropCustomFieldType");
            DropDownList dataType = (DropDownList)e.Item.FindControl("dropEditDataType");
            CheckBox required = (CheckBox)e.Item.FindControl("chkEditRequired");

            cf.Name = txtCustomFieldName.Text;

            ValidationDataType DataType = (ValidationDataType)Enum.Parse(typeof(ValidationDataType),  dataType.SelectedValue);
            CustomField.CustomFieldType FieldType = (CustomField.CustomFieldType)Enum.Parse(typeof(CustomField.CustomFieldType), customFieldType.SelectedValue);
            cf.FieldType = FieldType;
            cf.DataType = DataType;
            cf.Required = required.Checked;
            CustomFieldManager.SaveCustomField(cf);

            grdCustomFields.EditItemIndex = -1;
            BindCustomFields();

        }
        /// <summary>
        /// Handles the ItemDataBound event of the grdCustomFields control.
        /// </summary>
        /// <param name="s">The source of the event.</param>
        /// <param name="e">The <see cref="T:System.Web.UI.WebControls.DataGridItemEventArgs"/> instance containing the event data.</param>
        void grdCustomFields_ItemDataBound(Object s, DataGridItemEventArgs e)
        {
            Control container = e.Item;

            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem || e.Item.ItemType == ListItemType.SelectedItem)
            {
                if (e.Item.DataItem == null)
                {
                    return;
                }

                HtmlImage btnExpandButton = (HtmlImage)container.FindControl("image_");
                if (btnExpandButton != null)
                {
                    HtmlControl c = (HtmlControl)e.Item.FindControl("divSelectionValues");
                    btnExpandButton.Attributes.Add("OnClick", string.Format("Toggle('{0}', '{1}');",c.ClientID,btnExpandButton.ClientID));
                }	

                CustomField currentCustomField = (CustomField)e.Item.DataItem;

                Label lblName = (Label)e.Item.FindControl("lblName");
                lblName.Text = currentCustomField.Name;

                Label lblDataType = (Label)e.Item.FindControl("lblDataType");
                lblDataType.Text = currentCustomField.DataType.ToString();

                Label lblFieldType = (Label)e.Item.FindControl("lblFieldType");
                lblFieldType.Text = currentCustomField.FieldType.ToString();

                Label lblRequired = (Label)e.Item.FindControl("lblRequired");
                lblRequired.Text = currentCustomField.Required.ToString();

                ImageButton btnDelete = (ImageButton)e.Item.FindControl("btnDelete");
                string message = string.Format(GetLocalResourceObject("ConfirmDelete").ToString(), currentCustomField.Name);
                btnDelete.Attributes.Add("onclick", String.Format("return confirm('{0}');", message));

                //only drop down list fields have selection values.
                if (currentCustomField.FieldType == CustomField.CustomFieldType.DropDownList)
                {
                    DataGrid grid = (DataGrid)e.Item.Cells[grdCustomFields.Columns.Count - 1].FindControl("grdSelectionValues");
                    if (grid != null)
                    {
                        this.ViewState["CustomFieldId"] = currentCustomField.Id;
                        grid.DataSource = GetCustomFieldSelections(currentCustomField.Id);
                        grid.DataBind();
                    }
                }
                else
                {
                    e.Item.FindControl("image_").Visible = false;
                    e.Item.Cells[e.Item.Cells.Count - 1].Visible = false;  
                }
            }
            if (e.Item.ItemType == ListItemType.EditItem)
            {
                CustomField currentCustomField = (CustomField)e.Item.DataItem;
                TextBox txtCustomFieldName = (TextBox)e.Item.FindControl("txtCustomFieldName");
                DropDownList customFieldType = (DropDownList)e.Item.FindControl("dropCustomFieldType");
                DropDownList dataType = (DropDownList)e.Item.FindControl("dropEditDataType");
                CheckBox required = (CheckBox)e.Item.FindControl("chkEditRequired");

                required.Checked = currentCustomField.Required;
                txtCustomFieldName.Text  = currentCustomField.Name;
                customFieldType.SelectedValue = Convert.ToString((int)currentCustomField.FieldType);
                dataType.SelectedValue = currentCustomField.DataType.ToString();
                dataType.Items.Clear();
                dataType.DataSource = Enum.GetNames(typeof(ValidationDataType));
                dataType.DataBind();
            }
        }

        /// <summary>
        /// Handles the SelectedIndexChanged event of the DropFieldType control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void DropFieldType_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList dropEditDataType = (DropDownList)grdCustomFields.Items[grdCustomFields.EditItemIndex].FindControl("dropEditDataType");
            DropDownList dropEditCustomFieldType = (DropDownList)grdCustomFields.Items[grdCustomFields.EditItemIndex].FindControl("dropCustomFieldType");
            CheckBox chkEditRequired = (CheckBox)grdCustomFields.Items[grdCustomFields.EditItemIndex].FindControl("chkEditRequired");

            dropEditDataType.Items.Clear();
            dropEditDataType.DataSource = Enum.GetNames(typeof(ValidationDataType));
            dropEditDataType.DataBind();
            dropEditDataType.Enabled = true;

            switch (int.Parse(dropEditCustomFieldType.SelectedValue))
            {
                case 1:
                    dropEditDataType.Items.Remove(dropEditDataType.Items.FindByValue(ValidationDataType.Date.ToString()));
                    break;
                case 2:
                    dropEditDataType.SelectedValue = ValidationDataType.String.ToString();
                    dropEditDataType.Enabled = false;
                    break;
                case 3:
                    dropEditDataType.SelectedValue = ValidationDataType.Date.ToString();
                    dropEditDataType.Enabled = false;
                    break;
                case 4:
                    dropEditDataType.SelectedValue = ValidationDataType.String.ToString();
                    dropEditDataType.Enabled = false;
                    break;
                case 5:
                    dropEditDataType.SelectedValue = ValidationDataType.Integer.ToString();
                    dropEditDataType.Enabled = false;
                    chkEditRequired.Enabled = false;
                    break;
                case 6:
                    dropEditDataType.SelectedValue = ValidationDataType.String.ToString();
                    dropEditDataType.Enabled = false;
                    break;
            }
      
        }

        /// <summary>
        /// Handles the SelectedIndexChange event of the rblCustomFieldType control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="T:System.EventArgs"/> instance containing the event data.</param>
        protected void rblCustomFieldType_SelectedIndexChanged(object sender, EventArgs e)
        {
            dropDataType.Items.Clear();
            dropDataType.DataSource = Enum.GetNames(typeof(ValidationDataType));
            dropDataType.DataBind();
            dropDataType.Enabled = true;

            switch (int.Parse(rblCustomFieldType.SelectedValue))
            {
                case 1:
                    dropDataType.Items.Remove(dropDataType.Items.FindByValue(ValidationDataType.Date.ToString()));
                    break;
                case 2:
                    dropDataType.SelectedValue = ValidationDataType.String.ToString();
                    dropDataType.Enabled = false;
                    break;
                case 3:
                    dropDataType.SelectedValue = ValidationDataType.Date.ToString();
                    dropDataType.Enabled = false;
                    break;
                case 4:
                    dropDataType.SelectedValue = ValidationDataType.String.ToString();
                    dropDataType.Enabled = false;
                    break;
                case 5:
                    dropDataType.SelectedValue = ValidationDataType.Integer.ToString();
                    dropDataType.Enabled = false;
                    chkRequired.Enabled = false;
                    break;
                case 6:
                    dropDataType.SelectedValue = ValidationDataType.String.ToString();
                    dropDataType.Enabled = false;
                    break;
            }
        }

        /// <summary>
        /// Handles the Click event of the cmdCancel control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="T:System.EventArgs"/> instance containing the event data.</param>
        protected void cmdCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Administration/Projects/EditProject.aspx?id=" + ProjectId.ToString());
        }




     
    }
}
