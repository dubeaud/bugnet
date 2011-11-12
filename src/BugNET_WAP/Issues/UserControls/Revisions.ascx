<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Revisions.ascx.cs" Inherits="BugNET.Issues.UserControls.Revisions" %>
<asp:label id="IssueRevisionsLabel" Font-Italic="true" runat="server"></asp:label>
<asp:Datagrid  runat="server" Id="IssueRevisionsDataGrid" EnableViewState="true"  SkinID="DataGrid"
    AllowPaging="false"  Width="100%"
    AllowSorting="false">
    <Columns> 
        <asp:BoundColumn HeaderText="<%$ Resources:IssueRevisionsDataGrid.RevisionHeader.Text %>" DataField="Revision"></asp:BoundColumn>
        <asp:BoundColumn HeaderText="<%$ Resources:IssueRevisionsDataGrid.AuthorHeader.Text %>" DataField="Author"></asp:BoundColumn>
        <asp:BoundColumn HeaderText="<%$ Resources:IssueRevisionsDataGrid.RevisionDateHeader.Text %>" DataField="RevisionDate"></asp:BoundColumn>
        <asp:BoundColumn HeaderText="<%$ Resources:IssueRevisionsDataGrid.RepositoryHeader.Text %>" DataField="Repository"></asp:BoundColumn>
        <asp:BoundColumn HeaderText="<%$ Resources:IssueRevisionsDataGrid.MessageHeader.Text %>" DataField="Message"></asp:BoundColumn>
    </Columns>
</asp:Datagrid>