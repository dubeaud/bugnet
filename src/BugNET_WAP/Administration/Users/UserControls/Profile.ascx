<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Profile.ascx.cs" Inherits="BugNET.Administration.Users.UserControls.Profile" %>
<asp:Label ID="lblError" runat="server"  ForeColor="Red" />
<div class="fieldgroup">
    <h3><asp:Label id="lblTitle" runat="server" Text="<%$ Resources:ManageProfile %>" /> - <asp:Label id="lblUserName" runat="server"/></h3>
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
<div class="submit">
    <asp:ImageButton OnClick="cmdUpdate_Click" runat="server" id="save" CssClass="icon" ImageUrl="~/Images/disk.gif" />
    <asp:LinkButton ID="cmdUpdate" OnClick="cmdUpdate_Click" runat="server" Text="<%$ Resources:SharedResources, Update %>" />
</div>