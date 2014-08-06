using System;
using BugNET.BLL;
using BugNET.Entities;

namespace BugNET.SvnBrowse
{
	/// <summary>
	/// Summary description for BrowseProject.
	/// </summary>
	public partial class SubversionBrowser : BugNET.UserInterfaceLayer.BasePage
	{
	
        protected string RepoUrl;

        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
		protected void Page_Load(object sender, System.EventArgs e)
		{
			// Put user code to initialize the page here
			if(!Page.IsPostBack)
			{
                //get project id
                if (Request.QueryString["pid"] != null)
                {
                    ProjectId = Convert.ToInt32(Request.QueryString["pid"]);
                    Project proj = ProjectManager.GetById(ProjectId);
                    RepoUrl = proj.SvnRepositoryUrl;

                    if (string.IsNullOrEmpty(RepoUrl))
                    {
                        RepoUrl = "NoSvnUrl.html";
                    }
                }
                else
                {
                    RepoUrl = "NoSvnUrl.html";
                }
			}
		}
        


		#region Web Form Designer generated code
        /// <summary>
        /// Overrides the default OnInit to provide a security check for pages
        /// </summary>
        /// <param name="e"></param>
		override protected void OnInit(EventArgs e)
		{
			//
			// CODEGEN: This call is required by the ASP.NET Web Form Designer.
			//
			InitializeComponent();
			base.OnInit(e);
		}
		
		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{    	
		
		}

     
		#endregion

	}
}
