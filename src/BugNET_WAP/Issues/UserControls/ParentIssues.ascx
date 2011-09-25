<%@ Control Language="c#" CodeBehind="ParentIssues.ascx.cs" AutoEventWireup="True" Inherits="BugNET.Issues.UserControls.ParentIssues" %>
<p style="margin-bottom:1em">
    <asp:label ID="lblDescription" meta:resourcekey="lblDescription"  runat="server" Text="List all issues on which this issue depends. Enter the ID of the issue in the 
	text box below and click the Add Parent Issue button."></asp:label>	
</p>
<asp:DataGrid id="IssuesDataGrid" AutoGenerateColumns="false" Width="100%" SkinID="DataGrid" OnItemDataBound="grdIssueItemDataBound" OnItemCommand="grdBugsItemCommand" Runat="Server">
	<columns>
		<asp:templatecolumn SortExpression="IssueId" HeaderText="<%$ Resources:SharedResources, Id %>" >
			<itemtemplate>
				&nbsp;
				<asp:Label id="IssueIdLabel" Runat="Server" />
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
<asp:Panel ID="AddParentIssuePanel" runat="server"  CssClass="fieldgroup">
    <h3>Add Parent Issue</h3>
    <ol>
        <li>
            <asp:label ID="lblIssueId" runat="server" AssociatedControlID="IssueIdTextBox" Text="<%$ Resources:SharedResources, IssueId %>"/>
            <asp:TextBox id="IssueIdTextBox" Columns="5" CssClass="standardText" Runat="Server" />
            <asp:CompareValidator ControlToValidate="IssueIdTextBox" meta:resourcekey="CompareValidator1" ValidationGroup="AddRelatedIssue"  Operator="DataTypeCheck" Type="Integer" Text="(integer)"
	            Runat="server" id="CompareValidator1" />
        </li>
    </ol>
    <div class="submit">
        <asp:Button Text="Add Parent Issue"  meta:resourcekey="btnAdd" CssClass="standardText" Runat="server" id="btnAdd" ValidationGroup="AddRelatedIssue" onclick="AddRelatedIssue" />    
    </div>
</asp:Panel>