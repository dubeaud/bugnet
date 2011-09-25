<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Revisions.ascx.cs" Inherits="BugNET.Issues.UserControls.Revisions" %>
<asp:label id="IssueRevisionsLabel" Font-Italic="true" runat="server"></asp:label>
<asp:Datagrid  runat="server" Id="IssueRevisionsDataGrid" EnableViewState="true"  SkinID="DataGrid"
    AllowPaging="false"  Width="100%"
    AllowSorting="false">
    <Columns>
        <asp:BoundColumn HeaderText="Revision" DataField="Revision" meta:resourcekey="RevisionColumn"></asp:BoundColumn>
        <asp:BoundColumn HeaderText="Author" DataField="Author" meta:resourcekey="AuthorColumn"></asp:BoundColumn>
        <asp:BoundColumn HeaderText="RevisionDate" DataField="RevisionDate" meta:resourcekey="RevisionDateColumn"></asp:BoundColumn>
        <asp:BoundColumn HeaderText="Repository" DataField="Repository" meta:resourcekey="RepositoryColumn"></asp:BoundColumn>
        <asp:BoundColumn HeaderText="Message" DataField="Message" meta:resourcekey="MessageColumn"></asp:BoundColumn>
    </Columns>
</asp:Datagrid>