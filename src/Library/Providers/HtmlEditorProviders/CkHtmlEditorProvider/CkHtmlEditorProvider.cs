using System;
using System.Web.UI.WebControls;

namespace BugNET.Providers.HtmlEditorProviders
{
    /// <summary>
    /// 
    /// </summary>
    public class CkHtmlEditorProvider : HtmlEditorProvider
    {
        private readonly CKEditor.NET.CKEditorControl _textbox = new CKEditor.NET.CKEditorControl();
        private string _providerPath = string.Empty;

        /// <summary>
        /// Gets the HTML editor.
        /// </summary>
        /// <value>The HTML editor.</value>
        public override System.Web.UI.Control HtmlEditor
        {
            get { return _textbox; }
        }

        /// <summary>
        /// Gets or sets the width.
        /// </summary>
        /// <value>The width.</value>
        public override Unit Width
        {
            get { return _textbox.Width; }
            set { _textbox.Width = value; }
        }

        /// <summary>
        /// Gets or sets the height.
        /// </summary>
        /// <value>The height.</value>
        public override Unit Height
        {
            get { return _textbox.Height; }
            set { _textbox.Height = value; }
        }

        /// <summary>
        /// Gets or sets the text.
        /// </summary>
        /// <value>The text.</value>
        public override string Text
        {
            get { return _textbox.Text; }
            set { _textbox.Text = value; }
        }

        /// <summary>
        /// Gets or sets the control id.
        /// </summary>
        /// <value>The control id.</value>
        public override string ControlId
        {
            get { return _textbox.ID; }
            set { _textbox.ID = value; }
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
                throw new ArgumentNullException("config", "You must supply a valid configuration dictionary.");

            if (string.IsNullOrEmpty(config["description"]))
            {
                config.Remove("description");
                config.Add("description", "CKEditorHTMLEditorProvider");
            }

            //Let ProviderBase perform the basic initialization
            base.Initialize(name, config);
          

            //Perform feature-specific provider initialization here
            //A great deal more error checking and handling should exist here

            _providerPath = "" + config["providerPath"];
            _providerPath = System.Web.VirtualPathUtility.ToAbsolute(_providerPath.Trim().Replace("\\", "/"));
            if (!_providerPath.EndsWith("/"))
                _providerPath += "/";
               
            var text = config["Text"];
            Text = !String.IsNullOrEmpty(text) ? text : "";

            var height = config["Height"];
            Height = !String.IsNullOrEmpty(height) ? Unit.Parse(height) : Unit.Pixel(300);

            var width = config["Width"];
            Width = !String.IsNullOrEmpty(width) ? Unit.Parse(width) : Unit.Pixel(500);

            if (config["Toolbar"] != null)
                _textbox.Toolbar = config["Toolbar"];

            if (config["EditorSkin"] != null)
                _textbox.Skin = _textbox.Skin + "editor/skins/" + config["EditorSkin"] + "/";
            
            //CkEditor.CkEditorJS = _providerPath + "ckeditor.js";
            _textbox.BasePath = _providerPath;
            _textbox.CssClass = "form-control";

            //textbox.SkinPath = "skins/silver/";
            //textbox.ToolbarSet = "Default";
        }
    }
}
