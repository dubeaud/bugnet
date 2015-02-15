using BugNET.Common;

namespace BugNET.UserControls
{
	using System;

    /// <summary>
    /// This user control displays either text or an image with the text as
    /// alt text depending on whether an image is supplied. This control
    /// is used in the DisplayIssues.ascx control to display priorities, status
    /// values, and milestones.
	/// </summary>
	public partial class TextImage : System.Web.UI.UserControl
	{
        /// <summary>
        /// Gets or sets the text.
        /// </summary>
        /// <value>The text.</value>
		public string Text 
		{
			get { return ViewState.Get("Text", string.Empty); }
            set { ViewState.Set("Text", value); }
		}

        public string ImageDirectory
        {
            get { return ViewState.Get("ImageDirectory", string.Empty); }
            set { ViewState.Set("ImageDirectory", value); }
        }

        /// <summary>
        /// Gets or sets the image URL.
        /// </summary>
        /// <value>The image URL.</value>
		public string ImageUrl 
		{
			get { return ViewState.Get("ImageUrl", string.Empty); }
            set { ViewState.Set("ImageUrl", value); }
		}

        /// <summary>
        /// Handles the PreRender event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
		protected void Page_PreRender(object sender, EventArgs e) 
		{
			if (ImageUrl != String.Empty) 
			{
				ctlImage.ImageUrl = string.Format("~/Images{0}/{1}", ImageDirectory, ImageUrl);
				ctlImage.ToolTip = Text;
                ctlImage.AlternateText = Text;
			} 
			else 
			{
				ctlImage.Visible = false;
				lblText.Visible = true;
				lblText.Text = Text;
			}
		}
	}
}
