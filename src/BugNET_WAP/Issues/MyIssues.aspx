<%@ Page Language="C#" MasterPageFile="~/Shared/TwoColumn.Master" AutoEventWireup="true"
    Title="My Issues"  meta:resourceKey="Page" CodeBehind="MyIssues.aspx.cs" Inherits="BugNET.Issues.MyIssues" Async="true" %>

<%@ Register TagPrefix="it" TagName="DisplayIssues" Src="~/UserControls/DisplayIssues.ascx" %>
<asp:Content ID="Content2" ContentPlaceHolderID="PageTitle" runat="server">
    <div class="centered-content">
        <h1 class="page-title">
            <asp:Literal ID="DisplayNameLabel" runat="server" />
        </h1>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Left" runat="server">
    <div class="welcomemessage">
        <h2 class="title">
            <asp:Literal ID="Literal6" runat="server" Text="[Resource Needed]" meta:resourceKey="Statistics_Title" />
        </h2>
        <div class="content">
            <table class="stats">
                <tr>
                    <td class="item-column">
                        <asp:Literal ID="Literal1" runat="server" Text="[Resource Needed]" meta:resourceKey="ViewIssuesDropDownFilter_Assigned" />
                    </td>
                    <td class="count-column">
                        <%=GetTotalAssignedIssueCount()%>
                    </td>
                </tr>
                <tr>
                    <td class="item-column">
                        <asp:Literal ID="Literal2" runat="server" Text="[Resource Needed]" meta:resourceKey="ViewIssuesDropDownFilter_Created" />
                    </td>
                    <td class="count-column">
                        <%=GetTotalCreatedIssueCount()%>
                    </td>
                </tr>
                <tr>
                    <td class="item-column">
                        <asp:Literal ID="Literal3" runat="server" Text="[Resource Needed]" meta:resourceKey="ViewIssuesDropDownFilter_Owned" />
                    </td>
                    <td class="count-column">
                        <%=GetTotalOwnedIssueCount()%>
                    </td>
                </tr>
                <tr>
                    <td class="item-column">
                        <asp:Literal ID="Literal4" runat="server" Text="[Resource Needed]" meta:resourceKey="ViewIssuesDropDownFilter_Monitored" />
                    </td>
                    <td class="count-column">
                        <%=GetTotalMonitoredIssuesCount()%>
                    </td>
                </tr> 
                <tr>
                    <td class="item-column">
                        <asp:Literal ID="Literal5" runat="server" Text="[Resource Needed]" meta:resourceKey="ViewIssuesDropDownFilter_Closed" />
                    </td>
                    <td class="count-column">
                        <%=GetTotalClosedIssueCount()%>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="Content" runat="server">
    <div style="width: 99%">
        <div id="filter-box">
            <div style="float: left;">
                <div><strong><asp:Label ID="ProjectListFilterLabel" runat="server" Text="[Resource Needed]" meta:resourceKey="ProjectListFilterLabel" /></strong></div>
                <div>
                    <asp:ListBox ID="ProjectListBoxFilter" SelectionMode="Multiple" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ProjectListBoxFilter_SelectedIndexChanged" />
                </div>
            </div>
            <div style="margin-left: 10px; float: left;">
                <div><strong><asp:Label ID="ViewIssuesFilterLabel" runat="server" Text="[Resource Needed]" meta:resourceKey="ViewIssuesFilterLabel"></asp:Label></strong></div>
                <div>
                    <asp:DropDownList ID="ViewIssuesDropDownFilter" CssClass="standardText" AutoPostBack="True" runat="Server" OnSelectedIndexChanged="MyIssuesFilterChanged">
                        <asp:ListItem Text="-- Select a View --" Value="" meta:resourceKey="ViewIssuesDropDownFilter_Select" />
                        <%--<asp:ListItem Text="Relevant to You" Value="Relevant" meta:resourcekey="ViewIssuesDropDownFilter_Relevant" />--%>
                        <asp:ListItem Text="Assigned to You" Value="Assigned" Selected="True" meta:resourceKey="ViewIssuesDropDownFilter_Assigned" />
                        <asp:ListItem Text="Created by You" Value="Created" meta:resourceKey="ViewIssuesDropDownFilter_Created" />
                        <asp:ListItem Text="Owned by You" Value="Owned" meta:resourceKey="ViewIssuesDropDownFilter_Owned" />
                        <asp:ListItem Text="Monitored by You" Value="Monitored" meta:resourceKey="ViewIssuesDropDownFilter_Monitored" />
                        <asp:ListItem Text="Closed by You" Value="Closed" meta:resourceKey="ViewIssuesDropDownFilter_Closed" />
                    </asp:DropDownList>
                </div>
            </div>
            <div style="margin-left: 10px; float: left;">
                <div>&nbsp;</div>
                <div>
                    <strong><asp:CheckBox ID="ExcludeClosedIssuesFilter" Checked="True" AutoPostBack="True" runat="server" Text="Exclude Closed Issues" OnCheckedChanged="MyIssuesFilterChanged" meta:resourceKey="ExcludeClosedIssuesFilter"/></strong>
                </div>
            </div>    
        </div>
        <div style="height: 10px;"></div>
        <it:DisplayIssues ID="ctlDisplayIssues" runat="server" ShowProjectColumn="True" OnRebindCommand="IssuesRebind" />
    </div>
</asp:Content>
