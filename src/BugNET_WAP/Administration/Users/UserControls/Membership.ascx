<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Membership.ascx.cs" Inherits="BugNET.Administration.Users.UserControls.Membership" %>

<h2>
    <asp:Literal ID="ControlTitle" runat="server" Text="<%$ Resources:ControlTitle %>" /></h2>
<p>
    <asp:Literal ID="ControlDescription" runat="server" Text="<%$ Resources:ControlDescription %>" /></p>

<bn:Message ID="ActionMessage" runat="server" Visible="False" />
<div class="form-horizontal">
    <div class="form-group">
        <asp:Label ID="Label2" CssClass="col-md-4 control-label" AssociatedControlID="UserName" runat="server" Text="<%$ Resources:SharedResources, Username %>" />
        <div class="col-md-8">
            <asp:TextBox ID="UserName" runat="server" CssClass="form-control" Enabled="false" ReadOnly="true" /></div>
    </div>
    <div class="form-group">
        <asp:Label ID="Label1" CssClass="col-md-4 control-label" AssociatedControlID="FirstName" runat="server" Text="<%$ Resources:SharedResources, FirstName %>" />
        <div class="col-md-8">
            <asp:TextBox ID="FirstName" runat="server" CssClass="form-control" />
        </div>
    </div>
    <div class="form-group">
        <asp:Label ID="Label3" CssClass="col-md-4 control-label" AssociatedControlID="LastName" runat="server" Text="<%$ Resources:SharedResources, LastName %>" />
        <div class="col-md-8">
            <asp:TextBox ID="LastName" runat="server" CssClass="form-control" />
        </div>
    </div>
    <div class="form-group">
        <asp:Label ID="Label5" CssClass="col-md-4 control-label" AssociatedControlID="DisplayName" runat="server" Text="<%$ Resources:SharedResources, DisplayName %>" />
        <div class="col-md-8">
            <asp:TextBox ID="DisplayName" runat="server" CssClass="form-control" />
        </div>
    </div>
    <div class="form-group">
        <asp:Label ID="Label4" CssClass="col-md-4 control-label" AssociatedControlID="Email" runat="server" Text="<%$ Resources:SharedResources, Email %>" />
        <div class="col-md-8">
            <asp:TextBox ID="Email" runat="server" CssClass="form-control" />
        </div>
    </div>
    <div class="form-group">
        <label class="col-md-4 control-label">
            <asp:Literal ID="CreatedDateLabel" runat="server" Text="<%$ Resources:CreatedDate %>" /></label>
        <div class="col-md-8">
            <p class="form-control-static">
                <asp:Literal ID="CreatedDate" runat="server" /></p>
        </div>
    </div>
    <div class="form-group">
        <label class="col-md-4 control-label">
            <asp:Literal ID="LastLoginDateLabel" runat="server" Text="<%$ Resources:LastLoginDate %>" /></label>
        <div class="col-md-8">
            <p class="form-control-static">
                <asp:Literal ID="LastLoginDate" runat="server" /></p>
        </div>
    </div>
    <div class="form-group">
        <label class="col-md-4 control-label">
            <asp:Literal ID="LastActivityDateLabel" runat="server" Text="<%$ Resources:LastActivityDate %>" /></label>
        <div class="col-md-8">
            <p class="form-control-static">
                <asp:Literal ID="LastActivityDate" runat="server" /></p>
        </div>
    </div>
    <div class="form-group">
        <asp:Label ID="Label9" AssociatedControlID="LockedOut" CssClass="col-md-4 control-label" runat="server" Text="<%$ Resources:LockedOut %>" />
        <div class="col-md-8">
            <div class="checkbox">
                <asp:CheckBox ID="LockedOut" Enabled="false" runat="server" />
            </div>
        </div>
    </div>
    <div class="form-group">
        <asp:Label ID="Label10" AssociatedControlID="Authorized" CssClass="col-md-4 control-label" runat="server" Text="<%$ Resources:SharedResources, Authorized %>" />
        <div class="col-md-8">
            <div class="checkbox">
                <asp:CheckBox ID="Authorized" Enabled="false" runat="server" />
            </div>
        </div>
    </div>
    <div class="form-group">
        <asp:Label ID="Label12" AssociatedControlID="Online" CssClass="col-md-4 control-label" runat="server" Text="<%$ Resources:UserIsOnline %>" />
        <div class="col-md-8">
            <div class="checkbox">
                <asp:CheckBox ID="Online" Enabled="false" runat="server" />
            </div>
        </div>
    </div>
</div>
<div style="margin: 2em 0 0 0; border-top: 1px solid #ddd; padding-top: 5px; clear: both;">
    <asp:LinkButton ID="cmdUpdate" CssClass="btn btn-primary" OnClick="CmdUpdateClick" runat="server" Text="<%$ Resources:SharedResources, Save %>"></asp:LinkButton>
    <asp:LinkButton ID="cmdAuthorize" CssClass="btn btn-primary" runat="server" OnClick="AuthorizeUserClick" Text="<%$ Resources:AuthorizeUser %>" CausesValidation="False" />
    <asp:LinkButton ID="cmdUnAuthorize" CssClass="btn btn-danger" CausesValidation="False" OnClick="UnAuthorizeUserClick" runat="server" Text="<%$ Resources:UnAuthorizeUser %>"></asp:LinkButton>
    <asp:LinkButton ID="cmdUnLock" CssClass="btn btn-primary" runat="server" OnClick="UnLockUserClick" CausesValidation="False" Text="<%$ Resources:UnlockUser %>" />
    <asp:HyperLink ID="ReturnLink"  CssClass="btn btn-default" runat="server" NavigateUrl="~/Administration/Users/UserList.aspx" Text="<%$ Resources:BackToUserList %>"></asp:HyperLink>
</div>
