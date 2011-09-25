<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SubversionSettings.ascx.cs"
    Inherits="BugNET.Administration.Host.UserControls.SubversionSettings" %>
<h2>
    <asp:Literal ID="Title" runat="Server" Text="<%$ Resources:SubversionSettings %>" /></h2>
<bn:Message ID="Message1" runat="server" Visible="false" />
<div class="fieldgroup noborder">
    <ol>
        <li>
            <asp:Label ID="label29" runat="server" AssociatedControlID="EnableRepoCreation" Text="<%$ Resources:EnableAdministration %>" />
            <asp:CheckBox CssClass="checkboxlist" ID="EnableRepoCreation" runat="server"></asp:CheckBox>
        </li>
        <li>
            <asp:Label ID="label32" runat="server" AssociatedControlID="RepoRootUrl" Text="<%$ Resources:ServerRootUrl %>" />
            <asp:TextBox ID="RepoRootUrl" runat="Server" />
        </li>
        <li>
            <asp:Label ID="label30" runat="server" AssociatedControlID="RepoRootPath" Text="<%$ Resources:RootFolder %>" />
            <asp:TextBox ID="RepoRootPath" runat="Server" />
        </li>
        <li>
            <asp:Label ID="label34" runat="server" AssociatedControlID="SvnHookPath" Text="<%$ Resources:HooksExecutableFile %>" />
            <asp:TextBox ID="SvnHookPath" runat="Server" /></li>
        <li>
            <asp:Label ID="label31" runat="server" AssociatedControlID="RepoBackupPath" Text="<%$ Resources:BackupFolder %>" />
            <asp:TextBox ID="RepoBackupPath" runat="Server" />
        </li>
        <li>
            <asp:Label ID="label33" runat="server" AssociatedControlID="SvnAdminEmailAddress"
                Text="<%$ Resources:AdministratorEmail %>" />
            <asp:TextBox ID="SvnAdminEmailAddress" runat="Server" />
        </li>
    </ol>
</div>
