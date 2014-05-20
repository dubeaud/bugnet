<%@ Page Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" Title="Project Calendar" meta:resourcekey="Page" CodeBehind="ProjectCalendar.aspx.cs" Inherits="BugNET.Projects.ProjectCalendar" %>

<%@ Register TagPrefix="bn" TagName="PickDate" Src="~/UserControls/PickDate.ascx" %>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="page-header">
        <h1 class="page-title">
            <asp:Literal ID="Literal1" runat="server" Text="<%$ Resources:SharedResources, Calendar %>" />
            <small>
                <asp:Literal ID="ltProject" runat="server" />
                <span>(<asp:Literal ID="litProjectCode" runat="Server"></asp:Literal>)</span>
            </small>
        </h1>
    </div>
    <div class="row">
        <div class="col-md-7">
            <div class="form-inline">
                <div class="form-group">
                    <asp:Label ID="ViewLabel" CssClass="control-label" AssociatedControlID="dropView" runat="server" Text="View" meta:resourcekey="ViewLabel"></asp:Label>
                </div>
                <div class="form-group">
                    <asp:DropDownList ID="dropView" CssClass="form-control" AutoPostBack="True"
                        runat="Server" OnSelectedIndexChanged="ViewSelectedIndexChanged">
                        <asp:ListItem Text="Issue Due Dates" Value="IssueDueDates" meta:resourcekey="ListItem3" />
                        <asp:ListItem Text="Milestone Due Dates" Value="MilestoneDueDates" meta:resourcekey="ListItem4" />
                    </asp:DropDownList>
                </div>
            </div>
        </div>
        <div class="col-md-5 text-right">
            <div class="form-inline">
                <div class="form-group col-md-3">
                    <asp:Label ID="Label2" runat="server" CssClass="control-label" AssociatedControlID="JumpToDate" Text="Go To Date:" meta:resourcekey="GotoDate"></asp:Label>
                </div>
                <div class="form-group col-md-4">
                    <bn:PickDate ID="JumpToDate" runat="server" />
                </div>
                <div class="form-group">
                    <asp:Button ID="JumpButton" OnClick="JumpButton_Click" runat="server" meta:resourcekey="JumpButton" CssClass="btn btn-primary" Text="Go" />
                </div>
                <div class="form-group">
                    <asp:Label ID="Label1" runat="server" Text="View:" AssociatedControlID="dropCalendarView" meta:resourcekey="CalendarViewLabel"></asp:Label>
                </div>
                <div class="form-group">
                    <asp:DropDownList ID="dropCalendarView" AutoPostBack="True" CssClass="form-control"
                        runat="Server" OnSelectedIndexChanged="CalendarViewSelectedIndexChanged">
                        <asp:ListItem Text="Month" Value="Month" meta:resourcekey="ListItem1" />
                        <asp:ListItem Text="Week" Value="Week" meta:resourcekey="ListItem2" />
                    </asp:DropDownList>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <asp:LinkButton ID="btnPrevious" CssClass="pull-left" runat="server" OnClick="btnPrevious_Click" meta:resourcekey="btnPrevious" Text="&lt; Previous" ToolTip="Previous" />
            <asp:LinkButton ID="btnNext" CssClass="pull-right" runat="server" OnClick="btnNext_Click" Text="Next &gt;" meta:resourcekey="btnNext" ToolTip="Next" />
        </div>
    </div>
    <asp:Calendar ID="prjCalendar" CssClass="table table-bordered" Width="100%"
        ShowNextPrevMonth="false"
        BorderWidth="0px"
        DayNameFormat="Short"
        OnPreRender="prjCalendar_PreRender"
        OnDayRender="prjCalendar_DayRender" runat="server"
        meta:resourceKey="Calendar">
        <DayStyle CssClass="calendar-day" />
        <DayHeaderStyle CssClass="calendar-day-header" />
        <SelectedDayStyle BackColor="#D8EDF8" ForeColor="#428bca" />
        <WeekendDayStyle />
        <TitleStyle BackColor="White" BorderWidth="0" Font-Bold="true" BorderColor="White" Height="25px" BorderStyle="None" Font-Size="20px" ForeColor="#555557" />
    </asp:Calendar>
</asp:Content>
