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
    public partial class CreateIssue : BasePage
    {
        Project CurrentProject;

        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="EventArgs"/> instance containing the event data.</param>
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                ProjectId = Request.QueryString.Get("pid", 0);

                // If don't know project or issue then redirect to something missing page
                if (ProjectId == 0)
                    ErrorRedirector.TransferToSomethingMissingPage(Page);

                CurrentProject = ProjectManager.GetById(ProjectId);

                if (CurrentProject == null)
                {
                    ErrorRedirector.TransferToNotFoundPage(Page);
                    return;
                }

                //security check: add issue
                if (!UserManager.HasPermission(ProjectId, Common.Permission.AddIssue.ToString()))
                {
                    ErrorRedirector.TransferToLoginPage(Page);
                }

                BindOptions();

                lblIssueNumber.Text = GetGlobalResourceObject("SharedResources", "NotAvailableAbbr").ToString();

                BindDefaultValues();

                //check users role permission for adding an attachment
                if (!Page.User.Identity.IsAuthenticated || !UserManager.HasPermission(ProjectId, Common.Permission.AddAttachment.ToString()))
                {
                    pnlAddAttachment.Visible = false;
                }
                else
                {
                    pnlAddAttachment.Visible = true;
                }
            }

            //need to rebind these on every postback because of dynamic controls
            ctlCustomFields.DataSource = CustomFieldManager.GetByProjectId(ProjectId);
            ctlCustomFields.DataBind();

            // The ExpandIssuePaths method is called to handle
            // the SiteMapResolve event.
            SiteMap.SiteMapResolve += ExpandIssuePaths;
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
            tempNode.Title = GetGlobalResourceObject("SharedResources", "NewIssue").ToString();

            if ((null != (tempNode = tempNode.ParentNode)))
            {
                tempNode.Url = string.Format("~/Issues/IssueList.aspx?pid={0}", ProjectId);
            }

            return currentNode;
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
            DropMilestone.DataSource = MilestoneManager.GetByProjectId(ProjectId, false);
            DropMilestone.DataBind();

            DropAffectedMilestone.DataSource = MilestoneManager.GetByProjectId(ProjectId);
            DropAffectedMilestone.DataBind();

            //Get Users
            DropAssignedTo.DataSource = users;
            DropAssignedTo.DataBind();

            DropOwned.DataSource = users;
            DropOwned.DataBind();
            DropOwned.SelectedValue = User.Identity.Name;

            DropStatus.DataSource = StatusManager.GetByProjectId(ProjectId);
            DropStatus.DataBind();
        }


        /// <summary>
        /// Binds the default values.
        /// </summary>
        private void BindDefaultValues()
        {

            List<DefaultValue> defValues = IssueManager.GetDefaultIssueTypeByProjectId(ProjectId);
            DefaultValue selectedValue = defValues.FirstOrDefault();

            if (selectedValue != null)
            {
                DropIssueType.SelectedValue = selectedValue.IssueTypeId;
                DropPriority.SelectedValue = selectedValue.PriorityId;
                DropResolution.SelectedValue = selectedValue.ResolutionId;
                DropCategory.SelectedValue = selectedValue.CategoryId;
                DropMilestone.SelectedValue = selectedValue.MilestoneId;
                DropAffectedMilestone.SelectedValue = selectedValue.AffectedMilestoneId;

                if (selectedValue.AssignedUserName != "none")
                    DropAssignedTo.SelectedValue = selectedValue.AssignedUserName;

                if (selectedValue.OwnerUserName != "none")
                    DropOwned.SelectedValue = selectedValue.OwnerUserName;

                DropStatus.SelectedValue = selectedValue.StatusId;

                if (selectedValue.IssueVisibility == 0) chkPrivate.Checked = false;
                if (selectedValue.IssueVisibility == 1) chkPrivate.Checked = true;

                //Date 
                if (selectedValue.DueDate.HasValue)
                {
                    DateTime date = DateTime.Today;
                    date = date.AddDays(selectedValue.DueDate.Value);
                    DueDatePicker.SelectedValue = date;
                }

                ProgressSlider.Text = selectedValue.Progress.ToString();
                txtEstimation.Text = selectedValue.Estimation.ToString();

                //Visibility Section
                DropIssueType.Visible = IssueTypeLabel.Visible = selectedValue.TypeVisibility;
                DropStatus.Visible = StatusLabel.Visible = selectedValue.StatusVisibility;
                chkNotifyOwner.Visible = DropOwned.Visible = OwnerLabel.Visible = selectedValue.OwnedByVisibility;
                DropPriority.Visible = PriorityLabel.Visible = selectedValue.PriorityVisibility;
                chkNotifyAssignedTo.Visible = DropAssignedTo.Visible = AssignedToLabel.Visible = selectedValue.AssignedToVisibility;
                chkPrivate.Visible = PrivateLabel.Visible = selectedValue.PrivateVisibility;
                DropCategory.Visible = CategoryLabel.Visible = selectedValue.CategoryVisibility;
                DueDatePicker.Visible = DueDateLabel.Visible = selectedValue.DueDateVisibility;
                Label3.Visible = ProgressSlider.Visible = ProgressSlider_BoundControl.Visible = PercentLabel.Visible = selectedValue.PercentCompleteVisibility;
                DropMilestone.Visible = MilestoneLabel.Visible = selectedValue.MilestoneVisibility;
                HoursLabel.Visible = txtEstimation.Visible = EstimationLabel.Visible = selectedValue.EstimationVisibility;
                DropResolution.Visible = ResolutionLabel.Visible = selectedValue.ResolutionVisibility;
                DropAffectedMilestone.Visible = Label4.Visible = selectedValue.AffectedMilestoneVisibility;
                chkNotifyAssignedTo.Checked = selectedValue.AssignedToNotify;
                chkNotifyOwner.Checked = selectedValue.OwnedByNotify;
            }

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
        /// Cancels the button click.
        /// </summary>
        /// <param name="s">The s.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void CancelButtonClick(Object s, EventArgs e)
        {
            ReturnToPreviousPage();
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
        /// Saves the issue.
        /// </summary>
        /// <returns></returns>
        private bool SaveIssue()
        {
            decimal estimation;
            decimal.TryParse(txtEstimation.Text.Trim(), out estimation);
            var dueDate = DueDatePicker.SelectedValue ?? DateTime.MinValue;

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
                    Id = 0,
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

            if (!CustomFieldManager.SaveCustomFieldValues(issue.Id, ctlCustomFields.Values))
            {
                Message1.ShowErrorMessage(Resources.Exceptions.SaveCustomFieldValuesError);
                return false;
            }

            IssueId = issue.Id;

            //add attachment if present.
            if (AspUploadFile.HasFile)
            {
                // get the current file
                var uploadFile = AspUploadFile.PostedFile;
                string inValidReason;
                var validFile = IssueAttachmentManager.IsValidFile(uploadFile.FileName, out inValidReason);

                if (validFile)
                {
                    if (uploadFile.ContentLength > 0)
                    {
                        byte[] fileBytes;
                        using (var input = uploadFile.InputStream)
                        {
                            fileBytes = new byte[uploadFile.ContentLength];
                            input.Read(fileBytes, 0, uploadFile.ContentLength);
                        }

                        var issueAttachment = new IssueAttachment
                        {
                            Id = Globals.NEW_ID,
                            Attachment = fileBytes,
                            Description = AttachmentDescription.Text.Trim(),
                            DateCreated = DateTime.Now,
                            ContentType = uploadFile.ContentType,
                            CreatorDisplayName = string.Empty,
                            CreatorUserName = Security.GetUserName(),
                            FileName = uploadFile.FileName,
                            IssueId = issue.Id,
                            Size = fileBytes.Length
                        };

                        if (!IssueAttachmentManager.SaveOrUpdate(issueAttachment))
                        {
                            Message1.ShowErrorMessage(string.Format(GetGlobalResourceObject("Exceptions", "SaveAttachmentError").ToString(), uploadFile.FileName));
                        }
                    }

                }
                else
                {
                    Message1.ShowErrorMessage(inValidReason);
                    return false;
                }
            }

            //create a vote for the new issue
            var vote = new IssueVote { IssueId = issue.Id, VoteUsername = Security.GetUserName() };

            if (!IssueVoteManager.SaveOrUpdate(vote))
            { 
                Message1.ShowErrorMessage(Resources.Exceptions.SaveIssueVoteError);
                return false;
            }

            if (chkNotifyOwner.Checked && !string.IsNullOrEmpty(issue.OwnerUserName))
            {
                var oUser = UserManager.GetUser(issue.OwnerUserName);
                if (oUser != null)
                {
                    var notify = new IssueNotification { IssueId = issue.Id, NotificationUsername = oUser.UserName };
                    IssueNotificationManager.SaveOrUpdate(notify);
                }
            }
            if (chkNotifyAssignedTo.Checked && !string.IsNullOrEmpty(issue.AssignedUserName))
            {
                var oUser = UserManager.GetUser(issue.AssignedUserName);
                if (oUser != null)
                {
                    var notify = new IssueNotification { IssueId = issue.Id, NotificationUsername = oUser.UserName };
                    IssueNotificationManager.SaveOrUpdate(notify);
                }
            }

            //send issue notifications
            IssueNotificationManager.SendIssueAddNotifications(issue.Id);

            return true;
        }

        /// <summary>
        /// Gets or sets the issue id.
        /// </summary>
        /// <value>The issue id.</value>
        int IssueId
        {
            get { return ViewState.Get("IssueId", 0); }
            set { ViewState.Set("IssueId", value); }
        }
    }
}