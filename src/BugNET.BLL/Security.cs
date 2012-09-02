using System.Web;
using log4net;

namespace BugNET.BLL
{
	/// <summary>
	/// Summary description for Security.
	/// </summary>
	public static class Security
	{
        private static readonly ILog Log = LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);
         
        /// <summary>
        /// Gets the name of the logged on user.
        /// </summary>
        /// <returns></returns>
        public static string GetUserName()
        {
            return HttpContext.Current.User.Identity.Name;
        }

        /// <summary>
        /// Gets the display name.
        /// </summary>
        /// <returns></returns>
        public static string GetDisplayName()
        {
            return (HttpContext.Current == null) ? 
                "SYSTEM" :
                UserManager.GetUserDisplayName(HttpContext.Current.User.Identity.Name);
        }
	}
}
