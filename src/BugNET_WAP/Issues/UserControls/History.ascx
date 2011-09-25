<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="History.ascx.cs" Inherits="BugNET.Issues.UserControls.History" %>
<asp:label id="lblHistory" Font-Italic="true" runat="server"></asp:label>
<asp:Datagrid  runat="server" ID="HistoryDataGrid" EnableViewState="true" SkinID="DataGrid" Width="100%"> 
    <Columns>
        <asp:BoundColumn HeaderText="Date Modified" DataField="DateChanged" DataFormatString="{0:g}"/>
        <asp:BoundColumn HeaderText="User" DataField="CreatorDisplayName" />
        <asp:BoundColumn HeaderText="Item Changed" DataField="FieldChanged" />
        <asp:BoundColumn HeaderText="Previous Value" DataField="OldValue" />
        <asp:BoundColumn HeaderText="New Value" DataField="NewValue" />
    </Columns>
</asp:Datagrid>
