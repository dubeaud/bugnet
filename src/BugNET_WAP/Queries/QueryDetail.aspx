<%@ Register TagPrefix="it" TagName="DisplayIssues" Src="~/UserControls/DisplayIssues.ascx" %>
<%@ Page Language="c#" CodeBehind="QueryDetail.aspx.cs" AutoEventWireup="True" MasterPageFile="~/Shared/SingleColumn.master" Title="Query Detail" Inherits="BugNET.Queries.QueryDetail" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server">
    <BN:Message ID="Message1" runat="server"  Visible="False"  />
	<table>
		<tr>
			<td class="contentCell">
				<table>
					<tr>
						<td>
						    <asp:label ID="lblProject" meta:resourcekey="lblProject"  runat="server" />
						</td>
						<td>
						    <asp:Label ID="lblProjectName" runat="server" />
						</td>
					</tr>
				</table>
				<br/>
				<table class="queryList" cellpadding="4" cellspacing="0">
					<asp:PlaceHolder id="plhClauses" Runat="Server" />
				</table>
				<div style="padding: 15px 0 20px 0; clear:both;">
	                <asp:Panel ID="pnlDeleteQuery" runat="server" CssClass="float-left" style="padding-right: 15px;">
                        <asp:ImageButton ID="btnAddClause" runat="server" ToolTip="<%$ Resources: btnAddClause.Text %>" ImageUrl="~/Images/add.gif" style="vertical-align: text-bottom;" CssClass="icon" onclick="btnAddClause_Click" />
                        <asp:LinkButton ID="lbAddClause" runat="server" meta:resourcekey="btnAddClause" onclick="lbAddClause_Click" />
	                </asp:Panel>
	                <asp:Panel ID="pnlRemoveClause" runat="server" CssClass="float-left" style="padding-right: 15px;">
                        <asp:ImageButton ID="btnRemoveClause" runat="server" ToolTip="<%$ Resources: btnRemoveClause.Text %>" ImageUrl="~/Images/cross.gif" style="vertical-align: text-bottom;" CssClass="icon" onclick="btnRemoveClause_Click" />
                        <asp:LinkButton ID="lbRemoveClause" runat="server" meta:resourcekey="btnRemoveClause" onclick="lbRemoveClause_Click" />
	                </asp:Panel>
				</div>
                <div class="float-clear fieldgroup">
                    <asp:Panel ID="SaveQueryForm" runat="server">
                        <ol>
                            <li>
                                <asp:Label ID="Label1" runat="server" Text="Query Name" AssociatedControlID="txtQueryName" />
                                <asp:TextBox id="txtQueryName" Runat="Server" />
                            </li>
                            <li>
                                <asp:Label ID="Label7" runat="server" Text="Public Query:" meta:resourcekey="chkGlobalQuery" AssociatedControlID="chkGlobalQuery" />
                                 <asp:CheckBox ID="chkGlobalQuery"  runat="server" />
                            </li>
                        </ol>
                    </asp:Panel>
                    <div class="float-clear submit" style="padding-top: 15px;">
	                    <asp:Panel ID="pnlPerformQuery" runat="server" CssClass="float-left" style="padding-right: 15px;">
                            <asp:ImageButton ID="btnPerformQuery" runat="server" ToolTip="<%$ Resources: btnPerformQuery.Text %>" 
                                ImageUrl="~/Images/execute_sql.png" style="vertical-align: text-bottom;" CssClass="icon" 
                                onclick="btnPerformQuery_Click" />
                            <asp:LinkButton ID="lbPerformQuery" runat="server" meta:resourcekey="btnPerformQuery" onclick="lbPerformQuery_Click" />
	                    </asp:Panel>
	                    <asp:Panel ID="pnlSaveQuery" runat="server" CssClass="float-left" style="padding-right: 15px;">
                            <asp:ImageButton ID="btnSaveQuery" runat="server" ToolTip="<%$ Resources: btnSaveQuery.Text %>" 
                                ImageUrl="~/Images/save.gif" style="vertical-align: text-bottom;" CssClass="icon" onclick="btnSaveQuery_Click" />
                            <asp:LinkButton ID="lbSaveQuery" runat="server" meta:resourcekey="btnSaveQuery" onclick="lbSaveQuery_Click" />
	                    </asp:Panel>
                        <asp:Panel ID="pnlCancel" runat="server" CssClass="float-left" style="padding-right: 15px;">
                            <asp:ImageButton ID="btnCancel" runat="server" ToolTip="<%$ Resources: btnCancelQuery.Text %>" 
                                ImageUrl="~/Images/lt.gif" style="vertical-align: text-bottom;" CssClass="icon" onclick="btnCancel_Click" />
                            <asp:LinkButton ID="lbCancel" runat="server" meta:resourcekey="btnCancelQuery" onclick="lbCancel_Click" />
	                    </asp:Panel>
                    </div>
                </div>
			</td>
		</tr>
	</table>
	<table id="Results" runat="server" style="width:100%">
		<tr>
			<td>
                <hr />
				<h1>Results</h1>
				<it:DisplayIssues id="ctlDisplayIssues" Runat="Server" />
			</td>
		</tr>
	</table>
</asp:Content>
