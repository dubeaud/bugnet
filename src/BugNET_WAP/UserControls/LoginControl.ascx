<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="LoginControl.ascx.cs" Inherits="BugNET.UserControls.LoginControl" %>
       <asp:Panel ID="pnlLoginControl" runat="server" 
    onload="pnlLoginControl_Load" >
           <asp:Login ID="subLoginControl" runat="server" DestinationPageUrl="~/Default.aspx" 
                meta:resourcekey="LoginControl" PasswordRecoveryText="Forgot your password?" 
                PasswordRecoveryUrl="~/Account/ForgotPassword.aspx" TitleText="Login" 
                VisibleWhenLoggedIn="False" onload="LoginControl_Load">
               <TitleTextStyle CssClass="header" />
               <TextBoxStyle Width="110px" />
               <LabelStyle CssClass="label" HorizontalAlign="Left" />
               <CheckBoxStyle CssClass="label" />
               <HyperLinkStyle Font-Size="100%" />
               <LayoutTemplate>
                   <table border="0" cellpadding="1" cellspacing="0" 
                        style="border-collapse: collapse">
                       <tr>
                           <td>
                               <table border="0" cellpadding="0" 
                                    style="width:auto;margin-left:25px;margin-top:10px;">
                                   <tr>
                                       <td align="right" class="label">
                                           <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName" 
                                                Text="<%$ Resources:SharedResources, Username %>">Username:</asp:Label>
                                       </td>
                                       <td>
                                           <asp:TextBox ID="UserName" runat="server" Width="110px"></asp:TextBox>
                                           <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" 
                                                ControlToValidate="UserName" 
                                                ErrorMessage="Username is required." 
                                                meta:resourcekey="UserNameRequired" ToolTip="Username is required." 
                                                ValidationGroup="ctl00$Login1">*</asp:RequiredFieldValidator>
                                       </td>
                                   </tr>
                                   <tr>
                                       <td align="right" class="label">
                                           <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password" 
                                                Text="<%$ Resources:SharedResources, Password %>">Password:</asp:Label>
                                       </td>
                                       <td>
                                           <asp:TextBox ID="Password" runat="server" TextMode="Password" Width="110px"></asp:TextBox>
                                           <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" 
                                                ControlToValidate="Password" ErrorMessage="Password is required." 
                                                meta:resourcekey="PasswordRequired" ToolTip="Password is required." 
                                                ValidationGroup="ctl00$Login1">*</asp:RequiredFieldValidator>
                                       </td>
                                   </tr>
                                   <tr>
                                       <td class="label" colspan="2" style="color: gray; font-size: smaller;">
                                           <asp:CheckBox ID="RememberMe" runat="server" meta:resourcekey="RememberMe" 
                                                Text="Remember me next time." 
                                               oncheckedchanged="RememberMe_CheckedChanged" />
                                       </td>
                                   </tr>
                                   <tr>
                                       <td align="center" colspan="2" style="color: red">
                                           <asp:Literal ID="FailureText" runat="server" EnableViewState="False" 
                                                meta:resourcekey="FailureTextResource1"></asp:Literal>
                                       </td>
                                   </tr>
                                   <tr>
                                       <td align="right" colspan="2">
                                           <asp:Button ID="LoginButton" runat="server" CommandName="Login" 
                                                CssClass="button" meta:resourcekey="LoginButton" 
                                                Text="Log In" ValidationGroup="ctl00$Login1" 
                                               onclick="LoginButton_Click" />
                                       </td>
                                   </tr>
                                   <tr>
                                       <td colspan="2">
                                           <asp:HyperLink ID="PasswordRecoveryLink" runat="server" Font-Size="90%" 
                                                meta:resourcekey="PasswordRecoveryLink" 
                                                NavigateUrl="~/Account/ForgotPassword.aspx">Forgot your password?</asp:HyperLink>
                                       </td>
                                   </tr>
                               </table>
                           </td>
                       </tr>
                   </table>
               </LayoutTemplate>
           </asp:Login>
</asp:Panel>

