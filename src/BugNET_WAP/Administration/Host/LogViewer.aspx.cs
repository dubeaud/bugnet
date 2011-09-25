using System;
using System.Collections.Generic;
using System.Web.UI.WebControls;
using BugNET.BLL;
using BugNET.Common;
using BugNET.Entities;
using BugNET.UserInterfaceLayer;
using log4net;

namespace BugNET.Administration.Host
{
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
            if (!UserManager.IsInRole(Globals.SUPER_USER_ROLE))
                ErrorRedirector.TransferToLoginPage(this);

            if (!Page.IsPostBack)
            {
                SortField = "Date";
                BindData(FilterDropDown.SelectedValue);
            }
        }

       

        /// <summary>
        /// Gets or sets the sort field.
        /// </summary>
        /// <value>The sort field.</value>
        string SortField
        {
            get
            {
                object o = ViewState["SortField"];
                if (o == null)
                {
                    return String.Empty;
                }
                return (string)o;
            }

            set
            {
                if (value == SortField)
                {
                    // same as current sort file, toggle sort direction
                    SortAscending = !SortAscending;
                }
                ViewState["SortField"] = value;
            }
        }

        /// <summary>
        /// Gets or sets a value indicating whether [sort ascending].
        /// </summary>
        /// <value><c>true</c> if [sort ascending]; otherwise, <c>false</c>.</value>
        bool SortAscending
        {
            get
            {
                object o = ViewState["SortAscending"];
                if (o == null)
                {
                    return true;
                }
                return (bool)o;
            }

            set
            {
                ViewState["SortAscending"] = value;
            }
        }

        /// <summary>
        /// Handles the PageIndexChanging event of the gvLog control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.GridViewPageEventArgs"/> instance containing the event data.</param>
        protected void gvLog_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvLog.PageIndex = e.NewPageIndex;
            BindData(FilterDropDown.SelectedValue);
        }

        /// <summary>
        /// Handles the Sorting event of the gvUsers control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.GridViewSortEventArgs"/> instance containing the event data.</param>
        protected void gvLog_Sorting(object sender, GridViewSortEventArgs e)
        {
            SortField = e.SortExpression;
            BindData(FilterDropDown.SelectedValue);
        }

        /// <summary>
        /// Binds the data.
        /// </summary>
        protected void BindData(string filterType)
        {
            List<ApplicationLog> list = new List<ApplicationLog>();
            list = ApplicationLogManager.GetLog(FilterDropDown.SelectedValue);
            list.Sort(new ApplicationLogComparer(SortField, SortAscending));
            gvLog.DataSource = list;
            gvLog.DataBind();
        }

        protected void FilterDropDown_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindData(FilterDropDown.SelectedValue);
        }

        /// <summary>
        /// Handles the RowDataBound event of the gvLog control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="T:System.Web.UI.WebControls.GridViewRowEventArgs"/> instance containing the event data.</param>
        protected void gvLog_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Pager)
            {
                //e.Row.Cells.AddAt(0, new TableCell());
                //e.Row.Cells[0].Text = "Total Issues: " + _DataSource.Count;
                //e.Row.Cells[0].ColumnSpan = 3;
                //e.Row.Cells[0].Font.Bold = true;
                //e.Row.Cells[0].HorizontalAlign = HorizontalAlign.Left;
                //e.Row.Cells[1].ColumnSpan -= 3;  
                //PresentationUtils.SetPagerButtonStates(gvLog, e.Row, this.Page);

            }
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                ApplicationLog logItem = (ApplicationLog)e.Row.DataItem;
               
                System.Web.UI.WebControls.Image img = (System.Web.UI.WebControls.Image)e.Row.FindControl("imgLevel");
                img.ImageUrl = GetLogImageUrl(logItem.Level);
                img.AlternateText = logItem.Level;
                Label LevelLabel = (Label)e.Row.FindControl("LevelLabel");
                LevelLabel.Text = logItem.Level;
                Label MessageLabel = (Label)e.Row.FindControl("MessageLabel");
                MessageLabel.Text = Server.HtmlEncode((logItem.Message.Length >= 100) ? logItem.Message.Substring(0, 100) + "..." : logItem.Message);
                Label ExceptionLabel = (Label)e.Row.FindControl("ExceptionLabel");
                ExceptionLabel.Text = Server.HtmlEncode(logItem.Exception);
                Label LoggerLabel = (Label)e.Row.FindControl("LoggerLabel");
                LoggerLabel.Text = logItem.Logger;

                e.Row.Attributes.Add("onclick",string.Format("ExpandDetails('Exception_{0}')",logItem.Id));
                e.Row.Attributes.Add("style","cursor:pointer");
            }
        }

        /// <summary>
        /// Gets the log image URL.
        /// </summary>
        /// <param name="type">The type.</param>
        /// <returns></returns>
        private string GetLogImageUrl(string type)
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
            BindData(FilterDropDown.SelectedValue);
        }

        /// <summary>
        /// Handles the SelectedIndexChanged event of the ddlPages control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void ddlPages_SelectedIndexChanged(Object sender, EventArgs e)
        {
            GridViewRow gvrPager = gvLog.BottomPagerRow;
            if (gvrPager == null)
                return;
            DropDownList ddlPages = (DropDownList)gvrPager.Cells[0].FindControl("ddlPages");
            gvLog.PageIndex = ddlPages.SelectedIndex;
            BindData(FilterDropDown.SelectedValue);
        }
    }

}