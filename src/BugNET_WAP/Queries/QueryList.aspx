<%@ Page Language="c#" CodeBehind="QueryList.aspx.cs" AutoEventWireup="True" MasterPageFile="~/Shared/SingleColumn.master" Title="Query List" Inherits="BugNET.Queries.QueryList" %>
<%@ Register TagPrefix="it" TagName="PickProject" Src="~/UserControls/PickProject.ascx" %>
<%@ Register TagPrefix="it" TagName="PickQuery" Src="~/UserControls/PickQuery.ascx" %>
<%@ Register TagPrefix="it" TagName="DisplayIssues" Src="~/UserControls/DisplayIssues.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server">

							
	<table class="queryList">
		<tr>
			<td>
				Query:
			</td>
			<td>
				<it:PickQuery id="dropQueries" CssClass="standardText" DisplayDefault="true" Runat="Server" />
			</td>
			<td>
				<asp:Button id="btnPerformQuery" Text="Perform Query" meta:resourcekey="btnPerformQuery" CssClass="standardText" Runat="Server" onclick="btnPerformQueryClick" />
			</td>
		</tr>
	</table>
	
	<div style="margin-top:10px;margin-bottom:10px;">
        <asp:Button Text="Create New Query" meta:resourcekey="btnAddQuery" Class="standardText" Runat="server" id="btnAddQuery" onclick="AddQuery" />
		<asp:Button Text="Delete Query" meta:resourcekey="btnDeleteQuery" Class="standardText" Runat="server" id="btnDeleteQuery" onclick="DeleteQuery" />
        <asp:Button Text="Edit Query" Class="standardText" Runat="server" id="EditQueryButton" onclick="EditQuery" />
    </div>
	<asp:Label id="lblError" ForeColor="red" EnableViewState="false" Runat="Server" />
	<asp:panel ID="Results" runat="server">
        <table>
	        <tr>
		        <td class="contentCell">
			        <h1><asp:Literal ID="Literal1" runat="server" meta:resourcekey="Results" /></h1>
			        <it:DisplayIssues id="ctlDisplayIssues" Runat="Server" />
		        </td>
	        </tr>
        </table>
	</asp:panel>
</asp:Content>
