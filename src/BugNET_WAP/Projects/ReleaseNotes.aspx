<%@ Page Title="Release Notes" Language="C#" meta:resourcekey="Page" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeBehind="ReleaseNotes.aspx.cs" Inherits="BugNET.Projects.ReleaseNotes" %>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="page-header">
        <h1><asp:literal id="Literal1" runat="server"   /> <small><asp:literal enableviewstate="true" id="litProject" runat="server" /> - <asp:literal enableviewstate="true" id="litMilestone" runat="server" /></small> </h1>
     </div>
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
    <asp:TextBox ID="Output" runat="server" style="height: 450px; width: 80%!Important" TextMode="MultiLine"></asp:TextBox>
</asp:Content>
