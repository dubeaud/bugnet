<%@ Page Language="c#" Inherits="BugNET.Issues.SearchResults" MasterPageFile="~/Shared/SingleColumn.master" Title="<%$ Resources:SharedResources, Search %>"
    CodeBehind="IssueSearch.aspx.cs" %>

<%@ Register Src="~/UserControls/DisplayIssues.ascx" TagName="DisplayIssues" TagPrefix="uc1" %>
<%@ Register TagPrefix="it" TagName="TextImage" Src="~/UserControls/TextImage.ascx" %>
<asp:Content runat="server" ID="Content1" ContentPlaceHolderID="Content">

    <script type="text/javascript">
        $(document).ready(function () {
            // Todo: BGN-1829 Change the css class names etc below 
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

    <h1>
        <asp:Localize runat="server" ID="Localize2" Text="<%$ Resources:SharedResources, Search %>" /></h1>
    <p style="margin-top: 1em;">
        <asp:Localize runat="server" ID="Localize1" meta:resourcekey="SearchMessage" />
    </p>
    <br />
    <asp:TextBox ID="txtSearch" runat="server"></asp:TextBox>&nbsp;
    <asp:Button ID="btnGlobalSearch" runat="server" OnClick="Button1_Click" Text="Search" />
    <ajaxToolkit:TextBoxWatermarkExtender ID="TBWE2" runat="server" TargetControlID="txtSearch" WatermarkText="<%$ Resources:SearchWatermark %>"
        WatermarkCssClass="watermarked" />
    &nbsp;<asp:HyperLink ID="srchOptions" runat="server" Visible="False" meta:resourcekey="SearchOptions">Options...</asp:HyperLink>
    <br />
    <br />
    <asp:Panel ID="pnlOptions" runat="server">
        <div>
            <asp:CheckBox ID="chkSearchTitle" runat="server" Text="Search Title" meta:resourcekey="SearchTitle" Checked="true" /> 
            <asp:CheckBox ID="chkSearchDesc" runat="server" Text="Search Description" meta:resourcekey="SearchDescription" Checked="true" />
            <asp:CheckBox ID="chkComments" runat="server" Text="Search Comments (may be slow)" meta:resourcekey="SearchComments" />      
        </div>
        <div><asp:CheckBox ID="chkExcludeClosedIssues" Checked="True" runat="server" meta:resourcekey="ExcludeClosedIssues" /> </div>
        <div class="display-none">
            <asp:CheckBox ID="chkUsername" runat="server" Text="Include username fields" meta:resourcekey="IncludeUsernameFields" Visible="False" />&nbsp;|&nbsp;
            <asp:CheckBox ID="chkCommentUsername" runat="server" OnCheckedChanged="chkCommentUsername_CheckedChanged" Text="Search comment usernames" Visible="False" meta:resourcekey="SearchCommentUsernames" />&nbsp;|&nbsp;
            <asp:CheckBox ID="chkHistory" runat="server" OnCheckedChanged="chkHistory_CheckedChanged" Text="Search history records" Visible="False" meta:resourcekey="SearchHistoryRecords" />            
        </div>
    </asp:Panel>
    <asp:Panel ID="pnlResultsMessage" runat="server" Visible="False">
        <div class="align-center text-large text-italic text-color-grey" style="padding: 15px;">
            <asp:Literal ID="litResultsMessage" runat="server" Text="Please enter the text you wish to search for and check the search options above to filter for the issues you wish to find."/>
        </div>
    </asp:Panel>
    <asp:Panel ID="pnlSearchResults" runat="server">
        <div style="padding: 10px 0 0 10px;"><asp:Label ID="lblSearchSummary" Text="Please Search..." ForeColor="Red" Font-Italic="true" runat="server" /></div>
        <asp:Repeater runat="server" ID="SearchProjectRepeater" OnItemDataBound="SearchProjectRepeater_ItemDataBound">
            <HeaderTemplate>
                <ul class="milestoneList">
            </HeaderTemplate>
            <ItemTemplate>
                <li id='Project-<%#DataBinder.Eval(Container.DataItem, "Id") %>'>
                    <div class="milestoneGroupHeader">
                        <div class="issueCount">
                            <asp:HyperLink ID="IssuesCount" runat="server" />
                        </div>
                        <asp:HyperLink ID="ProjectLink" CssClass="milestoneName" runat="server" />
                        <asp:Label CssClass="milestoneNotes" ID="ProjectDescription" runat="Server"></asp:Label>
                        <br style="clear: both;" />
                        <span class="milestoneReleaseDate"><asp:Label ID="lblReleaseDate" runat="Server"></asp:Label>
                    </div>
                    <div class="milestoneContent" style="display: none;">
                        <asp:Repeater ID="IssuesList" runat="server" OnItemDataBound="IssuesListRepeater_ItemDataBound">
                            <HeaderTemplate>
                                <table class="grid">
                                    <tr>
                                        <td runat="server" id="tdId" class="gridHeader">
                                            <asp:LinkButton ID="LinkButton2" runat="server" Text="<%$ Resources:SharedResources, Id %>" />
                                        </td>
                                        <td runat="server" id="tdTitle" class="gridHeader">
                                            <asp:LinkButton ID="LinkButton3" runat="server" Text="<%$ Resources:SharedResources, Title %>" />
                                        </td>
                                        <td runat="server" id="tdCategory" class="gridHeader">
                                            <asp:LinkButton ID="lnkCategory" runat="server" Text="<%$ Resources:SharedResources, Category %>" />
                                        </td>
                                        <td runat="server" id="tdAssigned" class="gridHeader">
                                            <asp:LinkButton ID="LinkButton4" runat="server" Text="<%$ Resources:SharedResources, AssignedTo %>" />
                                        </td>
                                        <td runat="server" id="tdIssueType" class="gridHeader align-center">
                                            <asp:LinkButton ID="LinkButton1" runat="server" Text="<%$ Resources:SharedResources, Type %>" />
                                        </td>
                                        <td runat="server" id="tdStatus" class="gridHeader align-center">
                                            <asp:LinkButton ID="LinkButton6" runat="server" Text="<%$ Resources:SharedResources, Status %>" />
                                        </td>
                                        <td runat="server" id="tdPriority" class="gridHeader align-center">
                                            <asp:LinkButton ID="LinkButton8" runat="server" Text="<%$ Resources:SharedResources, Priority %>" />
                                        </td>
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
                                </tr>
                                <tr>
                                    <td colspan="9">
                                        <asp:Panel ID="pnlIssueComments" runat="server">
                                            <table class="subgrid">
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lblCommentCount" Text="0 comments found." runat="server" />
                                                    </td>
                                                </tr>
                                            </table>
                                            <asp:Repeater ID="IssuesCommentList" OnItemDataBound="IssuesCommentListRepeater_ItemDataBound" runat="server">
                                                <HeaderTemplate>
                                                    <table id="tabIssueComments" class="subgrid">
                                                        <tr>
                                                            <td runat="server" id="tdCreator" class="subgridHeader align-left" width="250px">
                                                                <asp:LinkButton ID="lnkCreator" runat="server" Text="<%$ Resources:SharedResources, Creator %>" />
                                                            </td>
                                                            <td runat="server" id="tdDateCreate" class="subgridHeader align-left" width="150px">
                                                                <asp:LinkButton ID="lnkDateCreate" runat="server" Text="<%$ Resources:SharedResources, Date %>" />
                                                            </td>
                                                            <td runat="server" id="tdComment" class="subgridHeader align-left">
                                                                <asp:LinkButton ID="lnkComment" runat="server" Text="<%$ Resources:SharedResources, Comment %>" />
                                                            </td>
                                                        </tr>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <tr>
                                                        <td class="align-left" width="250px">
                                                            <asp:Label ID="lblCreator" Text='<%# DataBinder.Eval(Container.DataItem, "CreatorDisplayName" )%>' runat="Server"></asp:Label>
                                                        </td>
                                                        <td class="align-left" width="150px">
                                                            <asp:Label ID="lblDateCreated" Text='<%# DataBinder.Eval(Container.DataItem, "DateCreated" )%>' runat="Server"></asp:Label>
                                                        </td>
                                                        <td class="align-left">
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
