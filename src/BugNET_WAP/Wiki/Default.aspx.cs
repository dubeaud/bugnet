using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WikiPlex.Formatting.Renderers;
using BugNET.Entities;
using BugNET.BLL;
using BugNET.UserInterfaceLayer.Wiki;
using BugNET.UserInterfaceLayer;
using WikiPlex;
using BugNET.Common;


namespace BugNET.Wiki
{
    public partial class Default : BasePage
    {
        private readonly IWikiEngine wikiEngine = new WikiEngine();
        private WikiContent wikiContent;

        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void Page_Load(object sender, EventArgs e)
        {
            int id = GetId();
            string slug = GetSlug();
            int projectid = GetProjectId();

            if (projectid == 0)
                ErrorRedirector.TransferToSomethingMissingPage(this.Page);

            ProjectId = projectid;

            if (!UserManager.HasPermission(ProjectId, Common.Permission.ViewWiki.ToString()))
                ErrorRedirector.TransferToLoginPage(this.Page);

            int version;
            if (!string.IsNullOrEmpty(Request.QueryString["v"]) && int.TryParse(Request.QueryString["v"], out version))
            {
                wikiContent = WikiManager.GetByVersion(id, version);
                if (wikiContent == null)
                    Response.Redirect(ResolveClientUrl("~/Wiki/Default.aspx?pid=" + projectid + "&i=" + id + "&p=" + HttpUtility.UrlEncode(slug)));
            }
            else
                wikiContent = WikiManager.Get(id);

            if (wikiContent == null)
                Response.Redirect(ResolveClientUrl("~/Wiki/Edit.aspx?pid=" + projectid + "&i=" + id + "&p=" + HttpUtility.UrlEncode(slug)));

            PageInfo.NavigateUrl = ResolveClientUrl("~/Wiki/PageInfo.aspx?pid=" + projectid + "&p=" + HttpUtility.UrlEncode(slug));
            Delete.OnClientClick = "return confirm('" + GetLocalResourceObject("DeleteMessage").ToString() + "');";
            Page.Title = HttpUtility.HtmlEncode(wikiContent.Title.Name);
            sourceId.Text = previewId.Text = wikiContent.Title.Id.ToString();
            projectId.Text = wikiContent.Title.ProjectId.ToString();
            sourceSlug.Text = previewSlug.Text = wikiContent.Title.Slug;
            sourceVersion.Text = wikiContent.Version.ToString();
            renderedSource.Text = wikiEngine.Render(wikiContent.Source, GetRenderers(projectid));
            Name.Value = wikiContent.Title.Name;
            NotLatestPlaceHolder.Visible = wikiContent.Version != wikiContent.Title.MaxVersion;
            editWiki.Visible = editWikiForm.Visible = IsEditable();
            NewPage.NavigateUrl = ResolveClientUrl(string.Format("~/Wiki/Edit.aspx?pid={0}&i=0", projectid, id));
            Delete.Visible = IsDeletable();

            pageHistory.DataSource = WikiManager.GetHistory(id).Take(5);
            pageHistory.DataBind();
        }

        /// <summary>
        /// Gets the id.
        /// </summary>
        /// <returns></returns>
        private int GetId()
        {
            string idParam = Request.QueryString["i"];
            if (string.IsNullOrEmpty(idParam))
                return GetDefaultPageId();
            return int.Parse(idParam);
        }


        /// <summary>
        /// Gets the default page id.
        /// </summary>
        /// <returns></returns>
        private int GetDefaultPageId()
        {
            WikiContent c = WikiManager.Get(GetProjectId(), GetSlug(), "Home");
            if (c != null)
                return c.Title.Id;
            else
                return 0;
        }
        /// <summary>
        /// Gets the slug.
        /// </summary>
        /// <returns></returns>
        private string GetSlug()
        {
            string slug = Request.QueryString["p"];
            if (string.IsNullOrEmpty(slug))
                slug = "home";
            return slug;
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

        /// <summary>
        /// Binds the page history item.
        /// </summary>
        /// <param name="sender">The sender.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.RepeaterItemEventArgs"/> instance containing the event data.</param>
        protected void BindPageHistoryItem(object sender, RepeaterItemEventArgs e)
        {
            var date = e.Item.FindControl("date") as Literal;
            var versionLink = e.Item.FindControl("versionLink") as HyperLink;
            var historyItem = e.Item.DataItem as WikiContent;

            date.Visible = versionLink.Visible = false;

            if (wikiContent.Version == historyItem.Version)
            {
                date.Visible = true;
                date.Text = wikiContent.VersionDate.ToString();
            }
            else
            {
                versionLink.Visible = true;
                versionLink.NavigateUrl = ResolveClientUrl("~/Wiki/Default.aspx?pid=" + wikiContent.Title.ProjectId + "&i=" + wikiContent.Title.Id + "&p=" + HttpUtility.UrlEncode(wikiContent.Title.Slug) + "&v=" + historyItem.Version);
                versionLink.Text = historyItem.VersionDate.ToString();
            }
        }

        /// <summary>
        /// Gets the renderers.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        private static IEnumerable<IRenderer> GetRenderers(int projectId)
        {
            var siteRenderers = new IRenderer[] {new IssueLinkRenderer(), new TitleLinkRenderer(projectId) };
            return Renderers.All.Union(siteRenderers);
        }

        /// <summary>
        /// Determines whether this instance is editable.
        /// </summary>
        /// <returns>
        /// 	<c>true</c> if this instance is editable; otherwise, <c>false</c>.
        /// </returns>
        private bool IsEditable()
        {
            return UserManager.HasPermission(ProjectId, Common.Permission.EditWiki.ToString());
        }

        /// <summary>
        /// Determines whether this instance is deletable.
        /// </summary>
        /// <returns>
        ///   <c>true</c> if this instance is deletable; otherwise, <c>false</c>.
        /// </returns>
        public bool IsDeletable()
        {
            if (GetSlug() == "home")
                return false;

            return UserManager.HasPermission(ProjectId, Common.Permission.DeleteWiki.ToString());
        }

        /// <summary>
        /// Saves the content of the wiki.
        /// </summary>
        /// <param name="sender">The sender.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void SaveWikiContent(object sender, EventArgs e)
        {
            int id = GetId();
            string slug = GetSlug();
            int projectid = GetProjectId();
            WikiManager.Save(projectid, id, slug, Name.Value, Source.Text, Security.GetUserName());
            Response.Redirect("~/Wiki/Default.aspx?pid=" + projectid + "&p=" + HttpUtility.UrlEncode(slug));
        }

        /// <summary>
        /// Handles the Click event of the Delete control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="EventArgs"/> instance containing the event data.</param>
        protected void Delete_Click(object sender, EventArgs e)
        {
            WikiManager.Delete(GetId());

            Response.Redirect(string.Format("~/Wiki/Default.aspx?pid={0}",  GetProjectId()));
        }
    }
}