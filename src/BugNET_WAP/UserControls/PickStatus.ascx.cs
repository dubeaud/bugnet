namespace BugNET.UserControls
{
    using System;
    using System.Collections.Generic;
    using System.Web.UI.WebControls;
    using BugNET.Entities;

    /// <summary>
    /// Summary description for PickStatus.
    /// </summary>
	public partial class PickStatus : System.Web.UI.UserControl
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

		//*********************************************************************
		//
		// PickStatus.ascx
		//
		// This user control displays a dropdown list of status values.
		//
		//*********************************************************************


		private List<Status> _DataSource;
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
        /// Gets the selected text.
        /// </summary>
        /// <value>The selected text.</value>
        public string SelectedText
        {
            get { return dropStatus.SelectedItem.Text; }
        }

        /// <summary>
        /// Gets or sets the selected value.
        /// </summary>
        /// <value>The selected value.</value>
		public int SelectedValue 
		{
			get {return Int32.Parse(dropStatus.SelectedValue); }
			set 
			{
				try 
				{
					dropStatus.SelectedValue = value.ToString();
				} 
				catch {}
			}
		}

        /// <summary>
        /// Gets or sets a value indicating whether this <see cref="PickStatus"/> is enabled.
        /// </summary>
        /// <value><c>true</c> if enabled; otherwise, <c>false</c>.</value>
		public bool Enabled 
		{
			get { return dropStatus.Enabled; }
			set { dropStatus.Enabled = value; }
		}

        /// <summary>
        /// Gets or sets the data source.
        /// </summary>
        /// <value>The data source.</value>
        public List<Status> DataSource 
		{
			get { return _DataSource; }
			set { _DataSource = value; }
		}

        /// <summary>
        /// Binds a data source to the invoked server control and all its child controls.
        /// </summary>
		public override void DataBind() 
		{
			dropStatus.Items.Clear();
			dropStatus.DataSource = _DataSource;
			dropStatus.DataTextField = "Name";
			dropStatus.DataValueField = "Id";
			dropStatus.DataBind();
			if (_DisplayDefault)
                dropStatus.Items.Insert(0, new ListItem(GetLocalResourceObject("SelectStatus").ToString(), "0"));
		}

        /// <summary>
        /// Gets or sets a value indicating whether this <see cref="PickStatus"/> is required.
        /// </summary>
        /// <value><c>true</c> if required; otherwise, <c>false</c>.</value>
		public bool Required 
		{
			get { return reqVal.Visible; }
			set { reqVal.Visible = value; }
		}

	
	}
}
