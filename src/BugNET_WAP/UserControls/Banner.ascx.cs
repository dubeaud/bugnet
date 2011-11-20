namespace BugNET.UserControls
{
    using System;
    using System.Web;
    using System.Web.UI.WebControls;
    using BugNET.BLL;
    using BugNET.Common;
    using BugNET.UserInterfaceLayer.WebControls;

    public partial class Banner : System.Web.UI.UserControl
    {

        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="T:System.EventArgs"/> instance containing the event data.</param>
        protected void Page_Load(object sender, EventArgs e)
        {
            //hide user registration if disabled in host settings
            if (!Page.User.Identity.IsAuthenticated && Convert.ToInt32(HostSettingManager.Get(HostSettingNames.UserRegistration)) == (int)Globals.UserRegistration.None)
            {
                if (LoginView1.FindControl("lnkRegister") != null)
                    LoginView1.FindControl("lnkRegister").Visible = false;
                if (LoginView1.FindControl("lblBar") != null)
                    LoginView1.FindControl("lblBar").Visible = false;
            }
            
            //add so the login/logout link would be hidden for someone using windows authentication
            if (HttpContext.Current.User.Identity.AuthenticationType == "Negotiate")
            {
                if (LoginView1.FindControl("LoginStatus1") != null)
                    LoginView1.FindControl("LoginStatus1").Visible = false;
                if (LoginView1.FindControl("lblBar") != null)
                    LoginView1.FindControl("lblBar").Visible = false;
            }

            // Make the search panel invisible to anonymous users if set in Host Settings
            if (!Page.User.Identity.IsAuthenticated && !Boolean.Parse(HostSettingManager.Get(HostSettingNames.AnonymousAccess)))
                Panel1.Visible = false;


            AppTitle.Text = HostSettingManager.Get(HostSettingNames.ApplicationTitle);
            ddlProject.DataTextField = "Name";
            ddlProject.DataValueField = "Id";

            if (!Page.IsPostBack)
            { 
                if (Page.User.Identity.IsAuthenticated)
                {
                    ddlProject.DataSource = ProjectManager.GetByMemberUserName(Security.GetUserName(), true);
                    ddlProject.DataBind();
                    ddlProject.Items.Insert(0, new ListItem(GetLocalResourceObject("SelectProject").ToString()));
                }
                else if (!Page.User.Identity.IsAuthenticated && Boolean.Parse(HostSettingManager.Get(HostSettingNames.AnonymousAccess)))
                {
                    ddlProject.DataSource = ProjectManager.GetPublicProjects();
                    ddlProject.DataBind();
                    ddlProject.Items.Insert(0, new ListItem(GetLocalResourceObject("SelectProject").ToString()));
                }
                else
                {
                    pnlHeaderNav.Visible = false;
                }
                   
                if (Request.QueryString["pid"] != null)
                {
                    try
                    {
                        ddlProject.SelectedValue = Request.QueryString["pid"].ToString();
                    }
                    catch { }
                }

                BindMenuOptions();

              
            }
            this.LoginView1.DataBind();
        }

        /// <summary>
        /// Binds the menu options.
        /// </summary>
        private void BindMenuOptions()
        {
            SuckerFishMenuHelper oHelper = new SuckerFishMenuHelper(ProjectId);
            litSucker.Text = oHelper.GetHtml();
        }

        /// <summary>
        /// Retrieves the project Id from the base page class
        /// </summary>
        public int ProjectId
        {
            get
            {
                try
                {
                    // do the as test to to see if the basepage is the same as page
                    // if not the page parameter will be null and no exception will bethrown
                    BugNET.UserInterfaceLayer.BasePage page = this.Page as BugNET.UserInterfaceLayer.BasePage;

                    if (page != null)
                    {
                        return page.ProjectId;
                    }
                    else
                    {
                        return -1;
                    }
                }
                catch
                {
                    return -1;
                }
            }
        }

        /// <summary>
        /// Gets the display name.
        /// </summary>
        /// <value>The display name.</value>
        protected string DisplayName
        {
            get
            {
                WebProfile Profile = new WebProfile().GetProfile(Page.User.Identity.Name);
                return Profile.DisplayName;
            }
        }

        /// <summary>
        /// Handles the Click event of the Profile control.
        /// </summary>
        /// <param name="s">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void Profile_Click(object s, EventArgs e)
        {
            Response.Redirect(string.Format("~/Account/UserProfile.aspx?referrerurl={0}", Request.RawUrl));
        }

        /// <summary>
        /// Handles the SelectedIndexChanged event of the ddlProject control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void ddlProject_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlProject.SelectedIndex != 0)
                Response.Redirect(string.Format("~/Projects/ProjectSummary.aspx?pid={0}", ddlProject.SelectedValue));
        }

        /// <summary>
        /// Handles the Click event of the btnSearch control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="T:System.EventArgs"/> instance containing the event data.</param>
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            // Stewart Moss
            // Apr 9 2010 
            //
            // Some code improvements to reduce errors on searching using the quick find box.
            // Also new feature to recognize a BugNet IssueID and try to search on that.
            // eg "AGN-123 or BUGNET-12 or B-9912"

            string strsearch = txtIssueId.Text.Trim();
            bool validflag = false;
            if (strsearch.Length != 0)
            {
                // turn off the error message
                this.QuickError.Visible = false;
                int IssueId = -1;
                try
                {
                    // First check.. Is this an integer?
                   IssueId= int.Parse(strsearch);
                    validflag = true;
                }
                catch
                {
                    // Not an integer.
                    //
                    // Test if the search box contain a valid BUGNET reference number 
                    // eg "AGN-123 or BUGNET-12 or B-9912"

                    if (strsearch.Contains("-"))
                    {
                        try
                        {
                            IssueId= int.Parse(strsearch.Substring(strsearch.IndexOf('-')+1));
                            validflag = true;
                        }
                        catch
                        {
                            // the invalid flag is already set
                        }
                    }

                    if (!validflag)
                    {
                        // Display secondary search error
                        this.QuickError.Visible = true;
                        this.QuickError.Text = "Enter a number or a BugNet ID.";
                        return;
                    }
                }

                // zero is a reserved ID
                if (IssueId == 0)
                {                    
                    validflag = false;
                }

                if (validflag)
                {
                    //if (IssueManager.IsValidId(IssueId))
                    //{
                    //    Response.Redirect(string.Format("~/Issues/IssueDetail.aspx?&id={0}", IssueId.ToString()));
                    //}
                    //else validflag = false;
                }

                if (!validflag)
                {
                    // Display primary search error
                    this.QuickError.Visible = true;
                    this.QuickError.Text = "Invalid Issue ID";
                }
            }
        }
    }
}