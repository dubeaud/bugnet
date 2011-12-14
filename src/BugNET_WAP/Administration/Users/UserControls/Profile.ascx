<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Profile.ascx.cs" Inherits="BugNET.Administration.Users.UserControls.Profile" %>
<div>
	<h2><asp:Literal ID="ControlTitle" runat="server" Text="<%$ Resources:ManageProfile %>" /></h2>
    <asp:Literal ID="ControlDescription" runat="server" Text="<%$ Resources:ManageProfileDescription %>" />
</div>
<BN:Message ID="ActionMessage" runat="server" Visible="False"  />
<div class="fieldgroup" style="border:none"> 
    <ol>
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
    </ol>
</div>
<div style="margin:2em 0 0 0; border-top:1px solid #ddd; padding-top:5px; clear:both;">
    <asp:ImageButton OnClick="CmdUpdateClick" runat="server" id="save" CssClass="icon" ImageUrl="~/Images/disk.gif" />
    <asp:LinkButton ID="cmdUpdate" OnClick="CmdUpdateClick" runat="server" Text="<%$ Resources:SharedResources, Save %>" />
    &nbsp;
    <asp:ImageButton runat="server" ImageUrl="~/Images/lt.gif" CssClass="icon" CausesValidation="false" AlternateText="<%$ Resources:BackToUserList %>" ID="ImageButton3" OnClick="CmdCancelClick" />
    <asp:HyperLink ID="ReturnLink" runat="server" NavigateUrl="~/Administration/Users/UserList.aspx" Text="<%$ Resources:BackToUserList %>"></asp:HyperLink>
</div>