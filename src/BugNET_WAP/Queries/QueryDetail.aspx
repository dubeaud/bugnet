<%@ Register TagPrefix="it" TagName="DisplayIssues" Src="~/UserControls/DisplayIssues.ascx" %>
<%@ Register TagPrefix="it" TagName="PickQueryField" Src="~/UserControls/PickQueryField.ascx" %>
<%@ Register TagPrefix="it" TagName="PickProject" Src="~/UserControls/PickProject.ascx" %>
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
				<br/>
				<asp:Button id="btnAddClause" Text="Add Clause" meta:resourcekey="btnAddClause" CssClass="standardText" Runat="Server" onclick="btnAddClauseClick" />
				<asp:Button id="btnRemoveClause" Text="Remove Clause" CssClass="standardText" meta:resourcekey="btnRemoveClause" Runat="Server" onclick="btnRemoveClauseClick" />   
                <div class="fieldgroup">
                    <asp:Panel ID="SaveQuery" runat="server">
                        <ol>
                            <li>
                                <asp:Label ID="Label1" runat="server" Text="Query Name" AssociatedControlID="txtQueryName" />
                                <asp:TextBox id="txtQueryName" Runat="Server" />
                            </li>
                            <li>
                                <asp:Label ID="Label7" runat="server" Text="Public Query:"  meta:resourcekey="chkGlobalQuery" AssociatedControlID="chkGlobalQuery" />
                                 <asp:CheckBox ID="chkGlobalQuery"  runat="server" />
                            </li>
                        </ol>
                    </asp:Panel>
                    <div class="submit">
                        <asp:Button id="btnPerformQuery" Text="Perform Query" meta:resourcekey="btnPerformQuery" CssClass="standardText" Runat="Server" onclick="btnPerformQueryClick" />
                        <asp:Button id="btnSaveQuery" Text="Save Query"  meta:resourcekey="btnSaveQuery" CssClass="standardText" Runat="Server" onclick="btnSaveQueryClick" />
                    </div>
                </div>
			</td>
		</tr>
	</table>
	<table id="Results" runat="server" style="width:100%">
		<tr>
			<td class="contentCell">
                <hr />
				<h1>Results</h1>
				<it:DisplayIssues id="ctlDisplayIssues" Runat="Server" />
			</td>
		</tr>
	</table>
</asp:Content>
