<%@ Page Language="C#" MasterPageFile="~/Shared/SingleColumn.master" AutoEventWireup="true" Title="Project Calendar" meta:resourcekey="Page" CodeBehind="ProjectCalendar.aspx.cs" Inherits="BugNET.Projects.ProjectCalendar"  %>

<asp:Content ID="Content3" ContentPlaceHolderID="Content" runat="server">
    <div style="margin: 0 auto;width:850px;">
        <div>
            <h1><asp:Label id="lblProjectName" Runat="Server" /></h1>
        </div>
        <table style="width:850px;border:0;border-collapse:collapse;">
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
              
                    <asp:Label ID="Label2" runat="server" Text="Go To Date:"   meta:resourcekey="GotoDate" ></asp:Label> 
                    <bn:PickDate id="JumpToDate" runat="server" />   
                    <asp:button ID="JumpButton" OnClick="JumpButton_Click"  runat="server"   meta:resourcekey="JumpButton" Text="Go" />
                    <asp:Label ID="Label1" runat="server" Text="View:" meta:resourcekey="CalendarViewLabel"></asp:Label>
                     <asp:DropDownList id="dropCalendarView" CssClass="standardText" AutoPostBack="True" 
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
                <td class="align-right" style="height:25px;padding-left:5px;">      
                    <asp:LinkButton ID="btnNext" runat="server" OnClick="btnNext_Click" Text="Next &gt;" meta:resourcekey="btnNext"  ToolTip="Next" />
                </td>
            </tr>
            <tr> 
                <td colspan="2">
                    <asp:Calendar ID="prjCalendar" Width="100%" SkinID="Calendar" OnPreRender="prjCalendar_PreRender" OnDayRender="prjCalendar_DayRender" runat="server" />                 
                </td>
            </tr>
        </table>
       
    </div>
</asp:Content>
