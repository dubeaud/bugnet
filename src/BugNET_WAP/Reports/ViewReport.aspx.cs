using System;
using System.Drawing;
using System.Web.UI;
using System.Web.UI.DataVisualization.Charting;
using System.Web.UI.WebControls;
using BugNET.BLL;
using BugNET.Common;
using BugNET.Entities;


namespace BugNET.Reports
{
    /// <summary>
    /// Loads the specified report based on the querystring
    /// </summary>
    public partial class ViewReport : BugNET.UserInterfaceLayer.BasePage 
    {

        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                string ReportName = string.Empty;
                ProjectId = Request.QueryString.Get("pid", 0);
                Project p = ProjectManager.GetById(ProjectId);
                litProjectCode.Text = p.Code;
                Literal1.Text = p.Name;
               
                int ReportId = Request.QueryString.Get("id", 0);
                ProjectId = Request.QueryString.Get("pid", 0);

                switch(ReportId)
                {
                         
                    case 1:
                        ChartArea c = new ChartArea("ChartArea1");
                        Chart1.Width = new Unit("650");
                        Chart1.Height = new Unit("400");

                        Chart1.Series.Add(new Series("Series1"));
                        Chart1.Series.Add(new Series("Series2"));
                        Chart1.ChartAreas.Add(c);

                        foreach (MilestoneBurnup bu in ReportManager.MilestoneBurnup(ProjectId))
                        {
                            Chart1.Series["Series1"].Points.AddXY(bu.MilestoneName, bu.TotalCompleted);
                            Chart1.Series["Series2"].Points.AddXY(bu.MilestoneName, bu.TotalHours);
                        }

                        // Set series chart type
                        Chart1.Series["Series1"].ChartType = SeriesChartType.Line;
                        Chart1.Series["Series2"].ChartType = SeriesChartType.Line;

                        // Set point labels
                        Chart1.Series["Series1"].IsValueShownAsLabel = true;
                        Chart1.Series["Series2"].IsValueShownAsLabel = true;

                        // Set axis labels angle
                        Chart1.ChartAreas["ChartArea1"].AxisX.LabelStyle.Angle = -30;
                       
                        // Enable X axis margin
                        Chart1.ChartAreas["ChartArea1"].AxisX.IsMarginVisible = true;

                        // Enable 3D, and show data point marker lines
                        Chart1.ChartAreas["ChartArea1"].Area3DStyle.Enable3D = false;
                        Chart1.Series["Series1"]["ShowMarkerLines"] = "True";
                        Chart1.Series["Series2"]["ShowMarkerLines"] = "True";

                        // Set axis title
                        Chart1.ChartAreas["ChartArea1"].AxisX.Title = "Milestone";
                        // Set Title font
                        Chart1.ChartAreas["ChartArea1"].AxisX.TitleFont = new Font("Arial", 12, FontStyle.Regular);
   
                        // Set axis title
                        Chart1.ChartAreas["ChartArea1"].AxisY.Title = "Hours";
                        // Set Title font
                        Chart1.ChartAreas["ChartArea1"].AxisY.TitleFont = new Font("Arial", 12, FontStyle.Regular);
                        Chart1.ChartAreas["ChartArea1"].BackColor = Color.Gainsboro;
                        //Chart1.BackSecondaryColor = Color.;
                        Chart1.BackGradientStyle = GradientStyle.DiagonalRight;
                        Chart1.Titles.Add("Burnup Chart");
                        Chart1.BorderSkin.SkinStyle = BorderSkinStyle.Emboss;
                        Chart1.Titles[0].Text = "Burnup Chart";
                        Chart1.Titles[0].Font = new Font("Arial", 14, FontStyle.Bold);


                        ReportName = "Burnup Chart";
                        break;
                    case 2:
                        //report = new IssuesOpenedAndClosed();
                        //((Report)report).ReportParameters["ProjectId"].Value = ProjectId;
                        ReportName = "Issues Opened and Closed in Last 30 days";
                        break;
                    case 3:
                        break;

                }
                //report.DocumentName = string.Format("{0}-{1}-{2}", p.Name, ReportName, DateTime.Now.ToString());
                //ReportViewer1.Report = report;
                Page.Title = ReportName;
          
            }
            
        }
    }
}