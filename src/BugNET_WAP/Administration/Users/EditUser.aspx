<%@ Page meta:resourceKey="Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EditUser.aspx.cs" Inherits="BugNET.Administration.Users.EditUser" Async="true" %>

<%@ Register Src="UserControls/Membership.ascx" TagName="Membership" TagPrefix="bn" %>
<%@ Register Src="UserControls/Roles.ascx" TagName="Roles" TagPrefix="bn" %>
<%@ Register Src="UserControls/Password.ascx" TagName="Password" TagPrefix="bn" %>
<%@ Register Src="UserControls/DeleteUser.ascx" TagName="DeleteUser" TagPrefix="bn" %>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="page-header">
        <h1 class="page-title">
            <asp:Literal ID="SectionTitle" runat="Server" meta:resourcekey="SectionTitle" />
            -
            <asp:Literal ID="litUserTitleName" runat="Server" />
        </h1>
    </div>
    <div class="row">
        <div class="col-md-2">
            <ul class="nav nav-pills nav-stacked">
                <asp:Repeater ID="AdminMenu" OnItemDataBound="AdminMenuItemDataBound" OnItemCommand="AdminMenuItemCommand" runat="server">
                    <ItemTemplate>
                        <li runat="server" id="ListItem">
                            <asp:LinkButton ID="MenuButton" runat="server" CausesValidation="false"></asp:LinkButton></li>
                    </ItemTemplate>
                </asp:Repeater>
            </ul>
        </div>
        <div class="col-md-10">
            <asp:Panel ID="pnlAdminControls" runat="server">
                <bn:Membership ID="UserDetails" runat="server" Visible="false" />
                <bn:Roles ID="UserRoles" runat="server" Visible="false" />
                <bn:Password ID="UserPassword" runat="server" Visible="false" />
                <bn:DeleteUser ID="UserDelete" runat="server" Visible="false" />
            </asp:Panel>
        </div>
    </div>
</asp:Content>
