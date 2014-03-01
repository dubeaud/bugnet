<%@ Page Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" Inherits="BugNET.Errors.Error" Title="<%$ Resources:ApplicationError %>" Codebehind="Error.aspx.cs" %>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <h1><asp:literal ID="litTitle" runat="server" Text="<%$ Resources:ApplicationError %>"></asp:literal> - <%=Request.QueryString["aspxerrorpath"]%></h1>
    <p style="margin-top:1em"><asp:Label id="Label1" runat="server" Text="<%$ Resources:Message %>" /></p> 
    <p style="margin-top:1em"><asp:Label id="Label2" runat="server" /></p>
</asp:Content>


