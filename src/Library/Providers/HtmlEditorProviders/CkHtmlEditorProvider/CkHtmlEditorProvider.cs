using System;
using System.Web.UI.WebControls;

namespace BugNET.Providers.HtmlEditorProviders
{
    public class CkHtmlEditorProvider : HtmlEditorProvider
    {
        private CKEditor.NET.CKEditorControl textbox = new CKEditor.NET.CKEditorControl();
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
            get { return textbox.Text; }
            set { textbox.Text = value; }
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

            if (config["Toolbar"] != null)
                textbox.Toolbar = config["Toolbar"];

            if (config["EditorSkin"] != null)
                textbox.Skin = textbox.Skin + "editor/skins/" + config["EditorSkin"] + "/";
            
            //CkEditor.CkEditorJS = _providerPath + "ckeditor.js";
            textbox.BasePath = _providerPath;

            //textbox.SkinPath = "skins/silver/";
            //textbox.ToolbarSet = "Default";

            ////Get the connection string
            //string connectionStringName = config["connectionStringName"];
            //if (String.IsNullOrEmpty(connectionStringName))
            //    throw new ProviderException("You must specify a connectionStringName attribute.");

            //ConnectionStringsSection cs =
            //    (ConnectionStringsSection)ConfigurationManager.GetSection("connectionStrings");
            //if (cs == null)
            //    throw new ProviderException("An error occurred retrieving the connection strings section.");

            //if (cs.ConnectionStrings[connectionStringName] == null)
            //    throw new ProviderException("The connection string could not be found in the connection strings section.");
            //else
            //    connectionString = cs.ConnectionStrings[connectionStringName].ConnectionString;

            //if (String.IsNullOrEmpty(connectionString))
            //    throw new ProviderException("The connection string is invalid.");
            //config.Remove("connectionStringName");

            ////Check to see if unexpected attributes were set in configuration
            //if (config.Count > 0)
            //{
            //    string extraAttribute = config.GetKey(0);
            //    if (!String.IsNullOrEmpty(extraAttribute))
            //        throw new ProviderException("The following unrecognized attribute was found in " + Name + "'s configuration: '" +
            //                                    extraAttribute + "'");
            //    else
            //        throw new ProviderException("An unrecognized attribute was found in the provider's configuration.");
            //}
        }
     
    }
}
