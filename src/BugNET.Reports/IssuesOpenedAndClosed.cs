namespace BugNET.Reports
{
    using System;
    using System.ComponentModel;
    using System.Drawing;
    using System.Windows.Forms;
    using Telerik.Reporting;
    using Telerik.Reporting.Drawing;
    using BugNET.BLL;
    using System.Collections.Generic;

    /// <summary>
    /// Summary description for IssuesOpenedAndClosed.
    /// </summary>
    public partial class IssuesOpenedAndClosed : Telerik.Reporting.Report
    {
        public IssuesOpenedAndClosed()
        {
            //
            // Required for telerik Reporting designer support
            //
            InitializeComponent();

            //
            // TODO: Add any constructor code after InitializeComponent call
            //
           
        }

        /// <summary>
        /// Handles the NeedDataSource event of the chart1 control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        private void chart1_NeedDataSource(object sender, System.EventArgs e)
        {
            int ProjectId = (int)this.ReportParameters["ProjectId"].Value;

            chart1.ChartTitle.TextBlock.Text = "Issues Opened and Closed in Last 30 Days";
            chart1.PlotArea.XAxis.DataLabelsColumn = "MilestoneName";
            chart1.PlotArea.XAxis.AxisLabel.TextBlock.Text = "Date";
            chart1.PlotArea.XAxis.AxisLabel.TextBlock.Visible = true;

            chart1.PlotArea.YAxis.AxisMode = Telerik.Reporting.Charting.ChartYAxisMode.Extended;
            chart1.PlotArea.YAxis.AutoScale = true;
            chart1.PlotArea.YAxis.LabelStep = 2;


            chart1.Series[0].DataYColumn = "TotalHours";
            chart1.Series[1].DataYColumn = "TotalCompleted";
            chart1.Series[0].Appearance.LabelAppearance.Visible = false;
            chart1.Series[1].Appearance.LabelAppearance.Visible = false;

            Dictionary<DateTime, int> items = ReportManager.GetOpenIssueCountByDate(96);
            Dictionary<DateTime, int> ClosedItems = ReportManager.GetClosedIssueCountByDate(96);

            DateTime startDate = DateTime.Now.AddDays(-30);
            for (int i = 0; i < 30; i++)
            {
                //add a xaxis date every 5 days.
                if (i % 5 == 0)
                    chart1.PlotArea.XAxis.Items.Add(new Telerik.Reporting.Charting.ChartAxisItem(startDate.AddDays(i).ToShortDateString()));
                if (items.ContainsKey(startDate.AddDays(i).Date))
                {
                    chart1.Series[0].Items.Add(new Telerik.Reporting.Charting.ChartSeriesItem(items[startDate.AddDays(i).Date]));
                }
                if (ClosedItems.ContainsKey(startDate.AddDays(i).Date))
                {
                    chart1.Series[1].Items.Add(new Telerik.Reporting.Charting.ChartSeriesItem(ClosedItems[startDate.AddDays(i).Date]));
                }
            }
          
        }
    }
}