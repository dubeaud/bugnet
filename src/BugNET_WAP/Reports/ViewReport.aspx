<%@ Page  Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeBehind="ViewReport.aspx.cs" Inherits="BugNET.Reports.ViewReport" %>


<asp:Content ID="Content1" ContentPlaceHolderID="PageTitle" runat="server">
    <div class="centered-content">
        <h1 class="page-title">
            <asp:Literal ID="Literal1" runat="server" Text="<%$ Resources:SharedResources, Reports %>" />
            -
            <asp:Literal ID="ltProject" runat="server" />
            <span>(<asp:Literal ID="litProjectCode" runat="Server"></asp:Literal>)</span>
        </h1>
    </div>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Content" runat="server">
    <div style="margin: 15px;text-align:center;">
        <asp:Chart ID="Chart1" runat="server"  />
    </div>
</asp:Content>
