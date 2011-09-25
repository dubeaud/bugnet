<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Password..ascx.cs" Inherits="BugNET.Administration.Users.UserControls.Password" %>
<BN:Message ID="Message1" runat="server" Width="650px" Visible="False"  />
<div class="fieldgroup">
    <h3><asp:Label id="lblTitle" runat="server" Text="<%$ Resources:ManagePassword %>" /> - <asp:Label id="lblUserName" runat="server"/></h3>     
    <ol>
        <li>
            <asp:Label ID="Label16" AssociatedControlID="PasswordLastChanged" Width="180px" runat="server" Text="<%$ Resources:PasswordLastChanged %>" ></asp:Label>
            <asp:Label ID="PasswordLastChanged" runat="server" ></asp:Label>
        </li>
    </ol>
</div>
<asp:Panel id="ChangePassword" runat="server">
<div class="fieldgroup" >  
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
<div class="submit">
    <asp:LinkButton ID="cmdChangePassword"  OnClick="cmdChangePassword_Click" runat="server" Text="<%$ Resources:ChangePassword %>"></asp:LinkButton>
</div>
</asp:Panel>
<asp:Panel id="ResetPassword" runat="server">
    <div class="fieldgroup">
        <h3><asp:Label ID="Label1" runat="server" Text="<%$ Resources:ResetPassword %>" /></h3>
        <asp:Label ID="Label13" runat="server" Text="<%$ Resources:ResetPasswordDesc %>"></asp:Label>
    </div>
    <div class="submit">
        <asp:ImageButton runat="server" id="Image7" OnClick="cmdResetPassword_Click" CssClass="icon" ImageUrl="~/Images/key_go.gif" />
        <asp:LinkButton ID="cmdResetPassword" OnClick="cmdResetPassword_Click" runat="server" Text="<%$ Resources:ResetPassword %>" />
    </div>
</asp:Panel>