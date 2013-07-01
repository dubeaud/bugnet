<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PasswordReset.aspx.cs" MasterPageFile="~/Shared/SingleColumn.master" Inherits="BugNET.Account.PasswordReset" %>

<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="Content">
        <asp:PlaceHolder runat="server" ID="message" Visible="false" ViewStateMode="Disabled">
            <p class="message-success"><%: Message %></p>
            <br />
        </asp:PlaceHolder>
        <p>Enter and confirm your new password</p>
        <br />
        Password: <asp:TextBox ID="Password" runat="server" />
        <br />
        <br />
        Confirm Password:<asp:TextBox ID="ConfirmPassword" runat="server" />
        <br />
        <br />
        <asp:Button ID="Submit" OnClick="Submit_Click" Text="Submit" runat="server" />
</asp:Content>
