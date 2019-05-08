<%@ Page Language="C#" MasterPageFile="~/Site.master" Title="<%$ Resources:SharedResources, Reports %>"
    AutoEventWireup="true" CodeBehind="ReportList.aspx.cs" Inherits="BugNET.Reports.ReportList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="page-header">
        <h1 class="page-title">
            <asp:Literal ID="Literal1" runat="server" Text="<%$ Resources:SharedResources, Reports %>" />
            -
            <small>
                <asp:Literal ID="ltProject" runat="server" />
                <span>(<asp:Literal ID="litProjectCode" runat="Server"></asp:Literal>)</span>
            </small>
        </h1>
    </div>
    <ul>
        <li><a style="font-size: 1.2em" href="../Burndown.aspx?pid=<%=ProjectId%>">
            <asp:Literal runat="server" ID="lit1" meta:ResourceKey="MilestoneBurndown" /></a>
            <p style="margin: 5px 0 20px 0;">
                <asp:Literal runat="server" ID="Literal3" meta:ResourceKey="MilestoneBurndownDescription" />
            </p>
        </li>
        <li><a style="font-size: 1.2em" href="../IssueTrend.aspx?pid=<%=ProjectId%>">
            <asp:Literal runat="server" ID="Literal2" meta:ResourceKey="MilestoneIssueTrend" /></a>
            <p style="margin: 5px 0 20px 0;">
                <asp:Literal runat="server" ID="Literal4" meta:ResourceKey="MilestoneIssueTrendDescription" />
            </p>
        </li>
        <li><a style="font-size: 1.2em" href="../TimeLogged.aspx?pid=<%=ProjectId%>">
            <asp:Literal runat="server" ID="Literal6" meta:ResourceKey="TimeLogged" /></a>
            <p style="margin: 5px 0 20px 0;">
                <asp:Literal runat="server" ID="Literal5" meta:ResourceKey="TimeLoggedDescription" />
            </p>
        </li>
        <li><a style="font-size: 1.2em" href="../IssuesByPriority.aspx?pid=<%=ProjectId%>">
            <asp:Literal runat="server" ID="Literal7" meta:ResourceKey="IssuesByPriority" /></a>
            <p style="margin: 5px 0 20px 0;">
                <asp:Literal runat="server" ID="Literal8" meta:ResourceKey="IssuesByPriorityDescription" />
            </p>
        </li>
    </ul>
</asp:Content>
