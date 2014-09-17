<%@ Page Language="c#" ValidateRequest="false" Inherits="BugNET.Administration.Host.Settings"
    MasterPageFile="~/Site.master" Title="<%$ Resources:ApplicationConfiguration %>"
    CodeBehind="Settings.aspx.cs" %>

<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="MainContent">
    <div class="page-header">
        <h1 class="page-title">
           <asp:Literal ID="NewProjectTitle" runat="Server" Text="<%$ Resources:ApplicationConfiguration %>" />
        </h1>
    </div>
    <div class="row">
        <div class="col-md-2">
            <ul class="nav nav-pills nav-stacked">
                <asp:Repeater ID="AdminMenu" OnItemDataBound="AdminMenu_ItemDataBound" OnItemCommand="AdminMenu_ItemCommand"
                    runat="server">
                    <ItemTemplate>
                        <li runat="server" id="ListItem">
                            <asp:LinkButton ID="MenuButton" runat="server" CausesValidation="false"></asp:LinkButton></li>
                    </ItemTemplate>
                </asp:Repeater>
            </ul>
        </div>
        <div class="col-md-10">
            <bn:Message ID="Message1" runat="server" Visible="False" />
            <asp:PlaceHolder ID="plhSettingsControl" runat="Server" />
            <hr />
            <asp:LinkButton ID="cmdUpdate" CssClass="btn btn-primary" OnClick="cmdUpdate_Click" runat="server" Text="<%$ Resources:UpdateSettings %>" />
        </div>
    </div>
</asp:Content>
