<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Roles.ascx.cs" Inherits="BugNET.Administration.Users.UserControls.Roles" %>
<asp:Label ID="lblError" runat="server"  ForeColor="Red" />
<div class="fieldgroup">
    <h3><asp:Label id="lblTitle" runat="server" Text="<%$ Resources:ManageRoles %>" /> - <asp:Label id="lblUserName" runat="server"/></h3>  
    <ol>
        <li>
            <asp:Label ID="lblSuperUsers" AssociatedControlID="chkSuperUsers" runat="server" Text="<%$ Resources:SuperUsers %>" />
            <asp:CheckBox ID="chkSuperUsers" OnCheckedChanged="chkSuperUsers_CheckChanged" AutoPostBack="true" Visible="false" Text="" runat="server" />
        </li>
    </ol>
</div>
<fieldset>
    <legend><asp:Label id="Label1" runat="server" Text="<%$ Resources:SharedResources, Project %>" /> <bn:PickProject id="dropProjects" CssClass="standardText" DisplayDefault="true"  OnSelectedIndexChanged="ddlProjects_SelectedIndexChanged" AutoPostBack="true" Runat="Server" /></legend> 
    <asp:CheckBoxList ID="RoleList" Width="500px" RepeatColumns="2" RepeatDirection="Horizontal" runat="server">
    </asp:CheckBoxList>
</fieldset>
<p align="center" style="margin-top:15px;">
    <asp:ImageButton OnClick="cmdUpdateRoles_Click" runat="server" id="save" CssClass="icon" ImageUrl="~/Images/disk.gif" />
    <asp:LinkButton ID="cmdUpdateRoles" runat="server" Text="<%$ Resources:SharedResources, Update %>" OnClick="cmdUpdateRoles_Click"></asp:LinkButton>
</p>
  