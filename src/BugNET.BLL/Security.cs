using System.Web;

namespace BugNET.BLL
{
	/// <summary>
	/// Summary description for Security.
	/// </summary>
	public class Security
	{
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
            return UserManager.GetUserDisplayName(HttpContext.Current.User.Identity.Name);
        }
	}
}
