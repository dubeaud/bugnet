<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Password.ascx.cs" Inherits="BugNET.Administration.Users.UserControls.Password" %>
<div>
	<h2><asp:Literal ID="ControlTitle" runat="server" Text="<%$ Resources:ControlTitle %>" /></h2>
</div>
<BN:Message ID="ActionMessage" runat="server" Visible="False"  />
<div class="fieldgroup" style="border: none"> 
    <ol>
        <li>
            <label><asp:Literal ID="PasswordLastChangedLabel" runat="server" Text="<%$ Resources:PasswordLastChanged %>" /></label>
            <span><asp:Literal ID="PasswordLastChanged" runat="server" /></span>
        </li>
    </ol>
</div>
<asp:Panel id="ChangePassword" runat="server">
    <div class="fieldgroup" style="border: none">
        <h3><asp:Label id="TitleLabel" Text="<%$ Resources:ChangePassword %>" runat="server"/></h3>
        <ol>
            <li>
                <asp:Label ID="Label11"  AssociatedControlID="NewPassword" runat="server" Text="<%$ Resources:NewPassword %>" />     
                <asp:TextBox ID="NewPassword" runat="server" TextMode="Password" />
            </li>
            <li>
                <asp:Label ID="Label12" AssociatedControlID="ConfirmPassword" runat="server" Text="<%$ Resources:ConfirmPassword %>" />
                <asp:TextBox ID="ConfirmPassword" runat="server" TextMode="Password" />
                <asp:CompareValidator ID="cvPasswords" runat="server" ControlToValidate="NewPassword" ControlToCompare="ConfirmPassword" Type="String" ErrorMessage="<%$ Resources:PasswordsMustMatch %>"></asp:CompareValidator>
            </li>
        </ol>
    </div>
    <div style="margin:2em 0 0 0; border-top:1px solid #ddd; padding-top:5px; clear:both;">
        <asp:ImageButton runat="server" id="ImageButton1" OnClick="CmdChangePasswordClick" CssClass="icon" ImageUrl="~/Images/key_go.gif" />
        <asp:LinkButton ID="cmdChangePassword"  OnClick="CmdChangePasswordClick" runat="server" Text="<%$ Resources:ChangePassword %>"></asp:LinkButton>
    </div>
</asp:Panel>
<div style="height: 30px;">&nbsp;</div>
<asp:Panel id="ResetPassword" runat="server">
    <div class="fieldgroup" style="border: none">
        <h3><asp:Label ID="Label1" runat="server" Text="<%$ Resources:ResetPassword %>" /></h3>
        <asp:Label ID="Label13" runat="server" Text="<%$ Resources:ResetPasswordDesc %>"></asp:Label>
    </div>
    <div style="margin:2em 0 0 0; border-top:1px solid #ddd; padding-top:5px; clear:both;">
        <asp:ImageButton runat="server" id="Image7" OnClick="CmdChangePasswordClick" CssClass="icon" ImageUrl="~/Images/key_go.gif" />
        <asp:LinkButton ID="cmdResetPassword" OnClick="CmdChangePasswordClick" runat="server" Text="<%$ Resources:ResetPassword %>" />
    </div>
</asp:Panel>
<div style="margin:2em 0 0 0; border-top:1px solid #ddd; padding-top:5px; clear:both;">
    <asp:ImageButton runat="server" ImageUrl="~/Images/lt.gif" CssClass="icon" CausesValidation="false" AlternateText="<%$ Resources:BackToUserList %>" ID="ImageButton3" OnClick="CmdCancelClick" />
    <asp:HyperLink ID="ReturnLink" runat="server" NavigateUrl="~/Administration/Users/UserList.aspx" Text="<%$ Resources:BackToUserList %>"></asp:HyperLink>
</div>