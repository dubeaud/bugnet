namespace BugNET.UserControls
{
    using System;
    using System.Collections.Generic;
    using System.Web.UI.WebControls;
    using BugNET.Entities;

	/// <summary>
	///	Summary description for PickComponent.
	/// </summary>
	public partial class PickCategory : System.Web.UI.UserControl
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

		private List<Category> _DataSource;
		private bool _DisplayDefault = false;


        /// <summary>
        /// Gets the item count.
        /// </summary>
        /// <value>The item count.</value>
		public int ItemCount 
		{
			get { return ddlComps.Items.Count; }
		}

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
        /// Gets or sets a value indicating whether this <see cref="PickComponent"/> is enabled.
        /// </summary>
        /// <value><c>true</c> if enabled; otherwise, <c>false</c>.</value>
		public bool Enabled 
		{
			get { return ddlComps.Enabled; }
			set { ddlComps.Enabled = value; }
		}

        /// <summary>
        /// Gets or sets a value indicating whether this <see cref="PickComponent"/> is required.
        /// </summary>
        /// <value><c>true</c> if required; otherwise, <c>false</c>.</value>
		public bool Required 
		{
			get { return reqVal.Visible; }
			set { reqVal.Visible = value; }
		}

        /// <summary>
        /// Gets the selected text.
        /// </summary>
        /// <value>The selected text.</value>
        public string SelectedText
        {
            get { return ddlComps.SelectedItem.Text; }
        }

        /// <summary>
        /// Gets or sets the selected value.
        /// </summary>
        /// <value>The selected value.</value>
		public int SelectedValue 
		{
			get {return Int32.Parse(ddlComps.SelectedValue); }
			set 
			{
				try 
				{
					ddlComps.SelectedValue = value.ToString();
				} 
				catch {}
			}
		}

        /// <summary>
        /// Gets or sets the data source.
        /// </summary>
        /// <value>The data source.</value>
		public List<Category> DataSource 
		{
			get { return _DataSource; }
			set { _DataSource = value; }
		}

        /// <summary>
        /// Binds a data source to the invoked server control and all its child controls.
        /// </summary>
		public override void DataBind() 
		{
			ddlComps.Items.Clear();

			if (_DataSource == null)
				return;

			ddlComps.DataSource = _DataSource;
			ddlComps.DataTextField = "Name";
			ddlComps.DataValueField = "Id";
			ddlComps.DataBind();

			// Display default project
			if (_DisplayDefault)
                ddlComps.Items.Insert(0, new ListItem(GetLocalResourceObject("SelectCategory").ToString(), "0"));


		}


		
	}
}
