namespace BugNET.UserControls
{
    using System;
    using System.Collections.Generic;
    using System.Web.UI.WebControls;
    using BugNET.Entities;

	/// <summary>
    ///	This user control displays a dropdown list of queries.
	/// </summary>
	public partial class PickQuery : System.Web.UI.UserControl
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


		private List<Query> _DataSource;
		private bool _DisplayDefault = false;


        /// <summary>
        /// Gets the item count.
        /// </summary>
        /// <value>The item count.</value>
		public int ItemCount 
		{
			get{ return dropQueries.Items.Count; }
		}


        /// <summary>
        /// Gets or sets the selected value.
        /// </summary>
        /// <value>The selected value.</value>
		public int SelectedValue 
		{
			get {return Int32.Parse(dropQueries.SelectedValue); }
			set { dropQueries.SelectedValue = value.ToString(); }
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
        /// Gets or sets the CSS class.
        /// </summary>
        /// <value>The CSS class.</value>
		public string CssClass 
		{
			get { return dropQueries.CssClass; }
			set { dropQueries.CssClass = value; }
		}


        /// <summary>
        /// Gets or sets the data source.
        /// </summary>
        /// <value>The data source.</value>
        public List<Query> DataSource 
		{
			get { return _DataSource; }
			set { _DataSource = value; }
		}

        /// <summary>
        /// Binds a data source to the invoked server control and all its child controls.
        /// </summary>
		public void DataBind() 
		{
			dropQueries.Items.Clear();
			dropQueries.DataSource = _DataSource;
			dropQueries.DataTextField = "Name";
			dropQueries.DataValueField = "Id";
			dropQueries.DataBind();
			if (_DisplayDefault)
                dropQueries.Items.Insert(0, new ListItem(GetLocalResourceObject("SelectQuery").ToString(), "0"));
		}


	
	}
}
