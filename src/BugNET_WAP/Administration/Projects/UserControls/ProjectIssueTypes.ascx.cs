using System;
using System.Web.UI.WebControls;
using BugNET.BLL;
using BugNET.Common;
using BugNET.Entities;
using BugNET.UserControls;
using BugNET.UserInterfaceLayer;

namespace BugNET.Administration.Projects.UserControls
{
    public partial class ProjectIssueTypes : System.Web.UI.UserControl, IEditProjectControl
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
        /// Gets a value indicating whether [show save button].
        /// </summary>
        /// <value><c>true</c> if [show save button]; otherwise, <c>false</c>.</value>
        public bool ShowSaveButton
        {
            get { return false; }
        }

        /// <summary>
        /// Inits this instance.
        /// </summary>
        public void Initialize()
        {
            BindIssueType();
            lstImages.Initialize();
        }


        /// <summary>
        /// Binds the status.
        /// </summary>
        void BindIssueType()
        {
            grdIssueTypes.Columns[1].HeaderText = GetGlobalResourceObject("SharedResources", "IssueType").ToString();
            grdIssueTypes.Columns[2].HeaderText = GetGlobalResourceObject("SharedResources", "Image").ToString();
            grdIssueTypes.Columns[3].HeaderText = GetGlobalResourceObject("SharedResources", "Order").ToString();

            grdIssueTypes.DataSource = IssueTypeManager.GetByProjectId(ProjectId);
            grdIssueTypes.DataKeyField = "Id";
            grdIssueTypes.DataBind();

            grdIssueTypes.Visible = grdIssueTypes.Items.Count != 0;
        }


        /// <summary>
        /// Handles the ItemCommand event of the grdIssueTypes control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.DataGridCommandEventArgs"/> instance containing the event data.</param>
        protected void grdIssueTypes_ItemCommand(object sender, DataGridCommandEventArgs e)
        {
            IssueType s;
            var itemIndex = e.Item.ItemIndex;
            switch (e.CommandName)
            {
                case "up":
                    //move row up
                    if (itemIndex == 0)
                        return;
                    s = IssueTypeManager.GetById(Convert.ToInt32(grdIssueTypes.DataKeys[e.Item.ItemIndex]));
                    s.SortOrder -= 1;
                    IssueTypeManager.SaveOrUpdate(s);
                    break;
                case "down":
                    //move row down
                    if (itemIndex == grdIssueTypes.Items.Count - 1)
                        return;
                    s = IssueTypeManager.GetById(Convert.ToInt32(grdIssueTypes.DataKeys[e.Item.ItemIndex]));
                    s.SortOrder += 1;
                    IssueTypeManager.SaveOrUpdate(s);
                    break;
            }
            BindIssueType();
        }

        /// <summary>
        /// Adds the status.
        /// </summary>
        /// <param name="s">The s.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void AddIssueType(Object s, EventArgs e)
        {
            var newName = txtName.Text.Trim();

            if (newName == String.Empty)
                return;

            var newIssueType = new IssueType { ProjectId = ProjectId, Name = newName, ImageUrl = lstImages.SelectedValue};

            if (IssueTypeManager.SaveOrUpdate(newIssueType))
            {
                txtName.Text = "";
                BindIssueType();
                lstImages.SelectedValue = String.Empty;
            }
            else
            {
                lblError.Text = LoggingManager.GetErrorMessageResource("SaveIssueTypeError");
            }
        }

        /// <summary>
        /// Deletes the status.
        /// </summary>
        /// <param name="s">The s.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.DataGridCommandEventArgs"/> instance containing the event data.</param>
        protected void grdIssueTypes_Delete(Object s, DataGridCommandEventArgs e)
        {
            var statusId = (int)grdIssueTypes.DataKeys[e.Item.ItemIndex];

            if (!IssueTypeManager.DeleteIssueType(statusId))
                lblError.Text = LoggingManager.GetErrorMessageResource("DeleteIssueTypeError");
            else
                BindIssueType();

        }

        /// <summary>
        /// Handles the Edit event of the grdIssueTypes control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.DataGridCommandEventArgs"/> instance containing the event data.</param>
        protected void grdIssueTypes_Edit(object sender, DataGridCommandEventArgs e)
        {
            grdIssueTypes.EditItemIndex = e.Item.ItemIndex;
            grdIssueTypes.DataBind();
        }

        /// <summary>
        /// Handles the Update event of the grdIssueTypes control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.DataGridCommandEventArgs"/> instance containing the event data.</param>
        protected void grdIssueTypes_Update(object sender, DataGridCommandEventArgs e)
        {
            
            var txtIssueTypeName = (TextBox)e.Item.FindControl("txtIssueTypeName");
            var pickimg = (PickImage)e.Item.FindControl("lstEditImages");

            if (txtIssueTypeName.Text.Trim() == "")
            {
                throw new ArgumentNullException("Issue Type name empty");
            }

            var s = IssueTypeManager.GetById(Convert.ToInt32(grdIssueTypes.DataKeys[e.Item.ItemIndex]));
            s.Name = txtIssueTypeName.Text.Trim();
            s.ImageUrl = pickimg.SelectedValue;
            IssueTypeManager.SaveOrUpdate(s);

            grdIssueTypes.EditItemIndex = -1;
            BindIssueType();

        }

        /// <summary>
        /// Handles the Cancel event of the grdIssueTypes control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.DataGridCommandEventArgs"/> instance containing the event data.</param>
        protected void grdIssueTypes_Cancel(object sender, DataGridCommandEventArgs e)
        {
            grdIssueTypes.EditItemIndex = -1;
            grdIssueTypes.DataBind();
        }

        /// <summary>
        /// Handles the ItemDataBound event of the grdIssueTypes control.
        /// </summary>
        /// <param name="s">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.DataGridItemEventArgs"/> instance containing the event data.</param>
        protected void grdIssueTypes_ItemDataBound(Object s, DataGridItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                var currentIssueType = (IssueType)e.Item.DataItem;

                var lblIssueTypeName = (Label)e.Item.FindControl("lblIssueTypeName");
                lblIssueTypeName.Text = currentIssueType.Name;

                var imgIssueType = (Image)e.Item.FindControl("imgIssueType");
                if (currentIssueType.ImageUrl == String.Empty)
                {
                    imgIssueType.Visible = false;
                }
                else
                {
                    imgIssueType.ImageUrl = "~/Images/IssueType/" + currentIssueType.ImageUrl;
                    imgIssueType.AlternateText = currentIssueType.Name;
                }

                var cmdDelete = (ImageButton)e.Item.FindControl("cmdDelete");
                var message = string.Format(GetLocalResourceObject("ConfirmDelete").ToString(), currentIssueType.Name);
                cmdDelete.Attributes.Add("onclick", String.Format("return confirm('{0}');", message));
            }

            if (e.Item.ItemType == ListItemType.EditItem)
            {
                var currentIssueType = (IssueType)e.Item.DataItem;
                var txtIssueTypeName = (TextBox)e.Item.FindControl("txtIssueTypeName");
                var pickimg = (PickImage)e.Item.FindControl("lstEditImages");

                txtIssueTypeName.Text = currentIssueType.Name;
                pickimg.Initialize();
                pickimg.SelectedValue = currentIssueType.ImageUrl;
            }
        }

        /// <summary>
        /// Validates the status.
        /// </summary>
        /// <param name="s">The s.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.ServerValidateEventArgs"/> instance containing the event data.</param>
        protected void ValidateIssueType(Object s, ServerValidateEventArgs e)
        {
            e.IsValid = grdIssueTypes.Items.Count > 0;
        }
    }
}