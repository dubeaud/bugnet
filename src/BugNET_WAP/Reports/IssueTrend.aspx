<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.master" CodeBehind="IssueTrend.aspx.cs" Inherits="BugNET.Reports.IssueTrend" %>

<%@ Register Src="~/UserControls/PickDate.ascx" TagPrefix="it" TagName="PickDate" %>
<%@ Register TagPrefix="it" TagName="PickMilestone" Src="~/UserControls/PickMilestone.ascx" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="row">
        <div class="col-md-12">
            <div class="form-inline">
                <div class="form-group col-md-1">
                    <asp:Label ID="MilestoneLabel" AssociatedControlID="DropMilestone" CssClass="control-label" meta:resourcekey="MilestoneLabel" Text="<%$ Resources:SharedResources, Milestone %>" runat="server" />
                </div>
                <div class="form-group col-sm-2">
                    <it:PickMilestone runat="server" ID="DropMilestone" />
                </div>
                <div class="form-group col-sm-2">
                    <asp:Label ID="Label1" AssociatedControlID="StartDate" CssClass="control-label" meta:resourcekey="StartDateLabel" Text="[Start Date]" runat="server" />
                </div>
                <div class="form-group col-sm-2">
                    <it:PickDate runat="server" ID="StartDate" />
                </div>
                <div class="form-group col-sm-2">
                    <asp:Label ID="Label2" AssociatedControlID="EndDate" CssClass="control-label" meta:resourcekey="EndDateLabel" Text="[End  Date]" runat="server" />
                </div>
                <div class="form-group col-sm-2">
                    <it:PickDate runat="server" ID="EndDate" />
                </div>
                <div class="form-group col-sm-1">
                    <asp:Button Text="View Report" ID="ViewReportButton" runat="server" CssClass="btn btn-primary" meta:resourcekey="ViewReportButton" OnClick="ViewReportButton_Click" />
                </div>
            </div>
        </div>
    </div>


    <div style="margin: 15px; text-align: center;">
        <asp:Chart ID="Chart1" runat="server" Width="800" Height="375" ImageType="Png">
            <Legends>
                <asp:Legend Enabled="True" IsTextAutoFit="False" Name="Default" BackColor="Transparent" Font="Segoe UI, 8.25pt, style=Bold"></asp:Legend>
            </Legends>
            <Series>
                <asp:Series Name="Series1" ChartType="Line" MarkerStep="1" MarkerBorderWidth="0" MarkerStyle="Square" MarkerSize="8" BorderWidth="2" BorderColor="180, 26, 59, 105" Color="224, 64, 10"></asp:Series>
                <asp:Series Name="Series2" ChartType="Line" MarkerStep="1" MarkerBorderWidth="0" MarkerStyle="Diamond" MarkerSize="8" BorderWidth="2" BorderColor="180, 26, 59, 105"></asp:Series>
                <asp:Series Name="Series3" ChartType="Line" MarkerStyle="None" BorderWidth="2" BorderColor="180, 26, 59, 105" Color="Black"></asp:Series>
            </Series>
        </asp:Chart>
    </div>

</asp:Content>
