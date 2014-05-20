<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Roles.ascx.cs" Inherits="BugNET.Administration.Users.UserControls.Roles" %>
<div>
    <h2>
        <asp:Literal ID="ControlTitle" runat="server" Text="<%$ Resources:ManageRoles %>" /></h2>
    <asp:Literal ID="ControlDescription" runat="server" Text="<%$ Resources:ManageRolesDescription %>" />
</div>
<p>
    <bn:Message ID="ActionMessage" runat="server" Visible="False" />
</p>
<div class="form-horizontal">
    <div class="form-group">
        <asp:Label ID="lblSuperUsers" CssClass="col-md-4 control-label" AssociatedControlID="chkSuperUsers" runat="server" Text="<%$ Resources:SuperUsers %>" />
        <div class="col-md-8">
            <div class="checkbox">
                <asp:CheckBox ID="chkSuperUsers" OnCheckedChanged="ChkSuperUsersCheckChanged" AutoPostBack="true" Visible="false" Text="" runat="server" />
            </div>
        </div>
    </div>
    <div class="form-group">
        <asp:Label ID="Label1" CssClass="col-md-4 control-label" AssociatedControlID="dropProjects" runat="server" Text="<%$ Resources:SharedResources, Project %>" />
        <div class="col-md-8">
            <bn:PickProject ID="dropProjects" CssClass="form-control" DisplayDefault="true" OnSelectedIndexChanged="DdlProjectsSelectedIndexChanged" AutoPostBack="true" runat="Server" />
        </div>
    </div>
</div>
<h3><asp:Literal ID="Literal1" runat="server" Text="<%$ Resources:Roles %>"/></h3>
<asp:CheckBoxList ID="RoleList" CssClass="checkbox" RepeatLayout="Flow" RepeatDirection="Vertical" runat="server">
</asp:CheckBoxList>
<hr />
<div class="row">
    <asp:LinkButton ID="cmdUpdateRoles" CssClass="btn btn-primary" runat="server" Text="<%$ Resources:SharedResources, Save %>" OnClick="CmdUpdateRolesClick"></asp:LinkButton>
    <asp:HyperLink ID="ReturnLink" CssClass="btn btn-default" runat="server" NavigateUrl="~/Administration/Users/UserList.aspx" Text="<%$ Resources:BackToUserList %>"></asp:HyperLink>
</div>
