<%@ Page meta:resourceKey="Page" Language="C#" MasterPageFile="~/Shared/TwoColumn.Master" AutoEventWireup="true" CodeBehind="EditUser.aspx.cs" Inherits="BugNET.Administration.Users.EditUser" Async="true" %>
<%@ Register src="UserControls/Membership.ascx" tagname="Membership" tagprefix="bn" %>
<%@ Register src="UserControls/Roles.ascx" tagname="Roles" tagprefix="bn" %>
<%@ Register src="UserControls/Password.ascx" tagname="Password" tagprefix="bn" %>
<%@ Register src="UserControls/Profile.ascx" tagname="Profile" tagprefix="bn" %>
<%@ Register src="UserControls/DeleteUser.ascx" tagname="DeleteUser" tagprefix="bn" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageTitle" runat="server">
    <h1 class="page-title"><asp:literal ID="SectionTitle" runat="Server" meta:resourcekey="SectionTitle"  /> - <asp:Literal id="litUserTitleName" runat="Server"/></h1>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Left" runat="server">
     <ul class="sideMenu">
        <asp:Repeater ID="AdminMenu" OnItemDataBound="AdminMenuItemDataBound" OnItemCommand="AdminMenuItemCommand" runat="server">
           <ItemTemplate>
                <li runat="server" id="ListItem"><asp:LinkButton ID="MenuButton" runat="server" CausesValidation="false" ></asp:LinkButton></li>
           </ItemTemplate>
        </asp:Repeater>
    </ul>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Content" runat="server">
    <asp:Panel ID="pnlAdminControls" runat="server">
        <bn:Membership ID="UserDetails" runat="server" Visible="false" />
        <bn:Roles ID="UserRoles" runat="server" Visible="false" />
        <bn:Password ID="UserPassword" runat="server" Visible="false" />
        <bn:Profile ID="UserProfile" runat="server" Visible="false" />
        <bn:DeleteUser ID="UserDelete" runat="server" Visible="false" />
    </asp:Panel>
</asp:Content>
