using System;
using System.Web;
using System.Web.UI.WebControls;
using HtmlEditor = AjaxControlToolkit.HTMLEditor;

namespace BugNET.Providers.HtmlEditorProviders
{
    public class AjaxControlToolkitHtmlEditorProvider : HtmlEditorProvider
    {
        private HtmlEditor.Editor textbox = new HtmlEditor.Editor();
        private string _providerPath = string.Empty;

        /// <summary>
        /// Gets the HTML editor.
        /// </summary>
        /// <value>The HTML editor.</value>
        public override System.Web.UI.Control HtmlEditor
        {
            get { return textbox; }
        }

        /// <summary>
        /// Gets or sets the width.
        /// </summary>
        /// <value>The width.</value>
        public override System.Web.UI.WebControls.Unit Width
        {
            get { return textbox.Width; }
            set { textbox.Width = value; }
        }

        /// <summary>
        /// Gets or sets the height.
        /// </summary>
        /// <value>The height.</value>
        public override System.Web.UI.WebControls.Unit Height
        {
            get { return textbox.Height; }
            set { textbox.Height = value; }
        }

        /// <summary>
        /// Gets or sets the text.
        /// </summary>
        /// <value>The text.</value>
        public override string Text
        {
            get { return textbox.Content; }
            set { textbox.Content= value; }
        }

        /// <summary>
        /// Gets or sets the control id.
        /// </summary>
        /// <value>The control id.</value>
        public override string ControlId
        {
            get { return textbox.ID; }
            set { textbox.ID = value; }
        }


        /// <summary>
        /// Gets the provider path.
        /// </summary>
        /// <value>The provider path.</value>
        public override string ProviderPath
        {
            get { return _providerPath; }
        }

        /// <summary>
        /// Initializes the provider.
        /// </summary>
        /// <param name="name">The friendly name of the provider.</param>
        /// <param name="config">A collection of the name/value pairs representing the provider-specific attributes specified in the configuration for this provider.</param>
        /// <exception cref="T:System.ArgumentNullException">The name of the provider is null.</exception>
        /// <exception cref="T:System.ArgumentException">The name of the provider has a length of zero.</exception>
        /// <exception cref="T:System.InvalidOperationException">An attempt is made to call <see cref="M:System.Configuration.Provider.ProviderBase.Initialize(System.String,System.Collections.Specialized.NameValueCollection)"/> on a provider after the provider has already been initialized.</exception>
        public override void Initialize(string name, System.Collections.Specialized.NameValueCollection config)
        {
            if ((config == null) || (config.Count == 0))
                throw new ArgumentNullException("You must supply a valid configuration dictionary.");

            if (string.IsNullOrEmpty(config["description"]))
            {
                config.Remove("description");
                config.Add("description", "AjaxControlToolkitHTMLEditorProvider");
            }

            //Let ProviderBase perform the basic initialization
            base.Initialize(name, config);
          

            //Perform feature-specific provider initialization here
            //A great deal more error checking and handling should exist here
            _providerPath = "" + config["providerPath"];
            _providerPath = System.Web.VirtualPathUtility.ToAbsolute(_providerPath.Trim().Replace("\\", "/"));
            if (!_providerPath.EndsWith("/"))
                _providerPath += "/";
               
            string text = config["Text"];
            if (!String.IsNullOrEmpty(text))
                Text = text;
            else
                Text = "";

            string height = config["Height"];
            if (!String.IsNullOrEmpty(height))
                Height = Unit.Parse(height);
            else
                Height = Unit.Pixel(300);

            string width = config["Width"];
            if (!String.IsNullOrEmpty(width))
                Width = Unit.Parse(width);
            else
                Width = Unit.Pixel(500);

            
        }
     
    }
}
