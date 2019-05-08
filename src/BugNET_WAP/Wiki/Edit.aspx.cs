using System;
using System.Configuration;
using System.Web;
using System.Web.UI;
using BugNET.Entities;
using BugNET.Common;
using BugNET.BLL;
using BugNET.UserInterfaceLayer;
using BugNET.UserInterfaceLayer.Wiki;

namespace BugNET.Wiki
{
    public partial class Edit : BasePage
    {
        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsEditable())
                Response.Redirect("~/Wiki/Default.aspx");

            if (Page.IsPostBack)
                return;

            int id = GetId();
            string slug = GetSlug();
            int projectid = GetProjectId();
            WikiContent content = WikiManager.Get(id);



            if (content != null)
            {
                Page.Title = HttpUtility.HtmlEncode(content.Title.Name);
                Literal1.Text = GetLocalResourceObject("EditPage").ToString();
                Name.Text = content.Title.Name;
                Source.Text = content.Source;
                CancelPlaceHolder.Visible = true;
                Cancel.OnClientClick = "window.location.href='" + ResolveClientUrl("~/Wiki/Default.aspx?pid=" + projectid + "&i=" + id + "&p=" + HttpUtility.UrlEncode(slug) + "'");
            }
            else
            {
                Page.Title = Literal1.Text =  GetLocalResourceObject("NewPage").ToString();
            }
        }

        /// <summary>
        /// Gets the id.
        /// </summary>
        /// <returns></returns>
        private int GetId()
        {
            string idParam = Request.QueryString["i"];
            if (string.IsNullOrEmpty(idParam))
                return 0;

            return int.Parse(idParam);
        }

        /// <summary>
        /// Gets the slug.
        /// </summary>
        /// <returns></returns>
        private string GetSlug()
        {
            string slug = Request.QueryString["p"];
            if (string.IsNullOrEmpty(slug))
                return SlugHelper.Generate(Name.Text);

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
        /// Determines whether this instance is editable.
        /// </summary>
        /// <returns>
        /// 	<c>true</c> if this instance is editable; otherwise, <c>false</c>.
        /// </returns>
        private static bool IsEditable()
        {
            return true;
        }

        /// <summary>
        /// Saves the source.
        /// </summary>
        /// <param name="sender">The sender.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void SaveSource(object sender, EventArgs e)
        {
            int id = GetId();
            string slug = GetSlug();
           
            int projectid = GetProjectId();
            id = WikiManager.Save(projectid, id, slug, Name.Text, Source.Text, Security.GetUserName());
            Response.Redirect("~/Wiki/Default.aspx?pid=" + projectid + "&i=" + id + "&p=" + HttpUtility.UrlEncode(slug));
        }
    }
}