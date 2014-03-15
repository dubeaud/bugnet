<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="DeleteUser.ascx.cs" Inherits="BugNET.Administration.Users.UserControls.DeleteUser" %>
<div>
    <h2>
        <asp:Literal ID="ControlTitle" runat="server" Text="<%$ Resources:ControlTitle %>" /></h2>
</div>
<div>
    <p>
        <asp:Literal ID="DeleteUserText" runat="server" meta:resourcekey="DeleteUserText" /></p>
    <p style="padding-top: 10px;">
        <asp:Literal ID="DeleteUserText2" runat="server" meta:resourcekey="DeleteUserText2" /></p>
</div>
<bn:Message ID="ActionMessage" runat="server" Visible="False" />
<hr>
<asp:LinkButton ID="cmdUnauthorizeAccount" CssClass="btn btn-warning" OnClick="UnauthorizeAccountClick" runat="server" Text="Unauthorize this Account" meta:resourcekey="UnauthorizeUser" />
<asp:LinkButton ID="cmdDeleteUser" CssClass="btn btn-danger" OnClick="DeleteUserClick" runat="server" Text="Delete this User" meta:resourcekey="DeleteUser" />
<asp:HyperLink ID="ReturnLink" CssClass="btn btn-default" runat="server" NavigateUrl="~/Administration/Users/UserList.aspx" Text="<%$ Resources:BackToUserList %>"></asp:HyperLink>