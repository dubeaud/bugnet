namespace BugNET.UserControls
{
    using System;
    using System.Collections.Generic;
    using System.Web.UI;
    using System.Web.UI.WebControls;
    using BugNET.BLL;
    using BugNET.Entities;
    /// <summary>
    /// 
    /// </summary>
    public partial class DisplayCustomFields : System.Web.UI.UserControl
    {
        private const string FIELD_VALUE_NAME = "FieldValue";
        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
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
            this.lstCustomFields.ItemDataBound += new System.Web.UI.WebControls.DataListItemEventHandler(this.lstCustomFieldsItemDataBound);

        }
        #endregion

        /// <summary>
        /// 
        /// </summary>
        public bool Required = true;


        /// <summary>
        /// Gets or sets the data source.
        /// </summary>
        /// <value>The data source.</value>
        public object DataSource
        {
            get { return lstCustomFields.DataSource; }
            set { lstCustomFields.DataSource = value; }
        }

        /// <summary>
        /// Binds a data source to the invoked server control and all its child controls.
        /// </summary>
        public override void DataBind()
        {
            lstCustomFields.DataKeyField = "Id";
            lstCustomFields.DataBind();
        }

        /// <summary>
        /// Gets or sets a value indicating whether this instance is locked.
        /// </summary>
        /// <value><c>true</c> if this instance is locked; otherwise, <c>false</c>.</value>
        public bool IsLocked
        {
            get
            {
                if (ViewState["IsLocked"] == null)
                    return false;
                else
                    return (bool)ViewState["IsLocked"];
            }
            set { ViewState["IsLocked"] = value; }
        }

        /// <summary>
        /// LSTs the custom fields item data bound.
        /// </summary>
        /// <param name="s">The s.</param>
        /// <param name="e">The <see cref="T:System.Web.UI.WebControls.DataListItemEventArgs"/> instance containing the event data.</param>
        void lstCustomFieldsItemDataBound(object s, DataListItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                CustomField currentField = (CustomField)e.Item.DataItem;
                PlaceHolder ph = (PlaceHolder)e.Item.FindControl("PlaceHolder");

                switch (currentField.FieldType)
                {
                    case Common.CustomFieldType.DropDownList:
                        DropDownList ddl = new DropDownList();
                        ddl.ID = FIELD_VALUE_NAME;
                        ddl.DataSource = CustomFieldSelectionManager.GetByCustomFieldId(currentField.Id);
                        ddl.DataTextField = "Name";
                        ddl.DataValueField = "Value";
                        ddl.DataBind();
                        ddl.Items.Insert(0,new ListItem( "-- Select One --", string.Empty));
                        ddl.SelectedValue = currentField.Value;
                        ph.Controls.Add(ddl);
                        if (IsLocked)
                            ddl.Enabled = false;
                        break;
                    case Common.CustomFieldType.Date:
                        TextBox FieldValue1 = new TextBox();
                        AjaxControlToolkit.CalendarExtender cal = new AjaxControlToolkit.CalendarExtender();
                        Image img = new Image();
                        img.ID = "calImage";
                        img.CssClass = "icon";
                        img.ImageUrl = "~/images/calendar.gif";
                        cal.PopupButtonID = "calImage";
                        cal.TargetControlID = FIELD_VALUE_NAME;
                        cal.ID = "Calendar1";
                        FieldValue1.ID = "FieldValue";
                        FieldValue1.Width = 80;
                        ph.Controls.Add(FieldValue1);
                        ph.Controls.Add(img);
                        ph.Controls.Add(new LiteralControl("&nbsp"));
                        FieldValue1.Text = currentField.Value;
                        ph.Controls.Add(cal);
                        if (IsLocked)
                        {
                            cal.Enabled = false;
                            FieldValue1.Enabled = false;
                            img.Visible = false;
                        }
                        break;
                    case Common.CustomFieldType.Text:
                        var fieldValue = new TextBox {ID = FIELD_VALUE_NAME, Text = currentField.Value};
                        ph.Controls.Add(fieldValue);
                        if (IsLocked)
                            fieldValue.Enabled = false;
                        break;
                    case Common.CustomFieldType.YesNo:
                        var chk = new CheckBox {ID = FIELD_VALUE_NAME};
                        if (!String.IsNullOrEmpty(currentField.Value))
                            chk.Checked = Boolean.Parse(currentField.Value);
                        ph.Controls.Add(chk);
                        if (IsLocked)
                            chk.Enabled = false;
                        break;
                    case Common.CustomFieldType.RichText:
                        var editor = new HtmlEditor {ID = FIELD_VALUE_NAME};

                        ph.Controls.Add(editor);
                        editor.Text = currentField.Value;
                        //if (IsLocked)
                        //    editor.Enabled = false;
                        break;
                    case Common.CustomFieldType.UserList:
                        ddl = new DropDownList
                                  {
                                      ID = FIELD_VALUE_NAME,
                                      DataSource = UserManager.GetUsersByProjectId(currentField.ProjectId),
                                      DataTextField = "DisplayName",
                                      DataValueField = "UserName"
                                  };
                        ddl.DataBind();
                        ddl.Items.Insert(0, new ListItem("-- Select One --", string.Empty));
                        ddl.SelectedValue = currentField.Value;
                        ph.Controls.Add(ddl);
                        if (IsLocked)
                            ddl.Enabled = false;
                        break;
                }

                var lblFieldName = (Label)e.Item.FindControl("lblFieldName");
                lblFieldName.AssociatedControlID = FIELD_VALUE_NAME;
                lblFieldName.Text = string.Format("{0}:", currentField.Name);

                if (EnableValidation) 
                { 
                    //if required dynamically add a required field validator
                    if (currentField.Required && currentField.FieldType != Common.CustomFieldType.YesNo)
                    {
                        var valReq = new RequiredFieldValidator
                                         {
                                             ControlToValidate = FIELD_VALUE_NAME,
                                             Text = " (required)",
                                             Display = ValidatorDisplay.Dynamic
                                         };

                        if (currentField.FieldType == Common.CustomFieldType.DropDownList)
                            valReq.InitialValue = string.Empty;

                        ph.Controls.Add(valReq);
                    }

                    //create datatype check validator
                    if (currentField.FieldType != Common.CustomFieldType.YesNo)
                    {
                        var valCompare = new CompareValidator
                                             {
                                                 Type = currentField.DataType,
                                                 Text = String.Format("({0})", currentField.DataType),
                                                 Operator = ValidationCompareOperator.DataTypeCheck,
                                                 Display = ValidatorDisplay.Dynamic,
                                                 ControlToValidate = FIELD_VALUE_NAME
                                             };
                        ph.Controls.Add(valCompare);
                    }
                }

            }
        }


        /// <summary>
        /// Gets the values.
        /// </summary>
        /// <value>The values.</value>
        public List<CustomField> Values
        {
            get
            {
                var colFields = new List<CustomField>();
                for (var i = 0; i < lstCustomFields.Items.Count; i++)
                {
                    var item = lstCustomFields.Items[i];
                    if (item.ItemType == ListItemType.Item || item.ItemType == ListItemType.AlternatingItem)
                    {
                        var fieldId = (int)lstCustomFields.DataKeys[i];

                        var c = item.FindControl("FieldValue");
                        if (c != null)
                        {
                            var fieldValue = string.Empty;

                            if (c.GetType() == typeof(DropDownList) && ((DropDownList)c).SelectedIndex != 0)
                                fieldValue = ((DropDownList)c).SelectedValue;

                            if (c.GetType() == typeof(TextBox))
                                fieldValue = ((TextBox)c).Text;

                            if (c.GetType() == typeof(CheckBox))
                                fieldValue = ((CheckBox)c).Checked.ToString();

                            if (c.GetType() == typeof(HtmlEditor))
                                fieldValue = ((HtmlEditor)c).Text;

                            colFields.Add(new CustomField { Id = fieldId, Value = fieldValue});
                        }
                    }
                }
                return colFields;
            }
        }

        /// <summary>
        /// Gets or sets a value indicating whether [enable validation].
        /// </summary>
        /// <value><c>true</c> if [enable validation]; otherwise, <c>false</c>.</value>
        public bool EnableValidation
        {
            get
            {
                object o = ViewState["EnableValidation"];
                if (o == null)
                {
                    return false;
                }
                return (bool)o;
            }
            set
            {
                ViewState["EnableValidation"] = value;
            }

        }

    }
}
