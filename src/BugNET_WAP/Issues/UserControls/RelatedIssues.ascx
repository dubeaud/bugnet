<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="RelatedIssues.ascx.cs" Inherits="BugNET.Issues.UserControls.RelatedIssues" %>
<%@ Register TagPrefix="it" TagName="TextImage" Src="~/UserControls/TextImage.ascx" %>
<p style="margin-bottom: 1em">
    <asp:Label ID="lblDescription" meta:resourcekey="lblDescription" runat="server" />
</p>
<bn:Message ID="RelatedIssuesMessage" runat="server" />
<asp:Label ID="NoIssuesLabel" Font-Italic="true" runat="server" />
<asp:DataGrid runat="server" ID="grdIssueItems" CssClass="table table-striped" UseAccessibleHeader="true" AutoGenerateColumns="false"
    GridLines="None" EnableViewState="true" OnItemDataBound="GrdIssueItemsDataBound" OnItemCommand="GrdIssueItemsItemCommand">
    <Columns>
        <asp:BoundColumn DataField="IssueId" SortExpression="IssueId" HeaderText="<%$ Resources:SharedResources, Id %>" />
        <asp:HyperLinkColumn DataNavigateUrlField="IssueId" DataNavigateUrlFormatString="~/Issues/IssueDetail.aspx?id={0}"
            DataTextField="Title" SortExpression="IssueTitle" HeaderText="<%$ Resources:SharedResources, Title %>"></asp:HyperLinkColumn>
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
    </Columns>
</asp:DataGrid>
<asp:Panel ID="AddRelatedIssuePanel" runat="server" CssClass="form-horizontal">
    <h3>
        <asp:Label ID="lblAddRelatedIssue" runat="Server" meta:resourcekey="lblAddRelatedIssue"></asp:Label></h3>
    <asp:Label ID="Label2" runat="server" Visible="False" ForeColor="Red"></asp:Label>
    <div class="form-group">
        <asp:Label ID="IssueIdLabel" CssClass="col-md-2 control-label" AssociatedControlID="IssueIdTextBox" runat="server" Text="<%$ Resources:SharedResources, IssueId %>" />
        <div class="col-md-2">
            <asp:TextBox ID="IssueIdTextBox" CssClass="form-control" runat="server" />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ControlToValidate="IssueIdTextBox" SetFocusOnError="True" ValidationGroup="AddRelatedIssue" runat="server" ErrorMessage=" *" />

        </div>
    </div>
    <div class="form-group">
        <div class="col-md-offset-2 col-md-7">
            <asp:Button Text="Add Related Issue" CssClass="btn btn-primary" meta:resourcekey="btnAdd" CausesValidation="True" runat="server" ID="Button1" OnClick="CmdAddRelatedIssueClick" ValidationGroup="AddRelatedIssue" />
        </div>
    </div>
</asp:Panel>
