using System;
using System.Collections.Generic;
using System.DirectoryServices;
using System.DirectoryServices.AccountManagement;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Security;
using BugNET.BLL;
using BugNET.Common;
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
		{ }

		/// <summary>
		/// Initializes a module and prepares it to handle requests.
		/// </summary>
		/// <param name="context">An <see cref="T:System.Web.HttpApplication"></see> that provides access to the methods, properties, and events common to all application objects within an ASP.NET application</param>
		public void Init(HttpApplication context)
		{
			context.AuthenticateRequest += context_AuthenticateRequest;
		}

		/// <summary>
		/// Handles the AuthenticateRequest event of the context control.
		/// </summary>
		/// <param name="sender">The source of the event.</param>
		/// <param name="e">The <see cref="T:System.EventArgs"/> instance containing the event data.</param>
		void context_AuthenticateRequest(object sender, EventArgs e)
		{
			//check if we are upgrading/installing
			if (HttpContext.Current.Request.Url.LocalPath.ToLower().EndsWith("install.aspx"))
				return;

			//get host settings
			bool enabled = HostSettingManager.Get(HostSettingNames.UserAccountSource) == "ActiveDirectory" || HostSettingManager.Get(HostSettingNames.UserAccountSource) == "WindowsSAM";

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
									if (!string.IsNullOrWhiteSpace(userprop.DisplayName))
										Profile.DisplayName = userprop.DisplayName;
									else
										Profile.DisplayName = String.Format("{0} {1}", userprop.FirstName, userprop.LastName);
									Profile.FirstName = userprop.FirstName;
									Profile.LastName = userprop.LastName;
									Profile.Save();

									//auto assign user to roles
									List<Role> roles = RoleManager.GetAll().FindAll(r => r.AutoAssign == true);
									foreach (Role r in roles)
										RoleManager.AddUser(mu.UserName, r.Id);
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
				// Setup the filter
				string username = identification.Substring(identification.LastIndexOf(@"\") + 1, identification.Length - identification.LastIndexOf(@"\") - 1);
				string domain = HostSettingManager.Get(HostSettingNames.ADPath);

				string login = HostSettingManager.Get(HostSettingNames.ADUserName);
				string password = HostSettingManager.Get(HostSettingNames.ADPassword);

				List<string> emailAddresses = new List<string>();

				PrincipalContext domainContext;
				if (string.IsNullOrWhiteSpace(login))
					domainContext = new PrincipalContext(ContextType.Domain, domain);
				else
					domainContext = new PrincipalContext(ContextType.Domain, domain, login, password);

				if (domainContext != null)
				{
					UserPrincipal user = UserPrincipal.FindByIdentity(domainContext, username);
					if (user != null)
					{
						// extract full name
						if (!string.IsNullOrWhiteSpace(user.GivenName) || !string.IsNullOrWhiteSpace(user.Surname))
						{
							userprop.FirstName = user.GivenName == null ? "" : user.GivenName.Trim();
							userprop.LastName = user.Surname == null ? "" : user.Surname.Trim();
						}

						if (!string.IsNullOrWhiteSpace(user.DisplayName))
						{
							userprop.DisplayName = user.DisplayName;
						}

						Regex regexEmail = new Regex(ValidEmailRegularExpression, RegexOptions.IgnoreCase | RegexOptions.CultureInvariant | RegexOptions.IgnorePatternWhitespace);

						foreach (var email in GetEmails(user))
						{
							if (string.IsNullOrWhiteSpace(email))
								continue;

							var fixedEmail = email.Trim();
							//Make it 'case insensitive'
							if (fixedEmail.StartsWith("smtp:", StringComparison.InvariantCultureIgnoreCase))
							{
								//Get the email string from AD
								fixedEmail = fixedEmail.Substring(5).Trim();
							}

							if (regexEmail.IsMatch(fixedEmail))
							{
								userprop.Email = fixedEmail;
								break;
							}
						}
					}
				}

				//add new properties here to fill the profile.
				return userprop;
			}
			else
			{
				// The user has not chosen an UserAccountSource or UserAccountSource as None
				// Usernames will be displayed as "Domain\Username"
				return userprop;
			}
		}

		IEnumerable<string> GetEmails(UserPrincipal user)
		{
			// Add the "mail" entry
			yield return user.EmailAddress;

			// Add the "proxyaddresses" entries.
			PropertyCollection properties = ((DirectoryEntry) user.GetUnderlyingObject()).Properties;
			foreach (object property in properties["proxyaddresses"])
				yield return property.ToString();

			yield return user.UserPrincipalName;
		}

		#endregion

	}
}
