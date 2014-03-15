<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Password.ascx.cs" Inherits="BugNET.Administration.Users.UserControls.Password" %>
<div>
    <h2>
        <asp:Literal ID="ControlTitle" runat="server" Text="<%$ Resources:ControlTitle %>" /></h2>
</div>
<bn:Message ID="ActionMessage" runat="server" Visible="False" />
<div class="form-horizontal">
    <div class="form-group">
        <label class="col-md-4 control-label">
            <asp:Literal ID="PasswordLastChangedLabel" runat="server" Text="<%$ Resources:PasswordLastChanged %>" /></label>
        <p class="form-control-static col-md-8">
            <asp:Literal ID="PasswordLastChanged" runat="server" />
        </p>
    </div>
</div>
<asp:Panel ID="ChangePassword" runat="server">
    <div class="form-horizontal">
        <h3>
            <asp:Label ID="TitleLabel" Text="<%$ Resources:ChangePassword %>" runat="server" /></h3>
        <div class="form-group">
            <asp:Label ID="Label11" CssClass="col-md-4 control-label" AssociatedControlID="NewPassword" runat="server" Text="<%$ Resources:NewPassword %>" />
            <div class="col-md-8">
                <asp:TextBox ID="NewPassword" CssClass="form-control" runat="server" TextMode="Password" />
            </div>
        </div>
        <div class="form-group">
            <asp:Label ID="Label12" CssClass="col-md-4 control-label" AssociatedControlID="ConfirmPassword" runat="server" Text="<%$ Resources:ConfirmPassword %>" />
            <div class="col-md-8">
                <asp:TextBox ID="ConfirmPassword" CssClass="form-control" runat="server" TextMode="Password" />
                <asp:CompareValidator ID="cvPasswords" runat="server" ControlToValidate="NewPassword" ControlToCompare="ConfirmPassword" Type="String" ErrorMessage="<%$ Resources:PasswordsMustMatch %>"></asp:CompareValidator>
            </div>
        </div>
        <div class="form-group">
            <div class="col-md-offset-2 col-md-4">
                <asp:LinkButton ID="cmdChangePassword" CssClass="btn btn-primary" OnClick="CmdChangePasswordClick" runat="server" Text="<%$ Resources:ChangePassword %>"></asp:LinkButton>
            </div>
        </div>
    </div>
</asp:Panel>
<div style="height: 30px;">&nbsp;</div>
<asp:Panel ID="ResetPassword" runat="server">
    <div class="fieldgroup" style="border: none">
        <h3>
            <asp:Label ID="Label1" runat="server" Text="<%$ Resources:ResetPassword %>" /></h3>
        <asp:Label ID="Label13" runat="server" Text="<%$ Resources:ResetPasswordDesc %>"></asp:Label>
    </div>
    <br>
    <asp:LinkButton ID="cmdResetPassword" CssClass="btn btn-primary" OnClick="CmdChangePasswordClick" runat="server" Text="<%$ Resources:ResetPassword %>" />
</asp:Panel>
<br><br>
<asp:HyperLink ID="ReturnLink" CssClass="btn btn-default" runat="server" NavigateUrl="~/Administration/Users/UserList.aspx" Text="<%$ Resources:BackToUserList %>"></asp:HyperLink>
