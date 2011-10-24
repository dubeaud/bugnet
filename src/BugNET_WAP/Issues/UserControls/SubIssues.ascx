<%@ Control Language="c#" CodeBehind="SubIssues.ascx.cs" AutoEventWireup="True" Inherits="BugNET.Issues.UserControls.SubIssues" %>
<p style="margin-bottom:1em">
    <asp:label ID="lblDescription" meta:resourcekey="lblDescription"  runat="server" />
</p>
<asp:DataGrid id="grdIssues" AutoGenerateColumns="false" Width="100%" SkinID="DataGrid" OnItemDataBound="GrdIssuesItemDataBound" OnItemCommand="GrdIssuesItemCommand" Runat="Server">
	<columns>
		<asp:templatecolumn SortExpression="IssueId" HeaderText="<%$ Resources:SharedResources, Id %>">
			<itemtemplate>
				&nbsp;
				<asp:Label id="lblIssueId" Runat="Server" />
			</itemtemplate>
		</asp:templatecolumn>
		<asp:hyperlinkcolumn DataNavigateUrlField="IssueId" DataNavigateUrlFormatString="~/Issues/IssueDetail.aspx?id={0}"
			DataTextField="Title" SortExpression="IssueTitle" HeaderText="<%$ Resources:SharedResources, Title %>">
		</asp:hyperlinkcolumn>
			<asp:templatecolumn SortExpression="IssueStatus" HeaderText="<%$ Resources:SharedResources, Status %>">
			<itemtemplate>
				<asp:Label id="IssueStatusLabel" Runat="Server" />
			</itemtemplate>
		</asp:templatecolumn>
		<asp:templatecolumn SortExpression="IssueResolution" HeaderText="<%$ Resources:SharedResources, Resolution %>">
			<itemtemplate>
				<asp:Label id="IssueResolutionLabel" Runat="Server" />
			</itemtemplate>
		</asp:templatecolumn>
		<asp:templatecolumn ItemStyle-Width="80px">
			<itemtemplate>
				<asp:Button id="btnDelete" Text="<%$ Resources:SharedResources, Delete %>" CssClass="standardText" CausesValidation="false" Runat="Server" />
			</itemtemplate>
		</asp:templatecolumn>
	</columns>
</asp:DataGrid>
<asp:Panel ID="AddSubIssuePanel" runat="server"  CssClass="fieldgroup">
	<h3>Add Sub Issue</h3>
    <ol>
        <li>
            <asp:label ID="lblIssueId" runat="server" AssociatedControlID="txtIssueId" Text="<%$ Resources:SharedResources, IssueId %>"/>
	        <asp:TextBox id="txtIssueId" Columns="5" CssClass="standardText" Runat="Server" />
            <asp:CompareValidator ControlToValidate="txtIssueId" meta:resourcekey="CompareValidator1" ValidationGroup="AddRelatedIssue" Operator="DataTypeCheck" Type="Integer" Text="(integer)"
		        Runat="server" id="CompareValidator1" />
        </li>
    </ol>
    <div class="submit">
	    <asp:Button Text="Add Sub Issue" meta:resourcekey="btnAdd" CssClass="standardText" Runat="server" id="btnAdd" ValidationGroup="AddRelatedIssue" OnClick="AddRelatedIssue" />
	</div>
</asp:Panel>