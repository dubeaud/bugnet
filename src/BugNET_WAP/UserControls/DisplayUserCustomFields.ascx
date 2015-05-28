<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="DisplayUserCustomFields.ascx.cs" Inherits="BugNET.UserControls.DisplayUserCustomFields" %>
<asp:Repeater ID="rptCustomFields" OnItemDataBound="rptCustomFields_ItemDataBound" runat="server">
    <HeaderTemplate>

    </HeaderTemplate>
    <ItemTemplate>
        <div class="form-group">
            <asp:Label id="lblFieldName" Runat="Server" CssClass="control-label col-md-2" />
            <div class="col-md-10">
                <asp:HiddenField ID="Id" runat="server" />
                <asp:HiddenField ID="Name" runat="server" />
                <asp:PlaceHolder id="PlaceHolder" runat="server">
                </asp:PlaceHolder>
            </div>
        </div>
    </ItemTemplate>
    <FooterTemplate>

    </FooterTemplate>
</asp:Repeater>