using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BugNET.BLL;
using BugNET.Common;
using BugNET.Entities;
using BugNET.UserInterfaceLayer;
using System.Linq;

namespace BugNET.Issues
{
    /// <summary>
    /// Issue Detail Page
    /// </summary>
    public partial class IssueDetail : BasePage
    {
        Issue _currentIssue;
        Project _currentProject;

        #region Private Events
        /// <summary>
        /// Page Load Event
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                var s = GetLocalResourceObject("DeleteIssueQuestion").ToString().Trim().JsEncode();
                lnkDelete.Attributes.Add("onclick", string.Format("return confirm('{0}');", s));

                IssueId = Request.QueryString.Get("id", 0);

                // If don't know issue id then redirect to something missing page
                if (IssueId == 0)
                    ErrorRedirector.TransferToSomethingMissingPage(Page);
                
                //set up global properties
                _currentIssue = IssueManager.GetById(IssueId);

                if (_currentIssue == null || _currentIssue.Disabled)
                {
                    ErrorRedirector.TransferToNotFoundPage(Page);
                    return;
                }

                //private issue check
                var issueVisible = IssueManager.CanViewIssue(_currentIssue, Security.GetUserName());

                //private issue check
                if (!issueVisible)
                {
                    ErrorRedirector.TransferToLoginPage(Page);
                }

                _currentProject = ProjectManager.GetById(_currentIssue.ProjectId);

                if (_currentProject == null)
                {
                    ErrorRedirector.TransferToNotFoundPage(Page);
                    return;
                }

                ProjectId = _currentProject.Id;

                if (_currentProject.AccessType == ProjectAccessType.Private && !User.Identity.IsAuthenticated)
                {
                    ErrorRedirector.TransferToLoginPage(Page);
                }
                else if (User.Identity.IsAuthenticated && _currentProject.AccessType == ProjectAccessType.Private 
                    && !ProjectManager.IsUserProjectMember(User.Identity.Name, ProjectId))
                {
                    ErrorRedirector.TransferToLoginPage(Page);
                }

                BindValues(_currentIssue);

                // Page.Title = string.Concat(_currentIssue.FullId, ": ", Server.HtmlDecode(_currentIssue.Title));
                lblIssueNumber.Text = string.Format("{0}-{1}", _currentProject.Code, IssueId);
                ctlIssueTabs.Visible = true;

                SetFieldSecurity();

                if (!_currentProject.AllowIssueVoting)
                { 
                    VoteBox.Visible = false;
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

            Page.Title = string.Concat(lblIssueNumber.Text, ": ", Server.HtmlDecode(TitleTextBox.Text));

            //need to rebind these on every postback because of dynamic controls
            ctlCustomFields.DataSource = CustomFieldManager.GetByIssueId(IssueId);
            ctlCustomFields.DataBind();

            // The ExpandIssuePaths method is called to handle
            // the SiteMapResolve event.
            SiteMap.SiteMapResolve += ExpandIssuePaths;

            ctlIssueTabs.IssueId = IssueId;
            ctlIssueTabs.ProjectId = ProjectId;
        }

        /// <summary>
        /// Handles the Unload event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void Page_Unload(object sender, EventArgs e)
        {
            //remove the event handler
            SiteMap.SiteMapResolve -= ExpandIssuePaths;
        }

        /// <summary>
        /// Expands the issue paths.
        /// </summary>
        /// <param name="sender">The sender.</param>
        /// <param name="e">The <see cref="System.Web.SiteMapResolveEventArgs"/> instance containing the event data.</param>
        /// <returns></returns>
        private SiteMapNode ExpandIssuePaths(Object sender, SiteMapResolveEventArgs e)
        {
            if (SiteMap.CurrentNode == null) return null;

            var currentNode = SiteMap.CurrentNode.Clone(true);
            var tempNode = currentNode;

            // The current node, and its parents, can be modified to include
            // dynamic query string information relevant to the currently
            // executing request.
            var title = (TitleTextBox.Text.Length >= 30) ? TitleTextBox.Text.Substring(0, 30) + " ..." : TitleTextBox.Text;
            tempNode.Title = string.Format("{0}: {1}", lblIssueNumber.Text, title);
            tempNode.Url = string.Concat(tempNode.Url, "?id=", IssueId);

            if ((null != (tempNode = tempNode.ParentNode)))
            {
                tempNode.Url = string.Format("~/Issues/IssueList.aspx?pid={0}", ProjectId);
            }

            return currentNode;
        }

        /// <summary>
        /// Binds the values.
        /// </summary>
        private void BindValues(Issue currentIssue)
        {
            BindOptions();

            lblIssueNumber.Text = string.Concat(currentIssue.FullId, ":");
            TitleLabel.Text = Server.HtmlDecode(currentIssue.Title);

            DropIssueType.SelectedValue = currentIssue.IssueTypeId;
            DropResolution.SelectedValue = currentIssue.ResolutionId;
            DropStatus.SelectedValue = currentIssue.StatusId;
            DropPriority.SelectedValue = currentIssue.PriorityId;
            DropOwned.SelectedValue = currentIssue.OwnerUserName;

            IssueReferenceToLinkConverter issueReferenceConverter =  IssueReferenceToLinkConverterBuilder.Build();
            string issueDescription = issueReferenceConverter.Convert(_currentProject.Code, currentIssue.Description);

            // SMOSS: XSS Bugfix
            Description.Text = (issueDescription);

            // WARNING: Do Not html decode the text for the editor. 
            // The editor is expecting HtmlEncoded text as input.
            DescriptionHtmlEditor.Text = currentIssue.Description;
            lblLastUpdateUser.Text = currentIssue.LastUpdateDisplayName;
            lblReporter.Text = currentIssue.CreatorDisplayName;

            // XSS Bugfix
            // The text box is expecting raw html
            TitleTextBox.Text = Server.HtmlDecode(currentIssue.Title);
            DisplayTitleLabel.Text = currentIssue.Title;
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
            chkPrivate.Checked = currentIssue.Visibility != 0;
            ProgressSlider.Text = currentIssue.Progress.ToString();
            IssueVoteCount.Text = currentIssue.Votes.ToString();

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

            if (currentIssue.StatusId != 0 && StatusManager.GetById(currentIssue.StatusId).IsClosedState)
            {
                VoteButton.Visible = false;
                VotedLabel.Visible = false;
            }

            List<DefaultValue> defValues = IssueManager.GetDefaultIssueTypeByProjectId(ProjectId);
            DefaultValue selectedValue = defValues.FirstOrDefault();

            if (selectedValue != null)
            {
                // Visibility Section
                IssueTypeField.Visible = selectedValue.TypeEditVisibility;
                StatusField.Visible = selectedValue.StatusEditVisibility;
                PriorityField.Visible = selectedValue.PriorityEditVisibility;
                PrivateField.Visible = selectedValue.PrivateEditVisibility;
                CategoryField.Visible = selectedValue.CategoryEditVisibility;
                DueDateField.Visible = selectedValue.DueDateEditVisibility;
                ProgressField.Visible = selectedValue.PercentCompleteEditVisibility;
                MilestoneField.Visible = selectedValue.MilestoneEditVisibility;
                EstimationField.Visible = selectedValue.EstimationEditVisibility;
                ResolutionField.Visible = selectedValue.ResolutionEditVisibility;
                AffectedMilestoneField.Visible = selectedValue.AffectedMilestoneEditVisibility;
                AssignedToField.Visible = selectedValue.AssignedToEditVisibility;
                OwnedByField.Visible = selectedValue.OwnedByEditVisibility;
                
            }
        }

        /// <summary>
        /// Binds the options.
        /// </summary>
        private void BindOptions()
        {
            List<ITUser> users = UserManager.GetUsersByProjectId(ProjectId, true);
            //Get Type
            DropIssueType.DataSource = IssueTypeManager.GetByProjectId(ProjectId);
            DropIssueType.DataBind();

            //Get Priority
            DropPriority.DataSource = PriorityManager.GetByProjectId(ProjectId);
            DropPriority.DataBind();

            //Get Resolutions
            DropResolution.DataSource = ResolutionManager.GetByProjectId(ProjectId);
            DropResolution.DataBind();

            //Get categories
            var categories = new CategoryTree();
            DropCategory.DataSource = categories.GetCategoryTreeByProjectId(ProjectId);
            DropCategory.DataBind();

            //Get milestones
            DropMilestone.DataSource = MilestoneManager.GetByProjectId(ProjectId);
            DropMilestone.DataBind();

            DropAffectedMilestone.DataSource = MilestoneManager.GetByProjectId(ProjectId);
            DropAffectedMilestone.DataBind();

            //Get Users
            DropAssignedTo.DataSource = users;
            DropAssignedTo.DataBind();

            DropOwned.DataSource = users;
            DropOwned.DataBind();         

            DropStatus.DataSource = StatusManager.GetByProjectId(ProjectId);
            DropStatus.DataBind();

            lblDateCreated.Text = DateTime.Now.ToString("f");
            lblLastModified.Text = DateTime.Now.ToString("f");

            if (!User.Identity.IsAuthenticated) return;

            lblReporter.Text = Security.GetDisplayName();
            lblLastUpdateUser.Text = Security.GetDisplayName();
        }

        /// <summary>
        /// Saves the issue.
        /// </summary>
        /// <returns></returns>
        private bool SaveIssue()
        {
            decimal estimation;
            decimal.TryParse(txtEstimation.Text.Trim(), out estimation);
            var dueDate = DueDatePicker.SelectedValue == null ? DateTime.MinValue : (DateTime)DueDatePicker.SelectedValue;

            // WARNING: DO NOT ENCODE THE HTMLEDITOR TEXT. 
            // It expects raw input. So pass through a raw string. 
            // This is a potential XSS vector as the Issue Class should
            // handle sanitizing the input and checking that its input is HtmlEncoded
            // (ie no < or > characters), not the IssueDetail.aspx.cs

            var issue = new Issue
                            {
                                AffectedMilestoneId = DropAffectedMilestone.SelectedValue,
                                AffectedMilestoneImageUrl = string.Empty,
                                AffectedMilestoneName = DropAffectedMilestone.SelectedText,
                                AssignedDisplayName = DropAssignedTo.SelectedText,
                                AssignedUserId = Guid.Empty,
                                AssignedUserName = DropAssignedTo.SelectedValue,
                                CategoryId = DropCategory.SelectedValue,
                                CategoryName = DropCategory.SelectedText,
                                CreatorDisplayName = Security.GetDisplayName(),
                                CreatorUserId = Guid.Empty,
                                CreatorUserName = Security.GetUserName(),
                                DateCreated = DateTime.Now,
                                Description = DescriptionHtmlEditor.Text.Trim(),
                                Disabled = false,
                                DueDate = dueDate,
                                Estimation = estimation,
                                Id = IssueId,
                                IsClosed = false,
                                IssueTypeId = DropIssueType.SelectedValue,
                                IssueTypeName = DropIssueType.SelectedText,
                                IssueTypeImageUrl = string.Empty,
                                LastUpdate = DateTime.Now,
                                LastUpdateDisplayName = Security.GetDisplayName(),
                                LastUpdateUserName = Security.GetUserName(),
                                MilestoneDueDate = null,
                                MilestoneId = DropMilestone.SelectedValue,
                                MilestoneImageUrl = string.Empty,
                                MilestoneName = DropMilestone.SelectedText,
                                OwnerDisplayName = DropOwned.SelectedText,
                                OwnerUserId = Guid.Empty,
                                OwnerUserName = DropOwned.SelectedValue,
                                PriorityId = DropPriority.SelectedValue,
                                PriorityImageUrl = string.Empty,
                                PriorityName = DropPriority.SelectedText,
                                Progress = Convert.ToInt32(ProgressSlider.Text),
                                ProjectCode = string.Empty,
                                ProjectId = ProjectId,
                                ProjectName = string.Empty,
                                ResolutionId = DropResolution.SelectedValue,
                                ResolutionImageUrl = string.Empty,
                                ResolutionName = DropResolution.SelectedText,
                                StatusId = DropStatus.SelectedValue,
                                StatusImageUrl = string.Empty,
                                StatusName = DropStatus.SelectedText,
                                Title = Server.HtmlEncode(TitleTextBox.Text),
                                TimeLogged = 0,
                                Visibility = chkPrivate.Checked ? 1 : 0,
                                Votes = 0
                            };

            if (!IssueManager.SaveOrUpdate(issue))
            {
                Message1.ShowErrorMessage(Resources.Exceptions.SaveIssueError);
                return false;
            }

            IssueId = issue.Id;

            if (!CustomFieldManager.SaveCustomFieldValues(IssueId, ctlCustomFields.Values))
            {
                Message1.ShowErrorMessage(Resources.Exceptions.SaveCustomFieldValuesError);
                return false;
            }

            return true;
        }
        /// <summary>
        /// Handles the Click event of the lnkUpdate control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void LnkSaveClick(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            if (SaveIssue())
            { 
                Response.Redirect(string.Format("~/Issues/IssueDetail.aspx?id={0}", IssueId));
            }
        }

        /// <summary>
        /// Handles the Click event of the VoteButton control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void VoteButtonClick(object sender, EventArgs e)
        {
            if (!User.Identity.IsAuthenticated)
                Response.Redirect(string.Format("~/Account/Login.aspx?ReturnUrl={0}", Server.UrlEncode(Request.RawUrl)));

            var vote = new IssueVote { IssueId = IssueId, VoteUsername = Security.GetUserName() };
            IssueVoteManager.SaveOrUpdate(vote);

            var count = Convert.ToInt32(IssueVoteCount.Text) + 1;

            IssueVoteCount.Text = count.ToString();
            VoteButton.Visible = false;
            VotedLabel.Visible = true;
        }

        /// <summary>
        /// Handles the Click event of the lnkDone control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void LnkDoneClick(object sender, EventArgs e)
        {
            if (Page.IsValid && SaveIssue())
                ReturnToPreviousPage();
        }

        /// <summary>
        /// Handles the Click event of the lnkDelete control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="T:System.EventArgs"/> instance containing the event data.</param>
        protected void LnkDeleteClick(object sender, EventArgs e)
        {
            IssueManager.Delete(IssueId);
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
        protected void EditTitleClick(object sender, ImageClickEventArgs e)
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
        protected void EditDescriptionClick(object sender, ImageClickEventArgs e)
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
                if ((UserManager.IsInRole(ProjectId, Globals.ProjectAdminRole) || UserManager.HasPermission(ProjectId, Common.Permission.EditIssueDescription.ToString())) && !DescriptionHtmlEditor.Visible)
                    EditDescription.Visible = true;

                if ((UserManager.IsInRole(ProjectId, Globals.ProjectAdminRole) || UserManager.HasPermission(ProjectId, Common.Permission.EditIssueTitle.ToString())) && !TitleTextBox.Visible)
                    EditTitle.Visible = true;

                //edit issue permission check
                if (!UserManager.HasPermission(ProjectId, Common.Permission.EditIssue.ToString()))
                    LockFields();

                //assign issue permission check
                if (!UserManager.HasPermission(ProjectId, Common.Permission.AssignIssue.ToString()))
                    DropAssignedTo.Enabled = false;

                //delete issue
                lnkDelete.Visible = UserManager.HasPermission(ProjectId, Common.Permission.DeleteIssue.ToString());

                //security check: assign issue
                if (!UserManager.HasPermission(ProjectId, Common.Permission.AssignIssue.ToString()))
                    DropAssignedTo.Enabled = false;

                if (!UserManager.HasPermission(ProjectId, Common.Permission.ChangeIssueStatus.ToString()))
                    DropStatus.Enabled = false;

                //remove closed status' if user does not have access
                if (!UserManager.HasPermission(ProjectId, Common.Permission.CloseIssue.ToString()))
                {
                    var stat = (DropDownList)DropStatus.FindControl("dropStatus");
                    var status = StatusManager.GetByProjectId(ProjectId).FindAll(st => st.IsClosedState);

                    foreach (var s in status)
                        stat.Items.Remove(stat.Items.FindByValue(s.Id.ToString()));
                }

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
            lnkCancel.Visible = true;
            lnkSave.Visible = false;
            lnkDone.Visible = false;
            lnkDelete.Visible = false;

            Description.Visible = true;
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
            get { return ViewState.Get("IssueId", 0); }
            set { ViewState.Set("IssueId", value); }
        }

        #endregion
    }
}
