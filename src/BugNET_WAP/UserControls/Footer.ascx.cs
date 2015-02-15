using System;

namespace BugNET.UserControls
{
    /// <summary>
    /// Footer user control
    /// </summary>
    public partial class Footer : System.Web.UI.UserControl
    {
        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="T:System.EventArgs"/> instance containing the event data.</param>
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!Page.IsPostBack)
                Version.Text = String.Format("{0}", System.Reflection.Assembly.GetExecutingAssembly().GetName().Version.ToString());
        }
    }
}