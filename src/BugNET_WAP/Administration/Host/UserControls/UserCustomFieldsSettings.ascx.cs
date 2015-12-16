using BugNET.BLL;
using BugNET.Common;
using BugNET.Entities;
using BugNET.UserInterfaceLayer;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace BugNET.Administration.Host.UserControls
{
    public partial class UserCustomFieldsSettings : System.Web.UI.UserControl, IEditHostSettingControl
    {

        #region IEditHostSettingControl Members

        public bool Update()
        {
            return true;
        }

        public void Initialize()
        {
            dropDataType.DataSource = Enum.GetNames(typeof(ValidationDataType));
            dropDataType.DataBind();
            BindCustomFields();
        }
        
        public bool ShowSaveButton
        {
            get { return false; }
        }

        #endregion

        /// <summary>
        /// Binds the custom field selections.
        /// </summary>
        private void BindCustomFieldSelections()
        {
            foreach (DataGridItem item in grdCustomFields.Items)
            {
                var grdSelectionValues = (DataGrid)item.FindControl("grdSelectionValues");
                if (null == grdSelectionValues) continue;
                grdSelectionValues.DataSource = GetCustomFieldSelections(Convert.ToInt32(item.Cells[0].Text.Trim()));
                grdSelectionValues.DataKeyField = "Id";
                grdSelectionValues.DataBind();
            }
        }

        /// <summary>
        /// Binds the custom fields.
        /// </summary>
        private void BindCustomFields()
        {
            //check if we are editing the sub grid - needed to fire update command on the nested grid.
            if (ViewState["EditingSubGrid"] == null)
            {
                grdCustomFields.DataSource = UserCustomFieldManager.GetAll();
                grdCustomFields.DataKeyField = "Id";
                grdCustomFields.DataBind();

                grdCustomFields.Visible = grdCustomFields.Items.Count != 0;
            }
        }

        /// <summary>
        /// Gets the custom field selections.
        /// </summary>
        /// <param name="customFieldId">The custom field id.</param>
        /// <returns></returns>
        private static List<UserCustomFieldSelection> GetCustomFieldSelections(int customFieldId)
        {
            return UserCustomFieldSelectionManager.GetByCustomFieldId(customFieldId);
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
        /// Handles the Click event of the lnkAddCustomField control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="T:System.EventArgs"/> instance containing the event data.</param>
        protected void lnkAddCustomField_Click(object sender, EventArgs e)
        {
            var newName = txtName.Text.Trim();

            if (newName == String.Empty)
                return;

            var dataType = (ValidationDataType)Enum.Parse(typeof(ValidationDataType), dropDataType.SelectedValue);
            var fieldType = (CustomFieldType)Enum.Parse(typeof(CustomFieldType), rblCustomFieldType.SelectedValue);
            var required = chkRequired.Checked;

            var newCustomField = new UserCustomField
            {
                Name = newName,
                DataType = dataType,
                Required = required,
                FieldType = fieldType
            };

            if (UserCustomFieldManager.SaveOrUpdate(newCustomField))
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
        /// Handles the Update event of the grdCustomFields control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.DataGridCommandEventArgs"/> instance containing the event data.</param>
        protected void grdCustomFields_Update(object sender, DataGridCommandEventArgs e)
        {
            var cf = UserCustomFieldManager.GetById(Convert.ToInt32(grdCustomFields.DataKeys[e.Item.ItemIndex]));
            var txtCustomFieldName = (TextBox)e.Item.FindControl("txtCustomFieldName");
            var customFieldType = (DropDownList)e.Item.FindControl("dropCustomFieldType");
            var dataType = (DropDownList)e.Item.FindControl("dropEditDataType");
            var required = (CheckBox)e.Item.FindControl("chkEditRequired");

            cf.Name = txtCustomFieldName.Text;

            var DataType = (ValidationDataType)Enum.Parse(typeof(ValidationDataType), dataType.SelectedValue);
            var FieldType = (CustomFieldType)Enum.Parse(typeof(CustomFieldType), customFieldType.SelectedValue);

            cf.FieldType = FieldType;
            cf.DataType = DataType;
            cf.Required = required.Checked;
            UserCustomFieldManager.SaveOrUpdate(cf);

            grdCustomFields.EditItemIndex = -1;
            BindCustomFields();
        }

        /// <summary>
        /// Handles the ItemDataBound event of the grdCustomFields control.
        /// </summary>
        /// <param name="s">The source of the event.</param>
        /// <param name="e">The <see cref="T:System.Web.UI.WebControls.DataGridItemEventArgs"/> instance containing the event data.</param>
        protected void grdCustomFields_ItemDataBound(Object s, DataGridItemEventArgs e)
        {
            Control container = e.Item;

            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem || e.Item.ItemType == ListItemType.SelectedItem)
            {
                if (e.Item.DataItem == null)
                {
                    return;
                }

                var btnExpandButton = (HtmlImage)container.FindControl("image_");
                if (btnExpandButton != null)
                {
                    var c = (HtmlControl)e.Item.FindControl("divSelectionValues");
                    btnExpandButton.Attributes.Add("OnClick", string.Format("Toggle('{0}', '{1}');", c.ClientID, btnExpandButton.ClientID));
                }

                var currentCustomField = (UserCustomField)e.Item.DataItem;

                var lblName = (Label)e.Item.FindControl("lblName");
                lblName.Text = currentCustomField.Name;

                var lblDataType = (Label)e.Item.FindControl("lblDataType");
                lblDataType.Text = currentCustomField.DataType.ToString();

                var lblFieldType = (Label)e.Item.FindControl("lblFieldType");
                lblFieldType.Text = LocalizeFieldType(currentCustomField.FieldType);

                var lblRequired = (Label)e.Item.FindControl("lblRequired");
                lblRequired.Text = currentCustomField.Required ? Resources.SharedResources.Yes : Resources.SharedResources.No;

                var btnDelete = (ImageButton)e.Item.FindControl("btnDeleteCustomField");
                var message = string.Format(GetLocalResourceObject("ConfirmDelete").ToString(), currentCustomField.Name.Trim());
                btnDelete.Attributes.Add("onclick", String.Format("return confirm('{0}');", message.JsEncode()));

                var table = e.Item.Cells[grdCustomFields.Columns.Count - 1].FindControl("tblSelectionValues") as HtmlTable;

                if (table != null)
                {
                    //only drop down list fields have selection values.
                    if (currentCustomField.FieldType == CustomFieldType.DropDownList)
                    {
                        e.Item.FindControl("image_").Visible = true;
                        table.Visible = true;
                        e.Item.Cells[e.Item.Cells.Count - 1].Visible = true;

                        var grid = (DataGrid)e.Item.Cells[grdCustomFields.Columns.Count - 1].FindControl("grdSelectionValues");
                        ViewState["CustomFieldId"] = currentCustomField.Id;
                        grid.DataSource = GetCustomFieldSelections(currentCustomField.Id);
                        grid.DataKeyField = "Id";
                        grid.DataBind();
                    }
                    else
                    {
                        e.Item.FindControl("image_").Visible = false;
                        table.Visible = false;
                        e.Item.Cells[e.Item.Cells.Count - 1].Visible = false;
                    }
                }
            }

            if (e.Item.ItemType == ListItemType.EditItem)
            {
                var currentCustomField = (UserCustomField)e.Item.DataItem;
                var txtCustomFieldName = (TextBox)e.Item.FindControl("txtCustomFieldName");
                var customFieldType = (DropDownList)e.Item.FindControl("dropCustomFieldType");
                var dataType = (DropDownList)e.Item.FindControl("dropEditDataType");
                var required = (CheckBox)e.Item.FindControl("chkEditRequired");

                required.Checked = currentCustomField.Required;
                txtCustomFieldName.Text = currentCustomField.Name;
                customFieldType.SelectedValue = Convert.ToString((int)currentCustomField.FieldType);
                dataType.SelectedValue = currentCustomField.DataType.ToString();
                dataType.Items.Clear();
                dataType.DataSource = Enum.GetNames(typeof(ValidationDataType));
                dataType.DataBind();
            }
        }

        /// <summary>
        /// Handles the ItemDataBound event of the grdSelectionValues control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.DataGridItemEventArgs"/> instance containing the event data.</param>
        protected void grdSelectionValues_ItemDataBound(object sender, DataGridItemEventArgs e)
        {
            var itemType = e.Item.ItemType;

            switch (itemType)
            {
                case ListItemType.AlternatingItem:
                case ListItemType.Item:
                    {
                        if (e.Item.DataItem == null)
                        {
                            return;
                        }
                        var cfs = (UserCustomFieldSelection)e.Item.DataItem;
                        var btnDelete = (ImageButton)e.Item.FindControl("btnDeleteSelectionValue");
                        if (btnDelete != null)
                        {
                            var message = string.Format(GetLocalResourceObject("ConfirmCustomFieldSelectionDelete").ToString(), cfs.Name.Trim());
                            btnDelete.Attributes.Add("onclick", String.Format("return confirm('{0}');", message.JsEncode()));
                        }
                    }
                    break;
                case ListItemType.Footer:
                    if (ViewState["CustomFieldId"] != null)
                    {
                        var btnAddSelectionValue = (ImageButton)e.Item.FindControl("btnAddSelectionValue");
                        var val1 = (RequiredFieldValidator)e.Item.FindControl("RequiredFieldValidator1");
                        var val2 = (RequiredFieldValidator)e.Item.FindControl("RequiredFieldValidator2");

                        if (val1 != null & val2 != null)
                        {
                            val1.ValidationGroup = string.Format("AddSelection{0}", ViewState["CustomFieldId"]);
                            val2.ValidationGroup = string.Format("AddSelection{0}", ViewState["CustomFieldId"]);
                        }

                        if (btnAddSelectionValue != null)
                        {
                            btnAddSelectionValue.ValidationGroup = string.Format("AddSelection{0}", ViewState["CustomFieldId"]);
                            btnAddSelectionValue.CommandArgument = ViewState["CustomFieldId"].ToString();
                        }
                    }
                    ViewState["CustomFieldId"] = null;
                    break;
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
            var lblCustomFieldId = (Label)e.Item.FindControl("lblCustomFieldId");

            if (lblCustomFieldId != null)
            {
                foreach (DataGridItem item in grdCustomFields.Items)
                {
                    var grdSelectionValues = (DataGrid)item.FindControl("grdSelectionValues");
                    grdSelectionValues.ShowFooter = false;
                    grdSelectionValues.EditItemIndex = -1;
                    if (lblCustomFieldId.Text != item.Cells[0].Text) continue;
                    grdSelectionValues.EditItemIndex = e.Item.ItemIndex;
                    //set a property to say we are editing the subgrid,
                    //rebinding the master grid will not fire the update command
                    ViewState["EditingSubGrid"] = true;
                }
            }

            BindCustomFieldSelections();
        }

        /// <summary>
        /// Handles the ItemCommand event of the grdSelectionValues control.
        /// </summary>
        /// <param name="source">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.DataGridCommandEventArgs"/> instance containing the event data.</param>
        protected void grdSelectionValues_ItemCommand(object source, DataGridCommandEventArgs e)
        {
            UserCustomFieldSelection cfs;
            var itemIndex = e.Item.ItemIndex;
            int itemId;
            var grid = source as DataGrid;

            switch (e.CommandName)
            {
                case "up":
                    //move row up
                    if (itemIndex == 0)
                        return;
                    itemId = Convert.ToInt32(grid.DataKeys[itemIndex]);
                    cfs = UserCustomFieldSelectionManager.GetById(itemId);
                    cfs.SortOrder -= 1;
                    UserCustomFieldSelectionManager.SaveOrUpdate(cfs);
                    break;
                case "down":
                    //move row down
                    if (itemIndex == grid.Items.Count - 1)
                        return;
                    itemId = Convert.ToInt32(grid.DataKeys[itemIndex]);
                    cfs = UserCustomFieldSelectionManager.GetById(itemId);
                    cfs.SortOrder += 1;
                    UserCustomFieldSelectionManager.SaveOrUpdate(cfs);
                    break;
                case "add":
                    if (Page.IsValid)
                    {
                        var txtAddSelectionName = (TextBox)e.Item.FindControl("txtAddSelectionName");
                        var txtAddSelectionValue = (TextBox)e.Item.FindControl("txtAddSelectionValue");

                        cfs = new UserCustomFieldSelection
                        {
                            CustomFieldId = Convert.ToInt32(e.CommandArgument),
                            Name = txtAddSelectionName.Text.Trim(),
                            Value = txtAddSelectionValue.Text.Trim()
                        };

                        UserCustomFieldSelectionManager.SaveOrUpdate(cfs);
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
        protected void grdSelectionValues_CancelCommand(object source, DataGridCommandEventArgs e)
        {
            lblError.Text = String.Empty;
            foreach (DataGridItem item in grdCustomFields.Items)
            {
                var grdSelectionValues = (DataGrid)item.FindControl("grdSelectionValues");
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
                var selectionName = (TextBox)e.Item.FindControl("txtEditSelectionName");
                var txtValue = (TextBox)e.Item.FindControl("txtEditSelectionValue");
                if (selectionName != null && txtValue != null)
                {
                    var customFieldSelectionId = (int)((DataGrid)source).DataKeys[e.Item.ItemIndex];

                    UserCustomFieldSelection cfs = UserCustomFieldSelectionManager.GetById(customFieldSelectionId);
                    cfs.Name = selectionName.Text.Trim();
                    cfs.Value = txtValue.Text.Trim();
                    UserCustomFieldSelectionManager.SaveOrUpdate(cfs);

                    lblError.Text = String.Empty;

                    foreach (DataGridItem item in grdCustomFields.Items)
                    {
                        var grdSelectionValues = (DataGrid)item.FindControl("grdSelectionValues");
                        if (null == grdSelectionValues) continue;

                        grdSelectionValues.ShowFooter = true;
                        grdSelectionValues.EditItemIndex = -1;
                        BindCustomFieldSelections();
                    }
                }
                ViewState["EditingSubGrid"] = null;
                BindCustomFields();
            }
        }

        /// <summary>
        /// Handles the SelectedIndexChanged event of the DropFieldType control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void DropFieldType_SelectedIndexChanged(object sender, EventArgs e)
        {
            var dropEditDataType =
                (DropDownList)grdCustomFields.Items[grdCustomFields.EditItemIndex].FindControl("dropEditDataType");
            var dropEditCustomFieldType =
                (DropDownList)grdCustomFields.Items[grdCustomFields.EditItemIndex].FindControl("dropCustomFieldType");
            var chkEditRequired =
                (CheckBox)grdCustomFields.Items[grdCustomFields.EditItemIndex].FindControl("chkEditRequired");

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
                case 6:
                    dropEditDataType.SelectedValue = ValidationDataType.String.ToString();
                    dropEditDataType.Enabled = false;
                    break;
                case 5:
                    dropEditDataType.SelectedValue = ValidationDataType.String.ToString();
                    dropEditDataType.Enabled = false;
                    chkEditRequired.Enabled = false;
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
                    dropDataType.SelectedValue = ValidationDataType.String.ToString();
                    dropDataType.Enabled = false;
                    chkRequired.Enabled = false;
                    break;
                case 6:
                    dropDataType.SelectedValue = ValidationDataType.String.ToString();
                    dropDataType.Enabled = false;
                    break;
            }
        }

        protected void btnDeleteSelectionValue_Click(object sender, ImageClickEventArgs e)
        {
            var btn = sender as ImageButton;

            if (btn == null) return;

            var id = btn.CommandArgument.To<int>();

            if (!UserCustomFieldSelectionManager.Delete(id))
                lblError.Text = LoggingManager.GetErrorMessageResource("DeleteCustomFieldError");
            else
                BindCustomFields();
        }

        protected void btnDeleteCustomField_Click(object sender, ImageClickEventArgs e)
        {
            var btn = sender as ImageButton;

            if (btn == null) return;

            var id = btn.CommandArgument.To<int>();

            if (!UserCustomFieldManager.Delete(id))
                lblError.Text = LoggingManager.GetErrorMessageResource("DeleteCustomFieldError");
            else
                BindCustomFields();
        }

        private string LocalizeFieldType(CustomFieldType fieldType)
        {
            switch (fieldType)
            {
                case CustomFieldType.Text:
                    return GetLocalResourceObject("TextType.Text").ToString();
                case CustomFieldType.DropDownList:
                    return GetLocalResourceObject("DropDownListType.Text").ToString();
                case CustomFieldType.Date:
                    return GetLocalResourceObject("DateType.Text").ToString();
                case CustomFieldType.RichText:
                    return GetLocalResourceObject("RichTextType.Text").ToString();
                case CustomFieldType.YesNo:
                    return GetLocalResourceObject("YesNoType.Text").ToString();
                case CustomFieldType.UserList:
                    return GetLocalResourceObject("UserListType.Text").ToString();
            }
            return "Unknown";
        }
    }
}