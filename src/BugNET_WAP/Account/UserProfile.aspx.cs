using System;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI.WebControls;
using BugNET.BLL;
using BugNET.Common;
using BugNET.Entities;
using BugNET.UserInterfaceLayer;
using log4net;

namespace BugNET.Account
{
    /// <summary>
    /// 
    /// </summary>
    public partial class UserProfile : BasePage
    {
        private static readonly ILog Log = LogManager.GetLogger(typeof(UserProfile));

        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Page.IsPostBack) return;

            foreach (ListItem li in BulletedList4.Items)
                li.Attributes.Add("class", "off");

            BulletedList4.Items[0].Attributes.Add("class", "on");

            var resources = ResourceManager.GetInstalledLanguageResources();
            var resourceItems = (from code in resources let cultureInfo = new CultureInfo(code, false) select new ListItem(cultureInfo.DisplayName, code)).ToList();
            ddlPreferredLocale.DataSource = resourceItems;
            ddlPreferredLocale.DataBind();

            var membershipUser = UserManager.GetUser(User.Identity.Name);
            litUserName.Text = User.Identity.Name;
            FirstName.Text = WebProfile.Current.FirstName;
            LastName.Text = WebProfile.Current.LastName;
            FullName.Text = WebProfile.Current.DisplayName;
            ddlPreferredLocale.SelectedValue = WebProfile.Current.PreferredLocale;
            IssueListItems.SelectedValue = UserManager.GetProfilePageSize().ToString();
            AllowNotifications.Checked = WebProfile.Current.RecieveEmailNotifications;

            if (membershipUser == null) return;

            UserName.Text = membershipUser.UserName;
            Email.Text = membershipUser.Email;

            var isFromOpenIdRegistration = Request.Get("oid", false);

            if(isFromOpenIdRegistration)
            {
                Message1.ShowInfoMessage(GetLocalResourceObject("UpdateProfileForOpenId").ToString());
            }
        }

        /// <summary>
        /// Adds the user.
        /// </summary>
        /// <param name="s">The s.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void AddProjectNotification(Object s, EventArgs e)
        {
            //The users must be added to a list first because the collection can not
            //be modified while we iterate through it.
            var usersToAdd = lstAllProjects.Items.Cast<ListItem>().Where(item => item.Selected).ToList();

            foreach (var item in usersToAdd)
            {
                var notification = new ProjectNotification
                        {
                            ProjectId = Convert.ToInt32(item.Value),
                            NotificationUsername = Security.GetUserName()
                        };

                if (!ProjectNotificationManager.SaveOrUpdate(notification)) continue;

                lstSelectedProjects.Items.Add(item);
                lstAllProjects.Items.Remove(item);
            }

            lstSelectedProjects.SelectedIndex = -1;
        }

        /// <summary>
        /// Removes the user.
        /// </summary>
        /// <param name="s">The s.</param>
        /// <param name="e">The <see cref="T:System.EventArgs"/> instance containing the event data.</param>
        protected void RemoveProjectNotification(Object s, EventArgs e)
        {
            //The users must be added to a list first because the collection can not
            //be modified while we iterate through it.
            var usersToRemove = lstSelectedProjects.Items.Cast<ListItem>().Where(item => item.Selected).ToList();

            foreach (var item in usersToRemove)
            {
                if (!ProjectNotificationManager.Delete(Convert.ToInt32(item.Value), Security.GetUserName())) continue;
                lstAllProjects.Items.Add(item);
                lstSelectedProjects.Items.Remove(item);
            }

            lstAllProjects.SelectedIndex = -1;
        }


        /// <summary>
        /// Handles the Click event of the SavePasswordSettings control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void SavePasswordSettings_Click(object sender, EventArgs e)
        {

            var membershipUser = Membership.GetUser();
            var currentPassword = CurrentPassword.Text;
            var newPassword = NewPassword.Text;
            var securityQuestion = SecurityQuestion.Text;
            var securityAnswer = SecurityAnswer.Text;

            if (membershipUser == null) return;

            //Set the password
            try
            {
                var passwordChanged = membershipUser.ChangePassword(currentPassword, newPassword);
                var securityQuestionChanged = false;

                if (passwordChanged)
                {
                    Message2.ShowSuccessMessage(GetLocalResourceObject("PasswordChanged").ToString());

                    if (Log.IsInfoEnabled)
                    {
                        if (HttpContext.Current.User != null && HttpContext.Current.User.Identity.IsAuthenticated)
                            MDC.Set("user", HttpContext.Current.User.Identity.Name);
                        Log.Info("Password changed");
                    }

                    securityQuestionChanged = membershipUser.ChangePasswordQuestionAndAnswer(newPassword, securityQuestion, securityAnswer);

                }
                else
                {
                    if (Log.IsErrorEnabled)
                    {
                        if (HttpContext.Current.User != null && HttpContext.Current.User.Identity.IsAuthenticated)
                            MDC.Set("user", HttpContext.Current.User.Identity.Name);
                        Log.Error("Password update failure");
                    }

                    Message2.ShowErrorMessage(GetLocalResourceObject("PasswordChangeError").ToString());
                }
                if (securityQuestionChanged)
                {
                    Message2.ShowSuccessMessage("Security question was changed successfully");
                }
            }
            catch (Exception ex)
            {
                Message2.ShowSuccessMessage(ex.Message);
            }
        }

        protected void BulletedList4_Click1(object sender, BulletedListEventArgs e)
        {

            //Label1.Text = "The Index of Item you clicked: " + e.Index + "<br> The value of Item you clicked: " + BulletedList4.Items[e.Index].Text;
            foreach (ListItem li in BulletedList4.Items)
                li.Attributes.Add("class", "off");

            BulletedList4.Items[e.Index].Attributes.Add("class", "on");

            ProfileView.ActiveViewIndex = e.Index;
            var userName = Security.GetUserName();

            switch (ProfileView.ActiveViewIndex)
            {
                case 3:
                    lstAllProjects.Items.Clear();
                    lstSelectedProjects.Items.Clear();
                    lstAllProjects.DataSource = ProjectManager.GetByMemberUserName(userName);
                    lstAllProjects.DataTextField = "Name";
                    lstAllProjects.DataValueField = "Id";
                    lstAllProjects.DataBind();

                    // Copy selected users into Selected Users List Box
                    var projectNotifications = ProjectNotificationManager.GetByUsername(userName);

                    foreach (var currentNotification in projectNotifications)
                    {
                        var matchItem = lstAllProjects.Items.FindByValue(currentNotification.ProjectId.ToString());
                        if (matchItem == null) continue;

                        lstSelectedProjects.Items.Add(matchItem);
                        lstAllProjects.Items.Remove(matchItem);
                    }
                    break;
            }

        }

        /// <summary>
        /// Handles the Click event of the SaveButton control.
        /// </summary>
        /// <param name="s">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void SaveButton_Click(object s, EventArgs e)
        {
            var membershipUser = UserManager.GetUser(User.Identity.Name);

            membershipUser.Email = Email.Text;
            WebProfile.Current.FirstName = FirstName.Text;
            WebProfile.Current.LastName = LastName.Text;
            WebProfile.Current.DisplayName = FullName.Text;

            try
            {
                UserManager.UpdateUser(membershipUser);
                WebProfile.Current.Save();
                Message1.ShowSuccessMessage(GetLocalResourceObject("ProfileSaved").ToString());

                if (Log.IsInfoEnabled)
                {
                    if (HttpContext.Current.User != null && HttpContext.Current.User.Identity.IsAuthenticated)
                        MDC.Set("user", HttpContext.Current.User.Identity.Name);
                    Log.Info("Profile updated");
                }
            }
            catch (Exception ex)
            {
                if (Log.IsErrorEnabled)
                {
                    if (HttpContext.Current.User != null && HttpContext.Current.User.Identity.IsAuthenticated)
                        MDC.Set("user", HttpContext.Current.User.Identity.Name);
                    Log.Error("Profile update error", ex);
                }

                Message1.ShowErrorMessage(GetLocalResourceObject("ProfileUpdateError").ToString());
            }


        }

        /// <summary>
        /// Handles the Click event of the BackButton control.
        /// </summary>
        /// <param name="s">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void BackButton_Click(object s, EventArgs e)
        {
            var url = Request.Get("referrerurl", string.Empty);

            if (!string.IsNullOrEmpty(url))
                Response.Redirect(url);
        }


        /// <summary>
        /// Handles the Click event of the SaveCustomizeSettings control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void SaveCustomSettings_Click(object sender, EventArgs e)
        {
            WebProfile.Current.IssuesPageSize = Convert.ToInt32(IssueListItems.SelectedValue);
            WebProfile.Current.PreferredLocale = ddlPreferredLocale.SelectedValue;
            WebProfile.Current.RecieveEmailNotifications = AllowNotifications.Checked;

            try
            {
                WebProfile.Current.Save();
                Message3.ShowSuccessMessage(GetLocalResourceObject("CustomSettingsSaved").ToString());

                if (Log.IsInfoEnabled)
                {
                    if (HttpContext.Current.User != null && HttpContext.Current.User.Identity.IsAuthenticated)
                        MDC.Set("user", HttpContext.Current.User.Identity.Name);
                    Log.Info("Profile updated");
                }
            }
            catch (Exception ex)
            {
                if (Log.IsErrorEnabled)
                {
                    if (HttpContext.Current.User != null && HttpContext.Current.User.Identity.IsAuthenticated)
                        MDC.Set("user", HttpContext.Current.User.Identity.Name);
                    Log.Error("Profile update error", ex);
                }
                Message3.ShowErrorMessage(GetLocalResourceObject("CustomSettingsUpdateError").ToString());

            }

        }
    }
}
