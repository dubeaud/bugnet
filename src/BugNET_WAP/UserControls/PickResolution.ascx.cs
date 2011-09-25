namespace BugNET.UserControls
{
    using System;
    using System.Collections.Generic;
    using System.Web.UI.WebControls;
    using BugNET.Entities;

	/// <summary>
	///		Summary description for PickResolution.
	/// </summary>
	public partial class PickResolution : System.Web.UI.UserControl
	{

        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
		protected void Page_Load(object sender, System.EventArgs e)
		{
	
		}

		private List<Resolution> _DataSource;
		private bool _DisplayDefault = false;

        /// <summary>
        /// Gets or sets a value indicating whether [display default].
        /// </summary>
        /// <value><c>true</c> if [display default]; otherwise, <c>false</c>.</value>
		public bool DisplayDefault 
		{
			get { return _DisplayDefault; }
			set { _DisplayDefault = value; }
		}

        /// <summary>
        /// Gets or sets the selected value.
        /// </summary>
        /// <value>The selected value.</value>
		public int SelectedValue 
		{
			get {return Int32.Parse(ddlResolution.SelectedValue); }
			set {ddlResolution.SelectedValue = value.ToString(); }
		}

        /// <summary>
        /// Gets the selected text.
        /// </summary>
        /// <value>The selected text.</value>
		public string SelectedText
		{
			get {return ddlResolution.SelectedItem.Text; }
		}

        /// <summary>
        /// Gets or sets the data source.
        /// </summary>
        /// <value>The data source.</value>
		public List<Resolution> DataSource 
		{
			get { return _DataSource; }
			set { _DataSource = value; }
		}

        /// <summary>
        /// Binds a data source to the invoked server control and all its child controls.
        /// </summary>
		public override void DataBind() 
		{
			ddlResolution.Items.Clear();
			ddlResolution.DataSource = _DataSource;
			ddlResolution.DataTextField = "Name";
			ddlResolution.DataValueField = "Id";
			ddlResolution.DataBind();

			if (_DisplayDefault)
                ddlResolution.Items.Insert(0, new ListItem(GetLocalResourceObject("SelectResolution").ToString(), "0"));
		}

        /// <summary>
        /// Removes the default.
        /// </summary>
		public void RemoveDefault() 
		{
			ListItem defaultItem = ddlResolution.Items.FindByValue("0");
			if (defaultItem != null)
				ddlResolution.Items.Remove(defaultItem);
		}

        /// <summary>
        /// Gets or sets a value indicating whether this <see cref="PickResolution"/> is required.
        /// </summary>
        /// <value><c>true</c> if required; otherwise, <c>false</c>.</value>
		public bool Required 
		{
			get { return reqVal.Visible; }
			set { reqVal.Visible = value; }
		}

        /// <summary>
        /// Gets or sets a value indicating whether this <see cref="PickResolution"/> is enabled.
        /// </summary>
        /// <value><c>true</c> if enabled; otherwise, <c>false</c>.</value>
		public bool Enabled
		{
			get{return ddlResolution.Enabled;}
			set{ddlResolution.Enabled = value;}
		}
	}
}
