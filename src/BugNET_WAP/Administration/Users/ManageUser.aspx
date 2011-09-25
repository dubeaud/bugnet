<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Shared/SingleColumn.master" Title="Edit User Account" CodeBehind="ManageUser.aspx.cs" Inherits="BugNET.Administration.Users.ManageUser" %>
<%@ Register src="UserControls/Membership.ascx" tagname="Membership" tagprefix="BN" %>
<%@ Register src="UserControls/Roles.ascx" tagname="Roles" tagprefix="BN" %>
<%@ Register src="UserControls/Profile.ascx" tagname="Profile" tagprefix="BN" %>
<%@ Register src="UserControls/Password.ascx" tagname="Password" tagprefix="BN" %>
<%@ Register src="UserControls/DeleteUser.ascx" tagname="Delete" tagprefix="BN" %>

<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="Content">
  
   <h1 class="page-title">Edit User Account</h1>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="always">
        <ContentTemplate>       
                <div style="text-align:center;">
                    <asp:ImageButton runat="server" ImageUrl="~/Images/vcard.gif" OnClick="ShowMembershipPanel" CssClass="icon" AlternateText="User Details" ID="ibMembership" />
                    <asp:LinkButton ID="cmdManageDetails" runat="server" Text="<%$ Resources:ManageUserDetails %>" OnClick="ShowMembershipPanel" />
                    &nbsp;
                    <asp:ImageButton runat="server" ImageUrl="~/Images/shield.gif" OnClick="ShowRolesPanel" CssClass="icon" AlternateText="<%$ Resources:ManageRoles %>" ID="ibManageRoles" />
                    <asp:LinkButton ID="cmdManageRoles"  runat="server" OnClick="ShowRolesPanel" Text="<%$ Resources:ManageRoles %>" />
                    &nbsp;
                    <asp:ImageButton runat="server"  ImageUrl="~/images/key.gif" OnClick="ShowPasswordPanel" CssClass="icon"  AlternateText="<%$ Resources:ManagePassword %>" ID="ibManagePassword" />
                    <asp:LinkButton ID="cmdManagePassword"  runat="server"  OnClick="ShowPasswordPanel" Text="<%$ Resources:ManagePassword %>" />
                    &nbsp;
                    <asp:ImageButton runat="server"  ImageUrl="~/Images/user.gif" CssClass="icon" OnClick="ShowProfilePanel"  AlternateText="<%$ Resources:ManageProfile %>" ID="ibManageProfile" />
                    <asp:LinkButton ID="cmdManageProfile"  OnClick="ShowProfilePanel"  runat="server" Text="<%$ Resources:ManageProfile %>" />
                    &nbsp;
                    <asp:ImageButton runat="server" id="ibDelete" OnClick="ShowDeletePanel" CssClass="icon" ImageUrl="~/Images/user_delete.gif" />
                    <asp:LinkButton ID="cmdDelete" OnClick="ShowDeletePanel" runat="server" Text="<%$ Resources:DeleteUser %>" />
                    <asp:Label ID="lblError" ForeColor="Red" runat="server"></asp:Label>
                </div>
                <div style="margin-left:auto;margin-right:auto;width:650px;">
                   <asp:panel id="pnlMembership" runat="server">
                        <BN:Membership ID="ctlMembership" runat="server" />                         
                   </asp:panel>
                    <asp:panel id="pnlRoles" runat="server" visible="false">
                        <BN:Roles id="ctlRoles" runat="server" />
                    </asp:panel>
                    <asp:panel id="pnlPassword" runat="server" visible="false">
                	    <BN:Password ID="ctlPassword" runat="server" />
                    </asp:panel>
                    <asp:panel id="pnlProfile" runat="server" visible="false">
        	            <BN:Profile id="ctlProfile" runat="server" />
                    </asp:panel>    
                     <asp:panel id="pnlDelete" runat="server" visible="false">
        	            <BN:Delete id="ctlDeleteUser" runat="server" />
                    </asp:panel>          
                </div>
                <p style="margin: 2em 0pt 0pt; border-top: 1px solid rgb(221, 221, 221); padding-top: 5px;">
                    <asp:ImageButton runat="server"  ImageUrl="~/Images/add.gif" CssClass="icon" OnClick="AddUser_Click"  AlternateText="Add New User" ID="ImageButton2" />
                    <asp:LinkButton ID="LinkButton2" runat="server" OnClick="AddUser_Click" Text="<%$ Resources:AddNewUser %>" />
                    &nbsp;
                    <asp:ImageButton runat="server"  ImageUrl="~/Images/lt.gif" CssClass="icon"  AlternateText="<%$ Resources:SharedResources, Return %>" ID="ImageButton3" OnClick="cmdCancel_Click" />
                    <asp:LinkButton ID="LinkButton3" runat="server" Text="<%$ Resources:SharedResources, Return %>" OnClick="cmdCancel_Click"/>
                </p>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
