<%@ Page Title="Release Notes" Language="C#" meta:resourcekey="Page" MasterPageFile="~/Shared/SingleColumn.master" AutoEventWireup="true" CodeBehind="ReleaseNotes.aspx.cs" Inherits="BugNET.Projects.ReleaseNotes" %>
<asp:Content ID="Content2" ContentPlaceHolderID="PageTitle" runat="server">
    <h1 class="page-title"><asp:literal id="Literal1" runat="server"   /> - <asp:literal enableviewstate="true" id="litProject" runat="server" /> - <asp:literal enableviewstate="true" id="litMilestone" runat="server" /></h1>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Content" runat="server">
 <asp:repeater runat="server" id="rptReleaseNotes" OnItemDataBound="rptReleaseNotes_ItemDataBound">
        <ItemTemplate>
            <h2 ><asp:Literal ID="IssueType" runat="server"></asp:Literal></h2>
            <asp:Repeater ID="IssuesList" runat="server" OnItemDataBound="IssueList_ItemDataBound">
                <HeaderTemplate>
                    <ul style="margin-left:35px">
                </HeaderTemplate>
                    <ItemTemplate>
                            <li><asp:Literal id="Issue" runat="server"></asp:Literal></li>
                    </ItemTemplate>
                <FooterTemplate>
                    </ul>
                </FooterTemplate>
            </asp:Repeater>
        </ItemTemplate>
</asp:repeater>
<br />
<h2><asp:literal id="Literal2" runat="server" meta:resourcekey="EditCopyNotes"   /></h2>
<p><asp:literal id="Literal3" runat="server" meta:resourcekey="EditCopyNotesDesc"   /></p>
<asp:TextBox ID="Output" runat="server" width="600px" Height="450px" TextMode="MultiLine"></asp:TextBox>
</asp:Content>
