<%@ Page Title="Manage Account" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Manage.aspx.cs" Inherits="BugNET.Account.Manage" meta:resourcekey="PageResource1" %>
<%@ Register Src="~/Account/OpenAuthProviders.ascx" TagPrefix="uc" TagName="OpenAuthProviders" %>
<%@ Import Namespace="Microsoft.AspNet.Membership.OpenAuth" %>
<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <h2><%: Title %>.</h2>

    <div>
        <asp:PlaceHolder runat="server" ID="successMessage" Visible="False" ViewStateMode="Disabled">
            <p class="text-success"><%: SuccessMessage %></p>
        </asp:PlaceHolder>
    </div>

    <div class="row">
        <div class="col-md-12">
            <section id="passwordForm">
                <asp:PlaceHolder runat="server" ID="setPassword" Visible="False">
                    <p>
                        You do not have a local password for this site. Add a local
                        password so you can log in without an external login.
                    </p>
                    <div class="form-horizontal">
                        <h4>Set Password Form</h4>
                        <asp:ValidationSummary runat="server" ShowModelStateErrors="true" CssClass="text-danger" meta:resourcekey="ValidationSummaryResource1" />
                        <div class="form-group">
                            <asp:Label runat="server" AssociatedControlID="password" CssClass="col-md-2 control-label" meta:resourcekey="LabelResource1">Password</asp:Label>
                            <div class="col-md-10">
                                <asp:TextBox runat="server" ID="password" TextMode="Password" CssClass="form-control" meta:resourcekey="passwordResource1" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="password" 
                                    CssClass="text-danger validation-error" ErrorMessage="The password field is required."
                                    Display="Dynamic" ValidationGroup="SetPassword" meta:resourcekey="RequiredFieldValidatorResource1" />
                                <asp:Label runat="server" ID="newPasswordMessage" CssClass="text-danger"
                                    AssociatedControlID="password" meta:resourcekey="newPasswordMessageResource1" />
                            </div>
                        </div>
                        <div class="form-group">
                            <asp:Label runat="server" AssociatedControlID="confirmPassword" CssClass="col-md-2 control-label" meta:resourcekey="LabelResource2">Confirm password</asp:Label>
                            <div class="col-md-10">
                                <asp:TextBox runat="server" ID="confirmPassword" TextMode="Password" CssClass="form-control" meta:resourcekey="confirmPasswordResource1" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="confirmPassword"
                                    CssClass="text-danger validation-error" Display="Dynamic" ErrorMessage="The confirm password field is required."
                                    ValidationGroup="SetPassword" meta:resourcekey="RequiredFieldValidatorResource2" />
                                <asp:CompareValidator runat="server" ControlToCompare="Password" ControlToValidate="confirmPassword"
                                    CssClass="text-danger validation-error" Display="Dynamic" ErrorMessage="The password and confirmation password do not match."
                                    ValidationGroup="SetPassword" meta:resourcekey="CompareValidatorResource1" />
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-md-offset-2 col-md-10">
                                <asp:Button runat="server" Text="Set Password" ValidationGroup="SetPassword" OnClick="setPassword_Click" CssClass="btn btn-default" meta:resourcekey="ButtonResource1" />
                            </div>
                        </div>
                    </div>
        </asp:PlaceHolder>

        <asp:PlaceHolder runat="server" ID="changePassword" Visible="False">
            <p>You're logged in as <strong><%: User.Identity.Name %></strong>.</p>
            
            <asp:ChangePassword runat="server" CancelDestinationPageUrl="~/" ViewStateMode="Disabled" RenderOuterTable="false" SuccessPageUrl="Manage?m=ChangePwdSuccess" meta:resourcekey="ChangePasswordResource1">
                <ChangePasswordTemplate>
                    <div class="form-horizontal">
                        <h4>Change Password Form</h4>
                        <hr />
                        <asp:ValidationSummary runat="server" CssClass="text-danger" meta:resourcekey="ValidationSummaryResource2" />
                        <div class="form-group">
                            <asp:Label runat="server" ID="CurrentPasswordLabel" AssociatedControlID="CurrentPassword" CssClass="col-md-2 control-label" meta:resourcekey="CurrentPasswordLabelResource1">Current password</asp:Label>
                            <div class="col-md-10">
                                <asp:TextBox runat="server" ID="CurrentPassword" TextMode="Password" CssClass="form-control" meta:resourcekey="CurrentPasswordResource1" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="CurrentPassword"
                                    CssClass="text-danger validation-error" ErrorMessage="The current password field is required."
                                    ValidationGroup="ChangePassword" meta:resourcekey="RequiredFieldValidatorResource3" />
                            </div>
                        </div>
                        <div class="form-group">
                            <asp:Label runat="server" ID="NewPasswordLabel" AssociatedControlID="NewPassword" CssClass="col-md-2 control-label" meta:resourcekey="NewPasswordLabelResource1">New password</asp:Label>
                            <div class="col-md-10">
                                <asp:TextBox runat="server" ID="NewPassword" TextMode="Password" CssClass="form-control" meta:resourcekey="NewPasswordResource1" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="NewPassword"
                                    CssClass="text-danger validation-error" ErrorMessage="The new password is required."
                                    ValidationGroup="ChangePassword" meta:resourcekey="RequiredFieldValidatorResource4" />
                            </div>
                        </div>
                        <div class="form-group">
                            <asp:Label runat="server" ID="ConfirmNewPasswordLabel" AssociatedControlID="ConfirmNewPassword" CssClass="col-md-2 control-label" meta:resourcekey="ConfirmNewPasswordLabelResource1">Confirm new password</asp:Label>
                            <div class="col-md-10">
                                <asp:TextBox runat="server" ID="ConfirmNewPassword" TextMode="Password" CssClass="form-control" meta:resourcekey="ConfirmNewPasswordResource1" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="ConfirmNewPassword"
                                    CssClass="text-danger validation-error" Display="Dynamic" ErrorMessage="Confirm new password is required."
                                    ValidationGroup="ChangePassword" meta:resourcekey="RequiredFieldValidatorResource5" />
                                <asp:CompareValidator runat="server" ControlToCompare="NewPassword" ControlToValidate="ConfirmNewPassword"
                                    CssClass="text-danger validation-error" Display="Dynamic" ErrorMessage="The new password and confirmation password do not match."
                                    ValidationGroup="ChangePassword" meta:resourcekey="CompareValidatorResource2" />
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-md-offset-2 col-md-10">
                                <asp:Button runat="server" Text="Change Password" ValidationGroup="ChangePassword" CommandName="ChangePassword" CssClass="btn btn-default" meta:resourcekey="ButtonResource2" />
                            </div>
                        </div>
                    </div>
                </ChangePasswordTemplate>
            </asp:ChangePassword>
        </asp:PlaceHolder>
    </section>

    <section id="externalLoginsForm">
        <asp:ListView runat="server" ID="externalLoginsList" ViewStateMode="Disabled"
            DataKeyNames="ProviderName,ProviderUserId" OnItemDeleting="externalLoginsList_ItemDeleting">
            <LayoutTemplate>
                <h4>Registered Logins</h4>
                <table class="table">
                    <thead><tr><th>Service</th><th>User Name</th><th>Last Used</th><th>&nbsp;</th></tr></thead>
                    <tbody>
                        <tr runat="server" id="itemPlaceholder"></tr>
                    </tbody>
                </table>
            </LayoutTemplate>
            <ItemTemplate>
                <tr>
                    <td><%# HttpUtility.HtmlEncode(Item<OpenAuthAccountData>().ProviderDisplayName) %></td>
                    <td><%# HttpUtility.HtmlEncode(Item<OpenAuthAccountData>().ProviderUserName) %></td>
                    <td><%# HttpUtility.HtmlEncode(ConvertToDisplayDateTime(Item<OpenAuthAccountData>().LastUsedUtc)) %></td>
                    <td>
                        <asp:Button runat="server" Text="Remove" CommandName="Delete" CausesValidation="False" 
                            ToolTip='<%# "Remove this " + Item<OpenAuthAccountData>().ProviderDisplayName + " login from your account" %>'
                            Visible="<%# CanRemoveExternalLogins %>" CssClass="btn btn-default" meta:resourcekey="ButtonResource3" />
                    </td>
                </tr>
            </ItemTemplate>
        </asp:ListView>

        <uc:OpenAuthProviders runat="server" ReturnUrl="~/Account/Manage" ID="Unnamed2" />
    </section>
    </div>
</div>
</asp:Content>
