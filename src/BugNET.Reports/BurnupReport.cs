namespace BugNET.Reports
{
    using System;
    using System.ComponentModel;
    using System.Drawing;
    using System.Windows.Forms;
    using Telerik.Reporting;
    using Telerik.Reporting.Drawing;
    using BugNET.BLL;
    using BugNET.Entities;
  

    /// <summary>
    /// Summary description for DailyBurndownReport.
    /// </summary>
    public partial class BurnupReport : Telerik.Reporting.Report
    {
        public BurnupReport()
        {
            //
            // Required for telerik Reporting designer support
            //
            InitializeComponent();
           
        }

        /// <summary>
        /// Handles the NeedDataSource event of the BurnupChart control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        private void BurnupChart_NeedDataSource(object sender, System.EventArgs e)
        {
            int ProjectId = (int)this.ReportParameters["ProjectId"].Value;

            BurnupChart.ChartTitle.TextBlock.Text = "Milestone Burnup";
            BurnupChart.DataSource = ReportManager.MilestoneBurnup(ProjectId);
            BurnupChart.PlotArea.XAxis.DataLabelsColumn = "MilestoneName";
            BurnupChart.PlotArea.XAxis.AxisLabel.TextBlock.Text = "Milestone";
            BurnupChart.PlotArea.XAxis.AxisLabel.TextBlock.Visible = true;
            BurnupChart.Series[0].DataYColumn = "TotalHours";
            BurnupChart.Series[1].DataYColumn = "TotalCompleted";


            BurnupChart.PlotArea.YAxis.AxisLabel.TextBlock.Text = "Sum of Task Estimates (hours)";
            BurnupChart.PlotArea.YAxis.AxisLabel.Visible = true;
            BurnupChart.PlotArea.XAxis.AxisLabel.TextBlock.Text = "Milestone";
            BurnupChart.PlotArea.XAxis.AxisLabel.Visible = true;
            BurnupChart.PlotArea.XAxis.AxisLabel.TextBlock.Appearance.Dimensions.Margins.Bottom = Telerik.Reporting.Charting.Styles.Unit.Pixel(25);
            BurnupChart.PlotArea.XAxis.AxisLabel.TextBlock.Appearance.Dimensions.Margins.Top = Telerik.Reporting.Charting.Styles.Unit.Pixel(25);
            // assign appearance related properties
            BurnupChart.PlotArea.XAxis.Appearance.LabelAppearance.RotationAngle = 300;
            BurnupChart.PlotArea.XAxis.Appearance.LabelAppearance.Position.AlignedPosition = Telerik.Reporting.Charting.Styles.AlignedPositions.Center;
            // BurnupChart.PlotArea.XAxis.Appearance.TextAppearance.TextProperties.Color = System.Drawing.Color.BlueViolet;
            BurnupChart.PlotArea.Appearance.Dimensions.Margins.Bottom = Telerik.Reporting.Charting.Styles.Unit.Percentage(30);

            // visually enhance the data points
            BurnupChart.Series[0].Appearance.PointMark.Dimensions.Width = 5;
            BurnupChart.Series[0].Appearance.PointMark.Dimensions.Height = 5;
            BurnupChart.Series[0].Appearance.PointMark.FillStyle.MainColor = System.Drawing.Color.Black;
            BurnupChart.Series[0].Appearance.PointMark.Visible = true;
            BurnupChart.Series[1].Appearance.PointMark.Dimensions.Width = 5;
            BurnupChart.Series[1].Appearance.PointMark.Dimensions.Height = 5;
            BurnupChart.Series[1].Appearance.PointMark.FillStyle.MainColor = System.Drawing.Color.Black;
            BurnupChart.Series[1].Appearance.PointMark.Visible = true;

           
        }
    }
}