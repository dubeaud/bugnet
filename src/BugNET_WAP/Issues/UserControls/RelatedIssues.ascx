<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="RelatedIssues.ascx.cs" Inherits="BugNET.Issues.UserControls.RelatedIssues" %>
<p style="margin-bottom:1em">
	<asp:label ID="lblDescription" meta:resourcekey="lblDescription"  runat="server" Text="List all issues on which this issue is related. Enter the ID of the issue in the 
	text box below and click the Add Related Issue button."></asp:label>	
	
</p>
<BN:Message ID="RelatedIssuesMessage" runat="server" />
<asp:Label ID="RelatedIssuesLabel"  Font-Italic="true" runat="server"></asp:Label> 
<asp:Datagrid  runat="server" ID="RelatedIssuesDataGrid" Width="100%"  SkinID="DataGrid" EnableViewState="true" OnItemDataBound="GrdIssueItemDataBound" OnItemCommand="RelatedIssuesDataGrid_ItemCommand">
    <columns>
		<asp:templatecolumn SortExpression="IssueId" HeaderText="<%$ Resources:SharedResources, Id %>">
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
				<asp:Button id="btnDelete" Text="<%$ Resources:SharedResources, Delete %>" CausesValidation="false" CssClass="standardText" Runat="Server" />
			</itemtemplate>
		</asp:templatecolumn>
	</columns>
</asp:Datagrid>	

<asp:panel id="AddRelatedIssuePanel" runat="server" CssClass="fieldgroup">
    <h3><asp:label ID="lblAddRelatedIssue" runat="Server" meta:resourcekey="lblAddRelatedIssue"></asp:label></h3>
    <asp:label id="Label2" runat="server" Visible="False" ForeColor="Red"></asp:label>
    <ol>
    
        <li>
            <asp:Label ID="lblRelatedIssue" AssociatedControlID="txtRelatedIssue" runat="server"  Text="<%$ Resources:SharedResources, IssueId %>" />
            <asp:textbox id="txtRelatedIssue" Width="70" runat="server" />
              <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ControlToValidate="txtRelatedIssue" SetFocusOnError="True" ValidationGroup="AddRelatedIssue"  runat="server" ErrorMessage=" *"></asp:RequiredFieldValidator>
            <asp:CompareValidator ControlToValidate="txtRelatedIssue" Operator="DataTypeCheck" Type="Integer" Text="(integer)"
		        Runat="server" id="CompareValidator1" />
        </li>
    </ol>    
    <div class="submit">
        <asp:Button Text="Add Related Issue" meta:resourcekey="lblAddRelatedIssue" CausesValidation="True" runat="server" id="Button1"  OnClick="cmdAddRelatedIssue_Click" ValidationGroup="AddRelatedIssue" />
    </div>
</asp:panel>