using System;
using System.Web;

namespace BugNET.Errors
{
    public partial class Error : System.Web.UI.Page
    {
        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void Page_Load(object sender, EventArgs e)
        {
            Label2.Text = string.Format(GetLocalResourceObject("Message1").ToString(), Page.ResolveUrl("~/Default.aspx"));
        }

        /// <summary>
        /// Raises the <see cref="E:System.Web.UI.TemplateControl.Error"/> event.
        /// </summary>
        /// <param name="e">An <see cref="T:System.EventArgs"/> that contains the event data.</param>
        protected override void OnError(EventArgs e)
        {
            //// At this point we have information about the error
            HttpContext ctx = HttpContext.Current;

            Exception exception = ctx.Server.GetLastError();

            string errorInfo =
               "<br>Offending URL: " + ctx.Request.Url.ToString() +
               "<br>Source: " + exception.Source +
               "<br>Message: " + exception.Message; // +
               //"<br>Stack trace: " + exception.StackTrace;

            ctx.Response.Write(errorInfo);

            //// --------------------------------------------------
            //// To let the page finish running we clear the error
            //// --------------------------------------------------
            ctx.Server.ClearError();

            base.OnError(e);
        }
    }
}
