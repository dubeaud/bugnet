using System;
using System.Linq;
using System.Web.UI.WebControls;
using BugNET.BLL;
using BugNET.BLL.Notifications;
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
          
            var notificationTypes = cblNotificationTypes.Items.Cast<ListItem>().Where(li => li.Selected).Aggregate(string.Empty, (current, li) => current + (li.Value + ";"));

            notificationTypes = notificationTypes.TrimEnd(';');
                
            HostSettingManager.UpdateHostSetting(HostSettingNames.EnabledNotificationTypes,notificationTypes);
            HostSettingManager.UpdateHostSetting(HostSettingNames.AdminNotificationUsername, AdminNotificationUser.SelectedValue);
            return true;
        }

        /// <summary>
        /// Inits this instance.
        /// </summary>
        public void Initialize()
        {
            cblNotificationTypes.DataSource = NotificationManager.Instance.GetNotificationTypes();
            cblNotificationTypes.DataTextField = "Name";
            cblNotificationTypes.DataValueField = "Name";
            cblNotificationTypes.DataBind();

            var notificationTypes = HostSettingManager.Get(HostSettingNames.EnabledNotificationTypes).Split(';');
            foreach (var currentCheckBox in notificationTypes.Select(s => cblNotificationTypes.Items.FindByText(s)).Where(currentCheckBox => currentCheckBox != null))
            {
                currentCheckBox.Selected = true;
            }

            AdminNotificationUser.DataSource = UserManager.GetAllUsers();
            AdminNotificationUser.DataTextField = "DisplayName";
            AdminNotificationUser.DataValueField = "UserName";
            AdminNotificationUser.DataBind();
            AdminNotificationUser.SelectedValue = HostSettingManager.Get(HostSettingNames.AdminNotificationUsername);
        }

        #endregion
    }
}