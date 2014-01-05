<%@ Page Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" Title="Project Calendar" meta:resourcekey="Page" CodeBehind="ProjectCalendar.aspx.cs" Inherits="BugNET.Projects.ProjectCalendar"  %>
<%@ Register TagPrefix="bn" TagName="PickDate" Src="~/UserControls/PickDate.ascx" %>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div>
        <div class="page-header">
            <h1><asp:Label id="lblProjectName" Runat="Server" /></h1>
        </div>
        <table style="width:100%;border:0;border-collapse:collapse;">
            <tr>
                <td>
                    <asp:Label ID="ViewLabel" runat="server" Text="View:" meta:resourcekey="ViewLabel"></asp:Label>
                    <asp:DropDownList id="dropView" CssClass="standardText" AutoPostBack="True" 
                            runat="Server" OnSelectedIndexChanged="ViewSelectedIndexChanged">
                        <asp:ListItem Text="Issue Due Dates" Value="IssueDueDates" meta:resourcekey="ListItem3" />
                        <asp:ListItem Text="Milestone Due Dates" Value="MilestoneDueDates"  meta:resourcekey="ListItem4"/>
                    </asp:DropDownList>
                </td>
                <td style="text-align:right;">
                    <asp:Label ID="Label2" runat="server" Text="Go To Date:" meta:resourcekey="GotoDate" ></asp:Label> 
                    <bn:PickDate ID="JumpToDate" runat="server" />
                    <asp:button ID="JumpButton" OnClick="JumpButton_Click"  runat="server"   meta:resourcekey="JumpButton" CssClass="btn" Text="Go" />
                    <asp:Label ID="Label1" runat="server" Text="View:" meta:resourcekey="CalendarViewLabel"></asp:Label>
                     <asp:DropDownList id="dropCalendarView" AutoPostBack="True" 
                            runat="Server" OnSelectedIndexChanged="CalendarViewSelectedIndexChanged">
                    <asp:ListItem Text="Month" Value="Month" meta:resourcekey="ListItem1" />
                    <asp:ListItem Text="Week" Value="Week" meta:resourcekey="ListItem2" />
                    </asp:DropDownList>
 
                </td>
            </tr>
            <tr>
                <td class="align-left" style="height:25px;padding-left:5px;">
                    <asp:LinkButton ID="btnPrevious" runat="server" OnClick="btnPrevious_Click" meta:resourcekey="btnPrevious" Text="&lt; Previous" ToolTip="Previous" />
                </td>
                <td class="pull-right align-right" style="height:25px;padding-left:5px;">
                    <asp:LinkButton ID="btnNext" runat="server" OnClick="btnNext_Click" Text="Next &gt;" meta:resourcekey="btnNext"  ToolTip="Next" />
                </td>
            </tr>
            <tr> 
                <td colspan="2">
                    <asp:Calendar ID="prjCalendar" CssClass="table table-bordered" Width="100%"  
                        ShowNextPrevMonth="false"  
                        BorderWidth="0px" 
                        DayNameFormat="Short"
                        OnPreRender="prjCalendar_PreRender" 
                        OnDayRender="prjCalendar_DayRender" runat="server"
                        meta:resourceKey="Calendar">
                        <DayStyle CssClass="calendar-day" />
                        <DayHeaderStyle CssClass="calendar-day-header" />
                        <SelectedDayStyle BackColor="#D8EDF8"  ForeColor="#428bca" />
                        <WeekendDayStyle />
                        <TitleStyle BackColor="White" BorderWidth="0" Font-Bold="true" BorderColor="White" Height="25px" BorderStyle="None" Font-Size="20px" ForeColor="#555557" />
                    </asp:Calendar>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
