<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SubversionSettings.ascx.cs"
    Inherits="BugNET.Administration.Host.UserControls.SubversionSettings" %>
<h2>
    <asp:Literal ID="Title" runat="Server" Text="<%$ Resources:SubversionSettings %>" /></h2>
<bn:Message ID="Message1" runat="server" Visible="false" />
<div class="form-horizontal">

    <div class="form-group">
        <asp:Label ID="label29" CssClass="col-md-4 control-label" runat="server" AssociatedControlID="EnableRepoCreation" Text="<%$ Resources:EnableAdministration %>" />
        <div class="col-md-8">
            <div class="checkbox">
                <asp:CheckBox CssClass="checkboxlist" ID="EnableRepoCreation" runat="server"></asp:CheckBox>
            </div>
        </div>
    </div>
    <div class="form-group">
        <asp:Label ID="label32" CssClass="col-md-4 control-label" runat="server" AssociatedControlID="RepoRootUrl" Text="<%$ Resources:ServerRootUrl %>" />
        <div class="col-md-8">
            <asp:TextBox ID="RepoRootUrl" CssClass="form-control" runat="Server" />
        </div>
    </div>
    <div class="form-group">
        <asp:Label ID="label30" CssClass="col-md-4 control-label" runat="server" AssociatedControlID="RepoRootPath" Text="<%$ Resources:RootFolder %>" />
        <div class="col-md-8">
            <asp:TextBox ID="RepoRootPath" CssClass="form-control" runat="Server" />
        </div>
    </div>
    <div class="form-group">
        <asp:Label ID="label34" CssClass="col-md-4 control-label" runat="server" AssociatedControlID="SvnHookPath" Text="<%$ Resources:HooksExecutableFile %>" />
        <div class="col-md-8">
            <asp:TextBox ID="SvnHookPath" CssClass="form-control" runat="Server" />
        </div>
    </div>
    <div class="form-group">
        <asp:Label ID="label31" CssClass="col-md-4 control-label" runat="server" AssociatedControlID="RepoBackupPath" Text="<%$ Resources:BackupFolder %>" />
        <div class="col-md-8">
            <asp:TextBox ID="RepoBackupPath" CssClass="form-control" runat="Server" />
        </div>
    </div>
    <div class="form-group">
        <asp:Label ID="label33" CssClass="col-md-4 control-label" runat="server" AssociatedControlID="SvnAdminEmailAddress"
            Text="<%$ Resources:AdministratorEmail %>" />
        <div class="col-md-8">
            <asp:TextBox ID="SvnAdminEmailAddress" CssClass="form-control" runat="Server" />
        </div>
    </div>
</div>
