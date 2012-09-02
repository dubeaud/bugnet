using System.Configuration.Provider;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BugNET.Providers.HtmlEditorProviders
{
    /// <summary>
    /// 
    /// </summary>
    public abstract class HtmlEditorProvider : ProviderBase
    {
        /// <summary>
        /// 
        /// </summary>
        public abstract Control HtmlEditor { get; }

        /// <summary>
        /// 
        /// </summary>
        public abstract Unit Width { get; set; }

        /// <summary>
        /// 
        /// </summary>
        public abstract Unit Height { get; set; }

        /// <summary>
        /// 
        /// </summary>
        public abstract string Text { get; set; }

        /// <summary>
        /// 
        /// </summary>
        public abstract string ControlId { get; set; }

        /// <summary>
        /// 
        /// </summary>
        public abstract string ProviderPath { get; }
    }
}