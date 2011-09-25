<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Membership.ascx.cs" Inherits="BugNET.Administration.Users.UserControls.Membership" %>
<asp:Label ID="lblError" runat="server"  ForeColor="Red" />
<div class="fieldgroup">
    <h3><asp:Label id="lblTitle" runat="server" Text="<%$ Resources:UserDetails %>" /> - <asp:Label id="lblUserName" runat="server"/></h3>
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
            <asp:Label ID="Label6" AssociatedControlID="CreatedDate" runat="server" Text="<%$ Resources:CreatedDate %>" />
            <asp:Label ID="CreatedDate" runat="server" Text="" />
        </li>
        <li>
            <asp:Label ID="Label7" runat="server" AssociatedControlID="LastLoginDate" Text="<%$ Resources:LastLoginDate %>" />
            <asp:Label ID="LastLoginDate" runat="server" Text="" />
        </li>
        <li>
            <asp:Label ID="Label8" AssociatedControlID="LastActivityDate" runat="server" Text="<%$ Resources:LastActivityDate %>" />
            <asp:Label ID="LastActivityDate" runat="server" Text="" />
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
<div class="submit">
    <asp:ImageButton OnClick="cmdUpdate_Click" runat="server" id="save" CssClass="icon" AlternateText="<%$ Resources:SharedResources, Update %>" ImageUrl="~/Images/disk.gif" />
    <asp:LinkButton ID="cmdUpdate" OnClick="cmdUpdate_Click" runat="server" Text="<%$ Resources:SharedResources, Update %>"></asp:LinkButton>
    &nbsp;&nbsp;
    <asp:ImageButton runat="server" id="ibAuthorize" OnClick="AuthorizeUser_Click" CssClass="icon" AlternateText="<%$ Resources:AuthorizeUser %>" causesvalidation="False" ImageUrl="~/Images/shield.gif" />
	<asp:linkbutton id="cmdAuthorize" runat="server" OnClick="AuthorizeUser_Click" Text="<%$ Resources:AuthorizeUser %>" causesvalidation="False" />
    &nbsp;&nbsp;
    <asp:ImageButton runat="server" id="ibUnAuthorize"  OnClick="UnAuthorizeUser_Click" CssClass="icon"  AlternateText="<%$ Resources:UnAuthorizeUser %>" ImageUrl="~/Images/shield.gif" />
	<asp:linkbutton id="cmdUnAuthorize" causesvalidation="False" OnClick="UnAuthorizeUser_Click" runat="server" Text="<%$ Resources:UnAuthorizeUser %>"></asp:linkbutton>	 
	&nbsp;&nbsp;
	<asp:ImageButton runat="server" id="ibUnLock"  OnClick="UnLockUser_Click" causesvalidation="False" AlternateText="<%$ Resources:UnlockUser %>" CssClass="icon" ImageUrl="~/Images/shield.gif" />
	<asp:linkbutton id="cmdUnLock" runat="server" OnClick="UnLockUser_Click" causesvalidation="False" Text="<%$ Resources:UnlockUser %>" />
</div>
