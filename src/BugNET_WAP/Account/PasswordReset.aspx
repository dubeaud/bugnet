<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PasswordReset.aspx.cs" Inherits="BugNET.Account.PasswordReset" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:PlaceHolder runat="server" ID="message" Visible="false" ViewStateMode="Disabled">
            <p class="message-success"><%: Message %></p>
        </asp:PlaceHolder>
        <asp:TextBox ID="Password" runat="server" />
        <asp:TextBox ID="ConfirmPassword" runat="server" />
        <asp:Button ID="Submit" OnClick="Submit_Click" Text="Submit" runat="server" />
    </div>
    </form>
</body>
</html>
