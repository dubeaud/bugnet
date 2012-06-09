using System;
using System.Web.UI.WebControls;
using BugNET.BLL;
using BugNET.Common;
using BugNET.Entities;
using BugNET.UserControls;
using BugNET.UserInterfaceLayer;

namespace BugNET.Administration.Projects.UserControls
{
    public partial class ProjectResolutions : System.Web.UI.UserControl, IEditProjectControl
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
            BindResolutions();
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
        private void BindResolutions()
        {
            grdResolutions.Columns[1].HeaderText = GetGlobalResourceObject("SharedResources", "Resolution").ToString();
            grdResolutions.Columns[2].HeaderText = GetGlobalResourceObject("SharedResources", "Image").ToString();
            grdResolutions.Columns[3].HeaderText = GetGlobalResourceObject("SharedResources", "Order").ToString();

            grdResolutions.DataSource = ResolutionManager.GetByProjectId(ProjectId);
            grdResolutions.DataKeyField = "Id";
            grdResolutions.DataBind();

            grdResolutions.Visible = grdResolutions.Items.Count != 0;
        }


        /// <summary>
        /// Deletes the milestone.
        /// </summary>
        /// <param name="s">The s.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.DataGridCommandEventArgs"/> instance containing the event data.</param>
        protected void grdResolutions_Delete(Object s, DataGridCommandEventArgs e)
        {
            var id = (int)grdResolutions.DataKeys[e.Item.ItemIndex];
            string cannotDeleteMessage;

            if (!ResolutionManager.Delete(id, out cannotDeleteMessage))
            {
                ActionMessage.ShowErrorMessage(cannotDeleteMessage);
                return;
            }

            BindResolutions();
        }

        /// <summary>
        /// Handles the Validate event of the ResolutionValidation control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="T:System.Web.UI.WebControls.ServerValidateEventArgs"/> instance containing the event data.</param>
        protected void ResolutionValidation_Validate(object sender, ServerValidateEventArgs e)
        {
            //validate that at least one Resolution exists.
            e.IsValid = ResolutionManager.GetByProjectId(ProjectId).Count > 0;
        }

        /// <summary>
        /// Handles the Edit event of the grdResolutions control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.DataGridCommandEventArgs"/> instance containing the event data.</param>
        protected void grdResolutions_Edit(object sender, DataGridCommandEventArgs e)
        {
            grdResolutions.EditItemIndex = e.Item.ItemIndex;
            grdResolutions.DataBind();
        }

        /// <summary>
        /// Handles the Update event of the grdResolutions control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.DataGridCommandEventArgs"/> instance containing the event data.</param>
        protected void grdResolutions_Update(object sender, DataGridCommandEventArgs e)
        {
            
            var txtResolutionName = (TextBox)e.Item.FindControl("txtResolutionName");
            var pickimg = (PickImage)e.Item.FindControl("lstEditImages");

            if (txtResolutionName.Text.Trim() == "")
            {
                throw new ArgumentNullException("Resolution name is empty.");
            }

            var m = ResolutionManager.GetById(Convert.ToInt32(grdResolutions.DataKeys[e.Item.ItemIndex]));
            m.Name = txtResolutionName.Text.Trim();
            m.ImageUrl = pickimg.SelectedValue;
            ResolutionManager.SaveOrUpdate(m);

            grdResolutions.EditItemIndex = -1;
            BindResolutions();

        }

        /// <summary>
        /// Handles the Cancel event of the grdResolutions control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.DataGridCommandEventArgs"/> instance containing the event data.</param>
        protected void grdResolutions_Cancel(object sender, DataGridCommandEventArgs e)
        {
            grdResolutions.EditItemIndex = -1;
            grdResolutions.DataBind();
        }
        /// <summary>
        /// Handles the ItemDataBound event of the grdResolutions control.
        /// </summary>
        /// <param name="s">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.DataGridItemEventArgs"/> instance containing the event data.</param>
        protected void grdResolutions_ItemDataBound(Object s, DataGridItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                var currentResolution = (Resolution)e.Item.DataItem;

                var lblResolutionName = (Label)e.Item.FindControl("lblResolutionName");
                lblResolutionName.Text = currentResolution.Name;

                var upButton = (ImageButton)e.Item.FindControl("MoveUp");
                var downButton = (ImageButton)e.Item.FindControl("MoveDown");
                upButton.CommandArgument = currentResolution.Id.ToString();
                downButton.CommandArgument = currentResolution.Id.ToString();

                var imgResolution = (Image)e.Item.FindControl("imgResolution");
                if (currentResolution.ImageUrl == String.Empty)
                {
                    imgResolution.Visible = false;
                }
                else
                {
                    imgResolution.ImageUrl = "~/Images/Resolution/" + currentResolution.ImageUrl;
                    imgResolution.AlternateText = currentResolution.Name;
                }

                var cmdDelete = (ImageButton)e.Item.FindControl("cmdDelete");
                var message = string.Format(GetLocalResourceObject("ConfirmDelete").ToString(), currentResolution.Name.Trim());
                cmdDelete.Attributes.Add("onclick", String.Format("return confirm('{0}');", message.JsEncode()));
            }

            if (e.Item.ItemType == ListItemType.EditItem)
            {
                var currentResolution = (Resolution)e.Item.DataItem;
                var txtResolutionName = (TextBox)e.Item.FindControl("txtResolutionName");
                var pickimg = (PickImage)e.Item.FindControl("lstEditImages");

                txtResolutionName.Text = currentResolution.Name;
                pickimg.Initialize();
                pickimg.SelectedValue = currentResolution.ImageUrl;
            }
        }

        /// <summary>
        /// Adds the milestone.
        /// </summary>
        /// <param name="s">The s.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void AddResolution(Object s, EventArgs e)
        {

            var newName = txtName.Text.Trim();

            if (newName == String.Empty)
                return;

            var newResolution = new Resolution { ProjectId = ProjectId, Name = newName, ImageUrl = lstImages.SelectedValue};
            if (ResolutionManager.SaveOrUpdate(newResolution))
            {
                txtName.Text = "";
                BindResolutions();
                lstImages.SelectedValue = String.Empty;
            }
            else
            {
                ActionMessage.ShowErrorMessage(LoggingManager.GetErrorMessageResource("SaveResolutionError"));
            }
        }


        /// <summary>
        /// Handles the ItemCommand event of the grdResolutions control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.DataGridCommandEventArgs"/> instance containing the event data.</param>
        protected void grdResolutions_ItemCommand(object sender, DataGridCommandEventArgs e)
        {
            Resolution m;
            var itemIndex = e.Item.ItemIndex;
            switch (e.CommandName)
            {
                case "up":
                    //move row up
                    if (itemIndex == 0)
                        return;
                    m = ResolutionManager.GetById(Convert.ToInt32(e.CommandArgument));
                    m.SortOrder -= 1;
                    ResolutionManager.SaveOrUpdate(m);
                    break;
                case "down":
                    //move row down
                    if (itemIndex == grdResolutions.Items.Count - 1)
                        return;
                    m = ResolutionManager.GetById(Convert.ToInt32(e.CommandArgument));
                    m.SortOrder += 1;
                    ResolutionManager.SaveOrUpdate(m);
                    break;
            }
            BindResolutions();
        }
    }
}