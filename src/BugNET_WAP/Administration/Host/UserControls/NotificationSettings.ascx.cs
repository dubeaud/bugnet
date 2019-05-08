using System;
using System.Linq;
using BugNET.BLL;
using BugNET.Common;
using BugNET.UserInterfaceLayer;

namespace BugNET.Administration.Host.UserControls
{
    public partial class NotificationSettings : System.Web.UI.UserControl, IEditHostSettingControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        #region IEditHostSettingControl Members

        /// <summary>
        /// Updates this instance.
        /// </summary>
        public bool Update()
        {
            HostSettingManager.UpdateHostSetting(HostSettingNames.AdminNotificationUsername, AdminNotificationUser.SelectedValue);
            return true;
        }

        /// <summary>
        /// Inits this instance.
        /// </summary>
        public void Initialize()
        {
            var users = UserManager.GetAllUsers();
            AdminNotificationUser.DataSource = users;
            AdminNotificationUser.DataTextField = "DisplayName";
            AdminNotificationUser.DataValueField = "UserName";
            AdminNotificationUser.DataBind();

            var adminNotifyUsername = HostSettingManager.Get(HostSettingNames.AdminNotificationUsername);

            if (users.SingleOrDefault(u => u.UserName == adminNotifyUsername) != null)
            { 
                AdminNotificationUser.SelectedValue = adminNotifyUsername;
            }
        }

        #endregion
    }
}