<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    Title="My Issues" meta:resourceKey="Page" CodeBehind="MyIssues.aspx.cs" Inherits="BugNET.Issues.MyIssues" Async="true" %>

<%@ Register TagPrefix="it" TagName="DisplayIssues" Src="~/UserControls/DisplayIssues.ascx" %>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
     <div class="page-header">
        <h1>
            <asp:Literal ID="DisplayNameLabel" runat="server" />
        </h1>
    </div>

    <div class="col-md-12">
        <div class="row">
            <div class="col-md-2">
                <h2>
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
            <div class="col-md-10">
                <div class="row">
                    <div class="col-md-5">
                        <div>
                            <strong>
                                <asp:Label ID="ProjectListFilterLabel" runat="server" Text="[Resource Needed]" meta:resourceKey="ProjectListFilterLabel" /></strong>
                        </div>
                        <div>
                            <asp:ListBox ID="ProjectListBoxFilter" Height="100px" CssClass="form-control" SelectionMode="Multiple" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ProjectListBoxFilter_SelectedIndexChanged" />
                        </div>
                    </div>

                    <div class="col-md-3">
                        <div>
                            <strong>
                                <asp:Label ID="ViewIssuesFilterLabel" runat="server" Text="[Resource Needed]" meta:resourceKey="ViewIssuesFilterLabel"></asp:Label></strong>
                        </div>
                        <div>
                            <asp:DropDownList ID="ViewIssuesDropDownFilter" CssClass="form-control" AutoPostBack="True" runat="Server" OnSelectedIndexChanged="MyIssuesFilterChanged">
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
                    <div class="col-md-3">
                        <div class="checkbox">
                            <asp:CheckBox ID="ExcludeClosedIssuesFilter" Checked="True" AutoPostBack="True" runat="server" Text="Exclude Closed Issues" OnCheckedChanged="MyIssuesFilterChanged" meta:resourceKey="ExcludeClosedIssuesFilter" />
                        </div>
                    </div>
                </div>
                <div class="row">
                    <it:DisplayIssues ID="ctlDisplayIssues" runat="server" ShowProjectColumn="True" OnRebindCommand="IssuesRebind" />
                </div>
            </div>

        </div>
    </div>

</asp:Content>
