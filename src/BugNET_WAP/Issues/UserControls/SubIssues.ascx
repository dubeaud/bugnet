<%@ Control Language="c#" CodeBehind="SubIssues.ascx.cs" AutoEventWireup="True" Inherits="BugNET.Issues.UserControls.SubIssues" %>
<p style="margin-bottom:1em">
	<asp:label ID="lblDescription" meta:resourcekey="lblDescription"  runat="server" />
</p>
<asp:Label ID="NoIssuesLabel"  Font-Italic="true" runat="server" />
<asp:DataGrid id="grdIssues" AutoGenerateColumns="false" Width="100%" SkinID="DataGrid" OnItemDataBound="GrdIssuesItemDataBound" OnItemCommand="GrdIssuesItemCommand" Runat="Server">
	<columns>
        <asp:BoundColumn DataField="IssueId" SortExpression="IssueId" HeaderText="<%$ Resources:SharedResources, Id %>" />
		<asp:HyperLinkColumn DataNavigateUrlField="IssueId" DataNavigateUrlFormatString="~/Issues/IssueDetail.aspx?id={0}"
			DataTextField="Title" SortExpression="IssueTitle" HeaderText="<%$ Resources:SharedResources, Title %>">
		</asp:HyperLinkColumn>
        <asp:BoundColumn DataField="Status" SortExpression="IssueStatus" HeaderText="<%$ Resources:SharedResources, Status %>" />
        <asp:BoundColumn DataField="Resolution" SortExpression="IssueResolution" HeaderText="<%$ Resources:SharedResources, Resolution %>" />
        <asp:TemplateColumn>
            <ItemStyle Width="16px" />
            <ItemTemplate>
                <asp:ImageButton ToolTip="<%$ Resources:SharedResources, Remove %>" AlternateText="<%$ Resources:SharedResources, Remove %>" CssClass="icon" ID="cmdDelete" ImageUrl="~/images/cross.gif"
                    BorderWidth="0px" CommandName="Delete" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "IssueId") %>' runat="server" />
            </ItemTemplate>
        </asp:TemplateColumn>
	</columns>
</asp:DataGrid>
<asp:Panel ID="AddSubIssuePanel" runat="server"  CssClass="fieldgroup">
	<h3>Add Sub Issue</h3>
    <ol>
        <li>
            <asp:label ID="IssueIdLabel" runat="server" AssociatedControlID="IssueIdTextBox" Text="<%$ Resources:SharedResources, IssueId %>"/>
	        <asp:TextBox id="IssueIdTextBox" Width="100" CssClass="standardText" Runat="Server" />
            <asp:CompareValidator ControlToValidate="IssueIdTextBox" meta:resourcekey="CompareValidator1" ValidationGroup="AddRelatedIssue" Operator="DataTypeCheck" Type="Integer" Text="(integer)"
		        Runat="server" id="CompareValidator1" />
        </li>
    </ol>
    <div class="submit">
	    <asp:Button Text="Add Sub Issue" meta:resourcekey="btnAdd" CssClass="standardText" Runat="server" id="btnAdd" ValidationGroup="AddRelatedIssue" OnClick="AddRelatedIssue" />
	</div>
</asp:Panel>