<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Roles.ascx.cs" Inherits="BugNET.Administration.Users.UserControls.Roles" %>
<div>
	<h2><asp:Literal ID="ControlTitle" runat="server" Text="<%$ Resources:ManageRoles %>" /></h2>
    <asp:Literal ID="ControlDescription" runat="server" Text="<%$ Resources:ManageRolesDescription %>" />
</div>
<BN:Message ID="ActionMessage" runat="server" Visible="False"  />
<div class="fieldgroup" style="border:none"> 
    <ol>
        <li>
            <asp:Label ID="lblSuperUsers" AssociatedControlID="chkSuperUsers" runat="server" Text="<%$ Resources:SuperUsers %>" />
            <asp:CheckBox ID="chkSuperUsers" OnCheckedChanged="ChkSuperUsersCheckChanged" AutoPostBack="true" Visible="false" Text="" runat="server" />
        </li>
    </ol>
</div>
<fieldset>
    <legend><asp:Label id="Label1" runat="server" Text="<%$ Resources:SharedResources, Project %>" /> <bn:PickProject id="dropProjects" CssClass="standardText" DisplayDefault="true"  OnSelectedIndexChanged="DdlProjectsSelectedIndexChanged" AutoPostBack="true" Runat="Server" /></legend> 
    <asp:CheckBoxList ID="RoleList" Width="500px" RepeatColumns="2" RepeatDirection="Horizontal" runat="server">
    </asp:CheckBoxList>
</fieldset>
<div style="margin:2em 0 0 0; border-top:1px solid #ddd; padding-top:5px; clear:both;">
    <asp:ImageButton OnClick="CmdUpdateRolesClick" runat="server" id="save" CssClass="icon" ImageUrl="~/Images/disk.gif" />
    <asp:LinkButton ID="cmdUpdateRoles" runat="server" Text="<%$ Resources:SharedResources, Save %>" OnClick="CmdUpdateRolesClick"></asp:LinkButton>
    &nbsp;
    <asp:ImageButton runat="server" ImageUrl="~/Images/lt.gif" CssClass="icon" CausesValidation="false" AlternateText="<%$ Resources:BackToUserList %>" ID="ImageButton3" OnClick="CmdCancelClick" />
    <asp:HyperLink ID="ReturnLink" runat="server" NavigateUrl="~/Administration/Users/UserList.aspx" Text="<%$ Resources:BackToUserList %>"></asp:HyperLink>
</div>