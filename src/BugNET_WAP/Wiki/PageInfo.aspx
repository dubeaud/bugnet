<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PageInfo.aspx.cs" Inherits="BugNET.Wiki.PageInfo" MasterPageFile="~\Site.Master" %>

<asp:Content ID="indexContent" ContentPlaceHolderID="MainContent" runat="server">

    <div id="wikiContainer">
        <h2>
            <asp:Literal ID="CurrentRevision" meta:resourceKey="CurrentRevision" runat="server" /></h2>
        <div>
            <div>
                <asp:Literal ID="LastUpdatedByLabel" meta:resourceKey="LastUpdatedByLabel" runat="server" />
                <asp:Literal ID="LastUpdatedBy" runat="server" /></div>
            <div>
                <asp:Literal ID="LastUpdatedLabel" meta:resourceKey="LastUpdatedLabel" runat="server" />
                <asp:Literal ID="LastUpdated" runat="server" /></div>
            <div>
                <asp:Literal ID="RevisionLabel" meta:resourceKey="RevisionLabel" runat="server" />
                <asp:Literal ID="RevisionNumber" runat="server" /></div>
        </div>

        <h2>
            <asp:Literal ID="litPageHistory" runat="server" meta:resourceKey="PageHistory" />
        </h2>
        <div>
            <asp:Repeater ID="pageHistory" runat="server" OnItemDataBound="BindPageHistoryItem">
                <HeaderTemplate>
                    <table class="table">
                        <thead>
                            <th>
                                <asp:Literal ID="Date" runat="server" meta:resourceKey="Date" /></th>
                            <th>
                                <asp:Literal ID="UpdatedByLabel" meta:resourceKey="UpdatedByLabel" runat="server" /></th>
                            <th></th>
                        </thead>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td>
                            <asp:Literal ID="date" runat="server" /></td>
                        <td>
                            <asp:Literal ID="user" runat="server" /></td>
                        <td>
                            <asp:HyperLink ID="versionLink" runat="server" /></td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                    </table>
                </FooterTemplate>
            </asp:Repeater>

        </div>
    </div>
</asp:Content>
