<%@ Control Language="c#" CodeBehind="SubIssues.ascx.cs" AutoEventWireup="True" Inherits="BugNET.Issues.UserControls.SubIssues" %>
<%@ Register TagPrefix="it" TagName="TextImage" Src="~/UserControls/TextImage.ascx" %>

<p style="margin-bottom:1em">
	<asp:label ID="lblDescription" meta:resourcekey="lblDescription"  runat="server" />
</p>
<BN:Message ID="SubIssuesMessage" runat="server" />
<asp:Label ID="NoIssuesLabel"  Font-Italic="true" runat="server" />
<asp:DataGrid id="grdIssues" AutoGenerateColumns="false" CssClass="table table-striped" UseAccessibleHeader="true"
    GridLines="None" OnItemDataBound="GrdIssuesItemDataBound" OnItemCommand="GrdIssuesItemCommand" Runat="Server">
	<columns>
        <asp:BoundColumn DataField="IssueId" SortExpression="IssueId" HeaderText="<%$ Resources:SharedResources, Id %>" />
		<asp:HyperLinkColumn DataNavigateUrlField="IssueId" DataNavigateUrlFormatString="~/Issues/IssueDetail.aspx?id={0}"
			DataTextField="Title" SortExpression="IssueTitle" HeaderText="<%$ Resources:SharedResources, Title %>">
		</asp:HyperLinkColumn>
        <asp:TemplateColumn HeaderText="<%$ Resources:SharedResources, Status %>" SortExpression="IssueStatus">
            <ItemTemplate>
                <it:TextImage ID="ctlStatus" ImageDirectory="/Status" Text='<%# DataBinder.Eval(Container.DataItem, "StatusName" )%>' ImageUrl='<%# DataBinder.Eval(Container.DataItem, "StatusImageUrl" )%>'
                    runat="server" />
            </ItemTemplate>
            <ItemStyle CssClass="text-center" />
            <HeaderStyle CssClass="text-center" />
        </asp:TemplateColumn>
        <asp:BoundColumn DataField="Resolution" SortExpression="IssueResolution" HeaderText="<%$ Resources:SharedResources, Resolution %>" />
        <asp:TemplateColumn>
            <ItemStyle Width="16px" />
            <ItemTemplate>
                <asp:ImageButton ToolTip="<%$ Resources:SharedResources, Remove %>" AlternateText="<%$ Resources:SharedResources, Remove %>" CssClass="icon" ID="cmdDelete" ImageUrl="~/images/cross.gif"
                    BorderWidth="0px" CommandName="Delete" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "IssueId") %>' runat="server" Visible="false" />
            </ItemTemplate>
        </asp:TemplateColumn>
	</columns>
</asp:DataGrid>
<asp:Panel ID="AddSubIssuePanel" runat="server"  CssClass="form-horizontal">
	<h3><asp:Literal runat="server" meta:resourcekey="TitleLiteral" Text="Add Sub Issue"/></h3>
    <div class="form-group">
         <asp:label ID="IssueIdLabel" runat="server" CssClass="col-md-2 control-label" AssociatedControlID="IssueIdTextBox" Text="<%$ Resources:SharedResources, IssueId %>"/>
        <div class="col-md-2">
            <asp:TextBox id="IssueIdTextBox" CssClass="form-control" Runat="Server" />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ControlToValidate="IssueIdTextBox" SetFocusOnError="True" ValidationGroup="AddSubIssue"  runat="server" ErrorMessage=" *"/>
        </div>
    </div>
    <div class="form-group">
        <div class="col-md-offset-2 col-md-7">
            <asp:Button Text="Add Sub Issue" meta:resourcekey="btnAdd" CssClass="btn btn-primary" Runat="server" id="btnAdd" ValidationGroup="AddRelatedIssue" OnClick="AddRelatedIssue" />
        </div>
    </div>
</asp:Panel>