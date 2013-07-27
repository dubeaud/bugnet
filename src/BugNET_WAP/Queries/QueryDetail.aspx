<%@ Page Language="c#" CodeBehind="QueryDetail.aspx.cs" AutoEventWireup="True" MasterPageFile="~/Shared/SingleColumn.master"
    Title="Query Detail" Inherits="BugNET.Queries.QueryDetail" Async="true" meta:resourcekey="Page" %>

<%@ Register TagPrefix="it" TagName="DisplayIssues" Src="~/UserControls/DisplayIssues.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server">
    <bn:Message ID="Message1" runat="server" Visible="False" />
    <table>
        <tr>
            <td class="contentCell">
                <table>
                    <tr>
                        <td>
                            <asp:Label ID="lblProject" meta:resourcekey="lblProject" runat="server" />
                        </td>
                        <td>
                            <asp:Label ID="lblProjectName" runat="server" />
                        </td>
                    </tr>
                </table>
                <br />
                <table class="queryList" cellpadding="4" cellspacing="0">
                    <asp:PlaceHolder ID="plhClauses" runat="Server" />
                </table>
                <div style="padding: 15px 0 20px 0; clear: both;">
                    <asp:Panel ID="pnlDeleteQuery" runat="server" CssClass="float-left" Style="padding-right: 15px;">
                        <asp:ImageButton ID="btnAddClause" runat="server" ToolTip="<%$ Resources: btnAddClause.Text %>" ImageUrl="~/Images/add.gif"
                            Style="vertical-align: text-bottom;" CssClass="icon" OnClick="btnAddClause_Click" />
                        <asp:LinkButton ID="lbAddClause" runat="server" meta:resourcekey="btnAddClause" OnClick="lbAddClause_Click" />
                    </asp:Panel>
                    <asp:Panel ID="pnlRemoveClause" runat="server" CssClass="float-left" Style="padding-right: 15px;">
                        <asp:ImageButton ID="btnRemoveClause" runat="server" ToolTip="<%$ Resources: btnRemoveClause.Text %>" ImageUrl="~/Images/cross.gif"
                            Style="vertical-align: text-bottom;" CssClass="icon" OnClick="btnRemoveClause_Click" />
                        <asp:LinkButton ID="lbRemoveClause" runat="server" meta:resourcekey="btnRemoveClause" OnClick="lbRemoveClause_Click" />
                    </asp:Panel>
                </div>
                <div class="float-clear fieldgroup">
                    <asp:Panel ID="SaveQueryForm" runat="server">
                        <ol>
                            <li>
                                <asp:Label ID="Label1" runat="server" Text="Query Name" AssociatedControlID="txtQueryName" meta:resourcekey="txtQueryName" />
                                <asp:TextBox ID="txtQueryName" runat="Server" />
                            </li>
                            <li>
                                <asp:Label ID="Label7" runat="server" Text="Public Query:" meta:resourcekey="chkGlobalQuery" AssociatedControlID="chkGlobalQuery" />
                                <asp:CheckBox ID="chkGlobalQuery" runat="server" />
                            </li>
                        </ol>
                    </asp:Panel>
                    <div class="float-clear submit" style="padding-top: 15px;">
                        <asp:Panel ID="pnlPerformQuery" runat="server" CssClass="float-left" Style="padding-right: 15px;">
                            <asp:ImageButton ID="btnPerformQuery" runat="server" ToolTip="<%$ Resources: btnPerformQuery.Text %>" ImageUrl="~/Images/execute_sql.png"
                                Style="vertical-align: text-bottom;" CssClass="icon" OnClick="btnPerformQuery_Click" />
                            <asp:LinkButton ID="lbPerformQuery" runat="server" meta:resourcekey="btnPerformQuery" OnClick="lbPerformQuery_Click" />
                        </asp:Panel>
                        <asp:Panel ID="pnlSaveQuery" runat="server" CssClass="float-left" Style="padding-right: 15px;">
                            <asp:ImageButton ID="btnSaveQuery" runat="server" ToolTip="<%$ Resources: btnSaveQuery.Text %>" ImageUrl="~/Images/save.gif"
                                Style="vertical-align: text-bottom;" CssClass="icon" OnClick="btnSaveQuery_Click" />
                            <asp:LinkButton ID="lbSaveQuery" runat="server" meta:resourcekey="btnSaveQuery" OnClick="lbSaveQuery_Click" />
                        </asp:Panel>
                        <asp:Panel ID="pnlCancel" runat="server" CssClass="float-left" Style="padding-right: 15px;">
                            <asp:ImageButton ID="btnCancel" runat="server" ToolTip="<%$ Resources: btnCancelQuery.Text %>" ImageUrl="~/Images/lt.gif"
                                Style="vertical-align: text-bottom;" CssClass="icon" OnClick="btnCancel_Click" />
                            <asp:LinkButton ID="lbCancel" runat="server" meta:resourcekey="btnCancelQuery" OnClick="lbCancel_Click" />
                        </asp:Panel>
                    </div>
                </div>
            </td>
        </tr>
    </table>
    <table id="Results" runat="server" style="width: 100%">
        <tr>
            <td>
                <hr />
                <h1>Results</h1>
                <it:DisplayIssues ID="ctlDisplayIssues" runat="Server" OnRebindCommand="IssuesRebind" />
            </td>
        </tr>
    </table>
</asp:Content>
