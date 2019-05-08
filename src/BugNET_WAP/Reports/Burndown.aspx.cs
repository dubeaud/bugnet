using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BugNET.Entities;
using BugNET.BLL;
using BugNET.Common;
using System.Web.UI.DataVisualization.Charting;
using System.Drawing;

namespace BugNET.Reports
{
    public partial class Burndown : BugNET.UserInterfaceLayer.BasePage
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
                this.Title = GetLocalResourceObject("PageTitle").ToString();

                string ReportName = string.Empty;
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
            Page.Title = string.Format("{0} {1} {0}", p.Name, DropMilestone.SelectedText, GetLocalResourceObject("Burndown"));

            ChartArea c = new ChartArea("ChartArea1");

            Chart1.Series["Series1"].LegendText =  GetLocalResourceObject("RemainingEffort").ToString();
            Chart1.Series["Series2"].LegendText = GetLocalResourceObject("IdealEffort").ToString();

            Chart1.ChartAreas.Add(c);

            foreach (MilestoneBurndown bu in ReportManager.MilestoneBurndown(ProjectId, DropMilestone.SelectedValue, StartDate.SelectedValue.Value, EndDate.SelectedValue.Value))
            {
                Chart1.Series["Series1"].Points.AddXY(bu.Date, bu.Remaining);
                Chart1.Series["Series2"].Points.AddXY(bu.Date, bu.Ideal);
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
            Chart1.ChartAreas["ChartArea1"].AxisY.LineColor = Color.LightGray;
            Chart1.ChartAreas["ChartArea1"].AxisX.LineColor = Color.LightGray;
            Chart1.ChartAreas["ChartArea1"].AxisX.MajorGrid.LineColor = Color.LightGray;
            Chart1.ChartAreas["ChartArea1"].AxisY.MajorGrid.LineColor = Color.LightGray;


            Chart1.Titles.Add(GetLocalResourceObject("ReportTitle").ToString());
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