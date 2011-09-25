using System;
using System.Collections.Generic;
using System.DirectoryServices;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Security;
using BugNET.BLL;
using BugNET.Entities;
using log4net;

namespace BugNET.HttpModules
{
    /// <summary>
    /// BugNET Authentication HttpModule
    /// </summary>
    public class AuthenticationModule : IHttpModule
    {
        private static readonly ILog Log = LogManager.GetLogger(typeof(AuthenticationModule));
        private const string _filter = "(&(ObjectClass=Person)(SAMAccountName={0}))";
        private static string _path = String.Empty;
        private const string ValidEmailRegularExpression = @"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$";

        /// <summary>
        /// Gets the name of the module.
        /// </summary>
        /// <value>The name of the module.</value>
        public string ModuleName
        {
            get { return "AuthenticationModule"; }
        }

        #region IHttpModule Members

        /// <summary>
        /// Disposes of the resources (other than memory) used by the module that implements <see cref="T:System.Web.IHttpModule"></see>.
        /// </summary>
        public void Dispose()
        {}

        /// <summary>
        /// Initializes a module and prepares it to handle requests.
        /// </summary>
        /// <param name="context">An <see cref="T:System.Web.HttpApplication"></see> that provides access to the methods, properties, and events common to all application objects within an ASP.NET application</param>
        public void Init(HttpApplication context)
        {
            context.AuthenticateRequest += new EventHandler(context_AuthenticateRequest);
        }

        /// <summary>
        /// Handles the AuthenticateRequest event of the context control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="T:System.EventArgs"/> instance containing the event data.</param>
        void context_AuthenticateRequest(object sender, EventArgs e)
        {
            //check if we are upgrading/installing
            if(HttpContext.Current.Request.Url.LocalPath.ToLower().EndsWith("install.aspx"))
               return;

            //get host settings
            bool enabled = HostSettingManager.GetHostSetting("UserAccountSource") == "ActiveDirectory" || HostSettingManager.GetHostSetting("UserAccountSource") == "WindowsSAM";

            //check if windows authentication is enabled in the host settings
            if (enabled)
            {
                if (System.Web.HttpContext.Current.User != null)
                    MDC.Set("user", System.Web.HttpContext.Current.User.Identity.Name);

                // This was moved from outside "if enabled" to only happen when we need it.
                HttpRequest request = HttpContext.Current.Request;

               // not needed to be removed
               // HttpResponse response = HttpContext.Current.Response;

                if (request.IsAuthenticated)
                {
                    if ((HttpContext.Current.User.Identity.AuthenticationType == "NTLM" || HttpContext.Current.User.Identity.AuthenticationType == "Negotiate"))
                    {
                        //check if the user exists in the database 
                        MembershipUser user = UserManager.GetUser(HttpContext.Current.User.Identity.Name);

                        if (user == null)
                        {
                            try
                            {
                                UserProperties userprop = GetUserProperties(HttpContext.Current.User.Identity.Name);
                                MembershipUser mu = null;
                                MembershipCreateStatus createStatus = MembershipCreateStatus.Success;

                                //create a new user with the current identity and a random password.
                                if (Membership.RequiresQuestionAndAnswer)
                                    mu = Membership.CreateUser(HttpContext.Current.User.Identity.Name, Membership.GeneratePassword(7, 2), userprop.Email, "WindowsAuth", "WindowsAuth", true, out createStatus);
                                else
                                    mu = Membership.CreateUser(HttpContext.Current.User.Identity.Name, Membership.GeneratePassword(7, 2), userprop.Email);

                                if (createStatus == MembershipCreateStatus.Success && mu != null)
                                {
                                    WebProfile Profile = new WebProfile().GetProfile(HttpContext.Current.User.Identity.Name);
                                    Profile.DisplayName = String.Format("{0} {1}", userprop.FirstName, userprop.LastName);
                                    Profile.FirstName = userprop.FirstName;
                                    Profile.LastName = userprop.LastName;
                                    Profile.Save();

                                    //auto assign user to roles
                                    List<Role> roles = RoleManager.GetAllRoles().FindAll(r => r.AutoAssign == true);
                                    foreach (Role r in roles)
                                        RoleManager.AddUserToRole(mu.UserName, r.Id);
                                }

                                user = Membership.GetUser(HttpContext.Current.User.Identity.Name);
                            }
                            catch (Exception ex)
                            {
                                if (Log.IsErrorEnabled)
                                    Log.Error(String.Format("Unable to add new user '{0}' to BugNET application. Authentication Type='{1}'.", HttpContext.Current.User.Identity.Name, HttpContext.Current.User.Identity.AuthenticationType), ex);
                            }
                        }
                        else
                        {
                            //update the user's last login date.
                            user.LastLoginDate = DateTime.Now;
                            Membership.UpdateUser(user);
                        }
                    }
                    //else
                    //{
                    //    // Warning:
                    //    // This line may generate too many log entries!!
                    //    // We will have to see in practice.
                    //    if (System.Web.HttpContext.Current.User != null)
                    //        MDC.Set("user", System.Web.HttpContext.Current.User.Identity.Name);

                    //    if (Log.IsErrorEnabled)
                    //        Log.Error(String.Format("Unknown Authentication Type '{0}'.", HttpContext.Current.User.Identity.Name));
                    //}
                } 
            }
        }

        /// <summary>
        /// Gets the users properties from the specified user store.
        /// </summary>
        /// <param name="identification">The identification.</param>
        /// <returns>
        /// Class of user properties
        /// </returns>
        public UserProperties GetUserProperties(string identification)
        {
            UserProperties userprop = new UserProperties();
            userprop.FirstName = identification;
      
            // Determine which method to use to retrieve user information

            // WindowsSAM
            if (HostSettingManager.UserAccountSource == "WindowsSAM")
            {
                // Extract the machine or domain name and the user name from the
                // identification string
                string[] samPath = identification.Split(new char[] { '\\' });
                _path = String.Format("{0}{1}", "WinNT://", samPath[0]);
                try
                {
                    // Find the user
                    DirectoryEntry entryRoot = new DirectoryEntry(_path);
                    DirectoryEntry userEntry = entryRoot.Children.Find(samPath[1], "user");
                    userprop.FirstName = userEntry.Properties["FullName"].Value.ToString();
                    userprop.Email = string.Empty;
                    return userprop;
                }
                catch
                {
                    return userprop;
                }
            }

            // Active Directory
            else if (HostSettingManager.UserAccountSource == "ActiveDirectory")
            {
                DirectoryEntry entry;
                if (string.IsNullOrEmpty(HostSettingManager.GetHostSetting("ADUserName")))
                    entry = new DirectoryEntry(String.Format("{0}{1}", "GC://", HostSettingManager.GetHostSetting("ADPath")), null, null, AuthenticationTypes.ReadonlyServer);
                else
                    entry = new DirectoryEntry(String.Format("{0}{1}", "GC://", HostSettingManager.GetHostSetting("ADPath")), HostSettingManager.GetHostSetting("ADUserName"), HostSettingManager.GetHostSetting("ADPassword"), AuthenticationTypes.Secure);

                // Setup the filter
                identification = identification.Substring(identification.LastIndexOf(@"\") + 1,
                    identification.Length - identification.LastIndexOf(@"\") - 1);
                string userNameFilter = string.Format(_filter, identification);

                // Get a Directory Searcher to the LDAPPath
                DirectorySearcher searcher = new DirectorySearcher(entry);
                if (searcher == null)
                {
                    return userprop;
                }

                // Add the properties that need to be retrieved
                searcher.PropertiesToLoad.Add("givenName");
                searcher.PropertiesToLoad.Add("mail");
                searcher.PropertiesToLoad.Add("sn");

                // Set the filter for the search
                searcher.Filter = userNameFilter;

                // Because this can get messy and there are multiple ways to have problems.
                string StrError = "";
                try
                {
                    // Execute the search
                    SearchResult search = searcher.FindOne();

                    if (search != null)
                    {
                        userprop.FirstName = SearchResultProperty(search, "givenName"); //firstname
                        userprop.LastName = SearchResultProperty(search, "sn"); //lastname
                        // Modification by Stewart Moss
                        // 12-Nov-2008 - Inserted into 0.8 branch 2009-02-17
                        //
                        // This is to resolve [BGN-774].
                        // 
                        // It gets the default email address and checks to see if it is a valid smtp address.
                        // If not, it tests each proxyaddress to see if it is smtp and returns the
                        // first smtp address it finds.
                        
                        string email= SearchResultProperty(search, "mail").Trim(); //email address
                        string bademail = "1st Run";
                       
                        // email regular expression
                        Regex regexEmail = new Regex(ValidEmailRegularExpression, RegexOptions.IgnoreCase | RegexOptions.CultureInvariant | RegexOptions.IgnorePatternWhitespace);                        
                        if (!regexEmail.IsMatch(email))
                        {
                            // It does not match an smtp format address, now we search the hard way
                            // most of the code courtesy of:
                            // http://blog.lozanotek.com/articles/149.aspx
                            // Querying Active Directory for User Emails
                            // Javier G. Lozano
                            email = "";

                            foreach (string proxyAddr in search.Properties["proxyaddresses"])
                            {
                                try
                                {
                                    //Make it 'case insensitive'
                                    if (proxyAddr.ToLower().StartsWith("smtp:"))
                                    {
                                        //Get the email string from AD
                                        email = proxyAddr.Substring(5).Trim();
                                        // we are only interested in the first *valid* smtp address
                                        if (regexEmail.IsMatch(email))
                                        {
                                            break;
                                        }
                                        else
                                        {
                                            bademail = email;
                                            email = "";
                                        }
                                    }
                                }
                                catch (Exception ex)
                                {
                                    // report errors nicely
                                    try
                                    {
                                        StrError = "Error in AD proxyaddresses '" + proxyAddr.ToLower() + "' returns '" + proxyAddr.Substring(5).Trim() + "'. Error='" + ex.Message + "'";
                                    }
                                    catch (Exception ex2)
                                    {
                                        StrError = "Error in AD proxyaddresses '" + proxyAddr.ToLower() + "' returns 'proxyAddr.Substring(5).Trim() undefined'. Error='" + ex2.Message + "'";
                                    }
                                    bademail = email;
                                    email = "";
                                    // Keep searching after exception
                                }
                            } // foreach
                        }

                        if (email == "")
                        {                            
                            throw new Exception("Email address='" + bademail + "' is invalid! Error='" + StrError + "'.");
                        }

                        userprop.Email = email;


                        //add new properties here to fill the profile.
                        return userprop;
                    }
                    else
                        return userprop;
                }
                catch
                {
                    return userprop;
                }
            }
            else
            {
                // The user has not choosen an UserAccountSource or UserAccountSource as None
                // Usernames will be displayed as "Domain\Username"
                return userprop;
            }
        }

        /// <summary>
        /// Searches the result property.
        /// </summary>
        /// <param name="sr">The sr.</param>
        /// <param name="field">The field.</param>
        /// <returns></returns>
        private static String SearchResultProperty(SearchResult sr, string field)
        {
            if (sr.Properties[field] != null)
            {
                return (String)sr.Properties[field][0];
            }

            return null;
        }

        #endregion

    }
}
