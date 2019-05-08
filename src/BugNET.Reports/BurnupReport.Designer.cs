namespace BugNET.Reports
{
    partial class BurnupReport
    {
        #region Component Designer generated code
        /// <summary>
        /// Required method for telerik Reporting designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            Telerik.Reporting.Charting.Styles.Corners corners1 = new Telerik.Reporting.Charting.Styles.Corners();
            Telerik.Reporting.Charting.Styles.ChartMargins chartMargins1 = new Telerik.Reporting.Charting.Styles.ChartMargins();
            Telerik.Reporting.Charting.ChartSeries chartSeries1 = new Telerik.Reporting.Charting.ChartSeries();
            Telerik.Reporting.Charting.ChartSeries chartSeries2 = new Telerik.Reporting.Charting.ChartSeries();
            Telerik.Reporting.ReportParameter reportParameter1 = new Telerik.Reporting.ReportParameter();
            this.pageHeaderSection1 = new Telerik.Reporting.PageHeaderSection();
            this.detail = new Telerik.Reporting.DetailSection();
            this.BurnupChart = new Telerik.Reporting.Chart();
            this.pageFooterSection1 = new Telerik.Reporting.PageFooterSection();
            ((System.ComponentModel.ISupportInitialize)(this)).BeginInit();
            // 
            // pageHeaderSection1
            // 
            this.pageHeaderSection1.Height = new Telerik.Reporting.Drawing.Unit(0.19999997317790985D, Telerik.Reporting.Drawing.UnitType.Inch);
            this.pageHeaderSection1.Name = "pageHeaderSection1";
            // 
            // detail
            // 
            this.detail.Height = new Telerik.Reporting.Drawing.Unit(4.9000000953674316D, Telerik.Reporting.Drawing.UnitType.Inch);
            this.detail.Items.AddRange(new Telerik.Reporting.ReportItemBase[] {
            this.BurnupChart});
            this.detail.Name = "detail";
            // 
            // BurnupChart
            // 
            this.BurnupChart.Appearance.Border.Color = System.Drawing.Color.FromArgb(((int)(((byte)(138)))), ((int)(((byte)(138)))), ((int)(((byte)(138)))));
            corners1.BottomLeft = Telerik.Reporting.Charting.Styles.CornerType.Round;
            corners1.BottomRight = Telerik.Reporting.Charting.Styles.CornerType.Round;
            corners1.RoundSize = 6;
            corners1.TopLeft = Telerik.Reporting.Charting.Styles.CornerType.Round;
            corners1.TopRight = Telerik.Reporting.Charting.Styles.CornerType.Round;
            this.BurnupChart.Appearance.Corners = corners1;
            this.BurnupChart.Appearance.FillStyle.FillSettings.BackgroundImage = "{chart}";
            this.BurnupChart.Appearance.FillStyle.FillSettings.ImageDrawMode = Telerik.Reporting.Charting.Styles.ImageDrawMode.Flip;
            this.BurnupChart.Appearance.FillStyle.FillSettings.ImageFlip = Telerik.Reporting.Charting.Styles.ImageTileModes.FlipX;
            this.BurnupChart.Appearance.FillStyle.FillType = Telerik.Reporting.Charting.Styles.FillType.Image;
            this.BurnupChart.BitmapResolution = 96F;
            this.BurnupChart.ChartTitle.Appearance.FillStyle.MainColor = System.Drawing.Color.Empty;
            this.BurnupChart.ChartTitle.Appearance.Position.AlignedPosition = Telerik.Reporting.Charting.Styles.AlignedPositions.Top;
            this.BurnupChart.ChartTitle.TextBlock.Appearance.TextProperties.Font = new System.Drawing.Font("Tahoma", 13F);
            this.BurnupChart.DefaultType = Telerik.Reporting.Charting.ChartSeriesType.Line;
            this.BurnupChart.ImageFormat = System.Drawing.Imaging.ImageFormat.Emf;
            this.BurnupChart.Legend.Appearance.Border.Color = System.Drawing.Color.Transparent;
            chartMargins1.Right = new Telerik.Reporting.Charting.Styles.Unit(3D, Telerik.Reporting.Charting.Styles.UnitType.Percentage);
            chartMargins1.Top = new Telerik.Reporting.Charting.Styles.Unit(15.399999618530273D, Telerik.Reporting.Charting.Styles.UnitType.Percentage);
            this.BurnupChart.Legend.Appearance.Dimensions.Margins = chartMargins1;
            this.BurnupChart.Legend.Appearance.FillStyle.MainColor = System.Drawing.Color.Empty;
            this.BurnupChart.Legend.Appearance.ItemMarkerAppearance.Border.Color = System.Drawing.Color.FromArgb(((int)(((byte)(134)))), ((int)(((byte)(134)))), ((int)(((byte)(134)))));
            this.BurnupChart.Legend.Appearance.ItemMarkerAppearance.Figure = "Square";
            this.BurnupChart.Legend.Appearance.Position.AlignedPosition = Telerik.Reporting.Charting.Styles.AlignedPositions.TopRight;
            this.BurnupChart.Location = new Telerik.Reporting.Drawing.PointU(new Telerik.Reporting.Drawing.Unit(0D, Telerik.Reporting.Drawing.UnitType.Inch), new Telerik.Reporting.Drawing.Unit(3.9339065551757812E-05D, Telerik.Reporting.Drawing.UnitType.Inch));
            this.BurnupChart.Name = "BurnupChart";
            this.BurnupChart.PlotArea.Appearance.Border.Color = System.Drawing.Color.FromArgb(((int)(((byte)(134)))), ((int)(((byte)(134)))), ((int)(((byte)(134)))));
            this.BurnupChart.PlotArea.Appearance.FillStyle.FillType = Telerik.Reporting.Charting.Styles.FillType.Solid;
            this.BurnupChart.PlotArea.Appearance.FillStyle.MainColor = System.Drawing.Color.White;
            this.BurnupChart.PlotArea.XAxis.Appearance.Color = System.Drawing.Color.FromArgb(((int)(((byte)(134)))), ((int)(((byte)(134)))), ((int)(((byte)(134)))));
            this.BurnupChart.PlotArea.XAxis.Appearance.MajorGridLines.Color = System.Drawing.Color.FromArgb(((int)(((byte)(209)))), ((int)(((byte)(222)))), ((int)(((byte)(227)))));
            this.BurnupChart.PlotArea.XAxis.Appearance.MajorGridLines.PenStyle = System.Drawing.Drawing2D.DashStyle.Solid;
            this.BurnupChart.PlotArea.XAxis.Appearance.MajorTick.Color = System.Drawing.Color.FromArgb(((int)(((byte)(134)))), ((int)(((byte)(134)))), ((int)(((byte)(134)))));
            this.BurnupChart.PlotArea.XAxis.Appearance.TextAppearance.TextProperties.Color = System.Drawing.Color.FromArgb(((int)(((byte)(51)))), ((int)(((byte)(51)))), ((int)(((byte)(51)))));
            this.BurnupChart.PlotArea.XAxis.AxisLabel.TextBlock.Appearance.TextProperties.Color = System.Drawing.Color.FromArgb(((int)(((byte)(51)))), ((int)(((byte)(51)))), ((int)(((byte)(51)))));
            this.BurnupChart.PlotArea.XAxis.MinValue = 1D;
            this.BurnupChart.PlotArea.YAxis.Appearance.Color = System.Drawing.Color.FromArgb(((int)(((byte)(134)))), ((int)(((byte)(134)))), ((int)(((byte)(134)))));
            this.BurnupChart.PlotArea.YAxis.Appearance.MajorGridLines.Color = System.Drawing.Color.FromArgb(((int)(((byte)(209)))), ((int)(((byte)(222)))), ((int)(((byte)(227)))));
            this.BurnupChart.PlotArea.YAxis.Appearance.MajorTick.Color = System.Drawing.Color.FromArgb(((int)(((byte)(134)))), ((int)(((byte)(134)))), ((int)(((byte)(134)))));
            this.BurnupChart.PlotArea.YAxis.Appearance.MinorGridLines.Color = System.Drawing.Color.FromArgb(((int)(((byte)(233)))), ((int)(((byte)(239)))), ((int)(((byte)(241)))));
            this.BurnupChart.PlotArea.YAxis.Appearance.MinorTick.Color = System.Drawing.Color.FromArgb(((int)(((byte)(134)))), ((int)(((byte)(134)))), ((int)(((byte)(134)))));
            this.BurnupChart.PlotArea.YAxis.Appearance.MinorTick.Width = 0F;
            this.BurnupChart.PlotArea.YAxis.Appearance.TextAppearance.TextProperties.Color = System.Drawing.Color.FromArgb(((int)(((byte)(51)))), ((int)(((byte)(51)))), ((int)(((byte)(51)))));
            this.BurnupChart.PlotArea.YAxis.AxisLabel.TextBlock.Appearance.TextProperties.Color = System.Drawing.Color.FromArgb(((int)(((byte)(51)))), ((int)(((byte)(51)))), ((int)(((byte)(51)))));
            this.BurnupChart.PlotArea.YAxis.MaxValue = 100D;
            this.BurnupChart.PlotArea.YAxis.Step = 10D;
            chartSeries1.Appearance.FillStyle.FillSettings.GradientMode = Telerik.Reporting.Charting.Styles.GradientFillStyle.Vertical;
            chartSeries1.Appearance.FillStyle.MainColor = System.Drawing.Color.FromArgb(((int)(((byte)(55)))), ((int)(((byte)(167)))), ((int)(((byte)(226)))));
            chartSeries1.Appearance.FillStyle.SecondColor = System.Drawing.Color.FromArgb(((int)(((byte)(22)))), ((int)(((byte)(85)))), ((int)(((byte)(161)))));
            chartSeries1.Appearance.TextAppearance.TextProperties.Color = System.Drawing.Color.Black;
            chartSeries1.Name = "Total";
            chartSeries1.Type = Telerik.Reporting.Charting.ChartSeriesType.Line;
            chartSeries2.Appearance.FillStyle.FillSettings.GradientMode = Telerik.Reporting.Charting.Styles.GradientFillStyle.Vertical;
            chartSeries2.Appearance.FillStyle.MainColor = System.Drawing.Color.FromArgb(((int)(((byte)(223)))), ((int)(((byte)(87)))), ((int)(((byte)(60)))));
            chartSeries2.Appearance.FillStyle.SecondColor = System.Drawing.Color.FromArgb(((int)(((byte)(200)))), ((int)(((byte)(38)))), ((int)(((byte)(37)))));
            chartSeries2.Appearance.TextAppearance.TextProperties.Color = System.Drawing.Color.Black;
            chartSeries2.Name = "Complete";
            chartSeries2.Type = Telerik.Reporting.Charting.ChartSeriesType.Line;
            this.BurnupChart.Series.AddRange(new Telerik.Reporting.Charting.ChartSeries[] {
            chartSeries1,
            chartSeries2});
            this.BurnupChart.Size = new Telerik.Reporting.Drawing.SizeU(new Telerik.Reporting.Drawing.Unit(6.4999604225158691D, Telerik.Reporting.Drawing.UnitType.Inch), new Telerik.Reporting.Drawing.Unit(4.8999218940734863D, Telerik.Reporting.Drawing.UnitType.Inch));
            this.BurnupChart.Skin = "Mac";
            // 
            // pageFooterSection1
            // 
            this.pageFooterSection1.Height = new Telerik.Reporting.Drawing.Unit(0.19999949634075165D, Telerik.Reporting.Drawing.UnitType.Inch);
            this.pageFooterSection1.Name = "pageFooterSection1";
            // 
            // BurnupReport
            // 
            this.Items.AddRange(new Telerik.Reporting.ReportItemBase[] {
            this.pageHeaderSection1,
            this.detail,
            this.pageFooterSection1});
            this.PageSettings.Landscape = false;
            this.PageSettings.Margins.Bottom = new Telerik.Reporting.Drawing.Unit(1D, Telerik.Reporting.Drawing.UnitType.Inch);
            this.PageSettings.Margins.Left = new Telerik.Reporting.Drawing.Unit(1D, Telerik.Reporting.Drawing.UnitType.Inch);
            this.PageSettings.Margins.Right = new Telerik.Reporting.Drawing.Unit(1D, Telerik.Reporting.Drawing.UnitType.Inch);
            this.PageSettings.Margins.Top = new Telerik.Reporting.Drawing.Unit(1D, Telerik.Reporting.Drawing.UnitType.Inch);
            this.PageSettings.PaperKind = System.Drawing.Printing.PaperKind.Letter;
            reportParameter1.Name = "ProjectId";
            reportParameter1.Type = Telerik.Reporting.ReportParameterType.Integer;
            this.ReportParameters.Add(reportParameter1);
            this.Style.BackgroundColor = System.Drawing.Color.White;
            this.Width = new Telerik.Reporting.Drawing.Unit(6.5D, Telerik.Reporting.Drawing.UnitType.Inch);
            this.NeedDataSource += new System.EventHandler(this.BurnupChart_NeedDataSource);
            ((System.ComponentModel.ISupportInitialize)(this)).EndInit();

        }
        #endregion

        private Telerik.Reporting.PageHeaderSection pageHeaderSection1;
        private Telerik.Reporting.DetailSection detail;
        private Telerik.Reporting.PageFooterSection pageFooterSection1;
        private Telerik.Reporting.Chart BurnupChart;
    }
}