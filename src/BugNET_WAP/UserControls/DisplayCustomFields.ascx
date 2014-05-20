<%@ Control Language="C#" AutoEventWireup="true" Inherits="BugNET.UserControls.DisplayCustomFields" Codebehind="DisplayCustomFields.ascx.cs" %>
<asp:DataList 
    id="lstCustomFields" 
    RepeatColumns="2" 
    RepeatDirection="Horizontal" 
    Width="100%" 
    CssClass="issue-detail" 
    CellSpacing="1" 
    Runat="Server" onitemdatabound="CustomFieldsItemDataBound">
   <ItemStyle Width="15%" />
   <ItemTemplate>       
	        <asp:Label id="lblFieldName" Runat="Server" />
        </td>
        <td style="width:35%;">          
            <asp:PlaceHolder id="PlaceHolder" runat="server">
            </asp:PlaceHolder>           
    </ItemTemplate>
</asp:DataList>

<asp:Repeater ID="rptCustomFields" OnItemDataBound="rptCustomFields_ItemDataBound" runat="server">
    <HeaderTemplate>
        <div class="row">
    </HeaderTemplate>
    <ItemTemplate>
        <%# (Container.ItemIndex != 0 && Container.ItemIndex % 2 == 0) ? @"</div><div class'row'>" : string.Empty %> 
        <div class="col-md-6">
            <div class="form-group">
                <asp:Label id="lblFieldName" Runat="Server" CssClass="control-label col-sm-4" />
                <div class="col-sm-7">
                    <asp:PlaceHolder id="PlaceHolder" runat="server">
                    </asp:PlaceHolder>
                </div>
            </div>
        </div>
    </ItemTemplate>
    <FooterTemplate>
        </div>
    </FooterTemplate>
</asp:Repeater>
