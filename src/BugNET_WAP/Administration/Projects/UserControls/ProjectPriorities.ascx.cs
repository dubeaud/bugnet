using BugNET.Common;
using System;
using System.Web.UI.WebControls;
using BugNET.BLL;
using BugNET.Entities;
using BugNET.UserControls;
using BugNET.UserInterfaceLayer;

namespace BugNET.Administration.Projects.UserControls
{
    /// <summary>
    /// Summary description for Priority.
    /// </summary>
	public partial class ProjectPriorities : System.Web.UI.UserControl, IEditProjectControl
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
        /// Updates this instance.
        /// </summary>
        /// <returns></returns>
		public bool Update()
        {
            return Page.IsValid;
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

			grdPriorities.Visible = grdPriorities.Items.Count != 0;
		}

        /// <summary>
        /// Handles the ItemCommand event of the grdPriorities control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.DataGridCommandEventArgs"/> instance containing the event data.</param>
        protected void grdPriorities_ItemCommand(object sender, DataGridCommandEventArgs e)
        {
            Priority p;
            var itemIndex = e.Item.ItemIndex;
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
        /// Handles the Update event of the grdPriority control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.DataGridCommandEventArgs"/> instance containing the event data.</param>
        protected void grdPriorities_Update(object sender, DataGridCommandEventArgs e)
        {
            
            var txtPriorityName = (TextBox)e.Item.FindControl("txtPriorityName");
            var pickimg = (PickImage)e.Item.FindControl("lstEditImages");

            if (txtPriorityName.Text.Trim() == "")
            {
                throw new ArgumentNullException("Priorty Name is empty.");
            }

            var p = PriorityManager.GetById(Convert.ToInt32(grdPriorities.DataKeys[e.Item.ItemIndex]));
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
                ActionMessage.ShowErrorMessage(LoggingManager.GetErrorMessageResource("SavePriorityError"));
			}
		}


        /// <summary>
        /// Deletes the priority.
        /// </summary>
        /// <param name="s">The s.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.DataGridCommandEventArgs"/> instance containing the event data.</param>
        protected void grdPriorities_Delete(Object s, DataGridCommandEventArgs e) 
		{
            var id = (int)grdPriorities.DataKeys[e.Item.ItemIndex];
            string cannotDeleteMessage;

            if (!PriorityManager.Delete(id, out cannotDeleteMessage))
            {
                ActionMessage.ShowErrorMessage(cannotDeleteMessage);
                return;
            }

            BindPriorities();
		}


        /// <summary>
        /// Handles the ItemDataBound event of the grdPriorities control.
        /// </summary>
        /// <param name="s">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.DataGridItemEventArgs"/> instance containing the event data.</param>
		protected void grdPriorities_ItemDataBound(Object s, DataGridItemEventArgs e) 
		{
			if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem) 
			{
				var currentPriority = (Priority)e.Item.DataItem;

				var lblPriorityName = (Label)e.Item.FindControl("lblPriorityName");
				lblPriorityName.Text = currentPriority.Name;

				var imgPriority = (Image)e.Item.FindControl("imgPriority");
				if (currentPriority.ImageUrl == String.Empty) 
				{
					imgPriority.Visible = false;
				} 
				else 
				{
					imgPriority.ImageUrl = "~/Images/Priority/" + currentPriority.ImageUrl;
					imgPriority.AlternateText = currentPriority.Name;
				}

                var cmdDelete = (ImageButton)e.Item.FindControl("cmdDelete");
                var message = string.Format(GetLocalResourceObject("ConfirmDelete").ToString(), currentPriority.Name.Trim());
                cmdDelete.Attributes.Add("onclick", String.Format("return confirm('{0}');", message.JsEncode()));
			}

            if (e.Item.ItemType == ListItemType.EditItem)
            {
                var currentPriority = (Priority)e.Item.DataItem;
                var txtPriorityName = (TextBox)e.Item.FindControl("txtPriorityName");
                var pickimg = (PickImage)e.Item.FindControl("lstEditImages");

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
            e.IsValid = grdPriorities.Items.Count > 0;
        }
	}
}
