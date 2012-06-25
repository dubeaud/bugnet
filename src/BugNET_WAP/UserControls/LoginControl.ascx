<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="LoginControl.ascx.cs" Inherits="BugNET.UserControls.LoginControl" %>
<asp:Panel ID="pnlLoginControl" runat="server" OnLoad="pnlLoginControl_Load">
    <asp:Login 
        ID="subLoginControl" 
        runat="server" 
        DestinationPageUrl="~/Default.aspx" 
        PasswordRecoveryText="Forgot your password?"
        PasswordRecoveryUrl="~/Account/ForgotPassword.aspx" 
        TitleText="Login" 
        VisibleWhenLoggedIn="False" 
        OnLoad="LoginControl_Load">
        <TitleTextStyle CssClass="header" />
        <LabelStyle CssClass="label" HorizontalAlign="Left" />
        <LayoutTemplate>
            <table>
                <tr>
                    <td class="align-center" colspan="2" style="color: red; padding-bottom: 10px;">
                        <asp:Literal ID="FailureText" runat="server" EnableViewState="False"/>&nbsp;
                    </td>
                </tr>                
                <tr>
                    <td class="label align-right" style="padding-right: 5px; width: 100px;">
                        <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName" Text="<%$ Resources:SharedResources, Username %>">Username:</asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="UserName" runat="server" Width="175" onblur="Page_ClientValidate('All')"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName" ErrorMessage="Username is required."
                            meta:resourcekey="UserNameRequired" ToolTip="Username is required." ValidationGroup="ctl00$Login1">*</asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td class="label align-right" style="padding-right: 5px; width: 100px;">
                        <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password" Text="<%$ Resources:SharedResources, Password %>">Password:</asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="Password" runat="server" TextMode="Password" Width="175" onblur="Page_ClientValidate('All')"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password" ErrorMessage="Password is required."
                            meta:resourcekey="PasswordRequired" ToolTip="Password is required." ValidationGroup="ctl00$Login1">*</asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr><td colspan="2">&nbsp;</td></tr>
                <tr>
                    <td colspan="2" class="label">
                        <asp:CheckBox ID="RememberMe" runat="server" meta:resourcekey="RememberMe" Text="Remember me next time." OnCheckedChanged="RememberMe_CheckedChanged" />
                    </td>
                </tr>
                <tr>
                    <td class="align-right" colspan="2" style="padding-right: 8px;">
                        <asp:Button ID="LoginButton" runat="server" CommandName="Login" CssClass="button" meta:resourcekey="LoginButton" Text="Log In"
                            ValidationGroup="ctl00$Login1" OnClick="LoginButton_Click" />
                    </td>
                </tr>
            </table>
            <div style="font-size: 90%; padding-top: 10px;">
                <asp:HyperLink ID="PasswordRecoveryLink" runat="server" meta:resourcekey="PasswordRecoveryLink" NavigateUrl="~/Account/ForgotPassword.aspx">Forgot your password?</asp:HyperLink>
            </div>
            <asp:Panel ID="RegisterPanel" runat="server">
                <div style="font-size: 90%;">
                    <asp:Localize runat="server" ID="Localize3" Text="If you don&#39;t have an account yet you can" meta:resourcekey="NoAccount" />
                    <asp:HyperLink ID="CreateUserLink" runat="server" meta:resourcekey="CreateUserLink" NavigateUrl="~/Account/Register.aspx">click here to get one</asp:HyperLink>.
                </div>                
            </asp:Panel>
        </LayoutTemplate>
    </asp:Login>
</asp:Panel>
