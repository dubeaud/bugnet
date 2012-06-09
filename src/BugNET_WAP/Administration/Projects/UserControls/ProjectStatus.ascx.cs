using System;
using System.Web.UI.WebControls;
using BugNET.BLL;
using BugNET.Common;
using BugNET.Entities;
using BugNET.UserInterfaceLayer;
using BugNET.UserControls;

namespace BugNET.Administration.Projects.UserControls
{
    /// <summary>
    ///		Summary description for Status.
    /// </summary>
    public partial class ProjectStatus : System.Web.UI.UserControl, IEditProjectControl
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

            grdStatus.DataSource = StatusManager.GetByProjectId(ProjectId);
            grdStatus.DataKeyField = "Id";
            grdStatus.DataBind();

            grdStatus.Visible = grdStatus.Items.Count != 0;
        }


        /// <summary>
        /// Handles the ItemCommand event of the grdStatus control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.DataGridCommandEventArgs"/> instance containing the event data.</param>
        protected void grdStatus_ItemCommand(object sender, DataGridCommandEventArgs e)
        {
            Status s;
            var itemIndex = e.Item.ItemIndex;
            switch (e.CommandName)
            {
                case "up":
                    //move row up
                    if (itemIndex == 0)
                        return;
                    s = StatusManager.GetById(Convert.ToInt32(grdStatus.DataKeys[e.Item.ItemIndex]));
                    s.SortOrder -= 1;
                    StatusManager.SaveOrUpdate(s);
                    break;
                case "down":
                    //move row down
                    if (itemIndex == grdStatus.Items.Count - 1)
                        return;
                    s = StatusManager.GetById(Convert.ToInt32(grdStatus.DataKeys[e.Item.ItemIndex]));
                    s.SortOrder += 1;
                    StatusManager.SaveOrUpdate(s);
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

            var newStatus = new Status { ProjectId = ProjectId, Name = newName, ImageUrl = lstImages.SelectedValue, IsClosedState = chkClosedState.Checked };

            if (StatusManager.SaveOrUpdate(newStatus))
            {
                txtName.Text = "";
                BindStatus();
                lstImages.SelectedValue = String.Empty;
                chkClosedState.Checked = false;
            }
            else
            {
                ActionMessage.ShowErrorMessage(LoggingManager.GetErrorMessageResource("SaveStatusError"));
            }
        }


        /// <summary>
        /// Deletes the status.
        /// </summary>
        /// <param name="s">The s.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.DataGridCommandEventArgs"/> instance containing the event data.</param>
        protected void grdStatus_Delete(Object s, DataGridCommandEventArgs e)
        {
            var id = (int)grdStatus.DataKeys[e.Item.ItemIndex];
            string cannotDeleteMessage;

            if (!StatusManager.Delete(id, out cannotDeleteMessage))
            {
                ActionMessage.ShowErrorMessage(cannotDeleteMessage);
                return;
            }

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

            var txtStatusName = (TextBox)e.Item.FindControl("txtStatusName");
            var pickimg = (PickImage)e.Item.FindControl("lstEditImages");
            var chkClosed = (CheckBox)e.Item.FindControl("chkEditClosedState");

            if (txtStatusName.Text.Trim() == "")
            {
                throw new ArgumentNullException("Status Name empty");
            }

            Status s = StatusManager.GetById(Convert.ToInt32(grdStatus.DataKeys[e.Item.ItemIndex]));
            s.IsClosedState = chkClosed.Checked;
            s.Name = txtStatusName.Text.Trim();
            s.ImageUrl = pickimg.SelectedValue;
            StatusManager.SaveOrUpdate(s);

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
        protected void grdStatus_ItemDataBound(Object s, DataGridItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                var currentStatus = (Status)e.Item.DataItem;

                var lblStatusName = (Label)e.Item.FindControl("lblStatusName");
                lblStatusName.Text = currentStatus.Name;

                var imgStatus = (Image)e.Item.FindControl("imgStatus");
                if (currentStatus.ImageUrl == String.Empty)
                {
                    imgStatus.Visible = false;
                }
                else
                {
                    imgStatus.ImageUrl = "~/Images/Status/" + currentStatus.ImageUrl;
                    imgStatus.AlternateText = currentStatus.Name;
                }
                var closedState = (CheckBox)e.Item.FindControl("chkClosedState");
                closedState.Checked = currentStatus.IsClosedState;

                var cmdDelete = (ImageButton)e.Item.FindControl("cmdDelete");
                var message = string.Format(GetLocalResourceObject("ConfirmDelete").ToString(), currentStatus.Name.Trim());
                cmdDelete.Attributes.Add("onclick", String.Format("return confirm('{0}');", message.JsEncode()));
            }

            if (e.Item.ItemType == ListItemType.EditItem)
            {
                var currentStatus = (Status)e.Item.DataItem;
                var txtStatusName = (TextBox)e.Item.FindControl("txtStatusName");
                var pickimg = (PickImage)e.Item.FindControl("lstEditImages");
                var closedState = (CheckBox)e.Item.FindControl("chkEditClosedState");

                txtStatusName.Text = currentStatus.Name;
                pickimg.Initialize();
                pickimg.SelectedValue = currentStatus.ImageUrl;
                closedState.Checked = currentStatus.IsClosedState;
            }
        }


        /// <summary>
        /// Validates the status.
        /// </summary>
        /// <param name="s">The s.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.ServerValidateEventArgs"/> instance containing the event data.</param>
        protected void ValidateStatus(Object s, ServerValidateEventArgs e)
        {
            e.IsValid = grdStatus.Items.Count > 0;
        }
    }
}
