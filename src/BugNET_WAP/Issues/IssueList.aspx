<%@ Page Language="c#" Inherits="BugNET.Issues.IssueList" MasterPageFile="~/Site.master" Title="Issue List"
    CodeBehind="IssueList.aspx.cs" AutoEventWireup="True" meta:resourcekey="Page" Async="true" %>

<%@ Register TagPrefix="it" TagName="DisplayIssues" Src="~/UserControls/DisplayIssues.ascx" %>
<asp:Content ID="Content3" runat="server" ContentPlaceHolderID="MainContent">
    <div class="align-center">
        <h1 class="page-title">Issues</h1>
        <h1 class="page-title">
            <asp:Literal ID="ltProject" runat="server" Visible="false"></asp:Literal>
            <span>
                <asp:Literal ID="litProjectCode" Visible="False" runat="Server"></asp:Literal></span>
        </h1>
    </div>
    <div class="form-inline">
        <div class="form-group">
            <p class="form-control-static">
                <asp:Label ID="ViewIssuesLabel" runat="server" Font-Bold="true" Text="View Issues" meta:resourcekey="ViewIssuesLabel"></asp:Label>
            </p>
        </div>
        <div class="form-group">
            <asp:DropDownList ID="dropView" CssClass="form-control" AutoPostBack="True" runat="Server" OnSelectedIndexChanged="ViewSelectedIndexChanged">
                <asp:ListItem Text="-- Select a View --" Value="" meta:resourcekey="ListItem6" />
                <asp:ListItem Text="Relevant to You" Value="Relevant" meta:resourcekey="ListItem1" />
                <asp:ListItem Text="Assigned to You" Value="Assigned" meta:resourcekey="ListItem2" />
                <asp:ListItem Text="Owned by You" Value="Owned" meta:resourcekey="ListItem3" />
                <asp:ListItem Text="Created by You" Value="Created" meta:resourcekey="ListItem4" />
                <asp:ListItem Text="All Issues" Value="All" meta:resourcekey="ListItem5" />
                <asp:ListItem Text="Open Issues" Value="Open" Selected="True" meta:resourcekey="ListItem7" />
                <asp:ListItem Text="Closed Issues" Value="Closed" meta:resourcekey="ListItem8" />
            </asp:DropDownList>
        </div>
    </div>
    <it:DisplayIssues ID="ctlDisplayIssues" runat="server" ShowProjectColumn="False" OnRebindCommand="IssuesRebind"></it:DisplayIssues>
</asp:Content>
