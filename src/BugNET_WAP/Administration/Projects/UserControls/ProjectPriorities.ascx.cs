namespace BugNET.Administration.Projects.UserControls
{
    using System;
    using System.Web.UI.WebControls;
    using BugNET.BLL;
    using BugNET.Entities;
    using BugNET.UserControls;
    using BugNET.UserInterfaceLayer;
    /// <summary>
    /// Summary description for Priority.
    /// </summary>
	public partial class ProjectPriorities : System.Web.UI.UserControl, IEditProjectControl
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
			this.grdPriorities.DeleteCommand += new System.Web.UI.WebControls.DataGridCommandEventHandler(this.DeletePriority);
			this.grdPriorities.ItemDataBound += new System.Web.UI.WebControls.DataGridItemEventHandler(this.grdPriorities_ItemDataBound);

		}
		#endregion

	
		//*********************************************************************
		//
		// Priority.ascx
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
			BindPriorities();
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
        /// Binds the priorities.
        /// </summary>
		void BindPriorities() 
		{
            grdPriorities.Columns[1].HeaderText = GetGlobalResourceObject("SharedResources", "Priority").ToString();
            grdPriorities.Columns[2].HeaderText = GetGlobalResourceObject("SharedResources", "Image").ToString();
            grdPriorities.Columns[3].HeaderText = GetGlobalResourceObject("SharedResources", "Order").ToString();

			grdPriorities.DataSource = PriorityManager.GetByProjectId(ProjectId);
			grdPriorities.DataKeyField="Id";
			grdPriorities.DataBind();

			if (grdPriorities.Items.Count == 0)
				grdPriorities.Visible = false;
			else
				grdPriorities.Visible = true;
		}

        /// <summary>
        /// Handles the ItemCommand event of the grdPriorities control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.DataGridCommandEventArgs"/> instance containing the event data.</param>
        protected void grdPriorities_ItemCommand(object sender, DataGridCommandEventArgs e)
        {
            Priority p;
            int itemIndex = e.Item.ItemIndex;
            switch (e.CommandName)
            {
                case "up":
                    //move row up
                    if (itemIndex == 0)
                        return;
                    p = PriorityManager.GetById(Convert.ToInt32(grdPriorities.DataKeys[e.Item.ItemIndex]));
                    p.SortOrder -= 1;
                    PriorityManager.SaveOrUpdate(p);
                    break;
                case "down":
                    //move row down
                    if (itemIndex == grdPriorities.Items.Count - 1)
                        return;
                    p = PriorityManager.GetById(Convert.ToInt32(grdPriorities.DataKeys[e.Item.ItemIndex]));
                    p.SortOrder += 1;
                    PriorityManager.SaveOrUpdate(p);
                    break;
            }
            BindPriorities();
        }

        /// <summary>
        /// Handles the Edit event of the grdPriority control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.DataGridCommandEventArgs"/> instance containing the event data.</param>
        protected void grdPriority_Edit(object sender, DataGridCommandEventArgs e)
        {
            grdPriorities.EditItemIndex = e.Item.ItemIndex;
            grdPriorities.DataBind();
        }

        /// <summary>
        /// Handles the Update event of the grdPriority control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.DataGridCommandEventArgs"/> instance containing the event data.</param>
        protected void grdPriorities_Update(object sender, DataGridCommandEventArgs e)
        {
            
            TextBox txtPriorityName = (TextBox)e.Item.FindControl("txtPriorityName");
            PickImage pickimg = (PickImage)e.Item.FindControl("lstEditImages");

            if (txtPriorityName.Text.Trim() == "")
            {
                throw new ArgumentNullException("Priorty Name is empty.");
            }

            Priority p = PriorityManager.GetById(Convert.ToInt32(grdPriorities.DataKeys[e.Item.ItemIndex]));
            p.Name = txtPriorityName.Text.Trim();
            p.ImageUrl = pickimg.SelectedValue;
            PriorityManager.SaveOrUpdate(p);

            grdPriorities.EditItemIndex = -1;
            BindPriorities();

        }

        /// <summary>
        /// Handles the Edit event of the grdPriorities control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.DataGridCommandEventArgs"/> instance containing the event data.</param>
        protected void grdPriorities_Edit(object sender, DataGridCommandEventArgs e)
        {
            grdPriorities.EditItemIndex = e.Item.ItemIndex;
            grdPriorities.DataBind();
        }

        /// <summary>
        /// Handles the Cancel event of the grdPriorities control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.DataGridCommandEventArgs"/> instance containing the event data.</param>
        protected void grdPriorities_Cancel(object sender, DataGridCommandEventArgs e)
        {
            grdPriorities.EditItemIndex = -1;
            grdPriorities.DataBind();
        }

        /// <summary>
        /// Adds the priority.
        /// </summary>
        /// <param name="s">The s.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
		protected void AddPriority(Object s, EventArgs e) 
		{
			var newName = txtName.Text.Trim();

			if (newName == String.Empty)
				return;

			var newPriority = new Priority { ProjectId = ProjectId, Name = newName, ImageUrl = lstImages.SelectedValue };

			if (PriorityManager.SaveOrUpdate(newPriority)) 
			{
				txtName.Text = "";
				lstImages.SelectedValue = String.Empty;
				BindPriorities();
			} 
			else 
			{
                lblError.Text = LoggingManager.GetErrorMessageResource("SavePriorityError");
			}
		}


        /// <summary>
        /// Deletes the priority.
        /// </summary>
        /// <param name="s">The s.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.DataGridCommandEventArgs"/> instance containing the event data.</param>
		void DeletePriority(Object s, DataGridCommandEventArgs e) 
		{
			int priorityId = (int)grdPriorities.DataKeys[e.Item.ItemIndex];

			if (!PriorityManager.Delete(priorityId))
				lblError.Text =  LoggingManager.GetErrorMessageResource("DeletePriorityError");
			else
				BindPriorities();
		}


        /// <summary>
        /// Handles the ItemDataBound event of the grdPriorities control.
        /// </summary>
        /// <param name="s">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.DataGridItemEventArgs"/> instance containing the event data.</param>
		void grdPriorities_ItemDataBound(Object s, DataGridItemEventArgs e) 
		{
			if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem) 
			{
				Priority currentPriority = (Priority)e.Item.DataItem;

				Label lblPriorityName = (Label)e.Item.FindControl("lblPriorityName");
				lblPriorityName.Text = currentPriority.Name;

				Image imgPriority = (Image)e.Item.FindControl("imgPriority");
				if (currentPriority.ImageUrl == String.Empty) 
				{
					imgPriority.Visible = false;
				} 
				else 
				{
					imgPriority.ImageUrl = "~/Images/Priority/" + currentPriority.ImageUrl;
					imgPriority.AlternateText = currentPriority.Name;
				}
                
				Button btnDelete = (Button)e.Item.FindControl("btnDelete");
                string message = string.Format(GetLocalResourceObject("ConfirmDelete").ToString(), currentPriority.Name);
                btnDelete.Attributes.Add("onclick", String.Format("return confirm('{0}');", message));
			}
            if (e.Item.ItemType == ListItemType.EditItem)
            {
                Priority currentPriority = (Priority)e.Item.DataItem;
                TextBox txtPriorityName = (TextBox)e.Item.FindControl("txtPriorityName");
                PickImage pickimg = (PickImage)e.Item.FindControl("lstEditImages");

                txtPriorityName.Text = currentPriority.Name;
                pickimg.Initialize();
                pickimg.SelectedValue = currentPriority.ImageUrl;
            }
		}


        /// <summary>
        /// Validates the priority.
        /// </summary>
        /// <param name="s">The s.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.ServerValidateEventArgs"/> instance containing the event data.</param>
		protected void ValidatePriority(Object s, ServerValidateEventArgs e) 
		{
			if (grdPriorities.Items.Count > 0)
				e.IsValid = true;
			else
				e.IsValid = false;
		}

	
	
	
	}
}
