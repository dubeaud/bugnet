using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using BugNET.BLL;
using BugNET.Common;
using BugNET.UserInterfaceLayer;

namespace BugNET.Administration.Users
{
    public partial class EditUser : BasePage
    {
        private static readonly List<AdminMenuItem> MenuItems = new List<AdminMenuItem>();

        /// <summary>
        /// Gets or sets the admin menu id.
        /// </summary>
        /// <value>The admin menu id.</value>
        int AdminMenuId
        {
            get { return ViewState.Get("AdminMenuId", 0); }
            set { ViewState.Set("AdminMenuId", value); }
        }

        /// <summary>
        /// Gets the tab id.
        /// </summary>
        /// <value>The tab id.</value>
        int QueryTabId
        {
            get { return Request.QueryString.Get("tabid", 0); }
        }

        /// <summary>
        /// Gets the user id.
        /// </summary>
        /// <value>The user id.</value>
        Guid UserId
        {
            get
            {
                var userId = Request.QueryString.Get("user", "");

                if (!userId.Equals(""))
                {
                    Guid userGuid;

                    if (Guid.TryParse(userId, out userGuid))
                        return userGuid;

                    throw new Exception(LoggingManager.GetErrorMessageResource("QueryStringError"));
                }

                return Guid.Empty;
            }
        }

        /// <summary>
        /// Loads the admin control.
        /// </summary>
        /// <param name="selectedMenuItem">The selected menu item id.</param>
        /// <param name="loadControl">Flag to indicate if the control should be loaded or not</param>
        void DisplayAdminControl(int selectedMenuItem, bool loadControl = true)
        {
            AdminMenuId = selectedMenuItem;

            foreach (var adminMenuItem in MenuItems)
            {
                var control = pnlAdminControls.FindControl(adminMenuItem.Argument) as IEditUserControl;

                if (control == null) continue;

                control.Action += EditUserAction;

                if (!loadControl) continue;

                control.Visible = false;
                var htmlControl = AdminMenu.Items[adminMenuItem.Id].FindControl("ListItem") as HtmlGenericControl;

                if (htmlControl != null) 
                    htmlControl.Attributes.Add("class", "");

                if (selectedMenuItem != adminMenuItem.Id) continue;

                if (htmlControl != null)
                    htmlControl.Attributes.Add("class", "active");

                control.Visible = true;
                control.UserId = UserId;
                control.Initialize();
            }
        }

        /// <summary>
        /// Events raised from the user specific user controls to the parent
        /// </summary>
        /// <param name="sender">The object sending the event</param>
        /// <param name="args">Arguments sent from the parent</param>
        void EditUserAction(object sender, ActionEventArgs args)
        {
            switch (args.Trigger)
            {
                case ActionTriggers.Save:
                    if (UserId != Guid.Empty)
                    {
                        var user = UserManager.GetUser(UserId);
                        litUserTitleName.Text = UserManager.GetUserDisplayName(user.UserName);
                    }
                    break;
            }
        }

        void LoadAdminMenuItems()
        {
            MenuItems.Clear();

            MenuItems.Add(new AdminMenuItem { Id = 0, Text = GetLocalResourceObject("UserDetails").ToString(), Argument = "UserDetails", ImageUrl = "vcard.gif" });
            MenuItems.Add(new AdminMenuItem { Id = 1, Text = GetLocalResourceObject("UserRoles").ToString(), Argument = "UserRoles", ImageUrl = "shield.gif" });
            MenuItems.Add(new AdminMenuItem { Id = 2, Text = GetLocalResourceObject("UserPassword").ToString(), Argument = "UserPassword", ImageUrl = "key.gif" });
            MenuItems.Add(new AdminMenuItem { Id = 3, Text = GetLocalResourceObject("UserProfile").ToString(), Argument = "UserProfile", ImageUrl = "user.gif" });
            MenuItems.Add(new AdminMenuItem { Id = 4, Text = GetLocalResourceObject("UserDelete").ToString(), Argument = "UserDelete", ImageUrl = "user_delete.gif" });

            AdminMenu.DataSource = MenuItems;
            AdminMenu.DataBind();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!UserManager.HasPermission(ProjectId, Common.Permission.AdminEditProject.ToString()))
                Response.Redirect("~/Errors/AccessDenied.aspx");

            if (UserId != Guid.Empty)
            {
                var user = UserManager.GetUser(UserId);
                litUserTitleName.Text = UserManager.GetUserDisplayName(user.UserName);
            }

            if (!Page.IsPostBack)
            {
                LoadAdminMenuItems();
                DisplayAdminControl(QueryTabId);
                return;
            }

            DisplayAdminControl(AdminMenuId, false);
        }

        protected void AdminMenuItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType != ListItemType.Item && e.Item.ItemType != ListItemType.AlternatingItem) return;

            var menuItem = e.Item.DataItem as AdminMenuItem;

            var listItem = e.Item.FindControl("ListItem") as HtmlGenericControl;
            var menuButton = e.Item.FindControl("MenuButton") as LinkButton;

            if (menuButton != null)
            {
                menuButton.Text = menuItem.Text;
                menuButton.Attributes.Add("data-menu-id", menuItem.Id.ToString());
            }
        }

        protected void AdminMenuItemCommand(object source, RepeaterCommandEventArgs e)
        {
            var menuButton = e.Item.FindControl("MenuButton") as LinkButton;

            if (menuButton != null)
            {
                DisplayAdminControl(menuButton.Attributes["data-menu-id"].To<int>());
            } 
        }
    }
}