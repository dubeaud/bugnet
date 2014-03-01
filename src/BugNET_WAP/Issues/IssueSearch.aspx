<%@ Page Language="c#" Inherits="BugNET.Issues.SearchResults" MasterPageFile="~/Site.master" Title="<%$ Resources:SharedResources, Search %>"
    CodeBehind="IssueSearch.aspx.cs" Async="true" %>

<%@ Register TagPrefix="it" TagName="TextImage" Src="~/UserControls/TextImage.ascx" %>

<asp:Content runat="server" ID="Content1" ContentPlaceHolderID="MainContent">
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
    <div class="page-header">
        <h1>
            <asp:Localize runat="server" ID="Localize2" Text="<%$ Resources:SharedResources, Search %>" /></h1>
    </div>
    <p style="margin-top: 1em;">
        <asp:Localize runat="server" ID="Localize1" meta:resourcekey="SearchMessage" />
    </p>
    <div class="form-horizontal">
    <div class="input-group input-group-lg">
      <asp:TextBox ID="txtSearch" placeholder="<%$ Resources:SearchWatermark %>" CssClass="form-control" runat="server"></asp:TextBox>
      <span class="input-group-btn">
        <asp:Button ID="btnGlobalSearch" runat="server" CssClass="btn btn-success btn-lg" OnClick="Button1_Click" Text="Search" meta:resourcekey="SearchButton" />
      </span>
    </div><!-- /input-group -->
        </div>


    <asp:Panel ID="pnlOptions" runat="server">
        <div class="checkbox">
            <asp:CheckBox ID="chkSearchTitle" runat="server" Text="Search Title" meta:resourcekey="SearchTitle" Checked="true" />
        </div>
        <div class="checkbox">
            <asp:CheckBox ID="chkSearchDesc" runat="server" Text="Search Description" meta:resourcekey="SearchDescription" Checked="true" />
        </div>
        <div class="checkbox">
            <asp:CheckBox ID="chkComments" runat="server" Text="Search Comments (may be slow)" meta:resourcekey="SearchComments" />
        </div>
        <div class="checkbox">
            <asp:CheckBox ID="chkExcludeClosedIssues" Checked="True" runat="server" meta:resourcekey="ExcludeClosedIssues" />
        </div>
        <div style="display: none;">
            <asp:CheckBox ID="chkUsername" runat="server" Text="Include username fields" meta:resourcekey="IncludeUsernameFields" Visible="False" />&nbsp;|&nbsp;
            <asp:CheckBox ID="chkCommentUsername" runat="server" OnCheckedChanged="chkCommentUsername_CheckedChanged" Text="Search comment usernames" Visible="False" meta:resourcekey="SearchCommentUsernames" />&nbsp;|&nbsp;
            <asp:CheckBox ID="chkHistory" runat="server" OnCheckedChanged="chkHistory_CheckedChanged" Text="Search history records" Visible="False" meta:resourcekey="SearchHistoryRecords" />
        </div>
    </asp:Panel>
    <asp:Panel ID="pnlResultsMessage" runat="server" Visible="False">
        <div class="align-center text-large text-italic text-color-grey" style="padding: 15px;">
            <asp:Literal ID="litResultsMessage" runat="server" Text="" />
        </div>
    </asp:Panel>
    <asp:Panel ID="pnlSearchResults" runat="server">
        <div style="padding: 10px 0 0 10px;">
            <asp:Label ID="lblSearchSummary" Text="Please Search..." ForeColor="Red" Font-Italic="true" runat="server" />
        </div>
        <asp:Repeater runat="server" ID="SearchProjectRepeater" OnItemDataBound="SearchProjectRepeater_ItemDataBound">
            <HeaderTemplate>
                <ul class="list-unstyled">
            </HeaderTemplate>
            <ItemTemplate>
                <li id='Project-<%#DataBinder.Eval(Container.DataItem, "Id") %>'>
                    <div class="milestone-group-header">
                        <div class="pull-right">
                            <asp:HyperLink ID="IssuesCount" runat="server" />
                        </div>
                        <asp:HyperLink ID="ProjectLink" CssClass="milestoneName" runat="server" />
                        <asp:Label CssClass="milestoneNotes" ID="ProjectDescription" runat="Server"></asp:Label>
                        <br style="clear: both;" />
                        <span class="milestoneReleaseDate">
                            <asp:Label ID="lblReleaseDate" runat="Server"></asp:Label>
                    </div>
                    <div class="milestoneContent" style="display: none;">
                        <asp:Repeater ID="IssuesList" runat="server" OnItemDataBound="IssuesListRepeater_ItemDataBound">
                            <HeaderTemplate>
                                <table class="table table-hover">
                                    <tr>
                                        <th runat="server" id="tdId">
                                            <asp:LinkButton ID="LinkButton2" runat="server" Text="<%$ Resources:SharedResources, Id %>" />
                                        </th>
                                        <th runat="server" id="tdTitle">
                                            <asp:LinkButton ID="LinkButton3" runat="server" Text="<%$ Resources:SharedResources, Title %>" />
                                        </th>
                                        <th runat="server" id="tdCategory">
                                            <asp:LinkButton ID="lnkCategory" runat="server" Text="<%$ Resources:SharedResources, Category %>" />
                                        </th>
                                        <th runat="server" id="tdAssigned">
                                            <asp:LinkButton ID="LinkButton4" runat="server" Text="<%$ Resources:SharedResources, AssignedTo %>" />
                                        </th>
                                        <th runat="server" id="tdIssueType">
                                            <asp:LinkButton ID="LinkButton1" runat="server" Text="<%$ Resources:SharedResources, Type %>" />
                                        </th>
                                        <th runat="server" id="tdStatus">
                                            <asp:LinkButton ID="LinkButton6" runat="server" Text="<%$ Resources:SharedResources, Status %>" />
                                        </th>
                                        <th runat="server" id="tdPriority">
                                            <asp:LinkButton ID="LinkButton8" runat="server" Text="<%$ Resources:SharedResources, Priority %>" />
                                        </th>
                                    </tr>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr>
                                    <td>
                                        <a href='../Issues/IssueDetail.aspx?id=<%#DataBinder.Eval(Container.DataItem, "Id") %>'>
                                            <%#DataBinder.Eval(Container.DataItem, "FullId") %></a>
                                    </td>
                                    <td>
                                        <a href='../Issues/IssueDetail.aspx?id=<%#DataBinder.Eval(Container.DataItem, "Id") %>'>
                                            <asp:Label ID="lblSummary" Text='<%# Server.HtmlEncode(DataBinder.Eval(Container.DataItem, "Title" ).ToString())%>' runat="Server"></asp:Label>
                                        </a>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblComponent" Text='<%# DataBinder.Eval(Container.DataItem, "CategoryName" )%>' runat="Server"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblAssignedTo" Text='<%# DataBinder.Eval(Container.DataItem, "AssignedDisplayName" )%>' runat="Server"></asp:Label>
                                    </td>
                                    <td>
                                        <it:TextImage ID="ctlType" ImageDirectory="/IssueType" Text='<%# DataBinder.Eval(Container.DataItem, "IssueTypeName" )%>'
                                            ImageUrl='<%# DataBinder.Eval(Container.DataItem, "IssueTypeImageUrl" )%>' runat="server" />
                                    </td>
                                    <td>
                                        <it:TextImage ID="ctlStatus" ImageDirectory="/Status" Text='<%# DataBinder.Eval(Container.DataItem, "StatusName" )%>' ImageUrl='<%# DataBinder.Eval(Container.DataItem, "StatusImageUrl" )%>'
                                            runat="server" />
                                    </td>
                                    <td>
                                        <it:TextImage ID="ctlPriority" ImageDirectory="/Priority" Text='<%# DataBinder.Eval(Container.DataItem, "PriorityName" )%>'
                                            ImageUrl='<%# DataBinder.Eval(Container.DataItem, "PriorityImageUrl" )%>' runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="9">
                                        <asp:Panel ID="pnlIssueComments" runat="server">
                                            <p>
                                                <asp:Label ID="lblCommentCount" Text="0 comments found." runat="server" />
                                            </p>
                                            <asp:Repeater ID="IssuesCommentList" OnItemDataBound="IssuesCommentListRepeater_ItemDataBound" runat="server">
                                                <HeaderTemplate>
                                                    <table id="tabIssueComments" class="table table-hover table-striped">
                                                        <tr>
                                                            <th runat="server" id="tdCreator">
                                                                <asp:LinkButton ID="lnkCreator" runat="server" Text="<%$ Resources:SharedResources, Creator %>" />
                                                            </th>
                                                            <th runat="server" id="tdDateCreate">
                                                                <asp:LinkButton ID="lnkDateCreate" runat="server" Text="<%$ Resources:SharedResources, Date %>" />
                                                            </th>
                                                            <th runat="server" id="tdComment">
                                                                <asp:LinkButton ID="lnkComment" runat="server" Text="<%$ Resources:SharedResources, Comment %>" />
                                                            </th>
                                                        </tr>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="lblCreator" Text='<%# DataBinder.Eval(Container.DataItem, "CreatorDisplayName" )%>' runat="Server"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblDateCreated" Text='<%# DataBinder.Eval(Container.DataItem, "DateCreated" )%>' runat="Server"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblComment" Text='' runat="Server"></asp:Label>
                                                        </td>
                                                    </tr>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    </table>
                                                </FooterTemplate>
                                            </asp:Repeater>
                                        </asp:Panel>
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
    </asp:Panel>
</asp:Content>
