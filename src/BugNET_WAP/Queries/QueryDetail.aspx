<%@ Page Language="c#" CodeBehind="QueryDetail.aspx.cs" AutoEventWireup="True" MasterPageFile="~/Site.master"
    Title="Query Detail" Inherits="BugNET.Queries.QueryDetail" Async="true" meta:resourcekey="Page" %>

<%@ Register TagPrefix="it" TagName="DisplayIssues" Src="~/UserControls/DisplayIssues.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <bn:Message ID="Message1" runat="server" Visible="False" />
    <div class="page-header">
        <h1>
            <asp:Literal ID="Literal2" runat="server" Text="<%$ Resources: Page.Title %>" />
            <small>
                <asp:Label ID="lblProjectName" runat="server" />
                <span>(<asp:Literal ID="litProjectCode" runat="Server"></asp:Literal>)</span>
            </small>
        </h1>
    </div>

    <br />
    <table class="table table-striped">
        <asp:PlaceHolder ID="plhClauses" runat="Server" />
    </table>
    <div style="padding: 15px 0 20px 0; clear: both;">
        <asp:Panel ID="pnlDeleteQuery" runat="server" CssClass="pull-left" Style="padding-right: 15px;">
            <asp:ImageButton ID="btnAddClause" runat="server" ToolTip="<%$ Resources: btnAddClause.Text %>" ImageUrl="~/Images/add.gif"
                Style="vertical-align: text-bottom;" CssClass="icon" OnClick="btnAddClause_Click" />
            <asp:LinkButton ID="lbAddClause" runat="server" meta:resourcekey="btnAddClause" OnClick="lbAddClause_Click" />
        </asp:Panel>
        <asp:Panel ID="pnlRemoveClause" runat="server" CssClass="pull-left" Style="padding-right: 15px;">
            <asp:ImageButton ID="btnRemoveClause" runat="server" ToolTip="<%$ Resources: btnRemoveClause.Text %>" ImageUrl="~/Images/cross.gif"
                Style="vertical-align: text-bottom;" CssClass="icon" OnClick="btnRemoveClause_Click" />
            <asp:LinkButton ID="lbRemoveClause" runat="server" meta:resourcekey="btnRemoveClause" OnClick="lbRemoveClause_Click" />
        </asp:Panel>
    </div>
    <hr />
    <h2>Save Query</h2>
    <asp:Panel ID="SaveQueryForm" CssClass="form-horizontal" runat="server">
        <div class="form-group">
            <asp:Label ID="Label1" runat="server" Text="Query Name" CssClass="control-label col-md-2" AssociatedControlID="txtQueryName" meta:resourcekey="txtQueryName" />
            <div class="col-md-5">
                <asp:TextBox ID="txtQueryName" CssClass="form-control" runat="Server" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtQueryName"
                    CssClass="text-danger validation-error" ErrorMessage="Query name field is required" />
            </div>
        </div>
        <div class="form-group">
            <div class="col-md-offset-2 col-md-10">
                <div class="checkbox">
                    <asp:CheckBox ID="chkGlobalQuery" runat="server" />
                    <asp:Label ID="Label7" runat="server" Text="Public Query" meta:resourcekey="chkGlobalQuery" AssociatedControlID="chkGlobalQuery" />
                </div>
            </div>
        </div>
    </asp:Panel>
        <div style="padding-top: 15px;">
            <asp:Panel ID="pnlPerformQuery" runat="server" CssClass="pull-left" Style="padding-right: 15px;">
                <asp:ImageButton ID="btnPerformQuery" runat="server" ToolTip="<%$ Resources: btnPerformQuery.Text %>" ImageUrl="~/Images/execute_sql.png"
                    Style="vertical-align: text-bottom;" CssClass="icon" OnClick="btnPerformQuery_Click" />
                <asp:LinkButton ID="lbPerformQuery" runat="server" meta:resourcekey="btnPerformQuery" OnClick="lbPerformQuery_Click" />
            </asp:Panel>
            <asp:Panel ID="pnlSaveQuery" runat="server" CssClass="pull-left" Style="padding-right: 15px;">
                <asp:ImageButton ID="btnSaveQuery" runat="server" ToolTip="<%$ Resources: btnSaveQuery.Text %>" ImageUrl="~/Images/save.gif"
                    Style="vertical-align: text-bottom;" CssClass="icon" OnClick="btnSaveQuery_Click" />
                <asp:LinkButton ID="lbSaveQuery" runat="server" meta:resourcekey="btnSaveQuery" OnClick="lbSaveQuery_Click" />
            </asp:Panel>
            <asp:Panel ID="pnlCancel" runat="server" CssClass="pull-left" Style="padding-right: 15px;">
                <asp:ImageButton ID="btnCancel" runat="server" ToolTip="<%$ Resources: btnCancelQuery.Text %>" ImageUrl="~/Images/lt.gif"
                    Style="vertical-align: text-bottom;" CssClass="icon" OnClick="btnCancel_Click" />
                <asp:LinkButton ID="lbCancel" runat="server" meta:resourcekey="btnCancelQuery" OnClick="lbCancel_Click" />
            </asp:Panel>
        </div>
    

    <table id="Results" runat="server" style="width: 100%">
        <tr>
            <td>
                <hr />
                <h2>Results</h2>
                <it:DisplayIssues ID="ctlDisplayIssues" runat="Server" OnRebindCommand="IssuesRebind" />
            </td>
        </tr>
    </table>
</asp:Content>
