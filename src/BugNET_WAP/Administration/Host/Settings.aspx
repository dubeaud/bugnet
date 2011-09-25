<%@ Page Language="c#" ValidateRequest="false" Inherits="BugNET.Administration.Host.Settings"
    MasterPageFile="~/Shared/SingleColumn.master" Title="<%$ Resources:ApplicationConfiguration %>"
    CodeBehind="Settings.aspx.cs" %>

<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="Content">
    <h1 class="page-title">
        <asp:Literal ID="NewProjectTitle" runat="Server" Text="<%$ Resources:ApplicationConfiguration %>" /></h1>
    <div id="menu">
        <ul class="sideMenu">
            <asp:Repeater ID="AdminMenu" OnItemDataBound="AdminMenu_ItemDataBound" OnItemCommand="AdminMenu_ItemCommand"
                runat="server">
                <ItemTemplate>
                    <li runat="server" id="ListItem">
                        <asp:LinkButton ID="MenuButton" runat="server" CausesValidation="false"></asp:LinkButton></li>
                </ItemTemplate>
            </asp:Repeater>
        </ul>
    </div>
    <div id="contentcolumn">
        <BN:Message ID="Message1" runat="server" Visible="False"  />
        <asp:PlaceHolder ID="plhSettingsControl" runat="Server" />
        <div style="margin: 2em 1em 1em 0; clear: both; border-top: 1px solid #cccccc; padding-top: 10px;">
            <asp:ImageButton runat="server" ID="save" OnClick="cmdUpdate_Click" CssClass="icon"
                ImageUrl="~/Images/disk.gif" />
            <asp:LinkButton ID="cmdUpdate" OnClick="cmdUpdate_Click" runat="server" Text="<%$ Resources:UpdateSettings %>" />
        </div>
    </div>
</asp:Content>
