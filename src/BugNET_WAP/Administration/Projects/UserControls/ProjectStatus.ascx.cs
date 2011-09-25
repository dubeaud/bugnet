namespace BugNET.Administration.Projects.UserControls
{
    using System;
    using System.Web.UI.WebControls;
    using BugNET.BLL;
    using BugNET.Entities;
    using BugNET.UserControls;
    using BugNET.UserInterfaceLayer;

    /// <summary>
	///		Summary description for Status.
	/// </summary>
	public partial class ProjectStatus : System.Web.UI.UserControl, IEditProjectControl
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
			Trace.Warn("Initializing");
			this.grdStatus.DeleteCommand += new System.Web.UI.WebControls.DataGridCommandEventHandler(this.DeleteStatus);
			this.grdStatus.ItemDataBound += new System.Web.UI.WebControls.DataGridItemEventHandler(this.grdStatus_ItemDataBound);

		}
		#endregion

	
		//*********************************************************************
		//
		// Status.ascx
		//
		// This user control is used by both the new project wizard and update
		// project page.
		//
		//*********************************************************************


		private int _ProjectId = -1;


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
			if (Page.IsValid)
				return true;
			else
				return false;
		}



        /// <summary>
        /// Inits this instance.
        /// </summary>
		public void Initialize() 
		{
			BindStatus();
			lstImages.Initialize();
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
        /// Binds the status.
        /// </summary>
		void BindStatus() 
		{

            grdStatus.Columns[1].HeaderText = GetGlobalResourceObject("SharedResources", "Status").ToString();
            grdStatus.Columns[2].HeaderText = GetGlobalResourceObject("SharedResources", "Image").ToString();
            grdStatus.Columns[3].HeaderText = GetLocalResourceObject("IsClosedState.Text").ToString();
            grdStatus.Columns[4].HeaderText = GetGlobalResourceObject("SharedResources", "Order").ToString();

			grdStatus.DataSource = StatusManager.GetStatusByProjectId(ProjectId);
			grdStatus.DataKeyField="Id";
			grdStatus.DataBind();

			if (grdStatus.Items.Count == 0)
				grdStatus.Visible = false;
			else
				grdStatus.Visible = true;
		}


        /// <summary>
        /// Handles the ItemCommand event of the grdStatus control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.DataGridCommandEventArgs"/> instance containing the event data.</param>
        protected void grdStatus_ItemCommand(object sender, DataGridCommandEventArgs e)
        {
            Status s;
            int itemIndex = e.Item.ItemIndex;
            switch (e.CommandName)
            {
                case "up":
                    //move row up
                    if (itemIndex == 0)
                        return;
                    s = StatusManager.GetStatusById(Convert.ToInt32(grdStatus.DataKeys[e.Item.ItemIndex]));
                    s.SortOrder -= 1;
                    StatusManager.SaveStatus(s);
                    break;
                case "down":
                    //move row down
                    if (itemIndex == grdStatus.Items.Count - 1)
                        return;
                    s = StatusManager.GetStatusById(Convert.ToInt32(grdStatus.DataKeys[e.Item.ItemIndex]));
                    s.SortOrder += 1;
                    StatusManager.SaveStatus(s);
                    break;
            }
            BindStatus();
        }

        /// <summary>
        /// Adds the status.
        /// </summary>
        /// <param name="s">The s.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
		protected void AddStatus(Object s, EventArgs e) 
		{
			string newName = txtName.Text.Trim();

			if (newName == String.Empty)
				return;

			Status newStatus = new Status(ProjectId, newName, lstImages.SelectedValue,chkClosedState.Checked);
			if (StatusManager.SaveStatus(newStatus)) 
			{
				txtName.Text = "";
				BindStatus();
				lstImages.SelectedValue = String.Empty;
                chkClosedState.Checked = false;
			} 
			else 
			{
                lblError.Text = LoggingManager.GetErrorMessageResource("SaveStatusError");
			}
		}


        /// <summary>
        /// Deletes the status.
        /// </summary>
        /// <param name="s">The s.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.DataGridCommandEventArgs"/> instance containing the event data.</param>
		void DeleteStatus(Object s, DataGridCommandEventArgs e) 
		{
			int statusId = (int)grdStatus.DataKeys[e.Item.ItemIndex];

			if (!StatusManager.DeleteStatus(statusId))
                lblError.Text = LoggingManager.GetErrorMessageResource("DeleteStatusError");
			else
				BindStatus();

		}

        /// <summary>
        /// Handles the Edit event of the grdStatus control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.DataGridCommandEventArgs"/> instance containing the event data.</param>
        protected void grdStatus_Edit(object sender, DataGridCommandEventArgs e)
        {
            grdStatus.EditItemIndex = e.Item.ItemIndex;
            grdStatus.DataBind();
        }

        /// <summary>
        /// Handles the Update event of the grdStatus control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.DataGridCommandEventArgs"/> instance containing the event data.</param>
        protected void grdStatus_Update(object sender, DataGridCommandEventArgs e)
        {
            
            TextBox txtStatusName = (TextBox)e.Item.FindControl("txtStatusName");
            PickImage pickimg = (PickImage)e.Item.FindControl("lstEditImages");
            CheckBox chkClosed = (CheckBox)e.Item.FindControl("chkEditClosedState");

            if (txtStatusName.Text.Trim() == "")
            {
                throw new ArgumentNullException("Status Name empty");
            }

            Status s = StatusManager.GetStatusById(Convert.ToInt32(grdStatus.DataKeys[e.Item.ItemIndex]));
            s.IsClosedState = chkClosed.Checked;
            s.Name = txtStatusName.Text.Trim();
            s.ImageUrl = pickimg.SelectedValue;
            StatusManager.SaveStatus(s);

            grdStatus.EditItemIndex = -1;
            BindStatus();

        }

        /// <summary>
        /// Handles the Cancel event of the grdStatus control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.DataGridCommandEventArgs"/> instance containing the event data.</param>
        protected void grdStatus_Cancel(object sender, DataGridCommandEventArgs e)
        {
            grdStatus.EditItemIndex = -1;
            grdStatus.DataBind();
        }


        /// <summary>
        /// Handles the ItemDataBound event of the grdStatus control.
        /// </summary>
        /// <param name="s">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.DataGridItemEventArgs"/> instance containing the event data.</param>
		void grdStatus_ItemDataBound(Object s, DataGridItemEventArgs e) 
		{
			if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem) 
			{
				Status currentStatus = (Status)e.Item.DataItem;

				Label lblStatusName = (Label)e.Item.FindControl("lblStatusName");
				lblStatusName.Text = currentStatus.Name;

				Image imgStatus = (Image)e.Item.FindControl("imgStatus");
				if (currentStatus.ImageUrl == String.Empty) 
				{
					imgStatus.Visible = false;
				} 
				else 
				{
					imgStatus.ImageUrl = "~/Images/Status/" + currentStatus.ImageUrl;
					imgStatus.AlternateText = currentStatus.Name;
				}
                CheckBox ClosedState = (CheckBox)e.Item.FindControl("chkClosedState");
                ClosedState.Checked = currentStatus.IsClosedState;

				Button btnDelete = (Button)e.Item.FindControl("btnDelete");
                string message = string.Format(GetLocalResourceObject("ConfirmDelete").ToString(),currentStatus.Name);
                btnDelete.Attributes.Add("onclick", String.Format("return confirm('{0}');", message));
			}
            if (e.Item.ItemType == ListItemType.EditItem)
            {
                Status currentStatus = (Status)e.Item.DataItem;
                TextBox txtStatusName = (TextBox)e.Item.FindControl("txtStatusName");
                PickImage pickimg = (PickImage)e.Item.FindControl("lstEditImages");
                CheckBox ClosedState = (CheckBox)e.Item.FindControl("chkEditClosedState");

                txtStatusName.Text = currentStatus.Name;
                pickimg.Initialize();
                pickimg.SelectedValue = currentStatus.ImageUrl;
                ClosedState.Checked = currentStatus.IsClosedState;
            }
		}


        /// <summary>
        /// Validates the status.
        /// </summary>
        /// <param name="s">The s.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.ServerValidateEventArgs"/> instance containing the event data.</param>
		protected void ValidateStatus(Object s, ServerValidateEventArgs e) 
		{
			if (grdStatus.Items.Count > 0)
				e.IsValid = true;
			else
				e.IsValid = false;
		}


	
	
	}
}
