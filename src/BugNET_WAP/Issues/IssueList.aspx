<%@ Page Language="c#" Inherits="BugNET.Issues.IssueList" MasterPageFile="~/Shared/SingleColumn.master" Title="Issue List"
    CodeBehind="IssueList.aspx.cs" AutoEventWireup="True"  meta:resourcekey="Page" Async="true" %>

<%@ Register TagPrefix="it" TagName="DisplayIssues" Src="~/UserControls/DisplayIssues.ascx" %>
<asp:Content ID="Content3" runat="server" ContentPlaceHolderID="PageTitle">
    <div class="align-center">
        <h1 class="page-title"><asp:Label ID="lblProjectName" runat="Server" /></h1>
        <h1 class="page-title">
            <asp:Literal ID="ltProject" runat="server" Visible="false"></asp:Literal>
            <span><asp:Literal ID="litProjectCode" Visible="False" runat="Server"></asp:Literal></span>
        </h1>
    </div>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server">
    <table style="width:100%;">
        <tr>
            <td style="text-align:left;">
                <asp:Label ID="ViewIssuesLabel" runat="server" Text="View Issues:" meta:resourcekey="ViewIssuesLabel"></asp:Label>
                <asp:DropDownList ID="dropView" CssClass="standardText" AutoPostBack="True" runat="Server" OnSelectedIndexChanged="ViewSelectedIndexChanged">
                    <asp:ListItem Text="-- Select a View --" Value="" meta:resourcekey="ListItem6" />
                    <asp:ListItem Text="Relevant to You" Value="Relevant" meta:resourcekey="ListItem1" />
                    <asp:ListItem Text="Assigned to You" Value="Assigned" meta:resourcekey="ListItem2" />
                    <asp:ListItem Text="Owned by You" Value="Owned" meta:resourcekey="ListItem3" />
                    <asp:ListItem Text="Created by You" Value="Created" meta:resourcekey="ListItem4" />
                    <asp:ListItem Text="All Issues" Value="All" meta:resourcekey="ListItem5" />
                    <asp:ListItem Text="Open Issues" Value="Open" Selected="True" meta:resourcekey="ListItem7" />
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="align-vtop">
                <it:DisplayIssues ID="ctlDisplayIssues" runat="server" ShowProjectColumn="False" OnRebindCommand="IssuesRebind"></it:DisplayIssues>
            </td>
        </tr>
    </table>
</asp:Content>
