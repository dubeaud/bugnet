<%@ Page Language="c#" CodeBehind="QueryList.aspx.cs" AutoEventWireup="True" MasterPageFile="~/Site.master"
    Title="Query List" Inherits="BugNET.Queries.QueryList" Async="true" meta:resourcekey="Page" %>

<%@ Register TagPrefix="it" TagName="PickQuery" Src="~/UserControls/PickQuery.ascx" %>
<%@ Register TagPrefix="it" TagName="DisplayIssues" Src="~/UserControls/DisplayIssues.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:HiddenField ID="ConfirmDeleteText" runat="server"/>
    <div class="page-header">
        <h1>
            <asp:Literal ID="Literal2" runat="server" Text="<%$ Resources: Page.Title %>" />
            <small>
                <asp:Literal ID="ltProject" runat="server" />
                <span>(<asp:Literal ID="litProjectCode" runat="Server"></asp:Literal>)</span>
            </small> 
        </h1>
    </div>
    <div class="form-horizontal">
        <div class="form-group">
            <asp:Label ID="lblQuery" runat="server" CssClass="control-label col-md-2" Text="Query:" meta:resourcekey="lblQuery"/>
            <div class="col-md-4">
            <it:PickQuery ID="dropQueries" DisplayDefault="true" runat="Server" />
                <asp:ImageButton runat="server" ID="imgPerformQuery" CssClass="icon" ToolTip="<%$ Resources: btnPerformQuery.Text %>" ImageUrl="~/Images/execute_sql.png"
                    OnClick="imgPerformQuery_Click" />
            </div>
        </div>
        
    </div>
  <hr />
    <div>
        <asp:Panel ID="pnlAddQuery" runat="server" CssClass="pull-left" Style="padding-right: 15px;">
            <asp:ImageButton ID="btnAddQuery" runat="server" ToolTip="<%$ Resources: btnAddQuery.Text %>" ImageUrl="~/Images/sql_new_query.png"
                Style="vertical-align: text-bottom;" CssClass="icon" OnClick="btnAddQuery_Click" />
            <asp:LinkButton ID="lbAddQuery" runat="server" meta:resourcekey="btnAddQuery" OnClick="lbAddQuery_Click" />
        </asp:Panel>
        <asp:Panel ID="pnlDeleteQuery" runat="server" CssClass="pull-left" Style="padding-right: 15px;">
            <asp:ImageButton ID="btnDeleteQuery" runat="server" ToolTip="<%$ Resources: btnDeleteQuery.Text %>" ImageUrl="~/Images/sql_delete_query.png"
                Style="vertical-align: text-bottom;" CssClass="icon" OnClick="btnDeleteQuery_Click" />
            <asp:LinkButton ID="lbDeleteQuery" runat="server" meta:resourcekey="btnDeleteQuery" OnClick="lbDeleteQuery_Click" />
        </asp:Panel>
        <asp:Panel ID="pnlEditQuery" runat="server" CssClass="pulls-left" Style="padding-right: 15px;">
            <asp:ImageButton ID="btnEditQuery" runat="server" ToolTip="<%$ Resources: btnEditQuery.Text %>" ImageUrl="~/Images/sql_edit_query.png"
                Style="vertical-align: text-bottom;" CssClass="icon" OnClick="btnEditQuery_Click" />
            <asp:LinkButton ID="lbEditQuery" runat="server" meta:resourcekey="btnEditQuery" OnClick="lbEditQuery_Click" />
        </asp:Panel>
    </div>
    <asp:Label ID="lblError" ForeColor="red" EnableViewState="false" runat="Server" />
    <asp:Panel ID="Results" runat="server" CssClass="float-clear" Style="padding-top: 15px;">
        <h2><asp:Literal ID="Literal1" runat="server" meta:resourcekey="Results" /></h2>
        <it:DisplayIssues ID="ctlDisplayIssues" runat="Server" />  
    </asp:Panel>
    <script type="text/javascript" language="javascript">
        function confirmDelete() {
            var message = $("input[id$='ConfirmDeleteText']").val();
            var dropQueries = $("select[id$='dropQueries']");

            if (dropQueries.length > 0) {

                var value = dropQueries.val();

                if (value == "0") return false;
                
                return confirm(message);
            }

            return false;
        }
    </script>
</asp:Content>
