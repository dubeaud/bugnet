using System;
using System.Web.UI.WebControls;
using BugNET.BLL;
using BugNET.BLL.Notifications;
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
          
                string notificationTypes = string.Empty;

                foreach (ListItem li in cblNotificationTypes.Items)
                {
                    if (li.Selected)
                        notificationTypes += li.Value + ";";

                }
                notificationTypes = notificationTypes.TrimEnd(';');
                
                HostSettingManager.UpdateHostSetting("EnabledNotificationTypes",notificationTypes);
                HostSettingManager.UpdateHostSetting("AdminNotificationUsername", AdminNotificationUser.SelectedValue);
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

            string[] notificationTypes = HostSettingManager.GetHostSetting("EnabledNotificationTypes").Split(';');
            foreach (string s in notificationTypes)
            {
                ListItem currentCheckBox = cblNotificationTypes.Items.FindByText(s);
                if (currentCheckBox != null)
                    currentCheckBox.Selected = true;
            }

            AdminNotificationUser.DataSource = UserManager.GetAllUsers();
            AdminNotificationUser.DataTextField = "DisplayName";
            AdminNotificationUser.DataValueField = "UserName";
            AdminNotificationUser.DataBind();
            AdminNotificationUser.SelectedValue = HostSettingManager.GetHostSetting("AdminNotificationUsername");
        }

        #endregion
    }
}