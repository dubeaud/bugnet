<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="LoggingSettings.ascx.cs"
    Inherits="BugNET.Administration.Host.UserControls.LoggingSettings" %>
<h2>
    <asp:Literal ID="Title" runat="Server" Text="<%$ Resources:LoggingSettings %>" /></h2>
<bn:Message ID="Message1" runat="server" Visible="false" />
<div class="fieldgroup noborder">
    <ol>
        <li>
            <asp:Label ID="label23" runat="server" AssociatedControlID="EmailErrors" Text="<%$ Resources:EmailErrorMessages %>" />
            <asp:CheckBox  ID="EmailErrors" runat="server"></asp:CheckBox>
        </li>
        <li>
            <asp:Label ID="label24" runat="server" AssociatedControlID="ErrorLoggingEmail" CssClass="col1b"
                Text="<%$ Resources:FromAddress %>" />
            <asp:TextBox ID="ErrorLoggingEmail" runat="Server"  /></li>
    </ol>
</div>
