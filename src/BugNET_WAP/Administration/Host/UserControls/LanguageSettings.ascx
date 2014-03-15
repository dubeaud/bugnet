<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="LanguageSettings.ascx.cs" Inherits="BugNET.Administration.Host.UserControls.LanguageSettings" %>
<h2>
    <asp:Literal ID="Title" runat="Server" Text="<%$ Resources:LanguageSettings %>" /></h2>
<bn:Message ID="Message1" runat="server" Visible="false" />
<div class="form-horizontal">
    <div class="form-group">
        <asp:Label CssClass="col-md-4 control-label" ID="lblApplicationDefault" runat="server" Text="<%$ Resources:ApplicationDefault %>" />
        <div class="col-md-8">
            <p class="form-control-static">
                <asp:Label ID="lblDefaultLanguage" runat="server" Text="" />
            </p>
        </div>
    </div>
    <div class="form-group">
        <asp:Label ID="label28" CssClass="col-md-4 control-label" runat="server" AssociatedControlID="ApplicationDefaultLanguage" Text="<%$ Resources:ApplicationDefault %>" />
        <div class="col-md-8">
            <asp:DropDownList ID="ApplicationDefaultLanguage" DataTextField="Text" DataValueField="Value" runat="server" />
        </div>
    </div>
        <h3><asp:Localize runat="server" ID="InstalledLanguages" Text="<%$ Resources:InstalledLanguages %>" /></h3>
    <asp:GridView ID="LanguagesGridView" AutoGenerateColumns="false" CssClass="table table-striped" GridLines="none" UseAccessibleHeader="true" runat="server">
        <Columns>
            <asp:BoundField DataField="Text" HeaderText="[Culture]" meta:resourcekey="LanguagesGridView_Col_Culture" />
        </Columns>
    </asp:GridView>
</div>
