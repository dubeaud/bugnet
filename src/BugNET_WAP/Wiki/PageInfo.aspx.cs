using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BugNET.BLL;
using BugNET.Entities;
using BugNET.UserInterfaceLayer;
using BugNET.UserInterfaceLayer.Wiki;

namespace BugNET.Wiki
{
    public partial class PageInfo : BasePage
    {
        private WikiContent content;

        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="EventArgs"/> instance containing the event data.</param>
        protected void Page_Load(object sender, EventArgs e)
        {
            string Slug = GetSlug();
            int ProjectId = GetProjectId();

            content = WikiManager.Get(ProjectId, Slug, string.Empty);

            if (content != null)
            {
                LastUpdated.Text = content.VersionDate.ToString();
                RevisionNumber.Text = content.Version.ToString();
                LastUpdatedBy.Text = content.CreatorDisplayName;
                Page.Title = GetLocalResourceObject("PageTitle.Text").ToString();              

                pageHistory.DataSource = WikiManager.GetHistory(content.Title.Id);
                pageHistory.DataBind();
            }
        }

        /// <summary>
        /// Gets the project id.
        /// </summary>
        /// <returns></returns>
        private int GetProjectId()
        {
            string idParam = Request.QueryString["pid"];
            if (string.IsNullOrEmpty(idParam))
                return 0;
            return int.Parse(idParam);
        }

        // <summary>
        /// Gets the slug.
        /// </summary>
        /// <returns></returns>
        private string GetSlug()
        {
            string slug = Request.QueryString["p"];
            if (string.IsNullOrEmpty(slug))
                return string.Empty;

            return slug;
        }

        /// <summary>
        /// Binds the page history item.
        /// </summary>
        /// <param name="sender">The sender.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.RepeaterItemEventArgs"/> instance containing the event data.</param>
        protected void BindPageHistoryItem(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Header || e.Item.ItemType == ListItemType.Footer)
                return;

            var date = e.Item.FindControl("date") as Literal;
            var versionLink = e.Item.FindControl("versionLink") as HyperLink;
            var historyItem = e.Item.DataItem as WikiContent;
            var user = e.Item.FindControl("user") as Literal;

            user.Text = historyItem.CreatorDisplayName;
            date.Text = historyItem.VersionDate.ToString();
            versionLink.Visible = true;
            versionLink.NavigateUrl = ResolveClientUrl("~/Wiki/Default.aspx?pid=" + content.Title.ProjectId + "&i=" + content.Title.Id + "&p=" + HttpUtility.UrlEncode(content.Title.Slug) + "&v=" + historyItem.Version);
            versionLink.Text = GetLocalResourceObject("View").ToString();
        }
    }
}