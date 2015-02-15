<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Profile.ascx.cs" Inherits="BugNET.Administration.Users.UserControls.Profile" %>

<h2>
    <asp:Literal ID="ControlTitle" runat="server" Text="<%$ Resources:ManageProfile %>" /></h2>
<p>
    <asp:Literal ID="ControlDescription" runat="server" Text="<%$ Resources:ManageProfileDescription %>" /></p>

<bn:Message ID="ActionMessage" runat="server" Visible="False" />
<div class="form-horizontal">
    <div class="form-group">
        <asp:Label ID="Label1" CssClass="col-md-2 control-label" AssociatedControlID="FirstName" runat="server" Text="<%$ Resources:SharedResources, FirstName %>" />
        <div class="col-md-10">
            <asp:TextBox ID="FirstName" CssClass="form-control" runat="server" /></div>
    </div>
    <div class="form-group">
        <asp:Label ID="Label3" CssClass="col-md-2 control-label" AssociatedControlID="LastName" runat="server" Text="<%$ Resources:SharedResources, LastName %>" />
        <div class="col-md-10">
            <asp:TextBox ID="LastName" CssClass="form-control" runat="server" />
        </div>
    </div>
    <div class="form-group">
        <asp:Label ID="Label5" CssClass="col-md-2 control-label" AssociatedControlID="DisplayName" runat="server" Text="<%$ Resources:SharedResources, DisplayName %>" />
        <div class="col-md-10">
            <asp:TextBox ID="DisplayName" CssClass="form-control" runat="server" /></div>
    </div>
</div>
<asp:LinkButton ID="cmdUpdate" CssClass="btn btn-primary" OnClick="CmdUpdateClick" runat="server" Text="<%$ Resources:SharedResources, Save %>" />
<asp:HyperLink ID="ReturnLink" CssClass="btn btn-default" runat="server" NavigateUrl="~/Administration/Users/UserList.aspx" Text="<%$ Resources:BackToUserList %>"></asp:HyperLink>