namespace BugNET.Administration.Projects.UserControls
{
    using System;
    using System.Collections;
    using System.Web.UI.WebControls;
    using BugNET.BLL;
    using BugNET.Entities;
    using BugNET.UserControls;
    using BugNET.UserInterfaceLayer;

    /// <summary>
    ///		Summary description for Mailboxes.
    /// </summary>
    public partial class Mailboxes : System.Web.UI.UserControl, IEditProjectControl
    {
        IList _mailboxes;

        public Mailboxes()
        {
            ProjectId = -1;
        }

        #region Web Form Designer generated code
        /// <summary>
        /// Raises the <see cref="E:System.Web.UI.Control.Init"></see> event.
        /// </summary>
        /// <param name="e">An <see cref="T:System.EventArgs"></see> object that contains the event data.</param>
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
            this.dtgMailboxes.DeleteCommand += new System.Web.UI.WebControls.DataGridCommandEventHandler(this.dtgMailboxes_DeleteCommand);

        }
        #endregion

        /// <summary>
        /// Binds the mailboxes.
        /// </summary>
        private void BindMailboxes()
        {
            _mailboxes = ProjectMailboxManager.GetByProjectId(ProjectId);

            if (_mailboxes.Count == 0)
            {
                lblMailboxes.Text = GetLocalResourceObject("NoConfiguredMailBoxes").ToString();
                lblMailboxes.Visible = true;
                dtgMailboxes.Visible = false;
            }
            else
            {
                dtgMailboxes.Visible = true;
                lblMailboxes.Visible = false;
                dtgMailboxes.DataSource = _mailboxes;
                dtgMailboxes.DataBind();
            }

            txtMailbox.Text = String.Empty;
            //			IssueAssignedUser.SelectedValue = -1;
            //			IssueAssignedType.SelectedValue = 0;

            //			if(Security.GetUserRole().Equals(Globals.ReadOnlyRole))
            //				AddMailbox.Visible=false;

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
                                  Mailbox = txtMailbox.Text,
                                  ProjectId = ProjectId
                              };

            if (ProjectMailboxManager.SaveOrUpdate(mailbox)) BindMailboxes();
        }

        #region IEditProjectControl Members

        /// <summary>
        /// Gets or sets the project id.
        /// </summary>
        /// <value>The project id.</value>
        public int ProjectId { get; set; }

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
            IssueAssignedUser.DataBind();

            IssueAssignedType.DataSource = IssueTypeManager.GetByProjectId(ProjectId);
            IssueAssignedType.DataBind();
        }

        /// <summary>
        /// Updates this instance.
        /// </summary>
        /// <returns></returns>
        public bool Update()
        {
            return Page.IsValid;
        }

        #endregion

        /// <summary>
        /// Handles the DeleteCommand event of the dtgMailboxes control.
        /// </summary>
        /// <param name="source">The source of the event.</param>
        /// <param name="e">The <see cref="T:System.Web.UI.WebControls.DataGridCommandEventArgs"/> instance containing the event data.</param>
        private void dtgMailboxes_DeleteCommand(object source, System.Web.UI.WebControls.DataGridCommandEventArgs e)
        {
            _mailboxes = ProjectMailboxManager.GetByProjectId(ProjectId);
            var mb = _mailboxes[e.Item.DataSetIndex] as ProjectMailbox;

            if (mb != null && ProjectMailboxManager.Delete(mb.Id))
                BindMailboxes();
        }

        /// <summary>
        /// Handles the ItemDataBound event of the dtgMailboxes control.
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

                var btnDelete = (Button)e.Item.FindControl("btnDelete");
                var message = string.Format(GetLocalResourceObject("ConfirmDelete").ToString(), currentMailbox.Mailbox);
                btnDelete.Attributes.Add("onclick", String.Format("return confirm('{0}');", message));
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
        }

        /// <summary>
        /// Handles the Edit event of the dtgMailboxes control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.DataGridCommandEventArgs"/> instance containing the event data.</param>
        protected void dtgMailboxes_Edit(object sender, DataGridCommandEventArgs e)
        {
            dtgMailboxes.EditItemIndex = e.Item.ItemIndex;
            dtgMailboxes.DataBind();
        }

        /// <summary>
        /// Handles the Update event of the dtgMailboxes control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.DataGridCommandEventArgs"/> instance containing the event data.</param>
        protected void dtgMailboxes_Update(object sender, DataGridCommandEventArgs e)
        {
            var emailAddress = (TextBox)e.Item.FindControl("txtEmailAddress");
            var pickUser = (PickSingleUser)e.Item.FindControl("IssueAssignedUser");
            var pickType = (PickType)e.Item.FindControl("IssueType");

            _mailboxes = ProjectMailboxManager.GetByProjectId(ProjectId);
            var mb = _mailboxes[e.Item.DataSetIndex] as ProjectMailbox;

            if (mb != null)
            {
                mb.Mailbox = emailAddress.Text;
                mb.IssueTypeId = pickType.SelectedValue;
                mb.AssignToUserName = pickUser.SelectedValue;

                ProjectMailboxManager.SaveOrUpdate(mb);
            }

            //TextBox txtIssueTypeName = (TextBox)e.Item.FindControl("txtIssueTypeName");
            //PickImage pickimg = (PickImage)e.Item.FindControl("lstEditImages");

            //if (txtIssueTypeName.Text.Trim() == "")
            //{
            //    throw new ArgumentNullException("Issue Type name empty");
            //}

            //IssueType s = IssueType.GetById(Convert.ToInt32(grdIssueTypes.DataKeys[e.Item.ItemIndex]));
            //s.Name = txtIssueTypeName.Text.Trim();
            //s.ImageUrl = pickimg.SelectedValue;
            //s.Save();

            dtgMailboxes.EditItemIndex = -1;
            BindMailboxes();
        }

        /// <summary>
        /// Handles the Cancel event of the dtgMailboxes control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.DataGridCommandEventArgs"/> instance containing the event data.</param>
        protected void dtgMailboxes_Cancel(object sender, DataGridCommandEventArgs e)
        {
            dtgMailboxes.EditItemIndex = -1;
            dtgMailboxes.DataBind();
        }

        /// <summary>
        /// Handles the Click event of the cmdCancel control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="T:System.EventArgs"/> instance containing the event data.</param>
        protected void cmdCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect(string.Concat("~/Administration/Projects/EditProject.aspx?id=", ProjectId));
        }
    }
}
