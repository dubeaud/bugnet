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


		#region Web Form Designer generated code
		override protected void OnInit(EventArgs e)
		{
			//
			// CODEGEN: This call is required by the ASP.NET Web Form Designer.
			//
			InitializeComponent();
			base.OnInit(e);
		}
		
		/// <summary>
		///		Required method for Designer support - do not modify
		///		the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{

		}
		#endregion

		public string ImageDirectory = String.Empty;

        /// <summary>
        /// Gets or sets the text.
        /// </summary>
        /// <value>The text.</value>
		public string Text 
		{
			get 
			{
				if (ViewState["Text"] == null)
					return String.Empty;
				else
					return (string)ViewState["Text"];
			}
			set {ViewState["Text"] = value; }
		}


        /// <summary>
        /// Gets or sets the image URL.
        /// </summary>
        /// <value>The image URL.</value>
		public string ImageUrl 
		{
			get 
			{
				if (ViewState["ImageUrl"] == null)
					return String.Empty;
				else
					return (string)ViewState["ImageUrl"];
			}
			set {ViewState["ImageUrl"] = value; }
		}


        /// <summary>
        /// Handles the PreRender event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
		protected void Page_PreRender(object sender, System.EventArgs e) 
		{
			if (ImageUrl != String.Empty) 
			{
				ctlImage.ImageUrl = "~/Images" + ImageDirectory + "/" + ImageUrl;
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
