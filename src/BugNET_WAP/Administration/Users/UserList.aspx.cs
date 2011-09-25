using System;
using System.Collections.Generic;
using System.Web.UI.WebControls;
using BugNET.BLL;
using BugNET.Common;
using BugNET.Providers.MembershipProviders;
using BugNET.UserInterfaceLayer;

namespace BugNET.Administration.Users
{
	/// <summary>
	/// Summary description for UserList.
	/// </summary>
	public partial class UserList : BasePage
	{

        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
		protected void Page_Load(object sender, System.EventArgs e)
		{
            if (!UserManager.IsInRole(Globals.SUPER_USER_ROLE) && !UserManager.IsInRole("Project Administrators"))
                Response.Redirect("~/Errors/AccessDenied.aspx");

            if (!IsPostBack)
            {
                CreateLetterSearch();
                BindData(string.Empty);
            }
		}


        /// <summary>
        /// Creates the letter search.
        /// </summary>
        private void CreateLetterSearch()
        {
            string[] Alphabet = { "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "All", "Unauthorized" };
            LetterSearch.DataSource = Alphabet;
            LetterSearch.DataBind();
        }

        /// <summary>
        /// Handles the RowCommand event of the gvUsers control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="T:System.Web.UI.WebControls.GridViewCommandEventArgs"/> instance containing the event data.</param>
        protected void gvUsers_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            switch (e.CommandName)
            {
                case "Edit":
                    Response.Redirect(string.Format("~/Administration/Users/ManageUser.aspx?user={0}", e.CommandArgument.ToString()));
                    break;
                case "ManageRoles":
                    Response.Redirect(string.Format("~/Administration/Users/ManageUser.aspx?user={0}&tabid=2", e.CommandArgument.ToString()));
                    break;
                case "Delete":
                    Response.Redirect(string.Format("~/Administration/Users/ManageUser.aspx?user={0}&tabid=4", e.CommandArgument.ToString()));
                    break;
            }

        }

        /// <summary>
        /// Gets or sets the search filter.
        /// </summary>
        /// <value>The search filter.</value>
        protected string SearchFilter
        {
            get { return (string)ViewState["SearchFilter"]; }
            set { ViewState["SearchFilter"] = value; }
        }

        /// <summary>
        /// Binds the data.
        /// </summary>
        /// <param name="filter">The filter.</param>
        private void BindData(string filter)
        {
            SearchFilter = filter;
            string SearchText = SearchFilter;
            switch (filter)
            {
                case "All":
                    SearchText = string.Empty;
                    break;
                case "Unauthorized":
                    SearchText = string.Empty;
                    break;
                default:
                    SearchText = filter + "%";
                    break;
            }
            List<CustomMembershipUser> users;
            if (String.IsNullOrEmpty(SearchText))
            {
                users = UserManager.GetAllUsers();
            }
            else
            {
                users = UserManager.FindUsersByName(SearchText);
            }

            if (filter == "Unauthorized")
            {
                List<CustomMembershipUser> UnauthenticatedUsers = new List<CustomMembershipUser>();
                foreach (CustomMembershipUser user in users)
                {
                    if (!user.IsApproved || user.LastLoginDate == DateTime.MinValue)
                        UnauthenticatedUsers.Add(user);
                }
                users = UnauthenticatedUsers;
            }

            //users.Sort(new UserComparer(SortField, SortAscending)); //TODO Fix this.
            gvUsers.DataSource = users;
            gvUsers.DataBind();

        }
        /// <summary>
        /// Filters the URL.
        /// </summary>
        /// <param name="filter">The filter.</param>
        /// <param name="currentPage">The current page.</param>
        protected string FilterUrl(object filter, string currentPage)
        {
            string f = (string)filter;
            string url = Page.TemplateControl.AppRelativeVirtualPath;
            if (!String.IsNullOrEmpty(f))
            {
                url = string.Format("{0}?Filter={1}", url, f);
            }
            return this.ResolveUrl(url);
        }

        /// <summary>
        /// Handles the Click event of the FilterButton control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="T:System.EventArgs"/> instance containing the event data.</param>
        protected void FilterButton_Click(object sender, EventArgs e)
        {
            LinkButton lb = (LinkButton)sender;
            BindData(lb.CommandArgument.ToString());
        }

        /// <summary>
        /// Handles the RowCreated event of the gvUsers control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.GridViewRowEventArgs"/> instance containing the event data.</param>
        protected void gvUsers_RowCreated(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                PresentationUtils.SetSortImageStates(gvUsers, e.Row, 1, SortField, SortAscending);
            }
        }
       

        /// <summary>
        /// Gets or sets the sort field.
        /// </summary>
        /// <value>The sort field.</value>
        string SortField
        {
            get
            {
                object o = ViewState["SortField"];
                if (o == null)
                {
                    return String.Empty;
                }
                return (string)o;
            }

            set
            {
                if (value == SortField)
                {
                    // same as current sort file, toggle sort direction
                    SortAscending = !SortAscending;
                }
                ViewState["SortField"] = value;
            }
        }

        /// <summary>
        /// Gets or sets a value indicating whether [sort ascending].
        /// </summary>
        /// <value><c>true</c> if [sort ascending]; otherwise, <c>false</c>.</value>
        bool SortAscending
        {
            get
            {
                object o = ViewState["SortAscending"];
                if (o == null)
                {
                    return true;
                }
                return (bool)o;
            }

            set
            {
                ViewState["SortAscending"] = value;
            }
        }


        /// <summary>
        /// Handles the Sorting event of the gvUsers control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.GridViewSortEventArgs"/> instance containing the event data.</param>
        protected void gvUsers_Sorting(object sender, GridViewSortEventArgs e)
        {
            SortField = e.SortExpression;
            BindData(SearchFilter);
        }

        /// <summary>
        /// Handles the Click event of the AddUser control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="T:System.EventArgs"/> instance containing the event data.</param>
        protected void AddUser_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Administration/Users/AddUser.aspx");
        }

        /// <summary>
        /// Handles the Click event of the ibSearch control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="T:System.EventArgs"/> instance containing the event data.</param>
        protected void ibSearch_Click(object sender, EventArgs e)
        {
            List<CustomMembershipUser> users;
            if (SearchField.SelectedValue == "Email")
            {
                users = UserManager.FindUsersByEmail(txtSearch.Text + "%");
            }
            else
            {
                users = UserManager.FindUsersByName(txtSearch.Text + "%");
            }
            gvUsers.DataSource = users;
            gvUsers.DataBind();
        }

        /// <summary>
        /// Handles the PageIndexChanging event of the gvUsers control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="T:System.Web.UI.WebControls.GridViewPageEventArgs"/> instance containing the event data.</param>
        protected void gvUsers_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvUsers.PageIndex = e.NewPageIndex;
            BindData(SearchFilter);
        }

        /// <summary>
        /// Handles the SelectedIndexChanged event of the ddlPages control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void ddlPages_SelectedIndexChanged(Object sender, EventArgs e)
        {
            GridViewRow gvrPager = gvUsers.BottomPagerRow;
            if (gvrPager == null)
                return;
            DropDownList ddlPages = (DropDownList)gvrPager.Cells[0].FindControl("ddlPages");
            gvUsers.PageIndex = ddlPages.SelectedIndex;
            BindData(SearchFilter);
        }

	}
}
