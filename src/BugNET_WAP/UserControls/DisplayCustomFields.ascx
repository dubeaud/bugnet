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
