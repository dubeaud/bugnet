using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BugNET.UserInterfaceLayer;
using BugNET.Entities;
using BugNET.BLL;
using System.Web.UI.DataVisualization.Charting;
using BugNET.Common;
using System.Drawing;

namespace BugNET.Reports
{
    public partial class IssuesByPriority : BasePage
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
                ProjectId = Request.QueryString.Get("pid", 0);
                Project p = ProjectManager.GetById(ProjectId);

                // Get milestones
                List<Milestone> milestones = MilestoneManager.GetByProjectId(ProjectId);
                milestones.Reverse();
                DropMilestone.DataSource = milestones;
                DropMilestone.DataBind();

                StartDate.SelectedValue = DateTime.Now.AddDays(-30);
                EndDate.SelectedValue = DateTime.Now;

                GenerateReport(p);
            }
        }

        /// <summary>
        /// Generates the report.
        /// </summary>
        /// <param name="p">The p.</param>
        private void GenerateReport(Project p)
        {
            this.Title = string.Format("{0} {1} {2}", p.Name, DropMilestone.SelectedText, GetLocalResourceObject("PageTitle").ToString());

            ChartArea c = new ChartArea("ChartArea1");
            Chart1.ChartAreas.Add(c);
            Color[] myPalette = new Color[5]{ 
             Color.FromArgb(255, 255, 192, 203), 
             Color.FromArgb(255,255,0,0), 
             Color.FromArgb(255,196, 2, 51), 
             Color.FromArgb(255,230, 32, 32),
             Color.FromArgb(255,206, 32, 41)};

            Chart1.Palette = ChartColorPalette.None;
            Chart1.PaletteCustomColors = myPalette;

            List<Issue> issues = ReportManager.IssuesByPriority(ProjectId, DropMilestone.SelectedValue, StartDate.SelectedValue.Value, EndDate.SelectedValue.Value);
 
            foreach(Priority priority in PriorityManager.GetByProjectId(ProjectId))
            {
                Series s = new Series(priority.Id.ToString());
                s.ChartType = SeriesChartType.StackedColumn;
                s["PointWidth"] = "0.8";
                s.LegendText = priority.Name;
                Chart1.Series.Add(s);

               for (int i = 0; i <= EndDate.SelectedValue.Value.Subtract(StartDate.SelectedValue.Value).Days; i++)
               {
                   int count = issues.Count(o => o.PriorityId == priority.Id);
                 
                   Chart1.Series[s.Name].Points.AddXY(StartDate.SelectedValue.Value.AddDays(i).ToString("MM/dd"), count);
               }
            }
            
            // Set axis labels angle
            Chart1.ChartAreas["ChartArea1"].AxisX.LabelStyle.Angle = -30;

            // Enable X axis margin
            Chart1.ChartAreas["ChartArea1"].AxisX.IsMarginVisible = true;

            // Set axis title
            Chart1.ChartAreas["ChartArea1"].AxisX.Title = GetLocalResourceObject("AxisXTitle").ToString();
            // Set Title font
            Chart1.ChartAreas["ChartArea1"].AxisX.TitleFont = new Font("Segoe UI", 10, FontStyle.Regular);
            Chart1.BorderSkin.SkinStyle = BorderSkinStyle.None;

            // Set axis title
            Chart1.ChartAreas["ChartArea1"].AxisY.Title = GetLocalResourceObject("AxisYTitle").ToString();
            // Set Title font
            Chart1.ChartAreas["ChartArea1"].AxisY.TitleFont = new Font("Segoe UI", 10, FontStyle.Regular);
            Chart1.ChartAreas["ChartArea1"].BackColor = Color.White;
            Chart1.ChartAreas["ChartArea1"].BorderColor = Color.LightGray;
            Chart1.ChartAreas["ChartArea1"].BorderDashStyle = ChartDashStyle.Solid;
            Chart1.ChartAreas["ChartArea1"].BorderWidth = 1;
            Chart1.ChartAreas["ChartArea1"].AxisX.Interval = 2;
            Chart1.ChartAreas["ChartArea1"].AxisX.Maximum = issues.Count + 30;
            Chart1.ChartAreas["ChartArea1"].AxisY.Interval = 5;
            Chart1.ChartAreas["ChartArea1"].AxisY.LineColor = Color.LightGray;
            Chart1.ChartAreas["ChartArea1"].AxisX.LineColor = Color.LightGray;
            Chart1.ChartAreas["ChartArea1"].AxisX.MajorGrid.LineColor = Color.LightGray;
            Chart1.ChartAreas["ChartArea1"].AxisY.MajorGrid.LineColor = Color.LightGray;


            Chart1.Titles.Add(GetLocalResourceObject("PageTitle").ToString());
            Chart1.Titles.Add(string.Format("{0} {1}", p.Name, DropMilestone.SelectedText));
            Chart1.Titles[0].Font = new Font("Segoe UI", 14, FontStyle.Bold);
            Chart1.Titles[1].Font = new Font("Segoe UI", 12, FontStyle.Regular);
        }


        /// <summary>
        /// Handles the Click event of the ViewReportButton control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void ViewReportButton_Click(object sender, EventArgs e)
        {
            Project p = ProjectManager.GetById(ProjectId);
            GenerateReport(p);
        }
    }
}