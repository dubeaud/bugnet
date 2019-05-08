<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="IssuesByPriority.aspx.cs" MasterPageFile="~/Site.master" Inherits="BugNET.Reports.IssuesByPriority" %>
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
 

	<div style="margin: 15px;text-align:center;">
		 <asp:Chart ID="Chart1" runat="server" Width="800" Height="375" ImageType="Png">
			<legends>
				<asp:legend Enabled="True"  LegendStyle="Row" Docking="Bottom"  Alignment="Far" IsTextAutoFit="False" Name="Default" BackColor="Transparent" Font="Segoe UI, 8.25pt, style=Bold"></asp:legend>
			</legends>
		</asp:Chart>
	</div>

</asp:Content>