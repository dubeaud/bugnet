using System.Web.UI;

namespace BugNET.UserInterfaceLayer
{
    /// <summary>
    /// This class gives the programmer access to quick and easy redirects when 
    /// errors happen.
    /// </summary>
    public class ErrorRedirector
    {
        /// <summary>
        /// Transfers to error page.
        /// </summary>
        public static void TransferToLoginPage(Page webPage)
        {
            webPage.Response.Redirect(string.Format("~/Login.aspx?returnurl={0}", webPage.Request.RawUrl), true);     
        }

        /// <summary>
        /// Transfers to NotFound page.
        /// </summary>
        public static void TransferToNotFoundPage(Page webPage)
        {
            webPage.Response.Redirect("~/Errors/NotFound.aspx", true);
        }

        /// <summary>
        /// Transfers to SomethingMissing page.
        /// </summary>
        public static void TransferToSomethingMissingPage(Page webPage)
        {
            webPage.Response.Redirect("~/Errors/SomethingMissing.aspx", true);
        }

        /// <summary>
        /// Transfers to SessionExpired page.
        /// </summary>
        public static void TransferToSessionExpiredPage(Page webPage)
        {
            webPage.Response.Redirect("~/Errors/SessionExpired.aspx", true);
        }

        /// <summary>
        /// Transfers to Error page.
        /// Shouldnt really need this.
        /// </summary>
        public static void TransferToErrorPage(Page webPage)
        {
            webPage.Response.Redirect("~/Errors/Error.aspx", true);
        }
    }
}