using System;
using System.Web.UI.WebControls;
using BugNET.BLL;
using BugNET.Entities;
using BugNET.UserControls;
using BugNET.UserInterfaceLayer;

namespace BugNET.Administration.Projects.UserControls
{
    public partial class ProjectResolutions : System.Web.UI.UserControl, IEditProjectControl
    {
        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void Page_Load(object sender, System.EventArgs e)
        { }

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
            BindResolutions();
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
        private void BindResolutions()
        {
            grdResolutions.Columns[1].HeaderText = GetGlobalResourceObject("SharedResources", "Resolution").ToString();
            grdResolutions.Columns[2].HeaderText = GetGlobalResourceObject("SharedResources", "Image").ToString();
            grdResolutions.Columns[3].HeaderText = GetGlobalResourceObject("SharedResources", "Order").ToString();

            grdResolutions.DataSource = ResolutionManager.GetResolutionsByProjectId(ProjectId);
            grdResolutions.DataKeyField = "Id";
            grdResolutions.DataBind();

            if (grdResolutions.Items.Count == 0)
                grdResolutions.Visible = false;
            else
                grdResolutions.Visible = true;
        }


        /// <summary>
        /// Deletes the milestone.
        /// </summary>
        /// <param name="s">The s.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.DataGridCommandEventArgs"/> instance containing the event data.</param>
        protected void DeleteResolution(Object s, DataGridCommandEventArgs e)
        {
            int mileStoneId = (int)grdResolutions.DataKeys[e.Item.ItemIndex];

            if (!ResolutionManager.DeleteResolution(mileStoneId))
                lblError.Text = LoggingManager.GetErrorMessageResource("DeleteResolutionError");
            else
                BindResolutions();
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
        /// Handles the Validate event of the ResolutionValidation control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="T:System.Web.UI.WebControls.ServerValidateEventArgs"/> instance containing the event data.</param>
        protected void ResolutionValidation_Validate(object sender, ServerValidateEventArgs e)
        {
            //validate that at least one Resolution exists.
            if (ResolutionManager.GetResolutionsByProjectId(ProjectId).Count > 0)
            {
                e.IsValid = true;
            }
            else
            {
                e.IsValid = false;
            }

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
            
            TextBox txtResolutionName = (TextBox)e.Item.FindControl("txtResolutionName");
            PickImage pickimg = (PickImage)e.Item.FindControl("lstEditImages");

            if (txtResolutionName.Text.Trim() == "")
            {
                throw new ArgumentNullException("Resolution name is empty.");
            }

            Resolution m = ResolutionManager.GetResolutionById(Convert.ToInt32(grdResolutions.DataKeys[e.Item.ItemIndex]));
            m.Name = txtResolutionName.Text.Trim();
            m.ImageUrl = pickimg.SelectedValue;
            ResolutionManager.SaveResolution(m);

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
                Resolution currentResolution = (Resolution)e.Item.DataItem;

                Label lblResolutionName = (Label)e.Item.FindControl("lblResolutionName");
                lblResolutionName.Text = currentResolution.Name;

                ImageButton UpButton = (ImageButton)e.Item.FindControl("MoveUp");
                ImageButton DownButton = (ImageButton)e.Item.FindControl("MoveDown");
                UpButton.CommandArgument = currentResolution.Id.ToString();
                DownButton.CommandArgument = currentResolution.Id.ToString();

                System.Web.UI.WebControls.Image imgResolution = (System.Web.UI.WebControls.Image)e.Item.FindControl("imgResolution");
                if (currentResolution.ImageUrl == String.Empty)
                {
                    imgResolution.Visible = false;
                }
                else
                {
                    imgResolution.ImageUrl = "~/Images/Resolution/" + currentResolution.ImageUrl;
                    imgResolution.AlternateText = currentResolution.Name;
                }
              
                Button btnDelete = (Button)e.Item.FindControl("btnDelete");
                string message = string.Format(GetLocalResourceObject("ConfirmDelete").ToString(), currentResolution.Name);
                btnDelete.Attributes.Add("onclick", String.Format("return confirm('{0}');", message));
            }
            if (e.Item.ItemType == ListItemType.EditItem)
            {
                Resolution currentResolution = (Resolution)e.Item.DataItem;
                TextBox txtResolutionName = (TextBox)e.Item.FindControl("txtResolutionName");
                PickImage pickimg = (PickImage)e.Item.FindControl("lstEditImages");

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

            string newName = txtName.Text.Trim();

            if (newName == String.Empty)
                return;

            Resolution newResolution = new Resolution(ProjectId, newName, lstImages.SelectedValue);
            if (ResolutionManager.SaveResolution(newResolution))
            {
                txtName.Text = "";
                BindResolutions();
                lstImages.SelectedValue = String.Empty;
            }
            else
            {
                lblError.Text = LoggingManager.GetErrorMessageResource("SaveResolutionError");
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
            int itemIndex = e.Item.ItemIndex;
            switch (e.CommandName)
            {
                case "up":
                    //move row up
                    if (itemIndex == 0)
                        return;
                    m = ResolutionManager.GetResolutionById(Convert.ToInt32(e.CommandArgument));
                    m.SortOrder -= 1;
                    ResolutionManager.SaveResolution(m);
                    break;
                case "down":
                    //move row down
                    if (itemIndex == grdResolutions.Items.Count - 1)
                        return;
                    m = ResolutionManager.GetResolutionById(Convert.ToInt32(e.CommandArgument));
                    m.SortOrder += 1;
                    ResolutionManager.SaveResolution(m);
                    break;
            }
            BindResolutions();
        }
    }
}