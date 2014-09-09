using System;
using System.Web;
using System.Security.Principal;
using System.Threading;
using System.Web.Services;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using Owin;
using BugNET.Models;
using BugNET.BLL;
using BugNET.Common;

namespace BugNET.Webservices
{

    /// <summary>
    /// Base abstract class for webservices to handle user authentication.
    /// </summary>
    public abstract class LogInWebService : WebService
    {
        /// <summary>
        /// Initializes a new instance of the <see cref="LogInWebService"/> class.
        /// </summary>
        public LogInWebService()
        {
            if (User.Identity != null && User.Identity.IsAuthenticated)
            {
                //already authenticated through web app.
            }
            else if (IsAuthenticated)
            {
                IIdentity identity = new GenericIdentity(UserName);
                IPrincipal principal = new GenericPrincipal(identity, null);
                Thread.CurrentPrincipal = principal;
            }
        }

        /// <summary>
        /// Gets or sets the name of the user.
        /// </summary>
        /// <value>The name of the user.</value>
        protected virtual string UserName
        {
            get
            {
                if (IsAuthenticated)
                {
                    return (string)Session["UserName"];
                }
                return "";
            }
            set
            {
                if (IsAuthenticated)
                {
                    Session["UserName"] = value;
                }
                else
                {
                    throw new UnauthorizedAccessException("Cannot set unauthenticated user name");
                }
            }
        }

        /// <summary>
        /// Gets or sets a value indicating whether this instance is authenticated.
        /// </summary>
        /// <value>
        /// 	<c>true</c> if this instance is authenticated; otherwise, <c>false</c>.
        /// </value>
        protected virtual bool IsAuthenticated
        {
            get
            {
                object state = Session["IsAuthenticated"];
                if (state != null)
                {
                    return (bool)state;
                }
                //Must be first request in session
                IsAuthenticated = false;
                return false;
            }
            set
            {
                Session["IsAuthenticated"] = value;
            }
        }

        /// <summary>
        /// Logs the in.
        /// </summary>
        /// <param name="userName">Name of the user.</param>
        /// <param name="password">The password.</param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public virtual bool LogIn(string userName, string password)
        {
            bool authenticated;

          
            
            var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
            var user = manager.FindByName(userName);
           

            if (user == null)
            {
                authenticated = false;
            }
            else
            {
                var result = manager.PasswordHasher.VerifyHashedPassword(user.PasswordHash, password);
                if(result == PasswordVerificationResult.Success || result == PasswordVerificationResult.SuccessRehashNeeded)
                {
                    authenticated = true;
                }
                else
                {
                    authenticated = false;
                }
            }

            IsAuthenticated = authenticated;

            if (authenticated)
            {
                UserName = userName;
            }
            return authenticated;
        }

        /// <summary>
        /// Logs the out.
        /// </summary>
        [WebMethod(EnableSession = true)]
        public virtual void LogOut()
        {
            UserName = "";
            IsAuthenticated = false;
        }
    }
}