using System;
using System.Web.UI.WebControls;
using BugNET.BLL;
using BugNET.Common;
using BugNET.Entities;
using BugNET.UserControls;
using BugNET.UserInterfaceLayer;

namespace BugNET.Administration.Projects.UserControls
{
    /// <summary>
	///	Summary description for ProjectMilestones.
	/// </summary>
	public partial class ProjectMilestones : System.Web.UI.UserControl,IEditProjectControl
	{

        //*********************************************************************
        //
        // This user control is used by both the new project wizard and update
        // project page.
        //
        //*********************************************************************

        /// <summary>
        /// Gets or sets the project id.
        /// </summary>
        /// <value>The project id.</value>
        public int ProjectId
        {
            get { return ViewState.Get("ProjectId", 0); }
            set { ViewState.Set("ProjectId", value); }
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
            return Page.IsValid;
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

            grdMilestones.Visible = grdMilestones.Items.Count != 0;
        }


        /// <summary>
        /// Deletes the milestone.
        /// </summary>
        /// <param name="s">The s.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.DataGridCommandEventArgs"/> instance containing the event data.</param>
        protected void grdMilestones_Delete(Object s, DataGridCommandEventArgs e)
        {
            var id = (int)grdMilestones.DataKeys[e.Item.ItemIndex];
            string cannotDeleteMessage;

            if (!MilestoneManager.Delete(id, out cannotDeleteMessage))
            {
                ActionMessage.ShowErrorMessage(cannotDeleteMessage);
                return;
            }

            BindMilestones();
        }

        /// <summary>
        /// Handles the Validate event of the MilestoneValidation control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="T:System.Web.UI.WebControls.ServerValidateEventArgs"/> instance containing the event data.</param>
        protected void MilestoneValidation_Validate(object sender, ServerValidateEventArgs e)
        {
            //validate that at least one Milestone exists.
            e.IsValid = MilestoneManager.GetByProjectId(ProjectId).Count > 0;
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
            var txtMilestoneName = (TextBox)e.Item.FindControl("txtMilestoneName");
            if (txtMilestoneName.Text.Trim()=="")
            {
                throw new ArgumentNullException("Milestone Name is empty");
            }

            var pickimg = (PickImage)e.Item.FindControl("lstEditImages");
            var milestoneDueDate = (PickDate)e.Item.FindControl("MilestoneDueDate");
            var milestoneReleaseDate = (PickDate)e.Item.FindControl("MilestoneReleaseDate");
            var isCompletedMilestone = (CheckBox)e.Item.FindControl("chkEditCompletedMilestone");
            var milestoneNotes = (TextBox)e.Item.FindControl("txtMilestoneNotes");

            var m = MilestoneManager.GetById(Convert.ToInt32(grdMilestones.DataKeys[e.Item.ItemIndex]));
            m.Name = txtMilestoneName.Text.Trim();
            m.ImageUrl = pickimg.SelectedValue;
            m.DueDate = milestoneDueDate.SelectedValue;
            m.ReleaseDate = milestoneReleaseDate.SelectedValue;
            m.IsCompleted = isCompletedMilestone.Checked;
            m.Notes = milestoneNotes.Text;
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
                var currentMilestone = (Milestone)e.Item.DataItem;

                var lblMilestoneName = (Label)e.Item.FindControl("lblMilestoneName");
                lblMilestoneName.Text = currentMilestone.Name;

                var lblMilestoneDueDate = (Label)e.Item.FindControl("lblMilestoneDueDate");
                lblMilestoneDueDate.Text = (currentMilestone.DueDate != null ? ((DateTime)currentMilestone.DueDate).ToShortDateString(): string.Empty);

                var lblMilestoneReleaseDate = (Label)e.Item.FindControl("lblMilestoneReleaseDate");
                lblMilestoneReleaseDate.Text = (currentMilestone.ReleaseDate != null ? ((DateTime)currentMilestone.ReleaseDate).ToShortDateString() : string.Empty);

                var lblMilestoneNotes = (Label)e.Item.FindControl("lblMilestoneNotes");
                lblMilestoneNotes.Text = currentMilestone.Notes;

                var isCompletedMilestone = (CheckBox)e.Item.FindControl("chkCompletedMilestone");
                isCompletedMilestone.Checked = currentMilestone.IsCompleted;

                var upButton = (ImageButton)e.Item.FindControl("MoveUp");
                var downButton = (ImageButton)e.Item.FindControl("MoveDown");
                upButton.CommandArgument = currentMilestone.Id.ToString();
                downButton.CommandArgument = currentMilestone.Id.ToString();

                var imgMilestone = (Image)e.Item.FindControl("imgMilestone");
                if (currentMilestone.ImageUrl == String.Empty)
                {
                    imgMilestone.Visible = false;
                }
                else
                {
                    imgMilestone.ImageUrl = "~/Images/Milestone/" + currentMilestone.ImageUrl;
                    imgMilestone.AlternateText = currentMilestone.Name;
                }

                var cmdDelete = (ImageButton)e.Item.FindControl("cmdDelete");
                var message = string.Format(GetLocalResourceObject("ConfirmDelete").ToString(), currentMilestone.Name.Trim());
                cmdDelete.Attributes.Add("onclick", String.Format("return confirm('{0}');", message.JsEncode()));
            }

            if (e.Item.ItemType == ListItemType.EditItem)
            {
                var currentMilestone = (Milestone)e.Item.DataItem;
                var milestoneName = (TextBox)e.Item.FindControl("txtMilestoneName");
                var pickimg = (PickImage)e.Item.FindControl("lstEditImages");
                var milestoneDueDate = (PickDate)e.Item.FindControl("MilestoneDueDate");
                var milestoneReleaseDate = (PickDate)e.Item.FindControl("MilestoneReleaseDate");
                var milestoneNotes = (TextBox)e.Item.FindControl("txtMilestoneNotes");
                var isCompletedMilestone = (CheckBox)e.Item.FindControl("chkEditCompletedMilestone");
                isCompletedMilestone.Checked = currentMilestone.IsCompleted;

                milestoneNotes.Text = currentMilestone.Notes;
                milestoneName.Text = currentMilestone.Name;
                milestoneDueDate.SelectedValue = currentMilestone.DueDate;
                milestoneReleaseDate.SelectedValue = currentMilestone.ReleaseDate;
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
            var newName = txtName.Text.Trim();

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
                ActionMessage.ShowErrorMessage(LoggingManager.GetErrorMessageResource("SaveMilestoneError"));
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
            var itemIndex = e.Item.ItemIndex;
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
