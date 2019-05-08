using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BugNET.BLL;
using BugNET.Common;
using BugNET.Entities;
using BugNET.UserInterfaceLayer;
using System.Drawing;
using System.Web.UI.DataVisualization.Charting;

namespace BugNET.Reports
{
    public partial class TimeLogged : BasePage
    {
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
                GenerateStackedReport(p);
            }
        }

        /// <summary>
        /// Generates the report.
        /// </summary>
        /// <param name="p">The p.</param>
        private void GenerateReport(Project p)
        {
            Page.Title = string.Format("{0} {1} {2}", p.Name, DropMilestone.SelectedText, GetLocalResourceObject("ReportTitle").ToString());

            ChartArea c = new ChartArea("ChartArea1");

            Chart1.ChartAreas.Add(c);

            List<ITUser> projectMembers = UserManager.GetUsersByProjectId(ProjectId);
            List<BugNET.Entities.TimeLogged> timeLogged = ReportManager.TimeLogged(ProjectId, DropMilestone.SelectedValue, StartDate.SelectedValue.Value, EndDate.SelectedValue.Value);

            foreach(ITUser user in projectMembers)
            {
                Series s = new Series(user.Id.ToString());
                s.ChartType = SeriesChartType.Column;
                s["PointWidth"] = "0.8";
                s.LegendText = user.DisplayName;

                Chart1.Series.Add(s);

                foreach (BugNET.Entities.TimeLogged tl in timeLogged.Where(o => o.UserId == user.Id))
                {
                    Chart1.Series[s.Name].Points.AddXY(tl.WorkDate, tl.TotalHours);
                }
            }

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
            Chart1.Titles.Add(GetLocalResourceObject("Title2").ToString());
            Chart1.Titles[0].Font = new Font("Segoe UI", 14, FontStyle.Bold);
            Chart1.Titles[1].Font = new Font("Segoe UI", 12, FontStyle.Regular);
            Chart1.Titles[2].Font = new Font("Segoe UI", 10, FontStyle.Regular);
        }

        public void GenerateStackedReport(Project p)
        {
            ChartArea c = new ChartArea("ChartArea1");

            Chart2.ChartAreas.Add(c);

            List<ITUser> projectMembers = UserManager.GetUsersByProjectId(ProjectId);
            List<BugNET.Entities.TimeLogged> timeLogged = ReportManager.TimeLogged(ProjectId, DropMilestone.SelectedValue, StartDate.SelectedValue.Value, EndDate.SelectedValue.Value);

            foreach (ITUser user in projectMembers)
            {
                Series s = new Series();
                s.Name = user.Id.ToString();
                s.ChartType = SeriesChartType.StackedColumn;
                s["PointWidth"] = "0.8";
                s.LegendText = user.DisplayName;

                Chart2.Series.Add(s);

                foreach (BugNET.Entities.TimeLogged tl in timeLogged.Where(o => o.UserId == user.Id))
                {
                    Chart2.Series[s.Name].Points.AddXY(tl.WorkDate, tl.TotalHours);
                }
            }

            Chart2.ChartAreas["ChartArea1"].AxisX.IsMarginVisible = true;
            // Set axis title
            Chart2.ChartAreas["ChartArea1"].AxisX.Title = GetLocalResourceObject("AxisXTitle").ToString();
            // Set Title font
            Chart2.ChartAreas["ChartArea1"].AxisX.TitleFont = new Font("Segoe UI", 10, FontStyle.Regular);
            Chart2.BorderSkin.SkinStyle = BorderSkinStyle.None;

            // Set axis title
            Chart2.ChartAreas["ChartArea1"].AxisY.Title = GetLocalResourceObject("AxisYTitle").ToString();
            // Set Title font
            Chart2.ChartAreas["ChartArea1"].AxisY.TitleFont = new Font("Segoe UI", 10, FontStyle.Regular);
            Chart2.ChartAreas["ChartArea1"].BackColor = Color.White;
            Chart2.ChartAreas["ChartArea1"].BorderColor = Color.LightGray;
            Chart2.ChartAreas["ChartArea1"].BorderDashStyle = ChartDashStyle.Solid;
            Chart2.ChartAreas["ChartArea1"].BorderWidth = 1;
            Chart2.ChartAreas["ChartArea1"].AxisY.LineColor = Color.LightGray;
            Chart2.ChartAreas["ChartArea1"].AxisX.LineColor = Color.LightGray;
            Chart2.ChartAreas["ChartArea1"].AxisX.MajorGrid.LineColor = Color.LightGray;
            Chart2.ChartAreas["ChartArea1"].AxisY.MajorGrid.LineColor = Color.LightGray;

            Chart2.Titles.Add( GetLocalResourceObject("ReportTitle").ToString());
            Chart2.Titles.Add(string.Format("{0} {1}", p.Name, DropMilestone.SelectedText));
            Chart2.Titles.Add( GetLocalResourceObject("Title2").ToString());
            Chart2.Titles[0].Font = new Font("Segoe UI", 14, FontStyle.Bold);
            Chart2.Titles[1].Font = new Font("Segoe UI", 12, FontStyle.Regular);
            Chart2.Titles[2].Font = new Font("Segoe UI", 10, FontStyle.Regular);
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