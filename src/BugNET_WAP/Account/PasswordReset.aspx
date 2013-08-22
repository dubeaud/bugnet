<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PasswordReset.aspx.cs" MasterPageFile="~/Shared/SingleColumn.master" Inherits="BugNET.Account.PasswordReset" meta:resourceKey="Page" %>

<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="Content">
    <asp:PlaceHolder runat="server" ID="message" Visible="false" ViewStateMode="Disabled">
        <p class="message-success"><%: Message %></p>
        <br />
    </asp:PlaceHolder>

    <p>
        <asp:Label ID="Label1" runat="server" meta:resourcekey="ConfirmLabel" /></p>
    <br />
    <div class="fieldgroup" style="border: none">
        <ol>
            <li>
                <asp:Label ID="Label2" runat="server" AssociatedControlID="Password" meta:resourcekey="PasswordLabel" /><asp:TextBox ID="Password" runat="server" TextMode="Password" />
            </li>
            <li>
                <asp:Label ID="Label3" runat="server" AssociatedControlID="ConfirmPassword" meta:resourcekey="ConfirmPasswordLabel" /><asp:TextBox ID="ConfirmPassword" runat="server" TextMode="Password" /></li>

            <li>
                <asp:Button ID="Submit" OnClick="Submit_Click" Text="<%$ Resources:SharedResources, Submit %>" runat="server" /></li>
        </ol>
    </div>
</asp:Content>
