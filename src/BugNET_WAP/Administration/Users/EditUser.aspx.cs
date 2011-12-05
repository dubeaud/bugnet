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
        private Control _contentControl;
        private static readonly Dictionary<string, string> MenuItems = new Dictionary<string, string>();

        /// <summary>
        /// Gets or sets the tab id.
        /// </summary>
        /// <value>The tab id.</value>
        int TabId
        {
            get { return ViewState.Get("TabId", 0); }
            set { ViewState.Set("TabId", value); }
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
        /// Loads the tab.
        /// </summary>
        /// <param name="selectedTab">The selected tab.</param>
        void LoadTab(int selectedTab)
        {
            var controlName = "Membership.ascx";
            TabId = selectedTab;

            switch (TabId)
            {
                case 0:
                    controlName = "Membership.ascx";
                    break;
                case 1:
                    controlName = "Roles.ascx";
                    break;
                case 2:
                    controlName = "Password.ascx";
                    break;
                case 3:
                    controlName = "Profile.ascx";
                    break;
                case 4:
                    controlName = "DeleteUser.ascx";
                    break;
            }

            LoadAdminMenuItems();

            for (var i = 0; i < MenuItems.Count; i++)
            {
                if (i == selectedTab)
                    ((HtmlGenericControl)AdminMenu.Items[i].FindControl("ListItem")).Attributes.Add("class", "on");
                else
                    ((HtmlGenericControl)AdminMenu.Items[i].FindControl("ListItem")).Attributes.Add("class", "off");
            }

            var controlPath = string.Format("~/Administration/Users/UserControls/{0}", controlName);

            _contentControl = Page.LoadControl(controlPath);
            _contentControl.ID = "ctlContent";
            plhContent.Controls.Clear();
            plhContent.Controls.Add(_contentControl);
            plhContent.Visible = true;

            var controlInterface = _contentControl as IEditUserControl;
            if (controlInterface == null) return;

            controlInterface.UserId = UserId;
            controlInterface.Initialize();
            controlInterface.Action += EditUserAction;
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
                case Globals.ActionTriggers.Save:
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

            MenuItems.Add(GetLocalResourceObject("UserDetails").ToString(), "vcard.gif");
            MenuItems.Add(GetLocalResourceObject("UserRoles").ToString(), "shield.gif");
            MenuItems.Add(GetLocalResourceObject("UserPassword").ToString(), "key.gif");
            MenuItems.Add(GetLocalResourceObject("UserProfile").ToString(), "user.gif");
            MenuItems.Add(GetLocalResourceObject("UserDelete").ToString(), "user_delete.gif");

            AdminMenu.DataSource = MenuItems;
            AdminMenu.DataBind();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!UserManager.HasPermission(ProjectId, Globals.Permission.AdminEditProject.ToString()))
                Response.Redirect("~/Errors/AccessDenied.aspx");

            if (UserId != Guid.Empty)
            {
                var user = UserManager.GetUser(UserId);
                litUserTitleName.Text = UserManager.GetUserDisplayName(user.UserName);
            }

            if (!Page.IsPostBack)
            {
                LoadTab(QueryTabId);
                return;
            }

            LoadTab(TabId);
        }

        protected void AdminMenuItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType != ListItemType.Item && e.Item.ItemType != ListItemType.AlternatingItem) return;

            var dataItem = (KeyValuePair<string, string>)e.Item.DataItem;
            var listItem = e.Item.FindControl("ListItem") as HtmlGenericControl;
            var lb = e.Item.FindControl("MenuButton") as LinkButton;
            if (listItem != null)
                listItem.Attributes.Add("style", string.Format("background: #C4EFA1 url(../../images/{0}) no-repeat 5px 4px;", dataItem.Value));
            if (lb != null) lb.Text = dataItem.Key;
        }

        protected void AdminMenuItemCommand(object source, RepeaterCommandEventArgs e)
        {
            TabId = e.Item.ItemIndex;
            LoadTab(TabId);
        }
    }
}