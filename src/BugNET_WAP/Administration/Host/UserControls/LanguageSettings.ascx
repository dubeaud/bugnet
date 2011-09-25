<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="LanguageSettings.ascx.cs" Inherits="BugNET.Administration.Host.UserControls.LanguageSettings" %>
<h2><asp:literal ID="Title" runat="Server" Text="<%$ Resources:LanguageSettings %>"  /></h2>
<BN:Message ID="Message1" runat="server" visible="false"  /> 
<div class="fieldgroup noborder">
        <asp:Label ID="label1" runat="server"   Text="<%$ Resources:ApplicationDefault %>" />
        <asp:Label ID="lblDefaultLanguage" runat="server" Text="" />
    <ol>
        <li>
            <asp:Label ID="label28" runat="server" AssociatedControlID="ApplicationDefaultLanguage"  Text="<%$ Resources:ApplicationDefault %>" />
            <asp:dropdownlist ID="ApplicationDefaultLanguage" DataTextField="Text" DataValueField="Value" runat="server"></asp:dropdownlist>
        </li>
    </ol>
    <p style="margin:0 0 0.5em 0"><asp:Localize runat="server" ID="InstalledLanguages" Text="<%$ Resources:InstalledLanguages %>" /></p>
    <asp:GridView ID="LanguagesGridView" AutoGenerateColumns="false" SkinID="GridView" Width="300px" runat="server">
        <Columns>
            <asp:BoundField DataField="Text" HeaderText="Culture" />
        </Columns>
    </asp:GridView>

</div>