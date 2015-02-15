namespace BugNET.UserControls
{
    using System;
    using System.Collections.Generic;
    using System.Web.UI.WebControls;
    using Entities;

    /// <summary>
    /// Summary description for PickStatus.
    /// </summary>
	public partial class PickStatus : System.Web.UI.UserControl
	{
        /// <summary>
        /// Gets or sets a value indicating whether [display default].
        /// </summary>
        /// <value><c>true</c> if [display default]; otherwise, <c>false</c>.</value>
        public bool DisplayDefault { get; set; }

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
        public List<Status> DataSource { get; set; }

        /// <summary>
        /// Binds a data source to the invoked server control and all its child controls.
        /// </summary>
		public override void DataBind() 
		{
			dropStatus.Items.Clear();
			dropStatus.DataSource = DataSource;
			dropStatus.DataTextField = "Name";
			dropStatus.DataValueField = "Id";
			dropStatus.DataBind();
			if (DisplayDefault)
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
