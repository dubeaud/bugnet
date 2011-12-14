<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="DeleteUser.ascx.cs" Inherits="BugNET.Administration.Users.UserControls.DeleteUser" %>
<div>
	<h2><asp:Literal ID="ControlTitle" runat="server" Text="<%$ Resources:ControlTitle %>" /></h2>
    <asp:Literal ID="ControlDescription" runat="server" Text="<%$ Resources:ControlDescription %>" />
</div>
<div class="fieldgroup" style="border:none"> 
    <p><asp:Literal ID="DeleteUserText" runat="server" meta:resourcekey="DeleteUserText" /></p>
    <p style="padding-top: 10px;"><asp:Literal ID="DeleteUserText2" runat="server" meta:resourcekey="DeleteUserText2" /></p>
</div>
<BN:Message ID="ActionMessage" runat="server" Visible="False"  />
<div style="margin:2em 0 0 0; border-top:1px solid #ddd; padding-top:5px; clear:both;">
    <asp:ImageButton runat="server" id="imgUnauthorizeAccount" OnClick="UnauthorizeAccountClick" CssClass="icon" ImageUrl="~/Images/key_delete.gif" />
    <asp:LinkButton ID="cmdUnauthorizeAccount" OnClick="UnauthorizeAccountClick" runat="server" Text="Unauthorize this Account" meta:resourcekey="UnauthorizeUser" />
    &nbsp;
    <asp:ImageButton runat="server" id="imgDeleteUser" OnClick="DeleteUserClick" CssClass="icon" ImageUrl="~/Images/user_delete.gif" />
    <asp:LinkButton ID="cmdDeleteUser" OnClick="DeleteUserClick" runat="server" Text="Delete this User" meta:resourcekey="DeleteUser" />
    &nbsp;
    <asp:ImageButton runat="server" ImageUrl="~/Images/lt.gif" CssClass="icon" CausesValidation="false" AlternateText="<%$ Resources:BackToUserList %>" ID="ImageButton3" OnClick="CmdCancelClick" />
    <asp:HyperLink ID="ReturnLink" runat="server" NavigateUrl="~/Administration/Users/UserList.aspx" Text="<%$ Resources:BackToUserList %>"></asp:HyperLink>
</div>