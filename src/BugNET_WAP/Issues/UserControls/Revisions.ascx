<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Revisions.ascx.cs" Inherits="BugNET.Issues.UserControls.Revisions" %>
<asp:label id="IssueRevisionsLabel" Font-Italic="true" runat="server"></asp:label>
<asp:Datagrid 
    runat="server" 
    Id="IssueRevisionsDataGrid" 
    EnableViewState="true"  
    SkinID="DataGrid"
    AllowPaging="false"  
    AllowSorting="false"
    Width="100%">
    <Columns>
        <asp:BoundColumn HeaderText="<%$ Resources:IssueRevisionsDataGrid.RevisionHeader.Text %>" DataField="Revision">
            <HeaderStyle HorizontalAlign="Left" />
            <ItemStyle HorizontalAlign="Left" Wrap="False" />
        </asp:BoundColumn>
        <asp:BoundColumn HeaderText="<%$ Resources:IssueRevisionsDataGrid.AuthorHeader.Text %>" DataField="Author">
            <HeaderStyle HorizontalAlign="Left" />
            <ItemStyle HorizontalAlign="Left" Wrap="False" />
        </asp:BoundColumn>
        <asp:BoundColumn HeaderText="<%$ Resources:IssueRevisionsDataGrid.RevisionDateHeader.Text %>" DataField="RevisionDate">
            <HeaderStyle HorizontalAlign="Left" />
            <ItemStyle HorizontalAlign="Left" Wrap="False" />
        </asp:BoundColumn>
        <asp:BoundColumn HeaderText="<%$ Resources:IssueRevisionsDataGrid.RepositoryHeader.Text %>" DataField="Repository">
            <HeaderStyle HorizontalAlign="Left" />
            <ItemStyle HorizontalAlign="Left" Wrap="False" />
        </asp:BoundColumn>
        <asp:BoundColumn HeaderText="<%$ Resources:IssueRevisionsDataGrid.MessageHeader.Text %>" DataField="Message">
            <HeaderStyle HorizontalAlign="Left" />
            <ItemStyle HorizontalAlign="Left" Wrap="False" />
        </asp:BoundColumn>
    </Columns>
</asp:Datagrid>