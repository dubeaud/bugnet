namespace BugNET.Issues.UserControls
{
    using System;
    using System.Collections;
    using System.Web;
    using System.Web.Security;
    using System.Web.UI;
    using System.Web.UI.HtmlControls;
    using System.Web.UI.WebControls;
    using BugNET.BLL;
    using BugNET.Common;
    using BugNET.Entities;
    using BugNET.UserInterfaceLayer;
    /// <summary>
	///		Summary description for Comments.
	/// </summary>
	public partial class Comments : System.Web.UI.UserControl, IIssueTab
	{

		private int _IssueId = 0;
		private int _ProjectId = 0;
		private Guid _IssueOwnerUserId;

		/// <summary>
		/// Gets or sets the bug id.
		/// </summary>
		/// <value>The bug id.</value>
		public int IssueId 
		{
			get { return _IssueId; }
			set { _IssueId = value; }
		}

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
		/// Initializes this instance.
		/// </summary>
		public void Initialize() 
		{
		   
			BindComments();

			//check users role permission for adding a comment
			if (!Page.User.Identity.IsAuthenticated || !UserManager.HasPermission(ProjectId, Globals.Permission.AddComment.ToString()))
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
				_IssueOwnerUserId = IssueManager.GetIssueById(IssueId).OwnerUserId;
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
			if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
			{
				IssueComment currentComment = (IssueComment)e.Item.DataItem;

				if (currentComment.CreatorUserId== _IssueOwnerUserId)
					((HtmlControl)e.Item.FindControl("CommentArea")).Attributes["class"] = "commentContainerOwner";
						 

				// The edit panel is default not shown.
				Panel pnlEditComment = (Panel)e.Item.FindControl("pnlEditComment");
				pnlEditComment.Visible = false;

				Label CreatorDisplayName = (Label)e.Item.FindControl("CreatorDisplayName");
				CreatorDisplayName.Text = UserManager.GetUserDisplayName(currentComment.CreatorUserName);

				Label lblDateCreated = (Label)e.Item.FindControl("lblDateCreated");
				lblDateCreated.Text = currentComment.DateCreated.ToString("f");

				Literal ltlComment = (Literal)e.Item.FindControl("ltlComment");

				// WARNING: Do not decode the text from the HTML control (which supplied the comment),
				// as this was encoded already.
				//
				// However it is still possible to edit the raw contents of the htmlcontrol
				// using hacked client side javascript or using a httprequest editor 
				// and poison the system that way! Does viewstate protect this in any way??

				ltlComment.Text = currentComment.Comment;

				LinkButton lnkDeleteComment = (LinkButton)e.Item.FindControl("lnkDeleteComment");

				lnkDeleteComment.Attributes.Add("onclick", string.Format("return confirm('{0}');", GetLocalResourceObject("DeleteComment")));

				Image Avatar = (Image)e.Item.FindControl("Avatar");
				if (HostSettingManager.Get(HostSettingNames.EnableGravatar, true))
				{
					MembershipUser user = Membership.GetUser(currentComment.CreatorUserName);
					Avatar.Attributes.Add("src", GetGravatarImageURL(user.Email, 35));
				}
				else
				{
					Avatar.Attributes.Add("src",Page.ResolveUrl("~/images/noprofile.png"));
					Avatar.Style.Add("height", "35px");
					Avatar.Style.Add("width", "35px");
				}
					

				HyperLink hlPermaLink = (HyperLink)e.Item.FindControl("hlPermalink");
				hlPermaLink.NavigateUrl = String.Format("{0}#{1}", HttpContext.Current.Request.Url, currentComment.Id);
				LinkButton lnkEditComment = (LinkButton)e.Item.FindControl("lnkEditComment");

				// Check if the current user is Authenticated and has permission to edit a comment.
				lnkEditComment.Visible = false;
                lnkDeleteComment.Visible = false;

                // Check if the current user is Authenticated and has permission to edit a comment.//If user can edit comments
                if (Page.User.Identity.IsAuthenticated && UserManager.HasPermission(ProjectId, Globals.Permission.EditComment.ToString()))
                    lnkEditComment.Visible = true;
                // Check if the project admin or a super user trying to edit the comment.
                else if ((Page.User.Identity.IsAuthenticated && UserManager.IsInRole(Globals.SUPER_USER_ROLE)) || (Page.User.Identity.IsAuthenticated && UserManager.IsInRole(this.ProjectId, Globals.ProjectAdminRole)))
                    lnkEditComment.Visible = true;
                // Check if it is the original user, the project admin or a super user trying to edit the comment.
                else if (currentComment.CreatorUserName.ToLower() == Context.User.Identity.Name.ToLower() && UserManager.HasPermission(ProjectId, Globals.Permission.OwnerEditComment.ToString()))
                    lnkEditComment.Visible = true;

                // Check if the current user is Authenticated and has the permission to delete a comment			
                if (Page.User.Identity.IsAuthenticated && UserManager.HasPermission(ProjectId, Globals.Permission.DeleteComment.ToString()))
                {
                    // Check if it is the original user, the project admin or a super user trying to delete the comment.
                    if (currentComment.CreatorUserName.ToLower() == Context.User.Identity.Name.ToLower() || UserManager.IsInRole(Globals.SUPER_USER_ROLE) || UserManager.IsInRole(this.ProjectId, Globals.ProjectAdminRole))
                    {
                        lnkDeleteComment.Visible = true;
                    }
                }
			}
		}

		/// <summary>
		/// Gets the gravatar image URL.
		/// </summary>
		/// <param name="emailId">The email id.</param>
		/// <param name="imgSize">Size of the img.</param>
		/// <returns></returns>
		public static string GetGravatarImageURL(string emailId, int imgSize)
		{
   
			string hash = string.Empty;
			string imageURL = string.Empty;
  
			// Convert emailID to lower-case
			emailId = emailId.ToLower();
		  
			hash = FormsAuthentication.HashPasswordForStoringInConfigFile(emailId, "MD5").ToLower();
  
			// build Gravatar Image URL
			imageURL = string.Format("http://www.gravatar.com/avatar/{0}?s={1}&d=mm&r=g", hash, imgSize);
 
			return imageURL;
		}

		/// <summary>
		/// Handles the click event of the cmdEditComment
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		protected void cmdEditComment_Click(object sender, EventArgs e)
		{
			Control ctrl = (Control)sender;
			Panel pnlEditComment = (Panel)ctrl.Parent;
			Panel pnlComment = (Panel)ctrl.Parent.Parent.FindControl("pnlComment");
			BugNET.UserControls.HtmlEditor editor = (BugNET.UserControls.HtmlEditor)pnlEditComment.FindControl("EditCommentHtmlEditor");

			if (editor.Text.Trim().Length != 0)
			{
				HiddenField commentNumber = (HiddenField)pnlEditComment.FindControl("commentNumber");
				int commentID = Convert.ToInt32(commentNumber.Value);

				IssueComment comment = IssueCommentManager.GetById(Convert.ToInt32(commentID));
				comment.Comment = editor.Text.Trim();
                IssueCommentManager.SaveOrUpdate(comment);

				editor.Text = String.Empty;
				pnlEditComment.Visible = false;
				pnlComment.Visible = true;
				pnlAddComment.Visible = true;
				commentNumber.Value = String.Empty;

				BindComments();
			}
		}

		/// <summary>
		/// Handles the Click event of the cmdCancelEdit control.
		/// </summary>
		/// <param name="sender">The source of the event.</param>
		/// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
		protected void cmdCancelEdit_Click(object sender, EventArgs e)
		{
			Control ctrl = (Control)sender;
			Panel pnlEditComment = (Panel)ctrl.Parent;
			Panel pnlComment = (Panel)ctrl.Parent.Parent.FindControl("pnlComment");

			pnlEditComment.Visible = false;
			pnlComment.Visible = true;
			pnlAddComment.Visible = true;
			BindComments();
		}

		//// <summary>
		/// Handles the ItemCommand event of the rptComments control.
		/// </summary>
		/// <param name="source">The source of the event.</param>
		/// <param name="e">The <see cref="System.Web.UI.WebControls.RepeaterCommandEventArgs"/> instance containing the event data.</param>
		protected void rptComments_ItemCommand(object source, RepeaterCommandEventArgs e)
		{
			switch (e.CommandName)
			{
				case "Delete":
					IssueCommentManager.Delete(Convert.ToInt32(e.CommandArgument));
					BindComments();
					break;
				case "Edit":
					IssueComment comment = IssueCommentManager.GetById(Convert.ToInt32(e.CommandArgument));

					// Show the edit comment panel for the comment
					Panel pnlEditComment = (Panel)e.Item.FindControl("pnlEditComment");
					Panel pnlComment = (Panel)e.Item.FindControl("pnlComment");
					pnlAddComment.Visible = false;
					pnlEditComment.Visible = true;
					pnlComment.Visible = false;

					// Insert the existing comment text in the edit control.
					BugNET.UserControls.HtmlEditor editor = (BugNET.UserControls.HtmlEditor)pnlEditComment.FindControl("EditCommentHtmlEditor");                  
					editor.Text = comment.Comment;

					// Save the comment ID for further editting.
					HiddenField commentNumber = (HiddenField)e.Item.FindControl("commentNumber");
					commentNumber.Value = (string)e.CommandArgument;

					break;
			}
		}

		/// <summary>
		/// Handles the Click event of the cmdAddComment control.
		/// </summary>
		/// <param name="sender">The source of the event.</param>
		/// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
		protected void cmdAddComment_Click(object sender, EventArgs e)
		{
		    if (CommentHtmlEditor.Text.Trim().Length == 0) return;

		    var comment = new IssueComment
		                      {
		                          IssueId = IssueId,
		                          Comment = CommentHtmlEditor.Text.Trim(),
		                          CreatorUserName = Security.GetUserName(),
		                          DateCreated = DateTime.Now
		                      };

		    IssueCommentManager.SaveOrUpdate(comment);
		    CommentHtmlEditor.Text = String.Empty;
		    BindComments();
		}
	}
}
