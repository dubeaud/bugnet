using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BugNET.BLL;
using BugNET.Common;
using BugNET.Entities;
using BugNET.UserInterfaceLayer;

namespace BugNET.Issues
{
    /// <summary>
    /// Issue Detail Page
    /// </summary>
    public partial class IssueDetail : BugNET.UserInterfaceLayer.BasePage
    {

        #region Private Events
        /// <summary>
        /// Page Load Event
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Page_Load(object sender, System.EventArgs e)
        {

            if (!Page.IsPostBack)
            {
                lnkDelete.Attributes.Add("onclick", string.Format("return confirm('{0}');", GetLocalResourceObject("DeleteIssue").ToString()));
                imgDelete.Attributes.Add("onclick", string.Format("return confirm('{0}');", GetLocalResourceObject("DeleteIssue").ToString()));

                // Get Issue Id from Query String
                if (Request.QueryString["id"] != null)
                { 
                    try
                    {
                        IssueId = Int32.Parse(Request.QueryString["id"]);
                    }
                    catch
                    {
                        ErrorRedirector.TransferToNotFoundPage(Page);
                    }
                }

                // Get Project Id from Query String
                if (Request.QueryString["pid"] != null)
                { 
                    try
                    {
                        ProjectId = Int32.Parse(Request.QueryString["pid"]);
                    }
                    catch
                    {
                        ErrorRedirector.TransferToNotFoundPage(Page);
                    }
                }

                // If don't know project or issue then redirect to something missing page
                if (ProjectId == 0 && IssueId == 0)
                    ErrorRedirector.TransferToSomethingMissingPage(Page);

                // Initialize for Adding or Editing
                if (IssueId == 0)
                {
                    BindOptions();
                    pnlAddAttachment.Visible = true;
                    TitleTextBox.Visible = true;
                    DescriptionHtmlEditor.Visible = true;
                    Description.Visible = false;
                    TitleLabel.Visible = false;
                    DisplayTitleLabel.Visible = false;
                    string test = GetLocalResourceObject("PageTitleNewIssue").ToString();
                    Page.Title = test;
                    lblIssueNumber.Text = "N/A";
                    VoteButton.Visible = false;
                }
                else
                {
                    BindValues();
                }

                //set the referrer url
                if (Request.UrlReferrer != null)
                {
                    if (Request.UrlReferrer.ToString() != Request.Url.ToString())
                        Session["ReferrerUrl"] = Request.UrlReferrer.ToString();
                }
                else
                {
                    Session["ReferrerUrl"] = string.Format("~/Issues/IssueList.aspx?pid={0}", ProjectId);
                }

            }

            //need to rebind these on every postback because of dynamic controls
            if (IssueId == 0)
            {
                ctlCustomFields.DataSource = CustomFieldManager.GetCustomFieldsByProjectId(ProjectId);
            }
            else
            {
                ctlCustomFields.DataSource = CustomFieldManager.GetCustomFieldsByIssueId(IssueId);
            }
            ctlCustomFields.DataBind();

            // The ExpandIssuePaths method is called to handle
            // the SiteMapResolve event.
            SiteMap.SiteMapResolve += new SiteMapResolveEventHandler(this.ExpandIssuePaths);

            ctlIssueTabs.IssueId = IssueId;
            ctlIssueTabs.ProjectId = ProjectId;

        }

        /// <summary>
        /// Handles the PreRender event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void Page_PreRender(object sender, EventArgs e)
        {
            Project p = ProjectManager.GetProjectById(ProjectId);

            if (p == null)
                ErrorRedirector.TransferToNotFoundPage(Page);

            //check if the user can access this project
            if (p.AccessType == Globals.ProjectAccessType.Private && !User.Identity.IsAuthenticated)
            {
                ErrorRedirector.TransferToLoginPage(Page);
            }
            else if (User.Identity.IsAuthenticated && p.AccessType == Globals.ProjectAccessType.Private && !ProjectManager.IsUserProjectMember(User.Identity.Name, ProjectId))
            {
                ErrorRedirector.TransferToLoginPage(Page);
            }
            else if (IssueId == 0)
            {
                //security check: add issue
                if (!UserManager.HasPermission(ProjectId, Globals.Permission.AddIssue.ToString()))
                    ErrorRedirector.TransferToLoginPage(Page);

                //check users role permission for adding an attachment
                if (!Page.User.Identity.IsAuthenticated || !UserManager.HasPermission(ProjectId, Globals.Permission.AddAttachment.ToString()))
                    pnlAddAttachment.Visible = false;
            }
            //security check: assign issue
            if (!UserManager.HasPermission(ProjectId, Globals.Permission.AssignIssue.ToString()))
                DropAssignedTo.Enabled = false;

            if (!p.AllowIssueVoting)
                VoteBox.Visible = false;

            if (IssueId != 0)
            {
                //private issue check
                Issue issue = IssueManager.GetIssueById(IssueId);

                if (issue.Visibility == (int)Globals.IssueVisibility.Private && issue.AssignedDisplayName != Security.GetUserName() && issue.CreatorDisplayName != Security.GetUserName() && !UserManager.IsInRole(Globals.SUPER_USER_ROLE) && !UserManager.IsInRole(Globals.ProjectAdminRole))
                    ErrorRedirector.TransferToLoginPage(Page);

                Page.Title = string.Concat(issue.FullId, ": ", issue.Title);
                lblIssueNumber.Text = string.Format("{0}-{1}", p.Code, IssueId);
                ctlIssueTabs.Visible = true;
                TimeLogged.Visible = true;
                TimeLoggedLabel.Visible = true;
                chkNotifyAssignedTo.Visible = false;
                chkNotifyOwner.Visible = false;
                SetFieldSecurity();
            }

            ctlCustomFields.DataBind();
        }

        /// <summary>
        /// Handles the Unload event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void Page_Unload(object sender, System.EventArgs e)
        {
            //remove the event handler
            SiteMap.SiteMapResolve -=
             new SiteMapResolveEventHandler(this.ExpandIssuePaths);
        }

        /// <summary>
        /// Expands the issue paths.
        /// </summary>
        /// <param name="sender">The sender.</param>
        /// <param name="e">The <see cref="System.Web.SiteMapResolveEventArgs"/> instance containing the event data.</param>
        /// <returns></returns>
        private SiteMapNode ExpandIssuePaths(Object sender, SiteMapResolveEventArgs e)
        {
            SiteMapNode currentNode = SiteMap.CurrentNode.Clone(true);
            SiteMapNode tempNode = currentNode;

            // The current node, and its parents, can be modified to include
            // dynamic query string information relevant to the currently
            // executing request.
            if (IssueId != 0)
            {
                string title = (TitleTextBox.Text.Length >= 30) ? TitleTextBox.Text.Substring(0, 30) + " ..." : TitleTextBox.Text;
                tempNode.Title = string.Format("{0}: {1}", lblIssueNumber.Text, title);
                tempNode.Url = tempNode.Url + "?id=" + IssueId.ToString();
            }
            else
                tempNode.Title = "New Issue";

            if ((null != (tempNode = tempNode.ParentNode)))
            {
                tempNode.Url = string.Format("~/Issues/IssueList.aspx?pid={0}", ProjectId);
            }

            return currentNode;
        }

        /// <summary>
        /// Binds the values.
        /// </summary>
        private void BindValues()
        {
            Issue currentIssue = IssueManager.GetIssueById(IssueId);

            if (currentIssue == null)
            {
                // BGN-1379
                ErrorRedirector.TransferToNotFoundPage(Page);
            }
            else
            {

                ProjectId = currentIssue.ProjectId;

                BindOptions();

                lblIssueNumber.Text = string.Concat(currentIssue.FullId, ":");
                TitleLabel.Text = Server.HtmlDecode(currentIssue.Title);
                //Page.Title = string.Concat(currentIssue.FullId, ": ", currentIssue.Title);
                DropIssueType.SelectedValue = currentIssue.IssueTypeId;
                DropResolution.SelectedValue = currentIssue.ResolutionId;
                DropStatus.SelectedValue = currentIssue.StatusId;
                DropPriority.SelectedValue = currentIssue.PriorityId;
                DropOwned.SelectedValue = currentIssue.OwnerUserName;

                // SMOSS: XSS Bugfix
                Description.Text = (currentIssue.Description);

                // WARNING: Do Not html decode the text for the editor. 
                // The editor is expecting HtmlEncoded text as input.
                DescriptionHtmlEditor.Text = currentIssue.Description;
                lblLastUpdateUser.Text = currentIssue.LastUpdateDisplayName;
                lblReporter.Text = currentIssue.CreatorDisplayName;

                // XSS Bugfix
                // The text box is expecting raw html
                TitleTextBox.Text = Server.HtmlDecode(currentIssue.Title);
                DisplayTitleLabel.Text = currentIssue.Title;

                Label5.Text = currentIssue.IssueTypeName;
                lblDateCreated.Text = currentIssue.DateCreated.ToString("g");
                lblLastModified.Text = currentIssue.LastUpdate.ToString("g");
                lblIssueNumber.Text = currentIssue.FullId;
                DropCategory.SelectedValue = currentIssue.CategoryId;
                DropMilestone.SelectedValue = currentIssue.MilestoneId;
                DropAffectedMilestone.SelectedValue = currentIssue.AffectedMilestoneId;
                DropAssignedTo.SelectedValue = currentIssue.AssignedUserName;
                lblLoggedTime.Text = currentIssue.TimeLogged.ToString();
                txtEstimation.Text = currentIssue.Estimation == 0 ? string.Empty : currentIssue.Estimation.ToString();
                DueDatePicker.SelectedValue = currentIssue.DueDate == DateTime.MinValue ? null : (DateTime?)currentIssue.DueDate;
                chkPrivate.Checked = currentIssue.Visibility == 0 ? false : true;
                ProgressSlider.Text = currentIssue.Progress.ToString();
                IssueVoteCount.Text = currentIssue.Votes.ToString();

                if (currentIssue.Votes > 1)
                    Votes.Text = GetLocalResourceObject("Votes").ToString();

                if (User.Identity.IsAuthenticated && IssueVoteManager.HasUserVoted(currentIssue.Id, Security.GetUserName()))
                {
                    VoteButton.Visible = false;
                    VotedLabel.Visible = true;
                    VotedLabel.Text = GetLocalResourceObject("Voted").ToString();
                }
                else
                {
                    VoteButton.Visible = true;
                    VotedLabel.Visible = false;
                }

                if (StatusManager.GetStatusById(currentIssue.StatusId).IsClosedState)
                {
                    VoteButton.Visible = false;
                    VotedLabel.Visible = false;
                }

            }


        }

        /// <summary>
        /// Binds the options.
        /// </summary>
        private void BindOptions()
        {
            List<ITUser> users = UserManager.GetUsersByProjectId(ProjectId);
            //Get Type
            DropIssueType.DataSource = IssueTypeManager.GetIssueTypesByProjectId(ProjectId);
            DropIssueType.DataBind();

            //Get Priority
            DropPriority.DataSource = PriorityManager.GetPrioritiesByProjectId(ProjectId);
            DropPriority.DataBind();

            //Get Resolutions
            DropResolution.DataSource = ResolutionManager.GetResolutionsByProjectId(ProjectId);
            DropResolution.DataBind();

            //Get categories
            CategoryTree categories = new CategoryTree();
            DropCategory.DataSource = categories.GetCategoryTreeByProjectId(ProjectId);
            DropCategory.DataBind();

            //Get milestones
            if (IssueId == 0)
            {
                DropMilestone.DataSource = MilestoneManager.GetMilestoneByProjectId(ProjectId, false);
            }
            else
            {
                DropMilestone.DataSource = MilestoneManager.GetMilestoneByProjectId(ProjectId);
            }
            DropMilestone.DataBind();

            DropAffectedMilestone.DataSource = MilestoneManager.GetMilestoneByProjectId(ProjectId);
            DropAffectedMilestone.DataBind();

            //Get Users
            DropAssignedTo.DataSource = users;
            DropAssignedTo.DataBind();

            DropOwned.DataSource = users;
            DropOwned.DataBind();
            DropOwned.SelectedValue = User.Identity.Name;

            DropStatus.DataSource = StatusManager.GetStatusByProjectId(ProjectId);
            DropStatus.DataBind();

            lblDateCreated.Text = DateTime.Now.ToString("f");
            lblLastModified.Text = DateTime.Now.ToString("f");

            if (User.Identity.IsAuthenticated)
            {
                lblReporter.Text = Security.GetDisplayName();
                lblLastUpdateUser.Text = Security.GetDisplayName();
            }

        }

        /// <summary>
        /// Saves the bug.
        /// </summary>
        /// <returns></returns>
        private bool SaveIssue()
        {
            decimal estimation;
            decimal.TryParse(txtEstimation.Text.Trim(), out estimation);
            DateTime dueDate = DueDatePicker.SelectedValue == null ?  DateTime.MinValue : (DateTime)DueDatePicker.SelectedValue;

            bool NewIssue = (IssueId <= 0);

            // WARNING: DO NOT ENCODE THE HTMLEDITOR TEXT. 
            // It expects raw input. So pass through a raw string. 
            // This is a potential XSS vector as the Issue Class should
            // handle sanitizing the input and checking that its input is HtmlEncoded
            // (ie no < or > characters), not the IssueDetail.aspx.cs

            Issue newIssue = new Issue(IssueId, ProjectId, string.Empty, string.Empty, Server.HtmlEncode(TitleTextBox.Text), DescriptionHtmlEditor.Text.Trim(),
                DropCategory.SelectedValue, DropCategory.SelectedText, DropPriority.SelectedValue, DropPriority.SelectedText,
                string.Empty, DropStatus.SelectedValue, DropStatus.SelectedText, string.Empty, DropIssueType.SelectedValue,
                DropIssueType.SelectedText, string.Empty, DropResolution.SelectedValue, DropResolution.SelectedText, string.Empty,
                DropAssignedTo.SelectedText, DropAssignedTo.SelectedValue, Guid.Empty, Security.GetDisplayName(),
                Security.GetUserName(), Guid.Empty, DropOwned.SelectedText, DropOwned.SelectedValue, Guid.Empty, dueDate,
                DropMilestone.SelectedValue, DropMilestone.SelectedText, string.Empty, null, DropAffectedMilestone.SelectedValue, DropAffectedMilestone.SelectedText,
                string.Empty, chkPrivate.Checked == true ? 1 : 0,
                0, estimation, DateTime.MinValue, DateTime.MinValue, Security.GetUserName(), Security.GetDisplayName(),
                Convert.ToInt32(ProgressSlider.Text), false, 0);


            if (!IssueManager.SaveIssue(newIssue))
            {
                Message1.ShowErrorMessage(Resources.Exceptions.SaveIssueError);
                return false;
            }

            IssueId = newIssue.Id;

            if (!CustomFieldManager.SaveCustomFieldValues(IssueId, ctlCustomFields.Values))
            {
                Message1.ShowErrorMessage(Resources.Exceptions.SaveCustomFieldValuesError); 
                return false;
            }


            //if new issue check if notify owner and assigned is checked.
            if (NewIssue)
            {
                //add attachment if present.
                // get the current file
                HttpPostedFile uploadFile = this.AspUploadFile.PostedFile;
                HttpContext context = HttpContext.Current;

                string returnMessage = IssueAttachmentManager.ValidateFileName(uploadFile.FileName);

                if (string.IsNullOrEmpty(returnMessage))
                {
                    if (uploadFile.ContentLength > 0)
                    {
                        byte[] fileBytes;
                        using (System.IO.Stream input = uploadFile.InputStream)
                        {
                            fileBytes = new byte[uploadFile.ContentLength];
                            input.Read(fileBytes, 0, uploadFile.ContentLength);
                        }

                        IssueAttachment issueAttachment = new IssueAttachment(IssueId, Security.GetUserName(), uploadFile.FileName, uploadFile.ContentType, fileBytes, fileBytes.Length, AttachmentDescription.Text.Trim());

                        if (!IssueAttachmentManager.SaveIssueAttachment(issueAttachment))
                        {
                            Message1.ShowErrorMessage(string.Format(GetGlobalResourceObject("Exceptions","SaveAttachmentError").ToString(), uploadFile.FileName)); 
                        }
                    }

                }
                else
                    Message1.ShowErrorMessage(returnMessage); 


                //create a vote for the new issue
                IssueVote vote = new IssueVote(IssueId, Security.GetUserName());
                if (!IssueVoteManager.SaveIssueVote(vote))
                    Message1.ShowErrorMessage(Resources.Exceptions.SaveIssueVoteError);

                if (chkNotifyOwner.Checked)
                {
                    System.Web.Security.MembershipUser oUser = UserManager.GetUser(newIssue.OwnerUserName);
                    if (oUser != null)
                    {
                        IssueNotification notify = new IssueNotification(IssueId, oUser.UserName);
                        IssueNotificationManager.SaveIssueNotification(notify);
                       
                    }
                }
                if (chkNotifyAssignedTo.Checked && !string.IsNullOrEmpty(newIssue.AssignedUserName))
                {
                    System.Web.Security.MembershipUser oUser = UserManager.GetUser(newIssue.AssignedUserName);
                    if (oUser != null)
                    {
                        IssueNotification notify = new IssueNotification(IssueId, oUser.UserName);
                        IssueNotificationManager.SaveIssueNotification(notify);
                    }
                }
                IssueNotificationManager.SendIssueAddNotifications(IssueId);
            }


            return true;
        }
        /// <summary>
        /// Handles the Click event of the lnkUpdate control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void lnkSave_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                SaveIssue();
                Response.Redirect(string.Format("~/Issues/IssueDetail.aspx?id={0}", this.IssueId));
            }
        }

        /// <summary>
        /// Handles the Click event of the VoteButton control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void VoteButton_Click(object sender, EventArgs e)
        {
            if (!User.Identity.IsAuthenticated)
                Response.Redirect(string.Format("~/Login.aspx?ReturnUrl={0}", Server.UrlEncode(Request.RawUrl)));

            IssueVote vote = new IssueVote(this.IssueId, Security.GetUserName());
            IssueVoteManager.SaveIssueVote(vote);
            int count = Convert.ToInt32(IssueVoteCount.Text) + 1;
            Votes.Text = GetLocalResourceObject("Votes").ToString();
            IssueVoteCount.Text = count.ToString();
            VoteButton.Visible = false;
            VotedLabel.Visible = true;
        }

        /// <summary>
        /// Handles the Click event of the lnkDone control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void lnkDone_Click(object sender, EventArgs e)
        {
            if (Page.IsValid && SaveIssue())
                ReturnToPreviousPage();
        }

        /// <summary>
        /// Handles the Click event of the lnkDelete control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="T:System.EventArgs"/> instance containing the event data.</param>
        protected void lnkDelete_Click(object sender, EventArgs e)
        {
            IssueManager.DeleteIssue(IssueId);
            ReturnToPreviousPage();
        }

        /// <summary>
        /// Cancels the button click.
        /// </summary>
        /// <param name="s">The s.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void CancelButtonClick(Object s, EventArgs e)
        {
            ReturnToPreviousPage();
        }
        #endregion

        #region Private Methods

        /// <summary>
        /// Handles the Click event of the EditSummary control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.ImageClickEventArgs"/> instance containing the event data.</param>
        protected void EditTitle_Click(object sender, ImageClickEventArgs e)
        {
            EditTitle.Visible = false;
            TitleTextBox.Visible = !TitleTextBox.Visible;
            DisplayTitleLabel.Visible = !DisplayTitleLabel.Visible;
        }

        /// <summary>
        /// Allows editing of the issue description
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void EditDescription_Click(object sender, ImageClickEventArgs e)
        {
            EditDescription.Visible = false;
            DescriptionHtmlEditor.Visible = !DescriptionHtmlEditor.Visible;
            Description.Visible = !Description.Visible;
        }

        /// <summary>
        /// Sets security according to permissions
        /// </summary>
        private void SetFieldSecurity()
        {
            //check permission objects
            if (User.Identity.IsAuthenticated)
            {
                //enable editing of description if user has permission or in admin role
                if ((UserManager.IsInRole(ProjectId, Globals.ProjectAdminRole) || UserManager.HasPermission(ProjectId, Globals.Permission.EditIssueDescription.ToString())) && !DescriptionHtmlEditor.Visible)
                    EditDescription.Visible = true;

                if ((UserManager.IsInRole(ProjectId, Globals.ProjectAdminRole) || UserManager.HasPermission(ProjectId, Globals.Permission.EditIssueTitle.ToString())) && !TitleTextBox.Visible)
                    EditTitle.Visible = true;

                //edit issue permission check
                if (!UserManager.HasPermission(ProjectId, Globals.Permission.EditIssue.ToString()))
                    LockFields();

                //assign issue permission check
                if (!UserManager.HasPermission(ProjectId, Globals.Permission.AssignIssue.ToString()))
                    DropAssignedTo.Enabled = false;

                //delete issue
                if (UserManager.HasPermission(ProjectId, Globals.Permission.DeleteIssue.ToString()))
                    DeleteButton.Visible = true;

                if (!UserManager.HasPermission(ProjectId, Globals.Permission.ChangeIssueStatus.ToString()))
                    DropStatus.Enabled = false;

                //remove closed status' if user does not have access
                if (!UserManager.HasPermission(ProjectId, Globals.Permission.CloseIssue.ToString()))
                {
                    List<Status> status = StatusManager.GetStatusByProjectId(ProjectId).FindAll(st => st.IsClosedState == true);
                    DropDownList stat = (DropDownList)DropStatus.FindControl("dropStatus");
                    foreach (Status s in status)
                        stat.Items.Remove(stat.Items.FindByValue(s.Id.ToString()));
                }

                //if status is closed, check if user is allowed to reopen issue
                //if (editBug.StatusId.CompareTo((int)Globals.StatusType.Closed) == 0)
                //{
                //    LockFields();
                //    pnlClosedMessage.Visible = true;

                //    if (UserIT.HasPermission(ProjectId, Globals.Permissions.REOPEN_ISSUE.ToString()))
                //        lnkReopen.Visible = true;
                //}
            }
            else
            {
                LockFields();
            }
        }

        /// <summary>
        /// Makes all editable fields on the form disabled
        /// </summary>
        private void LockFields()
        {
            lnkDone.Visible = false;
            imgDone.Visible = false;
            //lnkSave.Visible = false;
            //imgSave.Visible = false;
            imgDelete.Visible = false;
            lnkDelete.Visible = false;
           // DescriptionHtmlEditor.Visible = false;
            Description.Visible = true;
            //TitleTextBox.Visible = false;
            DisplayTitleLabel.Visible = true;
            DropOwned.Enabled = false;
            DropCategory.Enabled = false;
            DropStatus.Enabled = false;
            DropMilestone.Enabled = false;
            DropIssueType.Enabled = false;
            DropPriority.Enabled = false;
            DropResolution.Enabled = false;
            DropAssignedTo.Enabled = false;
            DropAffectedMilestone.Enabled = false;
            DueDatePicker.Enabled = false;
            chkPrivate.Enabled = false;
            ctlCustomFields.IsLocked = true;
            txtEstimation.Enabled = false;
            SliderExtender2.Enabled = false;
            ProgressSlider.Visible = false;
        }
        #endregion

        #region Properties

        /// <summary>
        /// Gets or sets the issue id.
        /// </summary>
        /// <value>The issue id.</value>
        int IssueId
        {
            get
            {
                if (ViewState["IssueId"] == null)
                    return 0;
                else
                    return (int)ViewState["IssueId"];
            }
            set { ViewState["IssueId"] = value; }
        }

        /// <summary>
        /// Gets or sets the project id.
        /// </summary>
        /// <value>The project id.</value>
        public override int ProjectId
        {
            get
            {
                if (ViewState["ProjectId"] == null)
                    return 0;
                else
                    return (int)ViewState["ProjectId"];
            }
            set { ViewState["ProjectId"] = value; }
        }

        #endregion
    }
}
