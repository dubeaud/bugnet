<%@ Page Language="c#" Inherits="BugNET.Projects.ProjectSummary" MasterPageFile="~/Site.Master" meta:resourcekey="Page"
    Title="Project Summary" MaintainScrollPositionOnPostback="true" CodeBehind="ProjectSummary.aspx.cs" %>
<%@ Register Src="~/UserControls/CategoryTreeView.ascx" TagName="CategoryTreeView" TagPrefix="uc1" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server" ID="content1"> 
    <div class="col-md-12">
        <div class="row">
            <div class="page-header">
                <div class="btn-group pull-right">
                    <button type="button" class="btn btn-link dropdown-toggle" data-toggle="dropdown">
                        <asp:Image AlternateText="RSS Feeds" CssClass="icon" runat="server" ImageUrl="~/images/xml_small.gif" ID="Image3" /> RSS <span class="caret"></span>
                    </button>
                    <ul class="dropdown-menu" role="menu">
                        <li><asp:HyperLink ID="lnkRSSIssuesByCategory" runat="server" meta:resourcekey="IssuesByCategory">Issues by category</asp:HyperLink></li>
                        <li><asp:HyperLink ID="lnkRSSIssuesByAssignee" runat="server" meta:resourcekey="IssuesByAssignee">Issues by assignee</asp:HyperLink></li>
                        <li><asp:HyperLink ID="lnkRSSIssuesByStatus" runat="server" meta:resourcekey="IssuesByStatus">Issues by status</asp:HyperLink></li>
                        <li><asp:HyperLink ID="lnkRSSIssuesByMilestone" runat="server" meta:resourcekey="IssuesByMilestone">Issues by milestone</asp:HyperLink></li>
                        <li><asp:HyperLink ID="lnkRSSIssuesByPriority" runat="server" meta:resourcekey="IssuesByPriority">Issues by priority</asp:HyperLink></li>
                        <li><asp:HyperLink ID="lnkRSSIssuesByType" runat="server" meta:resourcekey="IssuesByType">Issues by type</asp:HyperLink></li>
                    </ul>
                </div>
                <h1><asp:Literal EnableViewState="true" ID="litProject" runat="server" /> <small><asp:Literal ID="litProjectCode" runat="Server" /></small></h1>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-3">
                <asp:Repeater runat="server" ID="rptMilestonesOpenIssues" OnItemDataBound="SummaryItemDataBound">
                    <HeaderTemplate>
                        <table class="summary">
                            <tr>
                                <th colspan="4">
                                    <div class="roundedBox">
                                        <asp:Literal ID="Literal3" runat="server" Text="<%$ Resources:SharedResources, Milestone %>" />
                                        <span>
                                            <asp:Literal ID="Literal2" runat="server" meta:resourcekey="OpenIssues" />
                                        </span>
                                    </div>
                                </th>
                            </tr>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <td class="image-column"><bn:TextImage ID="summaryImage" runat="server" ImageDirectory="/Milestone" /></td>
                            <td class="item-column"><asp:HyperLink ID="summaryLink" NavigateUrl='<%# "~/Issues/IssueList.aspx?pid=" + HttpUtility.UrlEncode(ProjectId.ToString()) + "&m=" + HttpUtility.UrlEncode(DataBinder.Eval(Container.DataItem,"Id").ToString()) %>' runat="server" /></td>
                            <td class="count-column"><asp:Label ID="summaryCount" runat="Server"></asp:Label></td>
                            <td class="count-column"><asp:Label ID="summaryPercent" runat="Server"></asp:Label></td>
                        </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                        </table>
                    </FooterTemplate>
                </asp:Repeater>
            </div>
            <div class="col-sm-3">
                <table class="summary">
                    <tr>
                        <th>
                            <div>
                                <asp:Literal ID="Literal3" runat="server" Text="<%$ Resources:SharedResources, Category %>" />
                                <span><asp:Literal ID="Literal2" runat="server" meta:resourcekey="OpenIssues" /></span>
                            </div>
                        </th>
                    </tr>
                    <tr>
                        <td>
                            <uc1:CategoryTreeView ID="CategoryTreeView1" runat="server" />
                        </td>
                    </tr>
                </table>
            </div>
            <div class="col-sm-3">
               <asp:Repeater runat="server" ID="rptAssigneeOpenIssues" OnItemDataBound="SummaryItemDataBound">
                    <HeaderTemplate>
                        <table class="summary">
                            <tr>
                                <th colspan="2">
                                    <div class="roundedBox">
                                        <asp:Literal ID="Literal3" runat="server" meta:resourcekey="ByAssignee" />
                                        <span><asp:Literal ID="Literal2" runat="server" meta:resourcekey="OpenIssues" /></span>
                                    </div>
                                </th>
                            </tr>
                    </HeaderTemplate>
                    <ItemTemplate>
                            <tr>
                                <td class="item-column"><asp:HyperLink ID="summaryLink" NavigateUrl='<%# "~/Issues/IssueList.aspx?pid=" + HttpUtility.UrlEncode(ProjectId.ToString()) + "&u=" + HttpUtility.UrlEncode(DataBinder.Eval(Container.DataItem,"Id").ToString()) %>' runat="server" /></td>
                                <td class="count-column"><asp:Label ID="summaryCount" runat="Server"></asp:Label></td>
                            </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                        </table>
                    </FooterTemplate>
                </asp:Repeater>
            </div>
            <div class="col-sm-3">
            <asp:Repeater runat="server" ID="rptIssueStatus" OnItemDataBound="SummaryItemDataBound">
                <HeaderTemplate>
                    <table class="summary">
                        <tr>
                            <th colspan="4">
                                <div>
                                    <asp:Literal ID="Literal3" runat="server" Text="<%$ Resources:SharedResources, Status %>" />
                                </div>
                            </th>
                        </tr>
                </HeaderTemplate>
                <ItemTemplate>
                        <tr>
                            <td class="image-column"><bn:TextImage ID="summaryImage" runat="server" ImageDirectory="/Status" /></td>
                            <td class="item-column"><asp:HyperLink ID="summaryLink" NavigateUrl='<%# "~/Issues/IssueList.aspx?pid=" + HttpUtility.UrlEncode(ProjectId.ToString()) + "&s=" + HttpUtility.UrlEncode(DataBinder.Eval(Container.DataItem,"Id").ToString()) %>' runat="server" /></td>
                            <td class="count-column"><asp:Label ID="summaryCount" runat="Server"></asp:Label></td>
                            <td class="count-column"><asp:Label ID="summaryPercent" runat="Server"></asp:Label></td>
                        </tr>
                </ItemTemplate>
                <FooterTemplate>
                    </table>
                </FooterTemplate>
            </asp:Repeater>
            <asp:Repeater runat="server" ID="rptPriorityOpenIssues" OnItemDataBound="SummaryItemDataBound">
                <HeaderTemplate>
                    <table class="summary">
                        <tr>
                            <th colspan="3">
                                <div class="roundedBox">
                                    <asp:Literal ID="Literal3" runat="server" Text="<%$ Resources:SharedResources, Priority %>" />
                                    <span><asp:Literal ID="Literal2" runat="server" meta:resourcekey="OpenIssues" /></span>
                                </div>
                            </th>
                        </tr>
                </HeaderTemplate>
                <ItemTemplate>
                        <tr>
                            <td class="image-column"><bn:TextImage ID="summaryImage" runat="server" ImageDirectory="/Priority" /></td>
                            <td class="item-column"><asp:HyperLink ID="summaryLink" NavigateUrl='<%# "~/Issues/IssueList.aspx?pid=" + HttpUtility.UrlEncode(ProjectId.ToString()) + "&p=" + HttpUtility.UrlEncode(DataBinder.Eval(Container.DataItem,"Id").ToString()) %>' runat="server" /></td>
                            <td class="count-column"><asp:Label ID="summaryCount" runat="Server"></asp:Label></td>
                        </tr>
                </ItemTemplate>
                <FooterTemplate>
                    </table>
                </FooterTemplate>
            </asp:Repeater>
            <asp:Repeater runat="server" ID="rptTypeOpenIssues" OnItemDataBound="SummaryItemDataBound">
                <HeaderTemplate>
                    <table class="summary">
                        <tr>
                            <th colspan="3">
                                <div class="roundedBox">
                                    <asp:Literal ID="Literal3" runat="server" Text="<%$ Resources:SharedResources, Type %>" />
                                    <span><asp:Literal ID="Literal2" runat="server" meta:resourcekey="OpenIssues" /></span>
                                </div>
                            </th>
                        </tr>
                </HeaderTemplate>
                <ItemTemplate>
                        <tr>
                            <td class="image-column"><bn:TextImage ID="summaryImage" runat="server" ImageDirectory="/IssueType" /></td>
                            <td class="item-column"><asp:HyperLink ID="summaryLink" NavigateUrl='<%# "~/Issues/IssueList.aspx?pid=" + HttpUtility.UrlEncode(ProjectId.ToString()) + "&t=" + HttpUtility.UrlEncode(DataBinder.Eval(Container.DataItem,"Id").ToString()) %>' runat="server" /></td>
                            <td class="count-column"><asp:Label ID="summaryCount" runat="Server"></asp:Label></td>
                        </tr>
                </ItemTemplate>
                <FooterTemplate>
                    </table>
                </FooterTemplate>
            </asp:Repeater>
            </div>
        </div>
    </div>
</asp:Content>
