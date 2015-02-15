<%@ Control Language="C#" AutoEventWireup="true" Inherits="BugNET.UserControls.DisplayCustomFields" Codebehind="DisplayCustomFields.ascx.cs" %>
<asp:Repeater ID="rptCustomFields" OnItemDataBound="rptCustomFields_ItemDataBound" runat="server">
    <HeaderTemplate>

    </HeaderTemplate>
    <ItemTemplate>
        <div class="col-md-6">
            <div class="form-group">
                <asp:Label id="lblFieldName" Runat="Server" CssClass="control-label col-sm-4" />
                <div class="col-sm-7">
                    <asp:HiddenField ID="Id" runat="server" />
                    <asp:HiddenField ID="Name" runat="server" />
                    <asp:PlaceHolder id="PlaceHolder" runat="server">
                    </asp:PlaceHolder>
                </div>
            </div>
        </div>
    </ItemTemplate>
    <FooterTemplate>

    </FooterTemplate>
</asp:Repeater>
