<%@ Page Language="c#" Inherits="BugNET.Projects.ChangeLog" MasterPageFile="~/Shared/SingleColumn.master"
    meta:resourcekey="Page" Title="Change Log" CodeBehind="ChangeLog.aspx.cs" %>

<%@ Register TagPrefix="it" TagName="TextImage" Src="~/UserControls/TextImage.ascx" %>
<asp:Content ContentPlaceHolderID="Content" ID="content1" runat="server">
    <asp:ScriptManagerProxy ID="ScriptManagerProxy1" runat="server">
        <Scripts>
            <asp:ScriptReference Path="~/Scripts/jquery.cookie.js" />
        </Scripts>
    </asp:ScriptManagerProxy>
    <script type="text/javascript">
        $(document).ready(function () {
            $('.milestoneGroupHeader').click(function () {
                var li = $(this).parent();
                if (li.hasClass('active')) {
                    li.removeClass('active');
                    li.children('.milestoneContent').slideUp();
                    $.cookie(li.attr('id'), null);
                }
                else {
                    li.addClass('active');
                    li.children('.milestoneContent').slideDown();
                    $.cookie(li.attr('id'), 'expanded');
                }

            });
            $("li.expand").each(function () {
                var isExpanded = $.cookie($(this).attr('id'));
                if (isExpanded == 'expanded') {
                    $(this).addClass('active');
                    $(this).children('.milestoneContent').show();
                }
            });
        });
    </script>
    <div class="centered-content">
        <h1 class="page-title">
            <asp:Literal ID="Literal1" runat="server" Text="<%$ Resources:SharedResources, ChangeLog %>" />
            -
            <asp:Literal ID="ltProject" runat="server" />
            <span>(<asp:Literal ID="litProjectCode" runat="Server"></asp:Literal>)</span>
        </h1>
    </div>
    <div style="float: right;">
        <asp:Localize runat="server" ID="Sort" Text="Sort:" meta:resourcekey="SortLabel" />
        <asp:LinkButton ID="Linkbutton7" runat="server" OnClick="SortMilestone_Click" CommandArgument="false"
            meta:resourcekey="MostRecent" Text="Most Recent"></asp:LinkButton>
        |
        <asp:LinkButton ID="Linkbutton9" runat="server" CommandArgument="true" meta:resourcekey="FirstToLast"
            OnClick="SortMilestone_Click" Text="First To Last"></asp:LinkButton>
    </div>
    <div>
        <asp:LinkButton ID="PreviousMilestones" runat="server" OnClick="SwitchViewMode_Click"
            CommandArgument="1" meta:resourcekey="PreviousMilestones" Text="Top 5 milestones"></asp:LinkButton>
        |
        <asp:LinkButton ID="Linkbutton5" runat="server" OnClick="SwitchViewMode_Click" CommandArgument="2"
            meta:resourcekey="AllMilestones" Text="All milestones"></asp:LinkButton>
    </div>
    <asp:Repeater runat="server" ID="ChangeLogRepeater" OnItemDataBound="ChangeLogRepeater_ItemDataBound">
        <HeaderTemplate>
            <ul class="milestoneList">
        </HeaderTemplate>
        <ItemTemplate>
            <li class="expand" id='milestone-<%#DataBinder.Eval(Container.DataItem, "Id") %>'>
                <div class="milestoneGroupHeader">
                    <div class="issueCount">
                        <asp:HyperLink ID="IssuesCount" runat="server" />
                    </div>
                    <asp:HyperLink ID="MilestoneLink" CssClass="milestoneName" runat="server" />
                    <asp:Label CssClass="milestoneNotes" ID="MilestoneNotes" runat="Server"></asp:Label>
                    <br style="clear: both;" />
                    <span class="milestoneReleaseDate">
                        <asp:Label ID="lblReleaseDate" runat="Server"></asp:Label></span> <span style="font-weight: normal;">
                            <asp:HyperLink ID="ReleaseNotes" runat="server" Text="Release Notes" meta:resourcekey="ReleaseNotes" /></span>
                </div>
                <div class="milestoneContent" style="display: none;">
                    <asp:Repeater ID="IssuesList" OnItemCreated="rptChangeLog_ItemCreated" runat="server">
                        <HeaderTemplate>
                            <table class="grid">
                                <tr>
                                    <td runat="server" id="tdId" class="gridHeader">
                                        <asp:LinkButton ID="LinkButton2" runat="server" Text="<%$ Resources:SharedResources, Id %>" CommandName="Id" CommandArgument="iv.[IssueId]" OnClick="SortIssueClick" />
                                    </td>
                                    <td runat="server" id="tdCategory" class="gridHeader">
                                        <asp:LinkButton ID="lnkCategory" runat="server" Text="<%$ Resources:SharedResources, Category %>" CommandName="Category" CommandArgument="iv.[CategoryName]" OnClick="SortIssueClick" />
                                    </td>
                                    <td runat="server" id="tdIssueType" class="gridHeader" style="text-align: center;">
                                        <asp:LinkButton ID="LinkButton1" runat="server"  Text="<%$ Resources:SharedResources, Type %>" CommandName="IssueType" CommandArgument="iv.[IssueTypeName]" OnClick="SortIssueClick"/>
                                    </td>
                                    <td runat="server" id="tdPriority" class="gridHeader" style="text-align: center;">
                                        <asp:LinkButton ID="LinkButton8" runat="server" Text="<%$ Resources:SharedResources, Priority %>" CommandName="Priority" CommandArgument="iv.[PriorityName]" OnClick="SortIssueClick" />
                                    </td>
                                    <td runat="server" id="tdTitle" class="gridHeader">
                                        <asp:LinkButton ID="LinkButton3" runat="server" Text="<%$ Resources:SharedResources, Title %>" CommandName="Title" CommandArgument="iv.[IssueTitle]" OnClick="SortIssueClick" />
                                    </td>
                                    <td runat="server" id="tdAssigned" class="gridHeader">
                                        <asp:LinkButton ID="LinkButton4" runat="server" Text="<%$ Resources:SharedResources, AssignedTo %>" CommandName="Assigned" CommandArgument="iv.[AssignedDisplayName]" OnClick="SortIssueClick" />
                                    </td>
                                    <td runat="server" id="tdStatus" class="gridHeader" style="text-align: center;">
                                        <asp:LinkButton ID="LinkButton6" runat="server" Text="<%$ Resources:SharedResources, Status %>" CommandName="Status" CommandArgument="iv.[StatusName]" OnClick="SortIssueClick" />
                                    </td>
                                    <td runat="server" id="tdResolution" class="gridHeader" style="text-align: center;">
                                        <asp:LinkButton ID="LinkButton10" runat="server" Text="<%$ Resources:SharedResources, Resolution %>" CommandName="Resolution" CommandArgument="iv.[ResolutionName]" OnClick="SortIssueClick" />
                                    </td>
                                </tr>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr id="Row" runat="server">
                                <td>
                                    <a href='../Issues/IssueDetail.aspx?id=<%#DataBinder.Eval(Container.DataItem, "Id") %>'>
                                        <%#DataBinder.Eval(Container.DataItem, "FullId") %></a>
                                </td>
                                <td>
                                    <asp:Label ID="lblComponent" Text='<%# DataBinder.Eval(Container.DataItem, "CategoryName" )%>'
                                        runat="Server"></asp:Label>
                                </td>
                                <td style="text-align: center;">
                                    <it:TextImage ID="ctlType" ImageDirectory="/IssueType" Text='<%# DataBinder.Eval(Container.DataItem, "IssueTypeName" )%>'
                                        ImageUrl='<%# DataBinder.Eval(Container.DataItem, "IssueTypeImageUrl" )%>' runat="server" />
                                </td>
                                <td style="text-align: center;">
                                    <it:TextImage ID="ctlPriority" ImageDirectory="/Priority" Text='<%# DataBinder.Eval(Container.DataItem, "PriorityName" )%>'
                                        ImageUrl='<%# DataBinder.Eval(Container.DataItem, "PriorityImageUrl" )%>' runat="server" />
                                </td>
                                <td>
                                    <a href='../Issues/IssueDetail.aspx?id=<%#DataBinder.Eval(Container.DataItem, "Id") %>'>
                                        <asp:Label ID="lblSummary" Text='<%# DataBinder.Eval(Container.DataItem, "Title" )%>'
                                            runat="Server"></asp:Label></a>
                                </td>
                                <td>
                                    <asp:Label ID="lblAssignedTo" Text='<%# DataBinder.Eval(Container.DataItem, "AssignedDisplayName" )%>'
                                        runat="Server"></asp:Label>
                                </td>
                                <td style="text-align: center;">
                                    <it:TextImage ID="ctlStatus" ImageDirectory="/Status" Text='<%# DataBinder.Eval(Container.DataItem, "StatusName" )%>'
                                        ImageUrl='<%# DataBinder.Eval(Container.DataItem, "StatusImageUrl" )%>' runat="server" />
                                </td>
                                 <td style="text-align: center;">
                                    <it:TextImage ID="ctlResolution" ImageDirectory="/Resolution" Text='<%# DataBinder.Eval(Container.DataItem, "ResolutionName" )%>'
                                        ImageUrl='<%# DataBinder.Eval(Container.DataItem, "ResolutionImageUrl" )%>' runat="server" />
                                </td>
                            </tr>
                        </ItemTemplate>
                        <AlternatingItemTemplate>
                            <tr class="gridAltRow" id="AlternateRow" runat="server">
                                <td>
                                    <a href='../Issues/IssueDetail.aspx?id=<%#DataBinder.Eval(Container.DataItem, "Id") %>'>
                                        <%#DataBinder.Eval(Container.DataItem, "FullId") %></a>
                                </td>
                                <td>
                                    <asp:Label ID="lblComponent" Text='<%# DataBinder.Eval(Container.DataItem, "CategoryName" )%>'
                                        runat="Server"></asp:Label>
                                </td>
                                <td style="text-align: center;">
                                    <it:TextImage ID="ctlType" ImageDirectory="/IssueType" Text='<%# DataBinder.Eval(Container.DataItem, "IssueTypeName" )%>'
                                        ImageUrl='<%# DataBinder.Eval(Container.DataItem, "IssueTypeImageUrl" )%>' runat="server" />
                                </td>
                                <td style="text-align: center;">
                                    <it:TextImage ID="ctlPriority" ImageDirectory="/Priority" Text='<%# DataBinder.Eval(Container.DataItem, "PriorityName" )%>'
                                        ImageUrl='<%# DataBinder.Eval(Container.DataItem, "PriorityImageUrl" )%>' runat="server" />
                                </td>
                                <td>
                                    <a href='../Issues/IssueDetail.aspx?id=<%#DataBinder.Eval(Container.DataItem, "Id") %>'>
                                        <asp:Label ID="lblSummary" Text='<%# DataBinder.Eval(Container.DataItem, "Title" )%>'
                                            runat="Server"></asp:Label></a>
                                </td>
                                <td>
                                    <asp:Label ID="lblAssignedTo" Text='<%# DataBinder.Eval(Container.DataItem, "AssignedDisplayName" )%>'
                                        runat="Server"></asp:Label>
                                </td>
                                <td style="text-align: center;">
                                    <it:TextImage ID="ctlStatus" ImageDirectory="/Status" Text='<%# DataBinder.Eval(Container.DataItem, "StatusName" )%>'
                                        ImageUrl='<%# DataBinder.Eval(Container.DataItem, "StatusImageUrl" )%>' runat="server" />
                                </td>
                                 <td style="text-align: center;">
                                    <it:TextImage ID="ctlResolution" ImageDirectory="/Resolution" Text='<%# DataBinder.Eval(Container.DataItem, "ResolutionName" )%>'
                                        ImageUrl='<%# DataBinder.Eval(Container.DataItem, "ResolutionImageUrl" )%>' runat="server" />
                                </td>
                            </tr>
                        </AlternatingItemTemplate>
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
