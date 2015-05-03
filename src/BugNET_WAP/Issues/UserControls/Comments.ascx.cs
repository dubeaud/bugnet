using System;
using System.Collections;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using BugNET.BLL;
using BugNET.Common;
using BugNET.Entities;
using BugNET.UserInterfaceLayer;
using System.Web.Security;
using System.Security.Cryptography;
using System.Diagnostics;
using System.Text;

namespace BugNET.Issues.UserControls
{
    /// <summary>
    ///		Summary description for Comments.
    /// </summary>
    public partial class Comments : UserControl, IIssueTab
    {
        private Guid _issueOwnerUserId;

        /// <summary>
        /// Gets or sets the issue id.
        /// </summary>
        /// <value>The issue id.</value>
        public int IssueId
        {
            get { return ViewState.Get("IssueId", 0); }
            set { ViewState.Set("IssueId", value); }
        }

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
        /// Initializes this instance.
        /// </summary>
        public void Initialize()
        {

            BindComments();

            //check users role permission for adding a comment
            if (!Page.User.Identity.IsAuthenticated || !UserManager.HasPermission(ProjectId, Common.Permission.AddComment.ToString()))
                pnlAddComment.Visible = false;
        }

        /// <summary>
        /// Binds the comments.
        /// </summary>
        private void BindComments()
        {
            IList comments = IssueCommentManager.GetByIssueId(IssueId);

            if (comments.Count == 0)
            {
                lblComments.Text = GetLocalResourceObject("NoComments").ToString();
                lblComments.Visible = true;
                rptComments.Visible = false;
            }
            else
            {
                _issueOwnerUserId = IssueManager.GetById(IssueId).OwnerUserId;
                lblComments.Visible = false;

                rptComments.DataSource = comments;
                rptComments.DataBind();
                rptComments.Visible = true;
            }
        }

        /// <summary>
        /// Handles the ItemDataBound event of the rptComments control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.RepeaterItemEventArgs"/> instance containing the event data.</param>
        protected void rptComments_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType != ListItemType.Item && e.Item.ItemType != ListItemType.AlternatingItem) return;

            var currentComment = (IssueComment)e.Item.DataItem;

            //if (currentComment.CreatorUserId == _issueOwnerUserId)
            //    ((HtmlControl)e.Item.FindControl("CommentArea")).Attributes["class"] = "commentContainerOwner";

            // The edit panel is default not shown.
            var pnlEditComment = e.Item.FindControl("pnlEditComment") as Panel;

            if (pnlEditComment != null) pnlEditComment.Visible = false;

            var creatorDisplayName = (Label)e.Item.FindControl("CreatorDisplayName");
            creatorDisplayName.Text = UserManager.GetUserDisplayName(currentComment.CreatorUserName);
            creatorDisplayName.ToolTip = "Id: " + currentComment.CreatorUser.Id + Environment.NewLine + 
                                         "UserName: " + currentComment.CreatorUser.UserName + Environment.NewLine +
                                         "DisplayName: " + currentComment.CreatorUser.DisplayName;

            var lblDateCreated = (Label)e.Item.FindControl("lblDateCreated");
            lblDateCreated.Text = currentComment.DateCreated.ToString("f");

            var ltlComment = (Literal)e.Item.FindControl("ltlComment");

            // WARNING: Do not decode the text from the HTML control (which supplied the comment),
            // as this was encoded already.
            //
            // However it is still possible to edit the raw contents of the htmlcontrol
            // using hacked client side javascript or using a httprequest editor 
            // and poison the system that way! Does viewstate protect this in any way??

            ltlComment.Text = currentComment.Comment;


            var avatar = (Image)e.Item.FindControl("Avatar");

            if (HostSettingManager.Get(HostSettingNames.EnableGravatar, true))
            {
                var user = Membership.GetUser(currentComment.CreatorUserName);
                if (user != null && user.Email != null) avatar.Attributes.Add("src", PresentationUtils.GetGravatarImageUrl(user.Email, 64));
            }

            var hlPermaLink = (HyperLink)e.Item.FindControl("hlPermalink");
            hlPermaLink.NavigateUrl = String.Format("{0}#{1}", HttpContext.Current.Request.Url, currentComment.Id);


            var cmdEditComment = e.Item.FindControl("cmdEditComment") as ImageButton;

            // Check if the current user is Authenticated and has permission to edit a comment.
            if (cmdEditComment != null)
            {
                cmdEditComment.Visible = false;

                // Check if the current user is Authenticated and has permission to edit a comment.//If user can edit comments
                if (Page.User.Identity.IsAuthenticated && UserManager.HasPermission(ProjectId, Common.Permission.EditComment.ToString()))
                    cmdEditComment.Visible = true;
                    // Check if the project admin or a super user trying to edit the comment.
                else if ((Page.User.Identity.IsAuthenticated && UserManager.IsSuperUser()) || (Page.User.Identity.IsAuthenticated && UserManager.IsInRole(ProjectId, Globals.ProjectAdminRole)))
                    cmdEditComment.Visible = true;
                    // Check if it is the original user, the project admin or a super user trying to edit the comment.
                else if (currentComment.CreatorUserName.ToLower() == Context.User.Identity.Name.ToLower() && UserManager.HasPermission(ProjectId, Common.Permission.OwnerEditComment.ToString()))
                    cmdEditComment.Visible = true;
            }

            var cmdDeleteComment = e.Item.FindControl("cmdDeleteComment") as ImageButton;

            // Check if the current user is Authenticated and has the permission to delete a comment			
            if (!Page.User.Identity.IsAuthenticated || !UserManager.HasPermission(ProjectId, Common.Permission.DeleteComment.ToString())) return;

            if (cmdDeleteComment == null) return;

            cmdDeleteComment.Attributes.Add("onclick", string.Format("return confirm('{0}');", GetLocalResourceObject("DeleteComment").ToString().Trim().JsEncode()));
            cmdDeleteComment.Visible = false;

            // Check if it is the original user, the project admin or a super user trying to delete the comment.
            if (currentComment.CreatorUserName.ToLower() == Context.User.Identity.Name.ToLower() || UserManager.IsSuperUser() || UserManager.IsInRole(ProjectId, Globals.ProjectAdminRole))
            {
                cmdDeleteComment.Visible = true;
            }
        }


        /// <summary>
        /// Handles the ItemCommand event of the rptComments control.
        /// </summary>
        /// <param name="source">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.RepeaterCommandEventArgs"/> instance containing the event data.</param>
        protected void RptCommentsItemCommand(object source, RepeaterCommandEventArgs e)
        {
            var pnlEditComment = e.Item.FindControl("pnlEditComment") as Panel;
            var pnlComment = e.Item.FindControl("pnlComment") as Panel;

            if (pnlEditComment == null) return;
            if (pnlComment == null) return;

            BugNET.UserControls.HtmlEditor editor;
            HiddenField commentNumber;
            IssueComment comment;

            switch (e.CommandName)
            {
                case "Save":
                    editor = pnlEditComment.FindControl("EditCommentHtmlEditor") as BugNET.UserControls.HtmlEditor;
                    if (editor != null)
                    {
                        if (editor.Text.Trim().Length == 0) return;

                        commentNumber = (HiddenField)pnlEditComment.FindControl("commentNumber");
                        var commentId = Convert.ToInt32(commentNumber.Value);

                        comment = IssueCommentManager.GetById(Convert.ToInt32(commentId));
                        comment.Comment = editor.Text.Trim();
                        IssueCommentManager.SaveOrUpdate(comment);

                        editor.Text = String.Empty;
                        commentNumber.Value = String.Empty;
                    }

                    pnlEditComment.Visible = false;
                    pnlComment.Visible = true;
                    pnlAddComment.Visible = true;

                    BindComments();
                    break;
                case"Cancel":
                    pnlEditComment.Visible = false;
                    pnlComment.Visible = true;
                    pnlAddComment.Visible = true;
                    BindComments();
                    break;
                case "Delete":
                    IssueCommentManager.Delete(Convert.ToInt32(e.CommandArgument));
                    BindComments();
                    break;
                case "Edit":
                    comment = IssueCommentManager.GetById(Convert.ToInt32(e.CommandArgument));

                    // Show the edit comment panel for the comment
                    pnlAddComment.Visible = false;
                    pnlEditComment.Visible = true;
                    pnlComment.Visible = false;

                    // Insert the existing comment text in the edit control.
                    editor = pnlEditComment.FindControl("EditCommentHtmlEditor") as BugNET.UserControls.HtmlEditor;
                    if (editor != null) editor.Text = comment.Comment;

                    // Save the comment ID for further editting.
                    commentNumber = (HiddenField)e.Item.FindControl("commentNumber");
                    if (commentNumber != null) commentNumber.Value = (string)e.CommandArgument;
                    break;
            }
        }

        /// <summary>
        /// Handles the Click event of the cmdAddComment control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void CmdAddCommentClick(object sender, EventArgs e)
        {
            if (CommentHtmlEditor.Text.Trim().Length == 0) return;

            var comment = new IssueComment
                              {
                                  IssueId = IssueId,
                                  Comment = CommentHtmlEditor.Text.Trim(),
                                  CreatorUserName = Security.GetUserName(),
                                  DateCreated = DateTime.Now
                              };

            var result = IssueCommentManager.SaveOrUpdate(comment);

            if(result)
            {
                //add history record
                var history = new IssueHistory
                {
                    IssueId = IssueId,
                    CreatedUserName = Security.GetUserName(),
                    DateChanged = DateTime.Now,
                    FieldChanged = ResourceStrings.GetGlobalResource(GlobalResources.SharedResources, "Comment", "Comment"),
                    OldValue = string.Empty,
                    NewValue = ResourceStrings.GetGlobalResource(GlobalResources.SharedResources, "Added", "Added"),
                    TriggerLastUpdateChange = true
                };

                IssueHistoryManager.SaveOrUpdate(history);   
            }

            CommentHtmlEditor.Text = String.Empty;
            BindComments();
        }
    }
}
