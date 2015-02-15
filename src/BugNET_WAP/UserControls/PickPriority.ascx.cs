namespace BugNET.UserControls
{
    using System;
    using System.Collections.Generic;
    using System.Web.UI.WebControls;
    using BugNET.Entities;

	/// <summary>
	///		Summary description for PickPriority.
	/// </summary>
	public partial class PickPriority : System.Web.UI.UserControl
	{


        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
		protected void Page_Load(object sender, System.EventArgs e)
		{
			// Put user code to initialize the page here
		}

		private List<Priority> _DataSource;
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
			get {return Int32.Parse(ddlPriority.SelectedValue); }
			set {ddlPriority.SelectedValue = value.ToString(); }
		}

        /// <summary>
        /// Gets the selected text.
        /// </summary>
        /// <value>The selected text.</value>
		public string SelectedText
		{
			get {return ddlPriority.SelectedItem.Text; }
		}

        /// <summary>
        /// Gets or sets the data source.
        /// </summary>
        /// <value>The data source.</value>
        public List<Priority> DataSource 
		{
			get { return _DataSource; }
			set { _DataSource = value; }
		}

        /// <summary>
        /// Binds a data source to the invoked server control and all its child controls.
        /// </summary>
		public override void DataBind() 
		{
			ddlPriority.Items.Clear();
			ddlPriority.DataSource = _DataSource;
			ddlPriority.DataTextField = "Name";
			ddlPriority.DataValueField = "Id";
			ddlPriority.DataBind();

			if (_DisplayDefault)
				ddlPriority.Items.Insert(0, new ListItem(GetLocalResourceObject("SelectPriority").ToString(), "0" ) );
		}

        /// <summary>
        /// Removes the default.
        /// </summary>
		public void RemoveDefault() 
		{
			ListItem defaultItem = ddlPriority.Items.FindByValue("0");
			if (defaultItem != null)
				ddlPriority.Items.Remove(defaultItem);
		}

        /// <summary>
        /// Gets or sets a value indicating whether this <see cref="PickPriority"/> is required.
        /// </summary>
        /// <value><c>true</c> if required; otherwise, <c>false</c>.</value>
		public bool Required 
		{
			get { return reqVal.Visible; }
			set { reqVal.Visible = value; }
		}

        /// <summary>
        /// Gets or sets a value indicating whether this <see cref="PickPriority"/> is enabled.
        /// </summary>
        /// <value><c>true</c> if enabled; otherwise, <c>false</c>.</value>
		public bool Enabled
		{
			get{return ddlPriority.Enabled;}
			set{ddlPriority.Enabled = value;}
		}	
	}
}
