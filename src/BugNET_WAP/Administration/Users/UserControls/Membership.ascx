<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Membership.ascx.cs" Inherits="BugNET.Administration.Users.UserControls.Membership" %>
<div>
	<h2><asp:Literal ID="ControlTitle" runat="server" Text="<%$ Resources:ControlTitle %>" /></h2>
    <asp:Literal ID="ControlDescription" runat="server" Text="<%$ Resources:ControlDescription %>" />
</div>
<BN:Message ID="ActionMessage" runat="server" Visible="False"  />
<div class="fieldgroup" style="border:none"> 
    <ol>
        <li>
            <asp:Label ID="Label2" AssociatedControlID="UserName" runat="server" Text="<%$ Resources:SharedResources, Username %>" />
            <asp:TextBox ID="UserName" runat="server" Enabled="false"  ReadOnly="true"/>
        </li>
        <li>
            <asp:Label ID="Label1" AssociatedControlID="FirstName" runat="server" Text="<%$ Resources:SharedResources, FirstName %>" /> 
            <asp:TextBox ID="FirstName" runat="server" />
        </li>
        <li>
            <asp:Label ID="Label3" AssociatedControlID="LastName" runat="server" Text="<%$ Resources:SharedResources, LastName %>" />
            <asp:TextBox ID="LastName" runat="server" />
        </li>
        <li>
            <asp:Label ID="Label5" AssociatedControlID="DisplayName" runat="server" Text="<%$ Resources:SharedResources, DisplayName %>" />
            <asp:TextBox ID="DisplayName" runat="server" />
        </li>
        <li>
            <asp:Label ID="Label4"  AssociatedControlID="Email" runat="server" Text="<%$ Resources:SharedResources, Email %>" />
            <asp:TextBox ID="Email" runat="server" />
        </li>
        <li>
            <label><asp:Literal ID="CreatedDateLabel" runat="server" Text="<%$ Resources:CreatedDate %>" /></label>
            <span><asp:Literal ID="CreatedDate" runat="server" /></span>
        </li>
        <li>
            <label><asp:Literal ID="LastLoginDateLabel" runat="server" Text="<%$ Resources:LastLoginDate %>" /></label>
            <span><asp:Literal ID="LastLoginDate" runat="server" /></span>
        </li>
        <li>
            <label><asp:Literal ID="LastActivityDateLabel" runat="server" Text="<%$ Resources:LastActivityDate %>" /></label>
            <span><asp:Literal ID="LastActivityDate" runat="server" /></span>
        </li>
        <li>
            <asp:Label ID="Label9" AssociatedControlID="LockedOut" runat="server" Text="<%$ Resources:LockedOut %>" />
            <asp:CheckBox ID="LockedOut" Enabled="false" runat="server" />
        </li>
        <li>
            <asp:Label ID="Label10" AssociatedControlID="Authorized" runat="server" Text="<%$ Resources:SharedResources, Authorized %>" />
            <asp:CheckBox ID="Authorized" Enabled="false" runat="server" />
        </li>
        <li>
            <asp:Label ID="Label12" AssociatedControlID="Online" runat="server" Text="<%$ Resources:UserIsOnline %>" />
            <asp:CheckBox ID="Online" Enabled="false" runat="server" />
        </li>
    </ol>
</div>
<div style="margin:2em 0 0 0; border-top:1px solid #ddd; padding-top:5px; clear:both;">
    <asp:ImageButton OnClick="CmdUpdateClick" runat="server" id="save" CssClass="icon" AlternateText="<%$ Resources:SharedResources, Save %>" ImageUrl="~/Images/disk.gif" />
    <asp:LinkButton ID="cmdUpdate" OnClick="CmdUpdateClick" runat="server" Text="<%$ Resources:SharedResources, Save %>"></asp:LinkButton>
    &nbsp;
    <asp:ImageButton runat="server" id="ibAuthorize" OnClick="AuthorizeUserClick" CssClass="icon" AlternateText="<%$ Resources:AuthorizeUser %>" causesvalidation="False" ImageUrl="~/Images/shield.gif" />
	<asp:linkbutton id="cmdAuthorize" runat="server" OnClick="AuthorizeUserClick" Text="<%$ Resources:AuthorizeUser %>" causesvalidation="False" />
    &nbsp;
    <asp:ImageButton runat="server" id="ibUnAuthorize"  OnClick="UnAuthorizeUserClick" CssClass="icon"  AlternateText="<%$ Resources:UnAuthorizeUser %>" ImageUrl="~/Images/shield.gif" />
	<asp:linkbutton id="cmdUnAuthorize" causesvalidation="False" OnClick="UnAuthorizeUserClick" runat="server" Text="<%$ Resources:UnAuthorizeUser %>"></asp:linkbutton>	 
	&nbsp;
	<asp:ImageButton runat="server" id="ibUnLock"  OnClick="UnLockUserClick" causesvalidation="False" AlternateText="<%$ Resources:UnlockUser %>" CssClass="icon" ImageUrl="~/Images/shield.gif" />
	<asp:linkbutton id="cmdUnLock" runat="server" OnClick="UnLockUserClick" causesvalidation="False" Text="<%$ Resources:UnlockUser %>" />
    &nbsp;
    <asp:ImageButton runat="server" ImageUrl="~/Images/lt.gif" CssClass="icon" CausesValidation="false" AlternateText="<%$ Resources:BackToUserList %>" ID="ImageButton3" OnClick="CmdCancelClick" />
    <asp:HyperLink ID="ReturnLink" runat="server" NavigateUrl="~/Administration/Users/UserList.aspx" Text="<%$ Resources:BackToUserList %>"></asp:HyperLink>
</div>
