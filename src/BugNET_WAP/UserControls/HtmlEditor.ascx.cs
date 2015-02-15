using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using BugNET.Providers.HtmlEditorProviders;
using log4net;

namespace BugNET.UserControls
{
    [ValidationPropertyAttribute("Text")]
    public partial class HtmlEditor : System.Web.UI.UserControl
    {
        private HtmlEditorProvider p;
        private Unit _height = Unit.Empty;
        private Unit _width = Unit.Empty;
        private static readonly ILog Log = LogManager.GetLogger(typeof(HtmlEditor));

        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void Page_Load(object sender, EventArgs e)
        {
         
        }

         /// <summary>
         /// Raises the <see cref="E:System.Web.UI.Control.Init"/> event.
         /// </summary>
         /// <param name="e">An <see cref="T:System.EventArgs"/> object that contains the event data.</param>
         protected override void OnInit(EventArgs e) 
         {
             try
             {
                 p = HtmlEditorManager.Provider;
                 p.ControlId = this.ID;
            
                 if (_height != Unit.Empty)
                     p.Height = _height;
                 if (_width != Unit.Empty)
                     p.Width = _width;

                 this.Controls.Add(p.HtmlEditor);
             }
             catch (Exception ex)
             {
                 Log.Error(this, new Exception(string.Format("An error occurred initializing the HtmlEditorProvider: {0} \n\n {1}", ex.Message, ex.StackTrace)));
                 // Throw an exception now so you don't get exceptions when 
                 // other pages try to work with the control.
                 Response.Redirect("~/Errors/Error.aspx");
                 // throw new Exception("An error occurred initializing the HtmlEditorProvider. See log for details.");
             }          
        }
    

        /// <summary>
        /// Gets or sets the text.
        /// </summary>
        /// <value>The text.</value>
        public string Text
        {
            get
            {
                return p.Text;
            }
            set
            {
                p.Text = value;
            }
        }

        /// <summary>
        /// Gets or sets the height.
        /// </summary>
        /// <value>The height.</value>
        public  Unit Height
        {
            get
            {
                return _height;
            }
            set
            {
                _height = value;
            }
        }

        /// <summary>
        /// Gets or sets the width.
        /// </summary>
        /// <value>The width.</value>
        public Unit Width
        {
            get
            {
                return _width;
            }
            set
            {
                _width = value;
            }
        }
    }
}