using System;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI.WebControls;
using BugNET.BLL;
using BugNET.Common;
using DotNetOpenAuth.Messaging;
using DotNetOpenAuth.OpenId.Extensions.AttributeExchange;
using DotNetOpenAuth.OpenId.Extensions.SimpleRegistration;
using DotNetOpenAuth.OpenId.RelyingParty;
using log4net;

namespace BugNET.Account
{
    /// <summary>
    /// 
    /// </summary>
    public partial class Login : System.Web.UI.Page
    {

        private static readonly ILog Log = LogManager.GetLogger(typeof(Login));

        private bool IsOpenIdEnabled
        {
            get { return ViewState.Get("IsOpenIdEnabled", false); }
            set { ViewState.Set("IsOpenIdEnabled", value); }
        }

        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;

            Page.Title = string.Format("{0} - {1}", GetLocalResourceObject("Page.Title"), HostSettingManager.Get(HostSettingNames.ApplicationTitle));

            // check if OpenID is enabled
            // BGN-1356
            IsOpenIdEnabled = HostSettingManager.Get(HostSettingNames.OpenIdAuthentication, false);

            // if open id is not enabled no reason to show login options
            LoginTabsMenu.Visible = IsOpenIdEnabled;

            if (HttpContext.Current.User.Identity.IsAuthenticated)
            {
                Response.Redirect("~/Default.aspx");
            }
            else
            {
                if (Session["isDoingOpenIDLogin"] != null)
                {
                    if (Session["isDoingOpenIDLogin"].ToString() == "true")
                    {
                        LoginTabsMenu_Click(LoginTabsMenu, new MenuEventArgs(new MenuItem { Value = "1" }));
                    }
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
                if (!HostSettingManager.Get(HostSettingNames.OpenIdAuthentication, false))
                {
                    throw new UnauthorizedAccessException();
                }

                if (e.Response != null)
                {
                    var isNewUser = false;

                    switch (e.Response.Status)
                    {
                        case AuthenticationStatus.Authenticated:
                            // This is where you would look for any OpenID extension responses included  
                            // in the authentication assertion.  
                            // var extension = openid.Response.GetExtension<someextensionresponsetype>();  

                            // TODO : check for linked account via user profile settings if Desired
                            // May 31 2010

                            // WARNING: There is no logging in this method!
                            var email = string.Empty;
                            var alias = string.Empty;
                            var fullname = string.Empty;
                            var firstName = string.Empty;
                            var lastName = string.Empty;

                            var claim = e.Response.GetExtension<ClaimsResponse>();
                            var fetch = e.Response.GetExtension<FetchResponse>();

                            if (claim != null)
                            {
                                alias = claim.Nickname;
                                email = claim.Email;
                                fullname = claim.FullName;
                            }
                            else if (fetch != null)
                            {
                                alias = fetch.GetAttributeValue(WellKnownAttributes.Name.Alias);
                                email = fetch.GetAttributeValue(WellKnownAttributes.Contact.Email);
                                fullname = fetch.GetAttributeValue(WellKnownAttributes.Name.FullName);
                                firstName = fetch.GetAttributeValue(WellKnownAttributes.Name.First);
                                lastName = fetch.GetAttributeValue(WellKnownAttributes.Name.Last);
                            }

                            if (string.IsNullOrEmpty(alias))
                                alias = e.Response.ClaimedIdentifier;

                            // Warning: Invalid email address
                            if (string.IsNullOrEmpty(email))
                                email = e.Response.ClaimedIdentifier;

                            if (string.IsNullOrEmpty(fullname))
                                fullname = e.Response.ClaimedIdentifier;

                            if (string.IsNullOrEmpty(firstName))
                                firstName = string.Empty;

                            if (string.IsNullOrEmpty(lastName))
                                lastName = string.Empty;

                            //Now see if the user already exists, if not create them
                            var membershipUser = Membership.GetUser(e.Response.ClaimedIdentifier);

                            if (membershipUser != null)
                            {
                                // BGN-1867
                                // Banned users are not allowed to login via OpenID
                                // See if this user is allowed on the system. Also dont allow users 
                                // who are still logged in to try and login.
                                if ((!membershipUser.IsApproved) || (membershipUser.IsLockedOut) ||
                                    (membershipUser.IsOnline))
                                {
                                    loginFailedLabel.Text += string.Format(" {0}", GetLocalResourceObject("NotAuthorized.Text"));
                                    loginFailedLabel.Visible = true;
                                    e.Cancel = true;
                                    break;
                                }
                            }
                            else
                            {

                                // Part of BGN-1860
                                if (Convert.ToInt32(HostSettingManager.Get(HostSettingNames.UserRegistration)) ==
                                    (int)Globals.UserRegistration.None)
                                {
                                    loginFailedLabel.Text += GetLocalResourceObject("RegistrationDisabled").ToString();
                                    loginFailedLabel.Visible = true;
                                    e.Cancel = true;
                                    break; // unsecure break should be a return
                                }

                                MembershipCreateStatus membershipCreateStatus;

                                var user = Membership.CreateUser(e.Response.ClaimedIdentifier,
                                                                 Membership.GeneratePassword(7, 2), 
                                                                 email,
                                                                 GetLocalResourceObject("OpenIDPasswordQuestion").ToString(),
                                                                 Membership.GeneratePassword(12, 4),
                                                                 true,
                                                                 out membershipCreateStatus);

                                if (membershipCreateStatus != MembershipCreateStatus.Success)
                                {
                                    loginFailedLabel.Text += GetLocalResourceObject("CreateAccountFailed") +
                                                             membershipCreateStatus.ToString();
                                    loginFailedLabel.Visible = true;
                                    e.Cancel = true;
                                    break; // unsecure break should be a return
                                }

                                //save profile info
                                if (user != null)
                                {
                                    var profile = new WebProfile().GetProfile(user.UserName);

                                    profile.DisplayName = fullname;
                                    profile.FirstName = firstName;
                                    profile.LastName = lastName;

                                    profile.Save();

                                    user.Comment = alias;
                                    Membership.UpdateUser(user);

                                    //auto assign user to roles
                                    var roles = RoleManager.GetAll();
                                    foreach (var r in roles.Where(r => r.AutoAssign))
                                    {
                                        RoleManager.AddUser(user.UserName, r.Id);
                                    }

                                    if (Utilities.IsValidEmail(user.Email))
                                    {
                                        //send notification this user was created
                                        UserManager.SendUserRegisteredNotification(user.UserName);
                                    }

                                    isNewUser = true;
                                }
                                else
                                {
                                    Log.Info("Failed to return user from CreateUser");
                                }
                            }

                            // NB NB Only do the redirect when e.Cancel != true
                            // There is a very very slim chance this code will be reached with
                            // e.Cancel == true
                            if (e.Cancel == false)
                            {
                                // Use FormsAuthentication to tell ASP.NET that the user is now logged in,  
                                // with the OpenID Claimed Identifier as their username.
                                if(isNewUser)
                                {
                                    FormsAuthentication.SetAuthCookie(e.Response.ClaimedIdentifier, false);
                                    Response.Redirect("~/Account/UserProfile.aspx?oid=1", true);
                                }
                                else
                                {
                                    FormsAuthentication.RedirectFromLoginPage(e.Response.ClaimedIdentifier, false);  
                                }
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
                    Log.Info("OpenId returned a null respose");
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

        protected void LoginTabsMenu_Click(object sender, MenuEventArgs e)
        {
            ValidationSummary1.Visible = false;

            switch (e.Item.Value)
            {
                case "0":
                    ValidationSummary1.Visible = true;
                    MultiView1.SetActiveView(tab1);
                    Session["isDoingOpenIDLogin"] = "";
                    break;
                case "1":
                    if ((!IsOpenIdEnabled) || (HttpContext.Current.User.Identity.IsAuthenticated))
                    {
                        Session["isDoingOpenIDLogin"] = "";
                        throw new UnauthorizedAccessException();
                    }
                    Session["isDoingOpenIDLogin"] = "true";
                    MultiView1.SetActiveView(tab2);
                    break;
            }
        }
    }
}
