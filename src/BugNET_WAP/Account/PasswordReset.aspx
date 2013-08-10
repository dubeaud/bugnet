<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PasswordReset.aspx.cs" MasterPageFile="~/Shared/SingleColumn.master" Inherits="BugNET.Account.PasswordReset" meta:resourceKey="Page" %>

<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="Content">
        <asp:PlaceHolder runat="server" ID="message" Visible="false" ViewStateMode="Disabled">
            <p class="message-success"><%: Message %></p>
            <br />
        </asp:PlaceHolder>
        <p><asp:Label ID="Label1" runat="server" meta:resourcekey="ConfirmLabel"/></p>
        <br />
        <asp:Label ID="Label2" runat="server" meta:resourcekey="PasswordLabel" /><asp:TextBox ID="Password" runat="server" TextMode="Password" />
        <br />
        <br />
        <asp:Label ID="Label3" runat="server" meta:resourcekey="ConfirmPasswordLabel" /><asp:TextBox ID="ConfirmPassword" runat="server" TextMode="Password"/>
        <br />
        <br />
        <asp:Button ID="Submit" OnClick="Submit_Click" Text="<%$ Resources:SharedResources, Submit %>" runat="server" />
</asp:Content>
