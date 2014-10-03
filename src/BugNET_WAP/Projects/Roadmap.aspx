<%@ Page Language="C#" MasterPageFile="~/Site.master" Title="Road Map" AutoEventWireup="true" meta:resourcekey="Page"
    Inherits="BugNET.Projects.Roadmap" CodeBehind="RoadMap.aspx.cs" %>

<%@ Register TagPrefix="it" TagName="TextImage" Src="~/UserControls/TextImage.ascx" %>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <asp:ScriptManagerProxy ID="ScriptManagerProxy1" runat="server">
        <Scripts>
            <asp:ScriptReference Path="~/Scripts/jquery.cookie.js" />
        </Scripts>
    </asp:ScriptManagerProxy>

    <script type="text/javascript">
        $(document).ready(function () {
            $('.milestone-content').on('hidden.bs.collapse', function () {
                $.cookie($(this).attr('id'), null);
            })
            $('.milestone-content').on('shown.bs.collapse', function () {
                $.cookie($(this).attr('id'), 'expanded');
            })
            $(".milestone-content").each(function () {
                var isExpanded = $.cookie($(this).attr('id'));
                if (isExpanded == 'expanded') {
                    $(this).collapse('show');
                }
            });
        });
    </script>

    <div class="page-header">
        <h1>
            <asp:Literal ID="Literal1" runat="server" meta:resourcekey="TitleLabel" />
            <small>
                <asp:Literal ID="ltProject" runat="server" />
                <span>(<asp:Literal ID="litProjectCode" runat="Server"></asp:Literal>)</span>
            </small> 
        </h1>
    </div>

    <asp:Repeater runat="server" ID="RoadmapRepeater" OnItemDataBound="RoadmapRepeater_ItemDataBound">
        <ItemTemplate>
            <div class="panel panel-default">
                <div class="milestone-group-header panel-heading" data-toggle="collapse" data-target="#milestone-content-<%#DataBinder.Eval(Container.DataItem, "Id") %>">
                    <div class="milestoneProgress pull-right">
                        <div class="progress">
                            <div class="progress-bar progress-bar-success" id="ProgressBar" runat="server" role="progressbar"  aria-valuemin="0" aria-valuemax="100">
                            </div>
                        </div>
                        <asp:Label CssClass="pull-right" ID="lblProgress" runat="Server"></asp:Label>
                    </div>
                    <h4 class="panel-title">
                        <asp:HyperLink ID="MilestoneLink" runat="server" /> <small><asp:Label ID="MilestoneNotes" runat="Server"></asp:Label></small>
                    </h4>
                   
                    <asp:Label ID="lblDueDate" CssClass="milestone-release-date" runat="Server"></asp:Label>
                </div>
                <div class="milestone-content panel-collapse collapse" id="milestone-content-<%#DataBinder.Eval(Container.DataItem, "Id") %>">
                    <div class="panel-body">
                    <asp:Repeater ID="IssuesList" OnItemCreated="rptRoadMap_ItemCreated" runat="server">
                        <HeaderTemplate>
                            <div class="table-responsive">
                            <table class="table table-hover table-striped">
                                <tr>
                                    <th runat="server" id="tdId" class="gridHeader">
                                        <asp:LinkButton ID="LinkButton2" runat="server" Text="<%$ Resources:SharedResources, Id %>" CommandName="Id" CommandArgument="iv.[IssueId]" OnClick="SortIssueClick" />
                                    </th>
                                    <th runat="server" id="tdTitle" class="gridHeader">
                                        <asp:LinkButton ID="LinkButton3" runat="server" Text="<%$ Resources:SharedResources, Title %>" CommandName="Title" CommandArgument="iv.[IssueTitle]" OnClick="SortIssueClick" />
                                    </th>
                                    <th runat="server" id="tdCategory" class="gridHeader">
                                        <asp:LinkButton ID="lnkCategory" runat="server" Text="<%$ Resources:SharedResources, Category %>" CommandName="Category" CommandArgument="iv.[CategoryName]" OnClick="SortIssueClick" />
                                    </th>
                                    <th runat="server" id="tdAssigned" class="gridHeader">
                                        <asp:LinkButton ID="LinkButton4" runat="server" Text="<%$ Resources:SharedResources, AssignedTo %>" CommandName="Assigned" CommandArgument="iv.[AssignedDisplayName]" OnClick="SortIssueClick" />
                                    </th>
                                    <th runat="server" id="tdIssueType" class="gridHeader align-center">
                                        <asp:LinkButton ID="LinkButton1" runat="server" Text="<%$ Resources:SharedResources, Type %>" CommandName="IssueType" CommandArgument="iv.[IssueTypeSortOrder]" OnClick="SortIssueClick"/>
                                    </th>
                                    <th runat="server" id="tdStatus" class="gridHeader align-center">
                                        <asp:LinkButton ID="LinkButton6" runat="server" Text="<%$ Resources:SharedResources, Status %>" CommandName="Status" CommandArgument="iv.[StatusSortOrder]" OnClick="SortIssueClick" />
                                    </th>
                                    <th runat="server" id="tdPriority" class="gridHeader align-center">
                                        <asp:LinkButton ID="LinkButton8" runat="server" Text="<%$ Resources:SharedResources, Priority %>" CommandName="Priority" CommandArgument="iv.[PrioritySortOrder]" OnClick="SortIssueClick" />
                                    </th>
                                    <th runat="server" id="tdDueDate" class="gridHeader">
                                        <asp:LinkButton ID="LinkButton5" runat="server" Text="<%$ Resources:SharedResources, DueDate %>" CommandName="DueDate" CommandArgument="iv.[IssueDueDate]" OnClick="SortIssueClick" />
                                    </th>
                                </tr>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr>
                                <td>
                                    <asp:HyperLink runat="server" NavigateUrl='<%# String.Format("~/Issues/IssueDetail.aspx?id={0}", DataBinder.Eval(Container.DataItem, "Id").ToString()) %>'><%#DataBinder.Eval(Container.DataItem, "FullId") %></asp:HyperLink>
                                </td>
                                <td>
                                    <asp:HyperLink runat="server" NavigateUrl='<%# String.Format("~/Issues/IssueDetail.aspx?id={0}", DataBinder.Eval(Container.DataItem, "Id").ToString()) %>'><%#DataBinder.Eval(Container.DataItem, "Title") %></asp:HyperLink>
                                </td>
                                <td>
                                    <asp:Label ID="lblComponent" Text='<%# DataBinder.Eval(Container.DataItem, "CategoryName" )%>' runat="Server"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lblAssignedTo" Text='<%# DataBinder.Eval(Container.DataItem, "AssignedDisplayName" )%>' runat="Server"></asp:Label>
                                </td>
                                <td class="align-center">
                                    <it:TextImage ID="ctlType" ImageDirectory="/IssueType" Text='<%# DataBinder.Eval(Container.DataItem, "IssueTypeName" )%>'
                                        ImageUrl='<%# DataBinder.Eval(Container.DataItem, "IssueTypeImageUrl" )%>' runat="server" />
                                </td>
                                <td class="align-center">
                                    <it:TextImage ID="ctlStatus" ImageDirectory="/Status" Text='<%# DataBinder.Eval(Container.DataItem, "StatusName" )%>' ImageUrl='<%# DataBinder.Eval(Container.DataItem, "StatusImageUrl" )%>'
                                        runat="server" />
                                </td>
                                <td class="align-center">
                                    <it:TextImage ID="ctlPriority" ImageDirectory="/Priority" Text='<%# DataBinder.Eval(Container.DataItem, "PriorityName" )%>'
                                        ImageUrl='<%# DataBinder.Eval(Container.DataItem, "PriorityImageUrl" )%>' runat="server" />
                                </td>
                                <td>
                                    <%#(DateTime)Eval("DueDate") == DateTime.MinValue ? "none" : Eval("DueDate", "{0:d}") %>
                                </td>
                            </tr>
                        </ItemTemplate>
                        <FooterTemplate>
                            </table>
                            </div>
                        </FooterTemplate>
                    </asp:Repeater>
                        </div>
                </div>
            </div>
        </ItemTemplate>
    </asp:Repeater>
</asp:Content>
