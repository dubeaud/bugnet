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
    /// Summary description for Mailboxes.
    /// </summary>
    public partial class Mailboxes : System.Web.UI.UserControl, IEditProjectControl
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
            BindMailboxes();

            IssueAssignedUser.DataSource = UserManager.GetUsersByProjectId(ProjectId);
            IssueAssignedUser.DataTextField = "DisplayName";
            IssueAssignedUser.DataValueField = "UserName";
            IssueAssignedUser.DataBind();

            IssueAssignedType.DataSource = IssueTypeManager.GetByProjectId(ProjectId);
            IssueAssignedType.DataBind();

            IssueAssignedCategory.DataSource =  CategoryManager.GetByProjectId(ProjectId);
            IssueAssignedCategory.DataBind();
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
        /// Binds the mailboxes.
        /// </summary>
        private void BindMailboxes()
        {
            grdMailboxes.Columns[1].HeaderText = GetLocalResourceObject("EmailAddressLabel.Text").ToString();
            grdMailboxes.Columns[2].HeaderText = GetLocalResourceObject("IssueAssignedUserLabel.Text").ToString();
            grdMailboxes.Columns[3].HeaderText = GetLocalResourceObject("IssueTypeLabel.Text").ToString();
            grdMailboxes.Columns[4].HeaderText = GetLocalResourceObject("IssueCategoryLabel.Text").ToString();

            grdMailboxes.DataSource = ProjectMailboxManager.GetByProjectId(ProjectId);
            grdMailboxes.DataKeyField = "Id";
            grdMailboxes.DataBind();

            grdMailboxes.Visible = grdMailboxes.Items.Count != 0;

            //IssueAssignedUser.SelectedValue = -1;
            //IssueAssignedType.SelectedValue = 0;

            //if (Security.GetUserRole().Equals(Globals.ReadOnlyRole))
            //    AddMailbox.Visible = false;

        }

        /// <summary>
        /// Handles the Click event of the btnAdd control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="T:System.EventArgs"/> instance containing the event data.</param>
        protected void btnAdd_Click(object sender, EventArgs e)
        {
            var mailbox = new ProjectMailbox
                              {
                                  AssignToDisplayName = string.Empty,
                                  AssignToId = Guid.Empty,
                                  AssignToUserName = IssueAssignedUser.SelectedValue,
                                  IssueTypeId = IssueAssignedType.SelectedValue,
                                  CategoryId = IssueAssignedCategory.SelectedValue,
                                  Mailbox = txtMailbox.Text,
                                  ProjectId = ProjectId
                              };

            if (ProjectMailboxManager.SaveOrUpdate(mailbox)) BindMailboxes();
        }

        /// <summary>
        /// Handles the DeleteCommand event of the grdMailboxes control.
        /// </summary>
        /// <param name="source">The source of the event.</param>
        /// <param name="e">The <see cref="T:System.Web.UI.WebControls.DataGridCommandEventArgs"/> instance containing the event data.</param>
        protected void dtgMailboxes_Delete(object source, System.Web.UI.WebControls.DataGridCommandEventArgs e)
        {
            var id = (int)grdMailboxes.DataKeys[e.Item.ItemIndex];

            if (!ProjectMailboxManager.Delete(id))
                ActionMessage.ShowErrorMessage(LoggingManager.GetErrorMessageResource("DeleteMailboxError"));
            else
                BindMailboxes();
        }

        /// <summary>
        /// Handles the ItemDataBound event of the grdMailboxes control.
        /// </summary>
        /// <param name="s">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.DataGridItemEventArgs"/> instance containing the event data.</param>
        protected void dtgMailboxes_ItemDataBound(Object s, DataGridItemEventArgs e)
        {
            ProjectMailbox currentMailbox;

            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                currentMailbox = (ProjectMailbox)e.Item.DataItem;

                var emailAddressLabel = (Label)e.Item.FindControl("EmailAddressLabel");
                emailAddressLabel.Text = currentMailbox.Mailbox;

                var assignToLabel = (Label)e.Item.FindControl("AssignToLabel");
                assignToLabel.Text = currentMailbox.AssignToDisplayName;

                var issueTypeName = (Label)e.Item.FindControl("IssueTypeName");
                issueTypeName.Text = currentMailbox.IssueTypeName;

                var issueCategoryName = (Label)e.Item.FindControl("IssueCategoryName");
                issueCategoryName.Text = currentMailbox.CategoryName;

                var cmdDelete = (ImageButton)e.Item.FindControl("cmdDelete");
                var message = string.Format(GetLocalResourceObject("ConfirmDelete").ToString(), currentMailbox.Mailbox.Trim());
                cmdDelete.Attributes.Add("onclick", String.Format("return confirm('{0}');", message.JsEncode()));
            }

            if (e.Item.ItemType != ListItemType.EditItem) return;

            currentMailbox = (ProjectMailbox)e.Item.DataItem;

            var emailAddress = (TextBox)e.Item.FindControl("txtEmailAddress");
            emailAddress.Text = currentMailbox.Mailbox;

            var pickUser = (PickSingleUser)e.Item.FindControl("IssueAssignedUser");
            pickUser.DataSource = UserManager.GetUsersByProjectId(currentMailbox.ProjectId);
            pickUser.DataBind();
            pickUser.SelectedValue = currentMailbox.AssignToUserName;

            var pickType = (PickType)e.Item.FindControl("IssueType");
            pickType.DataSource = IssueTypeManager.GetByProjectId(currentMailbox.ProjectId);
            pickType.DataBind();
            pickType.SelectedValue = currentMailbox.IssueTypeId;

            var pickCategory = (PickCategory)e.Item.FindControl("IssueCategory");
            pickCategory.DataSource = CategoryManager.GetByProjectId(currentMailbox.ProjectId);
            pickCategory.DataBind();
            pickCategory.SelectedValue = currentMailbox.CategoryId;
        }

        /// <summary>
        /// Handles the Edit event of the grdMailboxes control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.DataGridCommandEventArgs"/> instance containing the event data.</param>
        protected void dtgMailboxes_Edit(object sender, DataGridCommandEventArgs e)
        {
            grdMailboxes.EditItemIndex = e.Item.ItemIndex;
            grdMailboxes.DataBind();
        }

        /// <summary>
        /// Handles the Update event of the grdMailboxes control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.DataGridCommandEventArgs"/> instance containing the event data.</param>
        protected void dtgMailboxes_Update(object sender, DataGridCommandEventArgs e)
        {
            var emailAddress = (TextBox)e.Item.FindControl("txtEmailAddress");
            var pickUser = (PickSingleUser)e.Item.FindControl("IssueAssignedUser");
            var pickType = (PickType)e.Item.FindControl("IssueType");
            var pickCategory = (PickCategory)e.Item.FindControl("IssueCategory");
            var id = Convert.ToInt32(grdMailboxes.DataKeys[e.Item.ItemIndex]);

            if (emailAddress.Text.Trim() == "")
            {
                throw new ArgumentNullException("Email Address empty");
            }

            var mailbox = ProjectMailboxManager.GetById(id);

            if (mailbox != null)
            {
                mailbox.Mailbox = emailAddress.Text;
                mailbox.IssueTypeId = pickType.SelectedValue;
                mailbox.CategoryId = pickCategory.SelectedValue;
                mailbox.AssignToUserName = pickUser.SelectedValue;

                ProjectMailboxManager.SaveOrUpdate(mailbox);
            }

            grdMailboxes.EditItemIndex = -1;
            BindMailboxes();
        }

        /// <summary>
        /// Handles the Cancel event of the grdMailboxes control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.DataGridCommandEventArgs"/> instance containing the event data.</param>
        protected void dtgMailboxes_Cancel(object sender, DataGridCommandEventArgs e)
        {
            grdMailboxes.EditItemIndex = -1;
            grdMailboxes.DataBind();
        }
    }
}
