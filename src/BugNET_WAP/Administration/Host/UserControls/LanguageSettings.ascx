<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="LanguageSettings.ascx.cs" Inherits="BugNET.Administration.Host.UserControls.LanguageSettings" %>
<h2>
    <asp:Literal ID="Title" runat="Server" Text="<%$ Resources:LanguageSettings %>" /></h2>
<bn:Message ID="Message1" runat="server" Visible="false" />
<div class="fieldgroup noborder">
    <asp:Label ID="lblApplicationDefault" runat="server" Text="<%$ Resources:ApplicationDefault %>" />
    <asp:Label ID="lblDefaultLanguage" runat="server" Text="" />
    <ol>
        <li>
            <asp:Label ID="label28" runat="server" AssociatedControlID="ApplicationDefaultLanguage" Text="<%$ Resources:ApplicationDefault %>" />
            <asp:DropDownList ID="ApplicationDefaultLanguage" DataTextField="Text" DataValueField="Value" runat="server" />
        </li>
    </ol>
    <p style="margin: 0 0 0.5em 0">
        <asp:Localize runat="server" ID="InstalledLanguages" Text="<%$ Resources:InstalledLanguages %>" /></p>
    <asp:GridView ID="LanguagesGridView" AutoGenerateColumns="false" SkinID="GridView" Width="300px" runat="server">
        <Columns>
            <asp:BoundField DataField="Text" HeaderText="[Culture]" meta:resourcekey="LanguagesGridView_Col_Culture" />
        </Columns>
    </asp:GridView>
</div>