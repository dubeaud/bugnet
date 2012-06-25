using System;
using System.Web.UI.WebControls;
using BugNET.BLL;
using BugNET.Common;
using BugNET.Entities;
using BugNET.UserInterfaceLayer;
using log4net;

namespace BugNET.Administration.Host
{
    /// <summary>
    /// 
    /// </summary>
    public partial class LogViewer : BasePage
    {
        private static readonly ILog Log = LogManager.GetLogger(typeof(LogViewer));

        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="T:System.EventArgs"/> instance containing the event data.</param>
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!UserManager.IsSuperUser())
                ErrorRedirector.TransferToLoginPage(this);

            if (Page.IsPostBack) return;

            SortField = "Date";
            BindData();
        }

        /// <summary>
        /// Gets or sets the sort field.
        /// </summary>
        /// <value>The sort field.</value>
        string SortField
        {
            get { return ViewState.Get("SortField", string.Empty); }
            set
            {
                if (value == SortField)
                {
                    // same as current sort file, toggle sort direction
                    SortAscending = !SortAscending;
                }
                ViewState.Set("SortField", value);
            }
        }

        /// <summary>
        /// Gets or sets a value indicating whether [sort ascending].
        /// </summary>
        /// <value><c>true</c> if [sort ascending]; otherwise, <c>false</c>.</value>
        bool SortAscending
        {
            get { return ViewState.Get("SortAscending", true); }
            set { ViewState.Set("SortAscending", value); }
        }

        /// <summary>
        /// Handles the PageIndexChanging event of the gvLog control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.GridViewPageEventArgs"/> instance containing the event data.</param>
        protected void gvLog_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvLog.PageIndex = e.NewPageIndex;
            BindData();
        }

        /// <summary>
        /// Handles the Sorting event of the gvUsers control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.GridViewSortEventArgs"/> instance containing the event data.</param>
        protected void gvLog_Sorting(object sender, GridViewSortEventArgs e)
        {
            SortField = e.SortExpression;
            BindData();
        }

        /// <summary>
        /// Binds the data.
        /// </summary>
        private void BindData()
        {
            var list = ApplicationLogManager.GetLog(FilterDropDown.SelectedValue);
            list.Sort(new ApplicationLogComparer(SortField, SortAscending));
            gvLog.DataSource = list;
            gvLog.DataBind();
        }

        protected void FilterDropDown_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindData();
        }

        /// <summary>
        /// Handles the RowDataBound event of the gvLog control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="T:System.Web.UI.WebControls.GridViewRowEventArgs"/> instance containing the event data.</param>
        protected void gvLog_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType != DataControlRowType.DataRow) return;

            var logItem = (ApplicationLog)e.Row.DataItem;

            var img = (Image)e.Row.FindControl("imgLevel");
            img.ImageUrl = GetLogImageUrl(logItem.Level);
            img.AlternateText = logItem.Level;
            var LevelLabel = (Label)e.Row.FindControl("LevelLabel");
            LevelLabel.Text = logItem.Level;
            var messageLabel = (Label)e.Row.FindControl("MessageLabel");
            messageLabel.Text = Server.HtmlEncode((logItem.Message.Length >= 100) ? logItem.Message.Substring(0, 100) + "..." : logItem.Message);
            var exceptionLabel = (Label)e.Row.FindControl("ExceptionLabel");
            exceptionLabel.Text = Server.HtmlEncode(logItem.Exception);
            var LoggerLabel = (Label)e.Row.FindControl("LoggerLabel");
            LoggerLabel.Text = logItem.Logger;

            e.Row.Attributes.Add("onclick", string.Format("ExpandDetails('Exception_{0}')", logItem.Id));
            e.Row.Attributes.Add("style", "cursor:pointer");
        }

        /// <summary>
        /// Gets the log image URL.
        /// </summary>
        /// <param name="type">The type.</param>
        /// <returns></returns>
        private static string GetLogImageUrl(string type)
        {
            switch (type)
            {
                case "FATAL":
                    return @"~\images\exclamation.gif";
                case "ERROR":
                    return @"~\images\error.gif";
                case "WARN":
                    return @"~\images\Critical.gif";
                case "INFO":
                    return @"~\images\information.gif";
                case "DEBUG":
                    return @"~\images\bug.gif";
            }
            return string.Empty;
        }

        /// <summary>
        /// Handles the Click event of the cmdClearLog control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="T:System.EventArgs"/> instance containing the event data.</param>
        protected void cmdClearLog_Click(object sender, EventArgs e)
        {
            ApplicationLogManager.ClearLog();

            if (System.Web.HttpContext.Current.User != null && System.Web.HttpContext.Current.User.Identity.IsAuthenticated)
                MDC.Set("user", System.Web.HttpContext.Current.User.Identity.Name);

            Log.Info("The error log was cleared.");
            BindData();
        }
    }

}