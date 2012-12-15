<%@ Control Language="c#" CodeBehind="ParentIssues.ascx.cs" AutoEventWireup="True" Inherits="BugNET.Issues.UserControls.ParentIssues" %>
<p style="margin-bottom:1em">
	<asp:label ID="lblDescription" meta:resourcekey="lblDescription"  runat="server" />
</p>
<BN:Message ID="ParentIssuesMessage" runat="server" />
<asp:Label ID="NoIssuesLabel"  Font-Italic="true" runat="server" />
<asp:DataGrid id="IssuesDataGrid" AutoGenerateColumns="false" Width="100%" SkinID="DataGrid" OnItemDataBound="GrdIssueItemDataBound" OnItemCommand="GrdBugsItemCommand" Runat="Server">
	<Columns>
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
                    BorderWidth="0px" CommandName="Delete" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "IssueId") %>' runat="server" Visible="false" />
            </ItemTemplate>
        </asp:TemplateColumn>
	</Columns>
</asp:DataGrid>
<asp:Panel ID="AddParentIssuePanel" runat="server"  CssClass="fieldgroup">
    <h3><asp:Literal runat="server" meta:resourcekey="TitleLiteral" Text="Add Parent Issue"/></h3>
    <ol>
        <li>
            <asp:label ID="IssueIdLabel" runat="server" AssociatedControlID="IssueIdTextBox" Text="<%$ Resources:SharedResources, IssueId %>"/>
            <asp:TextBox id="IssueIdTextBox" Width="100" CssClass="standardText" Runat="Server" />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ControlToValidate="IssueIdTextBox" SetFocusOnError="True" ValidationGroup="AddParentIssue"  runat="server" ErrorMessage=" *"/>
        </li>
    </ol>
    <div class="submit">
        <asp:Button Text="Add Parent Issue"  meta:resourcekey="btnAdd" CssClass="standardText" Runat="server" id="btnAdd" ValidationGroup="AddRelatedIssue" onclick="AddRelatedIssue" />    
    </div>
</asp:Panel>