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
            $('.milestone-group-header').click(function () {
                var li = $(this).parent();
                if (li.hasClass('active')) {
                    li.removeClass('active');
                    li.children('.milestone-content').hide();
                    $.cookie(li.attr('id'), null);
                }
                else {
                    li.addClass('active');
                    li.children('.milestone-content').show();
                    $.cookie(li.attr('id'), 'expanded');
                }

            });
            $("li.expand").each(function () {
                var isExpanded = $.cookie($(this).attr('id'));
                if (isExpanded == 'expanded') {
                    $(this).addClass('active');
                    $(this).children('.milestone-content').show();
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
        <HeaderTemplate>
            <ul class="milestone-list list-unstyled">
        </HeaderTemplate>
        <ItemTemplate>
            <li class="expand" id='milestoneRoadmap-<%#DataBinder.Eval(Container.DataItem, "Id") %>'>
                <div class="milestone-group-header">
                    <div class="milestoneProgress pull-right">
                        <asp:Label ID="PercentLabel" runat="Server" CssClass="pull-right" Style="padding-left: 5px; width: 40px; text-align: right;"></asp:Label>
                        <div class="roadMapProgress" style="float: right; vertical-align: top; background-color: #FA0000; font-size: 8px; width: 150px; height: 15px; margin: 0px;">
                            <div id="ProgressBar" runat='server' style="display: block; height: 15px; background: #6FB423 url('../images/fade.png') repeat-x 0% -3px;">&nbsp;</div>
                        </div>
                        <br />
                        <asp:Label CssClass="pull-right" ID="lblProgress" runat="Server"></asp:Label>
                    </div>
                    <asp:HyperLink ID="MilestoneLink" runat="server" />
                    <asp:Label ID="MilestoneNotes" runat="Server"></asp:Label>
                    <br />
                    <asp:Label ID="lblDueDate" CssClass="milestone-release-date" runat="Server"></asp:Label>
                </div>
                <div class="milestone-content" style="display: none;">
                    <asp:Repeater ID="IssuesList" OnItemCreated="rptRoadMap_ItemCreated" runat="server">
                        <HeaderTemplate>
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
                        </FooterTemplate>
                    </asp:Repeater>
                </div>
            </li>
        </ItemTemplate>
        <FooterTemplate>
            </ul>
        </FooterTemplate>
    </asp:Repeater>
</asp:Content>
