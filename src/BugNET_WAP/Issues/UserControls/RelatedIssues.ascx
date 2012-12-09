<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="RelatedIssues.ascx.cs" Inherits="BugNET.Issues.UserControls.RelatedIssues" %>
<p style="margin-bottom:1em">
	<asp:label ID="lblDescription" meta:resourcekey="lblDescription"  runat="server" />
</p>
<BN:Message ID="RelatedIssuesMessage" runat="server" />
<asp:Label ID="NoIssuesLabel"  Font-Italic="true" runat="server" />
<asp:DataGrid  runat="server" ID="grdIssueItems" Width="100%"  SkinID="DataGrid" EnableViewState="true" OnItemDataBound="GrdIssueItemsDataBound" OnItemCommand="GrdIssueItemsItemCommand">
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
<asp:panel id="AddRelatedIssuePanel" runat="server" CssClass="fieldgroup">
    <h3><asp:label ID="lblAddRelatedIssue" runat="Server" meta:resourcekey="lblAddRelatedIssue"></asp:label></h3>
    <asp:label id="Label2" runat="server" Visible="False" ForeColor="Red"></asp:label>
    <ol>
        <li>
            <asp:Label ID="IssueIdLabel" AssociatedControlID="IssueIdTextBox" runat="server"  Text="<%$ Resources:SharedResources, IssueId %>" />
            <asp:textbox id="IssueIdTextBox" Width="100" runat="server" />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ControlToValidate="IssueIdTextBox" SetFocusOnError="True" ValidationGroup="AddRelatedIssue"  runat="server" ErrorMessage=" *"/>
        </li>
    </ol>    
    <div class="submit">
        <asp:Button Text="Add Related Issue" meta:resourcekey="btnAdd" CausesValidation="True" runat="server" id="Button1"  OnClick="CmdAddRelatedIssueClick" ValidationGroup="AddRelatedIssue" />
    </div>
</asp:panel>