namespace BugNET.Administration.Projects.UserControls
{
    using System;
    using System.Web.UI.WebControls;
    using BugNET.BLL;
    using BugNET.Entities;
    using BugNET.UserControls;
    using BugNET.UserInterfaceLayer;

    /// <summary>
	///	Summary description for ProjectMilestones.
	/// </summary>
	public partial class ProjectMilestones : System.Web.UI.UserControl,IEditProjectControl
	{

        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
		protected void Page_Load(object sender, System.EventArgs e)
		{}

		#region IEditProjectControl Members

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
        /// Inits this instance.
        /// </summary>
		public void Initialize()
		{
           BindMilestones();
           lstImages.Initialize();
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
        /// Gets a value indicating whether [show save button].
        /// </summary>
        /// <value><c>true</c> if [show save button]; otherwise, <c>false</c>.</value>
        public bool ShowSaveButton
        {
            get { return false; }
        }

		#endregion

        /// <summary>
        /// Binds the milestones.
        /// </summary>
        private void BindMilestones()
        {
            grdMilestones.Columns[1].HeaderText = GetGlobalResourceObject("SharedResources", "Milestone").ToString();
            grdMilestones.Columns[2].HeaderText = GetGlobalResourceObject("SharedResources", "Image").ToString();
            grdMilestones.Columns[3].HeaderText = GetGlobalResourceObject("SharedResources", "DueDate").ToString();         
            grdMilestones.Columns[4].HeaderText = GetGlobalResourceObject("SharedResources", "ReleaseDate").ToString();
            grdMilestones.Columns[5].HeaderText = GetLocalResourceObject("IsCompletedMilestone.Text").ToString();
            grdMilestones.Columns[6].HeaderText = GetGlobalResourceObject("SharedResources" , "Notes").ToString();
            grdMilestones.Columns[7].HeaderText = GetGlobalResourceObject("SharedResources", "Order").ToString();
           

            grdMilestones.DataSource = MilestoneManager.GetByProjectId(ProjectId);
            grdMilestones.DataKeyField = "Id";
            grdMilestones.DataBind();

            if (grdMilestones.Items.Count == 0)
                grdMilestones.Visible = false;
            else
                grdMilestones.Visible = true;
        }


        /// <summary>
        /// Deletes the milestone.
        /// </summary>
        /// <param name="s">The s.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.DataGridCommandEventArgs"/> instance containing the event data.</param>
        protected void DeleteMilestone(Object s, DataGridCommandEventArgs e)
        {
            int mileStoneId = (int)grdMilestones.DataKeys[e.Item.ItemIndex];

            if (!MilestoneManager.Delete(mileStoneId))
                lblError.Text = "Could not delete Milestone";
            else
                BindMilestones();
        }

        /// <summary>
        /// Handles the Click event of the cmdCancel control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="T:System.EventArgs"/> instance containing the event data.</param>
        protected void cmdCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Administration/Projects/EditProject.aspx?id=" + ProjectId.ToString());
        }

        /// <summary>
        /// Handles the Validate event of the MilestoneValidation control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="T:System.Web.UI.WebControls.ServerValidateEventArgs"/> instance containing the event data.</param>
        protected void MilestoneValidation_Validate(object sender, ServerValidateEventArgs e)
        {
            //validate that at least one Milestone exists.
            if (MilestoneManager.GetByProjectId(ProjectId).Count > 0)
            {
                e.IsValid = true;
            }
            else
            {
                e.IsValid = false;
            }
           
        }

        /// <summary>
        /// Handles the Edit event of the grdMilestones control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.DataGridCommandEventArgs"/> instance containing the event data.</param>
        protected void grdMilestones_Edit(object sender, DataGridCommandEventArgs e)
        {
            grdMilestones.EditItemIndex = e.Item.ItemIndex;
            grdMilestones.DataBind();
        }

        /// <summary>
        /// Handles the Update event of the grdMilestones control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.DataGridCommandEventArgs"/> instance containing the event data.</param>
        protected void grdMilestones_Update(object sender, DataGridCommandEventArgs e)
        {
            TextBox txtMilestoneName = (TextBox)e.Item.FindControl("txtMilestoneName");
            if (txtMilestoneName.Text.Trim()=="")
            {
                throw new ArgumentNullException("Milestone Name is empty");
            }

            PickImage pickimg = (PickImage)e.Item.FindControl("lstEditImages");
            PickDate MilestoneDueDate = (PickDate)e.Item.FindControl("MilestoneDueDate");
            PickDate MilestoneReleaseDate = (PickDate)e.Item.FindControl("MilestoneReleaseDate");
            CheckBox IsCompletedMilestone = (CheckBox)e.Item.FindControl("chkEditCompletedMilestone");
            TextBox txtMilestoneNotes = (TextBox)e.Item.FindControl("txtMilestoneNotes");

            Milestone m = MilestoneManager.GetById(Convert.ToInt32(grdMilestones.DataKeys[e.Item.ItemIndex]));
            m.Name = txtMilestoneName.Text.Trim();
            m.ImageUrl = pickimg.SelectedValue;
            m.DueDate = MilestoneDueDate.SelectedValue;
            m.ReleaseDate = MilestoneReleaseDate.SelectedValue;
            m.IsCompleted = IsCompletedMilestone.Checked;
            m.Notes = txtMilestoneNotes.Text;
            MilestoneManager.SaveOrUpdate(m);

            grdMilestones.EditItemIndex = -1;
            BindMilestones();
          
        }

        /// <summary>
        /// Handles the Cancel event of the grdMilestones control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.DataGridCommandEventArgs"/> instance containing the event data.</param>
        protected void grdMilestones_Cancel(object sender, DataGridCommandEventArgs e)
        {
            grdMilestones.EditItemIndex =-1;
            grdMilestones.DataBind();
        }
        /// <summary>
        /// Handles the ItemDataBound event of the grdMilestones control.
        /// </summary>
        /// <param name="s">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.DataGridItemEventArgs"/> instance containing the event data.</param>
        protected void grdMilestones_ItemDataBound(Object s, DataGridItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Milestone currentMilestone = (Milestone)e.Item.DataItem;

                Label lblMilestoneName = (Label)e.Item.FindControl("lblMilestoneName");
                lblMilestoneName.Text = currentMilestone.Name;

                Label lblMilestoneDueDate = (Label)e.Item.FindControl("lblMilestoneDueDate");
                lblMilestoneDueDate.Text = (currentMilestone.DueDate != null ? ((DateTime)currentMilestone.DueDate).ToShortDateString(): string.Empty);

                Label lblMilestoneReleaseDate = (Label)e.Item.FindControl("lblMilestoneReleaseDate");
                lblMilestoneReleaseDate.Text = (currentMilestone.ReleaseDate != null ? ((DateTime)currentMilestone.ReleaseDate).ToShortDateString() : string.Empty);

                Label lblMilestoneNotes = (Label)e.Item.FindControl("lblMilestoneNotes");
                lblMilestoneNotes.Text = currentMilestone.Notes;

                CheckBox IsCompletedMilestone = (CheckBox)e.Item.FindControl("chkCompletedMilestone");
                IsCompletedMilestone.Checked = currentMilestone.IsCompleted;

                ImageButton UpButton = (ImageButton)e.Item.FindControl("MoveUp");
                ImageButton DownButton = (ImageButton)e.Item.FindControl("MoveDown");
                UpButton.CommandArgument = currentMilestone.Id.ToString();
                DownButton.CommandArgument = currentMilestone.Id.ToString();

                System.Web.UI.WebControls.Image imgMilestone = (System.Web.UI.WebControls.Image)e.Item.FindControl("imgMilestone");
                if (currentMilestone.ImageUrl == String.Empty)
                {
                    imgMilestone.Visible = false;
                }
                else
                {
                    imgMilestone.ImageUrl = "~/Images/Milestone/" + currentMilestone.ImageUrl;
                    imgMilestone.AlternateText = currentMilestone.Name;
                }

                Button btnDelete = (Button)e.Item.FindControl("btnDelete");
                string message = string.Format(GetLocalResourceObject("ConfirmDelete").ToString(), currentMilestone.Name);
                btnDelete.Attributes.Add("onclick", String.Format("return confirm('{0}');", message));
            }
            if (e.Item.ItemType == ListItemType.EditItem)
            {
                Milestone currentMilestone = (Milestone)e.Item.DataItem;
                TextBox txtMilestoneName = (TextBox)e.Item.FindControl("txtMilestoneName");
                PickImage pickimg = (PickImage)e.Item.FindControl("lstEditImages");
                PickDate MilestoneDueDate = (PickDate)e.Item.FindControl("MilestoneDueDate");
                PickDate MilestoneReleaseDate = (PickDate)e.Item.FindControl("MilestoneReleaseDate");
                TextBox txtMilestoneNotes = (TextBox)e.Item.FindControl("txtMilestoneNotes");
                CheckBox IsCompletedMilestone = (CheckBox)e.Item.FindControl("chkEditCompletedMilestone");
                IsCompletedMilestone.Checked = currentMilestone.IsCompleted;

                txtMilestoneNotes.Text = currentMilestone.Notes;
                txtMilestoneName.Text = currentMilestone.Name;
                MilestoneDueDate.SelectedValue = currentMilestone.DueDate;
                MilestoneReleaseDate.SelectedValue = currentMilestone.ReleaseDate;
                pickimg.Initialize();
                pickimg.SelectedValue = currentMilestone.ImageUrl;
            }
        }
      
        /// <summary>
        /// Adds the milestone.
        /// </summary>
        /// <param name="s">The s.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void AddMilestone(Object s, EventArgs e)
        {
            string newName = txtName.Text.Trim();

            if (newName == String.Empty)
                return;

            var newMilestone = new Milestone
                                   {
                                       ProjectId = ProjectId, 
                                       Name = newName, 
                                       ImageUrl = lstImages.SelectedValue, 
                                       DueDate = DueDate.SelectedValue,
                                       ReleaseDate = ReleaseDate.SelectedValue, 
                                       IsCompleted = chkCompletedMilestone.Checked, 
                                       Notes = txtMilestoneNotes.Text
                                   };

            if (MilestoneManager.SaveOrUpdate(newMilestone))
            {
                txtMilestoneNotes.Text = string.Empty;
                txtName.Text = string.Empty; 
                DueDate.SelectedValue = null;
                chkCompletedMilestone.Checked = false;
                ReleaseDate.SelectedValue = null;
                BindMilestones();
                lstImages.SelectedValue = String.Empty;
            }
            else
            {
                lblError.Text = LoggingManager.GetErrorMessageResource("SaveMilestoneError");
            }
        }


        /// <summary>
        /// Handles the ItemCommand event of the grdMilestones control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.DataGridCommandEventArgs"/> instance containing the event data.</param>
        protected void grdMilestones_ItemCommand(object sender, DataGridCommandEventArgs e)
        {
            Milestone m;
            int itemIndex = e.Item.ItemIndex;
            switch (e.CommandName)
            {
                case "up":
                    //move row up
                    if (itemIndex == 0)
                        return;
                    m = MilestoneManager.GetById(Convert.ToInt32(e.CommandArgument));
                    m.SortOrder -= 1;
                    MilestoneManager.SaveOrUpdate(m);
                    break;
                case "down":
                    //move row down
                    if (itemIndex == grdMilestones.Items.Count -1)
                        return;
                    m = MilestoneManager.GetById(Convert.ToInt32(e.CommandArgument));
                    m.SortOrder += 1;
                    MilestoneManager.SaveOrUpdate(m);
                    break;
            }
            BindMilestones();
        } 
	}
}
