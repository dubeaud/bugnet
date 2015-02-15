using System;
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BugNET.Common;
using BugNET.UserControls;
using System.Text.RegularExpressions;
using System.Collections.Generic;
using BugNET.BLL;

namespace BugNET.UserInterfaceLayer
{

    /// <summary>
    /// Exports a gridview to excel
    /// </summary>
    public static class GridViewExportUtil
    {
        /// <summary>
        /// 
        /// </summary>
        /// <param name="fileName"></param>
        /// <param name="gv"></param>
        public static void Export(string fileName, GridView gv)
        {
            HttpContext.Current.Response.Clear();
            HttpContext.Current.Response.AddHeader("content-disposition", string.Format("attachment; filename={0}", fileName));
            HttpContext.Current.Response.ContentType = "application/ms-excel";
            HttpContext.Current.Response.Charset = "utf-8";

            using (var sw = new StringWriter())
            {
                using (var htw = new HtmlTextWriter(sw))
                {
                    //  Create a table to contain the grid
                    var table = new Table { GridLines = gv.GridLines };

                    //  include the gridline settings

                    //  add the header row to the table
                    if (gv.HeaderRow != null)
                    {
                        PrepareControlForExport(gv.HeaderRow);
                        table.Rows.Add(gv.HeaderRow);
                    }

                    //  add each of the data rows to the table
                    foreach (GridViewRow row in gv.Rows)
                    {
                        PrepareControlForExport(row);
                        table.Rows.Add(row);
                    }

                    //  add the footer row to the table
                    if (gv.FooterRow != null)
                    {
                        PrepareControlForExport(gv.FooterRow);
                        table.Rows.Add(gv.FooterRow);
                    }

                    for (int j = 0; j < gv.Columns.Count; j++)
                    {
                        if (!gv.Columns[j].Visible)
                        {
                            for (int i = 0; i < table.Rows.Count; i++)
                            {
                                //First 2 columns should be hidden by default.                              
                                table.Rows[i].Cells[0].Visible = false;
                                table.Rows[i].Cells[1].Visible = false;

                                table.Rows[i].Cells[j].Visible = false;
                            }
                        }
                    }

                    //  render the table into the htmlwriter
                    table.RenderControl(htw);

                    //  render the htmlwriter into the response
                    HttpContext.Current.Response.Write(sw.ToString());
                    HttpContext.Current.Response.End();
                }
            }
        }

        /// <summary>
        /// Replace any of the contained controls with literals
        /// </summary>
        /// <param name="control"></param>
        private static void PrepareControlForExport(Control control)
        {
            for (var i = 0; i < control.Controls.Count; i++)
            {
                var current = control.Controls[i];

                //// hide columns
                //if (!columnsToInclude.Contains(i) && (current is System.Web.UI.WebControls.DataControlFieldHeaderCell || current is System.Web.UI.WebControls.DataControlFieldCell) || !current.Visible)
                //{
                //    current.Visible = false;
                //    continue;
                //}                    

                if (current is LinkButton)
                {
                    control.Controls.Remove(current);
                    control.Controls.AddAt(i, new LiteralControl((current as LinkButton).Text));
                }
                else if (current is ImageButton)
                {
                    control.Controls.Remove(current);
                    control.Controls.AddAt(i, new LiteralControl((current as ImageButton).AlternateText));
                }
                else if (current is HyperLink)
                {
                    ((current as HyperLink)).NavigateUrl = HostSettingManager.Get(HostSettingNames.DefaultUrl) + ((current as HyperLink)).NavigateUrl.Substring(2);
                    // control.Controls.Remove(current);
                    // control.Controls.AddAt(i, new LiteralControl((current as HyperLink).Text));
                }
                else if (current is DropDownList)
                {
                    control.Controls.Remove(current);
                    control.Controls.AddAt(i, new LiteralControl((current as DropDownList).SelectedItem.Text));
                }
                else if (current is CheckBox)
                {
                    control.Controls.Remove(current);
                    control.Controls.AddAt(i, new LiteralControl((current as CheckBox).Checked ? "True" : "False"));
                }
                else if (current is TextImage)
                {
                    control.Controls.Remove(current);
                    control.Controls.AddAt(i, new LiteralControl((current as TextImage).Text));
                }
                else if (current is Image)
                {
                    control.Controls.Remove(current);
                    control.Controls.AddAt(i, new LiteralControl((current as Image).AlternateText));
                }
                else if (current is LiteralControl)
                {
                    string text = (current as LiteralControl).Text.Replace(System.Environment.NewLine, "replacement text");
                    text = Regex.Replace((current as LiteralControl).Text, "<.*?>", string.Empty);
                    control.Controls.Remove(current);
                    control.Controls.AddAt(i, new LiteralControl(text));
                }
                else if (current.ID == "Progress")
                {
                    control.Controls.Remove(current);
                    control.Controls.AddAt(i, new LiteralControl(Regex.Replace((current.Controls[1] as System.Web.UI.HtmlControls.HtmlGenericControl).InnerText, "<.*?>", string.Empty)));
                }
                else if (current.ID == "PrivateIssue")
                {
                    control.Controls.Remove(current);
                    if(current.Visible)
                    { 
                        control.Controls.AddAt(i, new LiteralControl(Regex.Replace((current as System.Web.UI.HtmlControls.HtmlGenericControl).InnerText, "<.*?>", string.Empty)));
                    }
                }

                if (current.HasControls())
                {
                    PrepareControlForExport(current);
                }
            }
        }
    }

}
