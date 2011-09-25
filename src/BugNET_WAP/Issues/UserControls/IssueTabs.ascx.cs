using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using BugNET.BLL;
using BugNET.UserInterfaceLayer;

namespace BugNET.Issues.UserControls
{
    public partial class IssueTabs : System.Web.UI.UserControl
    {

        private int _ProjectId = 0;
        private int _IssueId = 0;
        private Control contentControl;

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
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        void Page_Load(object sender, System.EventArgs e)
        {   
            if (!Page.IsPostBack)
            {

                IssueTabsMenu.Items.Add(new MenuItem(GetTabName(GetLocalResourceObject("Comments").ToString(),"0"), "0", "~/images/comment.gif"));
                IssueTabsMenu.Items.Add(new MenuItem(GetTabName(GetLocalResourceObject("Attachments").ToString(),"1"), "1", "~/images/attach.gif"));
                IssueTabsMenu.Items.Add(new MenuItem(GetLocalResourceObject("History").ToString(), "2", "~/images/history.gif"));
                IssueTabsMenu.Items.Add(new MenuItem(GetLocalResourceObject("Notifications").ToString(), "3", "~/images/email.gif"));
                IssueTabsMenu.Items.Add(new MenuItem(GetLocalResourceObject("SubIssues").ToString(), "4", "~/images/link.gif"));
                IssueTabsMenu.Items.Add(new MenuItem(GetLocalResourceObject("ParentIssues").ToString(), "5", "~/images/link.gif"));
                IssueTabsMenu.Items.Add(new MenuItem(GetLocalResourceObject("RelatedIssues").ToString(), "6", "~/images/link.gif"));
                IssueTabsMenu.Items.Add(new MenuItem(GetLocalResourceObject("Revisions").ToString(), "7", "~/images/link.gif"));
                IssueTabsMenu.Items.Add(new MenuItem(GetLocalResourceObject("TimeTracking").ToString(), "8", "~/images/time.gif"));
                IssueTabsMenu.Items[0].Selected = true;
                
            }
            LoadTab(int.Parse(IssueTabsMenu.SelectedValue));
            
        }


        /// <summary>
        /// Refreshes the tab names.
        /// </summary>
        public void RefreshTabNames()
        {
            foreach (MenuItem item in IssueTabsMenu.Items)
            {
                if (item.Text.LastIndexOf('(') != -1)
                    item.Text = GetTabName(item.Text.Substring(0,item.Text.LastIndexOf('(')), item.Value);
                else
                    item.Text = GetTabName(item.Text, item.Value);
            }
        }

        /// <summary>
        /// Handles the PreRender event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void Page_PreRender(object sender, EventArgs e)
        {
           ((IIssueTab)contentControl).Initialize();
           RefreshTabNames();
        }

        /// <summary>
        /// Handles the Click event of the IssueTabsMenu control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.MenuEventArgs"/> instance containing the event data.</param>
        protected void IssueTabsMenu_Click(object sender, MenuEventArgs e)
        {
            LoadTab(int.Parse(e.Item.Value));

        }

        /// <summary>
        /// Loads the tab.
        /// </summary>
        void LoadTab(int selectedValue)
        {
            string controlName = "Comments.ascx";

            switch (selectedValue)
            {
                case 0:
                    controlName = "Comments.ascx";
                    break;
                case 1:
                    controlName = "Attachments.ascx";
                    break;
                case 2:
                    controlName = "History.ascx";
                    break;
                case 3:
                    controlName = "Notifications.ascx";
                    break;
                case 4:
                    controlName = "SubIssues.ascx";
                    break;
                case 5:
                    controlName = "ParentIssues.ascx";
                    break;
                case 6:
                    controlName = "RelatedIssues.ascx";
                    break;
                case 7:
                    controlName = "Revisions.ascx";
                    break;
                case 8:
                    controlName = "TimeTracking.ascx";
                    break;
            }

            contentControl = Page.LoadControl("~/Issues/UserControls/" + controlName);
            ((IIssueTab)contentControl).IssueId = _IssueId;
            ((IIssueTab)contentControl).ProjectId = _ProjectId;
            plhContent.Controls.Clear();
            plhContent.Controls.Add(contentControl);
            contentControl.ID = "ctlContent";
          
        }



        /// <summary>
        /// Gets the name of the tab.
        /// </summary>
        /// <param name="tab">The tab.</param>
        /// <returns></returns>
        private string GetTabName(string tabName, string tabValue)
        {
            //if (IssueId == 0)
            //    return string.Empty;

            switch (tabValue)
            {
                case "0":
                    return string.Format("{0} ({1})", tabName, IssueId == 0 ? 0 : IssueCommentManager.GetIssueCommentsByIssueId(IssueId).Count);
                case "2":
                    return string.Format("{0} ({1})", tabName, IssueId == 0 ? 0 : IssueHistoryManager.GetIssueHistoryByIssueId(IssueId).Count);
                case "1":
                    return string.Format("{0} ({1})",tabName,IssueId == 0 ? 0 : IssueAttachmentManager.GetIssueAttachmentsByIssueId(IssueId).Count);
                case "3":
                    return string.Format("{0} ({1})", tabName, IssueId == 0 ? 0 : IssueNotificationManager.GetIssueNotificationsByIssueId(IssueId).Count);
                case "6":
                    return string.Format("{0} ({1})", tabName, IssueId == 0 ? 0 : RelatedIssueManager.GetRelatedIssues(IssueId).Count);
                case "5":
                    return string.Format("{0} ({1})", tabName, IssueId == 0 ? 0 : RelatedIssueManager.GetParentIssues(IssueId).Count);
                case "4":
                    return string.Format("{0} ({1})", tabName, IssueId == 0 ? 0 : RelatedIssueManager.GetChildIssues(IssueId).Count);
                case "7":
                    return string.Format("{0} ({1})", tabName, IssueId == 0 ? 0 : IssueRevisionManager.GetIssueRevisionsByIssueId(IssueId).Count);
                case "8":
                    return string.Format("{0} ({1})", tabName, IssueId == 0 ? 0 : IssueWorkReportManager.GetWorkReportsByIssueId(IssueId).Count);
                default:
                    return tabName;
            }
        }
    }

    
   
}