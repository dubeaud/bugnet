using System;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using BugNET.BLL;
using BugNET.Common;
using log4net;

namespace BugNET.UserControls
{
    /// <summary>
    /// 
    /// </summary>
    public partial class LoginControl : UserControl
    {
         private static readonly ILog Log = LogManager.GetLogger(typeof(Global));

         /// <summary>
         /// Handles the Click event of the LoginButton control.
         /// </summary>
         /// <param name="sender">The source of the event.</param>
         /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void LoginButton_Click(object sender, EventArgs e)
         {
             if (!Page.IsValid) return;

             if (!Membership.ValidateUser(subLoginControl.UserName, subLoginControl.Password)) return;

             FormsAuthentication.RedirectFromLoginPage(subLoginControl.UserName, subLoginControl.RememberMeSet);
         }

        /// <summary>
        /// Handles the Load event of the LoginControl control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void LoginControl_Load(object sender, EventArgs e)
        {

            
         
        }

        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void Page_Load(object sender, EventArgs e)
        {
            // Set our Text Box inside the login control as focus.
            // BGN-1356
            subLoginControl.Focus();

            //hide the registration link if we have disabled registration
            if (HostSettingManager.Get(HostSettingNames.UserRegistration, 0) == (int)Globals.UserRegistration.None)
            {
                var registerPanel = subLoginControl.FindControl("RegisterPanel") as Panel;

                if(registerPanel != null)
                    registerPanel.Visible = false;
            }
         }

        /// <summary>
        /// Handles the Load event of the pnlLoginControl control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void pnlLoginControl_Load(object sender, EventArgs e)
        {


        }

        /// <summary>
        /// Handles the CheckedChanged event of the RememberMe control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void RememberMe_CheckedChanged(object sender, EventArgs e)
        {

            this.subLoginControl.RememberMeSet = ((CheckBox)sender).Checked;
        }

        /// <summary>
        /// Handles the LoginError event of the subLoginControl control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void subLoginControl_LoginError(object sender, EventArgs e)
        {
            // Log invalid logins
            // username trimmed because the login control trims              
            Log.Error("Login Error", new Exception(string.Format("Login Error by USER='{0}' IP_ADDR='{1}' USER_AGENT='{2}'", subLoginControl.UserName.Trim(), this.Context.Request.UserHostAddress, this.Context.Request.UserAgent )));
        }


    }
}