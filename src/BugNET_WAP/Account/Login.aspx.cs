using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Security;
using BugNET.BLL;
using BugNET.Common;
using BugNET.Entities;
using DotNetOpenAuth.OpenId.Extensions.SimpleRegistration;
using DotNetOpenAuth.OpenId.RelyingParty;

namespace BugNET.Account
{
    /// <summary>
    /// 
    /// </summary>
    public partial class Login : System.Web.UI.Page
    {

        private bool isOpenIDEnabled = false;

        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void Page_Load(object sender, EventArgs e)
        {
            Page.Title = string.Format("{0} - {1}", GetLocalResourceObject("Page.Title").ToString(), HostSettingManager.GetHostSetting("ApplicationTitle"));

            //hide the registration link if we have disabled registration
            if (Convert.ToInt32(HostSettingManager.GetHostSetting("UserRegistration")) == (int)Globals.UserRegistration.None)
                RegisterPanel.Visible = false;

            // check if OpenID is enabled
            // BGN-1356
            isOpenIDEnabled = Boolean.Parse(HostSettingManager.GetHostSetting("OpenIdAuthentication"));

            if (HttpContext.Current.User.Identity.IsAuthenticated)
            {
                Response.Redirect("~/Default.aspx");
            }
            else
            {
                btnShowOpenID.Visible = isOpenIDEnabled;
                if (Session["isDoingOpenIDLogin"] != null)
                    if (Session["isDoingOpenIDLogin"] == "true")
                    {
                        // Call the logic as if we clicked on the OpenID button
                        btnShowOpenID_Click(sender, new EventArgs() );
                    }

            }

        }

        protected void OpenIdLogin1_LoggingIn(object sender, OpenIdEventArgs e)
        {

            // Allow us to "remember" that we are preforming an OpenID login
            Session["isDoingOpenIDLogin"] = "true";
        }


        /// <summary>
        /// Handles the LoggedIn event of the OpenIdLogin1 control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="DotNetOpenAuth.OpenId.RelyingParty.OpenIdEventArgs"/> instance containing the event data.</param>
        protected void OpenIdLogin1_LoggedIn(object sender, OpenIdEventArgs e)
        {
            try
            {
                // Clear previously remembered OpenID state
                Session["isDoingOpenIDLogin"] = "";

                // May 30 2010 
                // BGN-1356
                //
                // Added by smoss for security. 
                // User shouldnt be able to use this method if OpenID is off.
                if (!Boolean.Parse(HostSettingManager.GetHostSetting("OpenIdAuthentication")))
                {
                    throw new UnauthorizedAccessException();
                }

                if (e.Response != null)
                {
                    switch (e.Response.Status)
                    {
                        case AuthenticationStatus.Authenticated:
                            // This is where you would look for any OpenID extension responses included  
                            // in the authentication assertion.  
                            // var extension = openid.Response.GetExtension<someextensionresponsetype>();  

                            // TODO : check for linked account via user profile settings if Desired
                            // May 31 2010

                            // WARNING: There is no logging in this method!
                            string email = string.Empty;
                            string alias = string.Empty;
                            string fullname = string.Empty;

                            ClaimsResponse fetch = e.Response.GetExtension(typeof(ClaimsResponse)) as ClaimsResponse;
                            if (fetch != null)
                            {
                                alias = fetch.Nickname;    // set size limits
                                email = fetch.Email;       // no validation of email
                                fullname = fetch.FullName; // set size limits
                            }


                            if (string.IsNullOrEmpty(alias))
                                alias = e.Response.ClaimedIdentifier;

                            // Warning: Invalid email address
                            if (string.IsNullOrEmpty(email))
                                email = e.Response.ClaimedIdentifier;

                            if (string.IsNullOrEmpty(fullname))
                                fullname = e.Response.ClaimedIdentifier;

                            //Now see if the user already exists, if not create them
                            MembershipUser TestUser = Membership.GetUser(e.Response.ClaimedIdentifier);

                            if (TestUser != null)
                            {
                                // BGN-1867
                                // Banned users are not allowed to login via OpenID
                                // See if this user is allowed on the system. Also dont allow users 
                                // who are still logged in to try and login.
                                if ((!TestUser.IsApproved) || (TestUser.IsLockedOut) || (TestUser.IsOnline))
                                {
                                    loginFailedLabel.Text += " " + GetLocalResourceObject("NotAuthorized.Text").ToString();
                                    loginFailedLabel.Visible = true;
                                    e.Cancel = true;
                                    break;
                                }
                            }
                            else
                            {

                                // Part of BGN-1860
                                if (Convert.ToInt32(HostSettingManager.GetHostSetting("UserRegistration")) == (int)Globals.UserRegistration.None)
                                {
                                    loginFailedLabel.Text += GetLocalResourceObject("RegistrationDisabled").ToString();
                                    loginFailedLabel.Visible = true;
                                    e.Cancel = true;
                                    break; // unsecure break should be a return
                                }

                                MembershipCreateStatus membershipCreateStatus;

                                MembershipUser user = Membership.CreateUser(e.Response.ClaimedIdentifier, Membership.GeneratePassword(7, 2), email, GetLocalResourceObject("OpenIDPasswordQuestion").ToString(), Membership.GeneratePassword(12, 4), true, out membershipCreateStatus);

                                if (membershipCreateStatus != MembershipCreateStatus.Success)
                                {
                                    loginFailedLabel.Text += GetLocalResourceObject("CreateAccountFailed").ToString() + membershipCreateStatus.ToString();
                                    loginFailedLabel.Visible = true;
                                    e.Cancel = true;
                                    break;// unsecure break should be a return
                                }

                                //save profile info
                                WebProfile Profile = new WebProfile().GetProfile(user.UserName);
                                Profile.DisplayName = fullname;
                                Profile.Save();
                                user.Comment = alias;
                                Membership.UpdateUser(user);

                                //auto assign user to roles
                                List<Role> roles = RoleManager.GetAllRoles();
                                foreach (Role r in roles)
                                {
                                    if (r.AutoAssign)
                                        RoleManager.AddUserToRole(user.UserName, r.Id);
                                }

                                //send notification this user was created
                                UserManager.SendUserRegisteredNotification(user.UserName);
                            }

                            // NB NB Only do the redirect when e.Cancel != true
                            // There is a very very slim chance this code will be reached with
                            // e.Cancel == true
                            if (e.Cancel == false)
                            {
                                // Use FormsAuthentication to tell ASP.NET that the user is now logged in,  
                                // with the OpenID Claimed Identifier as their username. 
                                FormsAuthentication.RedirectFromLoginPage(e.Response.ClaimedIdentifier, false);
                            }
                            break;


                        case AuthenticationStatus.Canceled:
                            loginCanceledLabel.Visible = true;
                            e.Cancel = true;
                            break; // unsecure break should be a return

                        // extra enums detected and force a default case
                        // They all mean failures
                        case AuthenticationStatus.Failed:
                        case AuthenticationStatus.ExtensionsOnly:
                        case AuthenticationStatus.SetupRequired:
                        default:
                            loginFailedLabel.Visible = true;
                            e.Cancel = true;
                            break; // unsecure break should be a return                        
                    }

                }
                else
                {
                    // response is null
                }

            }
            finally
            { 
                // This finally block covers all the code
                if (e.Cancel)
                {
                    // make sure we stay focused on the openid control
                    Session["isDoingOpenIDLogin"] = "true";
                }
            }
        }

        /// <summary>
        /// Handles the Click event of the btnShowOpenID control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void btnShowOpenID_Click(object sender, EventArgs e)
        {
            // May 30 2010
            // Added by smoss for security. 
            // User shouldnt be able to use this method
            // if OpenID is off or they are logged in.
            if ((!isOpenIDEnabled) || (HttpContext.Current.User.Identity.IsAuthenticated))
            {
                pnlOpenIDLogin.Visible = false;
                pnlNormalLogin.Visible = true;
                Session["isDoingOpenIDLogin"] = "";
                throw new UnauthorizedAccessException();
            }

            pnlOpenIDLogin.Visible = true;
            pnlNormalLogin.Visible = false;
            Session["isDoingOpenIDLogin"] = "true";
        }

        /// <summary>
        /// Handles the Click event of the btnShowNormal control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void btnShowNormal_Click(object sender, EventArgs e)
        {
            pnlOpenIDLogin.Visible = false;
            pnlNormalLogin.Visible = true;
            Session["isDoingOpenIDLogin"] = "";
        }



    }
}
