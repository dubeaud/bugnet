
namespace BugNET.UserInterfaceLayer.Wiki
{
    using System;
    using System.Collections.Generic;
    using WikiPlex.Formatting.Renderers;
    using BugNET.BLL;
    using BugNET.Entities;

    public class IssueLinkRenderer : Renderer
    {
        private const string LinkFormat = "<a href=\"{0}\">{1}</a>";

        /// <summary>
        /// Initializes a new instance of the <see cref="TitleLinkRenderer"/> class.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        public IssueLinkRenderer() 
        {

        }

        /// <summary>
        /// Gets the collection of scope names for this <see cref="T:WikiPlex.Formatting.Renderers.IRenderer"/>.
        /// </summary>
        /// <value></value>
        protected override ICollection<string> ScopeNames
        {
            get { return new[] {WikiScopeName.IssueLink}; }
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
            string title;
            string id = input.Substring(input.LastIndexOf("-") + 1);
            Issue issue = IssueManager.GetById(Convert.ToInt32(id));

            if(issue != null)
            {
                if (input.Contains("|"))
                {
                    title = input.Substring(input.LastIndexOf(":") + 1, (input.LastIndexOf("|") - 1) - input.LastIndexOf(":"));
                }
                else
                {
                     title = issue.Title;
                }
            }
            else
            {
                return "<span class=\"unresolved\">Cannot resolve issue macro, invalid id.</span>";
            }
             
            string url = System.Web.VirtualPathUtility.ToAbsolute("~/Issues/IssueDetail.aspx?id=" + id);
            return string.Format(LinkFormat, attributeEncode(url), htmlEncode(title));
        }
    }
}