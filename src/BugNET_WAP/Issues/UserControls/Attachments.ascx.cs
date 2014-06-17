using System;
using System.Collections.Generic;
using System.IO;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using BugNET.BLL;
using BugNET.Common;
using BugNET.Entities;
using BugNET.UserInterfaceLayer;
using log4net;

namespace BugNET.Issues.UserControls
{
    /// <summary>
    /// 
    /// </summary>
    public partial class Attachments : UserControl, IIssueTab
    {
        private static readonly ILog Log = LogManager.GetLogger(typeof(Attachments));

        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void Page_Load(object sender, EventArgs e)
        {
            var sman = ScriptManager.GetCurrent(Page);
            if (sman != null) sman.RegisterPostBackControl(UploadButton);
        }

        #region IIssueTab Members

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
            AttachmentsDataGrid.Columns[0].HeaderText = GetLocalResourceObject("AttachmentsGrid.FileNameHeader.Text").ToString();
            AttachmentsDataGrid.Columns[1].HeaderText = GetLocalResourceObject("AttachmentsGrid.SizeHeader.Text").ToString();
            AttachmentsDataGrid.Columns[2].HeaderText = GetLocalResourceObject("AttachmentsGrid.Description.Text").ToString();

            BindAttachments();

            //check users role permission for adding an attachment
            if (!Page.User.Identity.IsAuthenticated || !UserManager.HasPermission(ProjectId, Common.Permission.AddAttachment.ToString()))
                pnlAddAttachment.Visible = false;

            if (!Page.User.Identity.IsAuthenticated || !UserManager.HasPermission(ProjectId, Common.Permission.DeleteAttachment.ToString()))
                AttachmentsDataGrid.Columns[5].Visible = false;
        }

        #endregion

        /// <summary>
        /// Binds the attachments.
        /// </summary>
        private void BindAttachments()
        {
            //Fix tab names after adding or deleting a record.
           //IssueTabs tabs = this.Parent as Issues.UserControls.IssueTabs;
           //tabs.RefreshTabNames();
            List<IssueAttachment> attachments = IssueAttachmentManager.GetByIssueId(IssueId);

            AttachmentDescription.Text = string.Empty;

            if (attachments.Count == 0)
            {
                lblAttachments.Text = GetLocalResourceObject("NoAttachments").ToString();
                lblAttachments.Visible = true;
                AttachmentsDataGrid.Visible = false;
            }
            else
            {
                lblAttachments.Visible = false;
                AttachmentsDataGrid.DataSource = attachments;
                AttachmentsDataGrid.DataBind();
                AttachmentsDataGrid.Visible = true;
            }
        }

        /// <summary>
        /// Uploads the document.
        /// </summary>
        /// <param name="sender">The sender.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void UploadDocument(object sender, EventArgs e)
        {
            // get the current file
            var uploadFile = AspUploadFile.PostedFile;

            // if there was a file uploaded
            if (uploadFile != null && uploadFile.ContentLength > 0)
            {
                var inValidReason = string.Empty;
                var fileName = Path.GetFileName(uploadFile.FileName);

                var validFile = IssueAttachmentManager.IsValidFile(fileName, out inValidReason);

                if (validFile)
                {
                    byte[] fileBytes;
                    using (var input = uploadFile.InputStream)
                    {
                        fileBytes = new byte[uploadFile.ContentLength];
                        input.Read(fileBytes, 0, uploadFile.ContentLength);
                    }

                    var attachment = new IssueAttachment
                    {
                        Id = Globals.NEW_ID,
                        Attachment = fileBytes,
                        Description = AttachmentDescription.Text.Trim(),
                        DateCreated = DateTime.Now,
                        ContentType = uploadFile.ContentType,
                        CreatorDisplayName = string.Empty,
                        CreatorUserName = Security.GetUserName(),
                        FileName = fileName,
                        IssueId = IssueId,
                        Size = fileBytes.Length
                    };

                    if (!IssueAttachmentManager.SaveOrUpdate(attachment))
                    {
                        AttachmentsMessage.ShowErrorMessage(string.Format(GetGlobalResourceObject("Exceptions", "SaveAttachmentError").ToString(), uploadFile.FileName));
                        if (Log.IsWarnEnabled) Log.Warn(string.Format(GetGlobalResourceObject("Exceptions", "SaveAttachmentError").ToString(), uploadFile.FileName));
                        return;
                    }

                    //add history record and send notifications
                    var history = new IssueHistory
                    {
                        IssueId = IssueId,
                        CreatedUserName = Security.GetUserName(),
                        DateChanged = DateTime.Now,
                        FieldChanged = ResourceStrings.GetGlobalResource(GlobalResources.SharedResources, "Attachment", "Attachment"),
                        OldValue = fileName,
                        NewValue = ResourceStrings.GetGlobalResource(GlobalResources.SharedResources, "Added", "Added"),
                        TriggerLastUpdateChange = true
                    };

                    IssueHistoryManager.SaveOrUpdate(history);

                    var changes = new List<IssueHistory> { history };

                    IssueNotificationManager.SendIssueNotifications(IssueId, changes);

                    BindAttachments();
                }
                else
                    AttachmentsMessage.ShowErrorMessage(inValidReason); 
            }
        }

        /// <summary>
        /// Handles the ItemDataBound event of the AttachmentsDataGrid control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.DataGridItemEventArgs"/> instance containing the event data.</param>
        protected void AttachmentsDataGridItemDataBound(object sender, DataGridItemEventArgs e)
        {
            if (e.Item.ItemType != ListItemType.Item && e.Item.ItemType != ListItemType.AlternatingItem) return;

            var currentAttachment = (IssueAttachment)e.Item.DataItem;
            var lnkAttachment = e.Item.FindControl("lnkAttachment") as HtmlAnchor;

            if (lnkAttachment != null)
            {
                if (ProjectManager.GetById(ProjectId).AttachmentStorageType == IssueAttachmentStorageTypes.FileSystem)
                {
                    lnkAttachment.InnerText = IssueAttachmentManager.StripGuidFromFileName(currentAttachment.FileName);
                }
                else
                {
                    lnkAttachment.InnerText = currentAttachment.FileName;
                }
                lnkAttachment.HRef = string.Concat("DownloadAttachment.axd?id=", currentAttachment.Id.ToString());
            }

            var lblSize = e.Item.FindControl("lblSize") as Label;

            if (lblSize == null) return;

            float size;
            string label;

            if (currentAttachment.Size > 1000)
            {
                size = currentAttachment.Size / 1000f;
                label = string.Format("{0} kb", size.ToString("##,##"));
            }
            else
            {
                size = currentAttachment.Size;
                label = string.Format("{0} b", size.ToString("##,##"));
            }

            lblSize.Text = label;

            var cmdDelete = e.Item.FindControl("cmdDelete") as ImageButton;

            // Check if the current user is Authenticated and has the permission to delete a comment			
            if (!Page.User.Identity.IsAuthenticated || !UserManager.HasPermission(ProjectId, Common.Permission.DeleteAttachment.ToString())) return;

            if (cmdDelete == null) return;

            cmdDelete.Attributes.Add("onclick", string.Format("return confirm('{0}');", GetLocalResourceObject("DeleteAttachment").ToString().Trim().JsEncode()));
            cmdDelete.Visible = false;

            // Check if it is the original user, the project admin or a super user trying to delete the comment.
            if (currentAttachment.CreatorUserName.ToLower() == Context.User.Identity.Name.ToLower() || UserManager.IsSuperUser() || UserManager.IsInRole(ProjectId, Globals.ProjectAdminRole))
            {
                cmdDelete.Visible = true;
            }
        }

        /// <summary>
        /// Handles the ItemCommand event of the dtgAttachment control.
        /// </summary>
        /// <param name="source">The source of the event.</param>
        /// <param name="e">The <see cref="T:System.Web.UI.WebControls.DataGridCommandEventArgs"/> instance containing the event data.</param>
        protected void AttachmentsDataGridItemCommand(object source, DataGridCommandEventArgs e)
        {
            switch (e.CommandName)
            {
                case "Delete":
                    IssueAttachmentManager.Delete(Convert.ToInt32(e.CommandArgument));
                    break;
            }
            BindAttachments();
        }
    }
}