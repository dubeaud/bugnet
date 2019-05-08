using System;
using System.Collections.Generic;
using WikiPlex.Formatting.Renderers;
using BugNET.BLL;
using BugNET.Entities;

namespace BugNET.UserInterfaceLayer.Wiki
{
    public class TitleLinkRenderer : Renderer
    {
        private const string LinkFormat = "<a href=\"{0}\">{1}</a>";
        private int ProjectId;
        /// <summary>
        /// Initializes a new instance of the <see cref="TitleLinkRenderer"/> class.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        public TitleLinkRenderer(int projectId) 
        {
            ProjectId = projectId;
        }

        /// <summary>
        /// Gets the collection of scope names for this <see cref="T:WikiPlex.Formatting.Renderers.IRenderer"/>.
        /// </summary>
        /// <value></value>
        protected override ICollection<string> ScopeNames
        {
            get { return new[] {WikiScopeName.WikiLink}; }
        }

        /// <summary>
        /// Will expand the input into the appropriate content based on scope for the derived types.
        /// </summary>
        /// <param name="scopeName">The scope name.</param>
        /// <param name="input">The input to be expanded.</param>
        /// <param name="htmlEncode">Function that will html encode the output.</param>
        /// <param name="attributeEncode">Function that will html attribute encode the output.</param>
        /// <returns>The expanded content.</returns>
        protected override string PerformExpand(string scopeName, string input, Func<string, string> htmlEncode, Func<string, string> attributeEncode)
        {
            string slug = SlugHelper.Generate(input);
            WikiContent content = WikiManager.Get(ProjectId, slug, input);
            int id = content != null ? content.Title.Id : 0;
            string url;

            url = System.Web.VirtualPathUtility.ToAbsolute("~/Wiki/Default.aspx?pid=" + ProjectId + "&i=" + id + "&p=" + slug);
            return string.Format(LinkFormat, attributeEncode(url), htmlEncode(input));
        }
    }
}