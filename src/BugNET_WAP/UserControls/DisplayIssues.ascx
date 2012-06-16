<%@ Control Language="c#" Inherits="BugNET.UserControls.DisplayIssues" CodeBehind="DisplayIssues.ascx.cs" %>
<%@ Register TagPrefix="it" TagName="TextImage" Src="~/UserControls/TextImage.ascx" %>
<%@ Register TagPrefix="it" TagName="PickCategory" Src="~/UserControls/PickCategory.ascx" %>
<%@ Register TagPrefix="it" TagName="PickMilestone" Src="~/UserControls/PickMilestone.ascx" %>
<%@ Register TagPrefix="it" TagName="PickType" Src="~/UserControls/PickType.ascx" %>
<%@ Register TagPrefix="it" TagName="PickStatus" Src="~/UserControls/PickStatus.ascx" %>
<%@ Register TagPrefix="it" TagName="PickPriority" Src="~/UserControls/PickPriority.ascx" %>
<%@ Register TagPrefix="it" TagName="PickSingleUser" Src="~/UserControls/PickSingleUser.ascx" %>
<%@ Register TagPrefix="it" TagName="PickResolution" Src="~/UserControls/PickResolution.ascx" %>
<%@ Register TagPrefix="it" TagName="DisplayCustomFields" Src="~/UserControls/DisplayCustomFields.ascx" %>
<%@ Register TagPrefix="bn" TagName="PickDate" Src="~/UserControls/PickDate.ascx" %>
<%@ Register Assembly="BugNET" Namespace="BugNET.UserInterfaceLayer.WebControls" TagPrefix="BNWC" %>

<script type="text/javascript">
    var tog = false;
    function checkAll() {
        $("#<%=gvIssues.ClientID%> :checkbox").attr('checked', !tog);
        tog = !tog;
    }
    $(document).ready(function () {

        $('#editProperties').click(function () {
            $('#SetProperties').slideToggle('fast');
        });
        $('#showColumns').click(function () {
            $('#ChangeColumns').slideToggle('fast');
        });
    });
</script>

<table style="border-collapse: collapse; table-layout: fixed; width: 100%; border: none;">
    <tr>
        <td>
            <asp:Panel ID="OptionsContainerPanel" runat="server" CssClass="issueListOptionsContainer">
                <div style="height: 25px; background-color: #F1F2EC; width: 100%;">
                    <asp:Panel ID="LeftButtonContainerPanel" CssClass="leftButtonContainerPanel" runat="server">
                        For Selected:&nbsp; <span id="EditIssueProperties"><a href="#" id="editProperties">
                            <asp:Label ID="EditPropertiesLabel" meta:resourcekey="EditPropertiesLabel" Text="Test" runat="server"></asp:Label>
                        </a></span>
                    </asp:Panel>
                    <div id="rightButtonContainer">
                        <p id="AddRemoveColumns">
                            <a href="#" id="showColumns">
                                <asp:Label ID="Label12" meta:resourcekey="SelectColumnsLinkButton" runat="server"></asp:Label></a>
                        </p>
                        <p id="ExportExcel">
                            <asp:LinkButton ID="ExportExcelButton" runat="server" OnClick="ExportExcelButton_Click">Export</asp:LinkButton>
                        </p>
                        <p id="Rss">
                            <asp:HyperLink ID="lnkRSS" runat="server">RSS</asp:HyperLink>
                        </p>
                    </div>
                </div>
                <div id="SetProperties" style="display: none;">
                    <div style="margin: 0px 10px 10px 10px; padding: 10px 0 5px 0; border-bottom: 1px dotted #cccccc;">
                        <asp:Label ID="Label10" runat="server" meta:resourcekey="SetPropertiesLabel"></asp:Label></div>
                    <div style="margin-left: 10px; margin-right: 10px; padding-bottom: 10px;">
                        <table width="100%" style="color: #55555F;">
                            <tr>
                                <td style="width: 15%;">
                                    <asp:Label ID="Label1" runat="server" AssociatedControlID="dropCategory:ddlComps" Text="<%$ Resources:SharedResources, Category %>"></asp:Label>:
                                </td>
                                <td style="width: 35%;">
                                    <it:PickCategory ID="dropCategory" DisplayDefault="true" Required="false" runat="server" />
                                </td>
                                <td style="width: 15%;">
                                    <asp:Label ID="Label2" runat="server" AssociatedControlID="dropOwner:ddlUsers" Text="<%$ Resources:SharedResources, Owner %>"></asp:Label>:
                                </td>
                                <td style="width: 35%;">
                                    <it:PickSingleUser ID="dropOwner" DisplayDefault="true" Required="false" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label3" runat="server" AssociatedControlID="dropMilestone:ddlMilestone" Text="<%$ Resources:SharedResources, Milestone %>"></asp:Label>:
                                </td>
                                <td>
                                    <it:PickMilestone ID="dropMilestone" DisplayDefault="true" Required="false" runat="server" />
                                </td>
                                <td>
                                    <asp:Label ID="Label11" AssociatedControlID="dropAffectedMilestone:ddlMilestone" runat="server" Text="<%$ Resources:SharedResources, AffectedMilestone %>"></asp:Label>:
                                </td>
                                <td>
                                    <it:PickMilestone ID="dropAffectedMilestone" DisplayDefault="true" Required="false" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label4" runat="server" AssociatedControlID="dropType:ddlType" Text="<%$ Resources:SharedResources, Type %>"></asp:Label>:
                                </td>
                                <td>
                                    <it:PickType ID="dropType" DisplayDefault="true" Required="false" runat="server" />
                                </td>
                                <td>
                                    <asp:Label ID="Label5" runat="server" AssociatedControlID="dropResolution:ddlResolution" Text="<%$ Resources:SharedResources, Resolution %>" />:
                                </td>
                                <td>
                                    <it:PickResolution ID="dropResolution" DisplayDefault="true" Required="false" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label6" runat="server" AssociatedControlID="dropPriority:ddlPriority" Text="<%$ Resources:SharedResources, Priority %>" />:
                                </td>
                                <td>
                                    <it:PickPriority ID="dropPriority" DisplayDefault="true" Required="false" runat="server" />
                                </td>
                                <td>
                                    <asp:Label ID="Label7" runat="server" AssociatedControlID="dropStatus:dropStatus" Text="<%$ Resources:SharedResources, Status %>" />:
                                </td>
                                <td>
                                    <it:PickStatus ID="dropStatus" DisplayDefault="true" Required="false" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label8" runat="server" AssociatedControlID="dropAssigned:ddlUsers" Text="<%$ Resources:SharedResources, Assigned %>" />:
                                </td>
                                <td>
                                    <it:PickSingleUser ID="dropAssigned" DisplayDefault="true" Required="false" runat="server" />
                                </td>
                                <td>
                                    <asp:Label ID="Label9" runat="server" AssociatedControlID="DueDate:DateTextBox" Text="<%$ Resources:SharedResources, DueDate %>" />:
                                </td>
                                <td>
                                    <bn:PickDate ID="DueDate" runat="server" />
                                </td>
                            </tr>
                        </table>
                        <it:DisplayCustomFields ID="ctlCustomFields" runat="server" />
                        <br />
                        <asp:Button ID="SaveIssues" runat="server" OnClick="SaveIssues_Click" Text="<%$ Resources:SharedResources, Save %>" />
                        <input type="button" id="CancelEditProperties" onclick="$('#SetProperties').toggle();" runat="server" value="<%$ Resources:SharedResources, Cancel%>" />
                    </div>
                </div>
                <asp:Panel ID="SelectColumnsPanel" Visible="False" runat="Server">
                    <div id="ChangeColumns" style="display: none; width: 100%; background-color: #FFFAF6; margin-bottom: 10px;">
                        <div style="margin: 0px 10px 10px 10px; padding: 10px 0 5px 0; border-bottom: 1px dotted #cccccc;">
                            <asp:Literal ID="Literal3" runat="server" meta:resourcekey="SelectColumnsLiteral"></asp:Literal></div>
                        <div style="margin-left: 10px; margin-right: 10px; padding-bottom: 10px;">
                            <asp:CheckBoxList ID="lstIssueColumns" Width="100%" RepeatColumns="7" CellPadding="0" CellSpacing="0" runat="server" RepeatDirection="Horizontal">
                                <asp:ListItem Text="<%$ Resources:SharedResources, Project %>" Value="4" />
                                <asp:ListItem Text="<%$ Resources:SharedResources, Votes %>" Value="5" />
                                <asp:ListItem Text="<%$ Resources:SharedResources, Category %>" Value="6" />
                                <asp:ListItem Text="<%$ Resources:SharedResources, Creator %>" Value="7" />
                                <asp:ListItem Text="<%$ Resources:SharedResources, Owner %>" Value="8" />
                                <asp:ListItem Text="<%$ Resources:SharedResources, Assigned %>" Value="9" />
                                <asp:ListItem Text="<%$ Resources:SharedResources, Type %>" Value="10" />
                                <asp:ListItem Text="<%$ Resources:SharedResources, Milestone %>" Value="11" />
                                <asp:ListItem Text="<%$ Resources:SharedResources, AffectedMilestone %>" Value="12" />
                                <asp:ListItem Text="<%$ Resources:SharedResources, Status %>" Value="13" />
                                <asp:ListItem Text="<%$ Resources:SharedResources, Priority %>" Value="14" />
                                <asp:ListItem Text="<%$ Resources:SharedResources, Resolution %>" Value="15" />
                                <asp:ListItem Text="<%$ Resources:SharedResources, DueDate %>" Value="16" />
                                <asp:ListItem Text="<%$ Resources:SharedResources, Estimation %>" Value="17" />
                                <asp:ListItem Text="<%$ Resources:SharedResources, Progress %>" Value="18" />
                                <asp:ListItem Text="<%$ Resources:SharedResources, TimeLogged %>" Value="19" />
                                <asp:ListItem Text="<%$ Resources:SharedResources, Created %>" Value="20" />
                                <asp:ListItem Text="<%$ Resources:SharedResources, LastUpdate %>" Value="21" />
                                <asp:ListItem Text="<%$ Resources:SharedResources, LastUpdateUser %>" Value="22" />
                            </asp:CheckBoxList>
                            <br />
                            <asp:Button ID="SaveButton" runat="server" Text="<%$ Resources:SharedResources, Save %>" OnClick="SaveClick"></asp:Button>&nbsp;&nbsp;
                            <input type="button" id="Button1" onclick="$('#ChangeColumns').toggle();" runat="server" value="<%$ Resources:SharedResources, Cancel%>" />
                        </div>
                    </div>
                </asp:Panel>
            </asp:Panel>
            <asp:Panel ID="ScrollPanel" runat="server" ScrollBars="Horizontal" Width="100%">
                <BNWC:GridView ID="gvIssues" ClientIDMode="Predictable" SkinID="GridView" AllowPaging="True" AllowSorting="True" BorderWidth="1px"
                    BorderStyle="Solid" GridLines="None" DataKeyNames="Id" UseAccessibleHeader="true" EnableMultiColumnSorting="True" ShowSortSequence="True"
                    PagerStyle-HorizontalAlign="right" SortAscImageUrl="~/images/bullet_arrow_up.png" SortDescImageUrl="~/images/bullet_arrow_down.png"
                    OnRowDataBound="gvIssues_RowDataBound" OnSorting="gvIssues_Sorting" Width="100%" OnPageIndexChanging="gvIssues_PageIndexChanging"
                    runat="server" ondatabinding="gvIssues_DataBinding">
                    <Columns>
                        <asp:TemplateField>
                            <ItemStyle HorizontalAlign="center" />
                            <HeaderStyle HorizontalAlign="center" />
                            <HeaderTemplate>
                                <asp:Image ID="CheckAllImage" ImageUrl="~/Images/tick.gif" onclick="checkAll();" runat="server" />
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:CheckBox ID="cbSelectAll" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemStyle HorizontalAlign="center" />
                            <HeaderStyle HorizontalAlign="center" />
                            <ItemTemplate>
                                <asp:Image runat="server" ID="imgPrivate" meta:resourcekey="imgPrivate" AlternateText="Private" ImageUrl="~/images/lock.gif">
                                </asp:Image>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="FullId" HeaderText="<%$ Resources:SharedResources, Id %>" ItemStyle-Wrap="false" SortExpression="iv.[IssueId]">
                            <ItemStyle Wrap="False"></ItemStyle>
                        </asp:BoundField>
                        <asp:HyperLinkField HeaderStyle-HorizontalAlign="Left" HeaderText="<%$ Resources:SharedResources, Title %>" SortExpression="IssueTitle"
                            DataNavigateUrlFormatString="~/Issues/IssueDetail.aspx?id={0}" DataNavigateUrlFields="Id" DataTextField="Title">
                            <ControlStyle Width="250" />
                        </asp:HyperLinkField>
                        <asp:BoundField DataField="ProjectName" HeaderText="<%$ Resources:SharedResources, Project %>" SortExpression="ProjectName"
                            ItemStyle-Wrap="false" Visible="false">
                            <ItemStyle Wrap="False"></ItemStyle>
                        </asp:BoundField>
                        <asp:TemplateField HeaderText="<%$ Resources:SharedResources, Votes %>" Visible="false" SortExpression="IssueVotes">
                            <ItemTemplate>
                                <%# DataBinder.Eval(Container.DataItem, "Votes")%>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="<%$ Resources:SharedResources, Category %>" Visible="false" SortExpression="CategoryName">
                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                            <ItemTemplate>
                                <%# DataBinder.Eval(Container.DataItem, "CategoryName")%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="<%$ Resources:SharedResources, Creator %>" Visible="false" SortExpression="CreatorDisplayName">
                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                            <ItemTemplate>
                                <%# DataBinder.Eval(Container.DataItem, "CreatorDisplayName")%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="<%$ Resources:SharedResources, Owner %>" Visible="false" SortExpression="OwnerDisplayName">
                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                            <ItemTemplate>
                                <%# DataBinder.Eval(Container.DataItem, "OwnerDisplayName")%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="<%$ Resources:SharedResources, Assigned %>" Visible="false" SortExpression="AssignedDisplayName">
                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                            <ItemTemplate>
                                <%# DataBinder.Eval(Container.DataItem, "AssignedDisplayName" )%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="<%$ Resources:SharedResources, Type %>" Visible="false" SortExpression="IssueTypeName">
                            <ItemStyle HorizontalAlign="center" />
                            <HeaderStyle HorizontalAlign="center" />
                            <ItemTemplate>
                                <it:TextImage ID="ctlType" ImageDirectory="/IssueType" Text='<%# DataBinder.Eval(Container.DataItem, "IssueTypeName" )%>'
                                    ImageUrl='<%# DataBinder.Eval(Container.DataItem, "IssueTypeImageUrl" )%>' runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="<%$ Resources:SharedResources, Milestone %>" Visible="false" SortExpression="MilestoneName">
                            <ItemStyle HorizontalAlign="center" />
                            <HeaderStyle HorizontalAlign="center" />
                            <ItemTemplate>
                                <it:TextImage ID="ctlMilestone" ImageDirectory="/Milestone" Text='<%# DataBinder.Eval(Container.DataItem, "MilestoneName" )%>'
                                    ImageUrl='<%# DataBinder.Eval(Container.DataItem, "MilestoneImageUrl" )%>' runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="<%$ Resources:SharedResources, AffectedMilestone %>" Visible="false" SortExpression="AffectedMilestoneName">
                            <ItemStyle HorizontalAlign="center" />
                            <HeaderStyle HorizontalAlign="center" />
                            <ItemTemplate>
                                <it:TextImage ID="ctlAffectedMilestone" ImageDirectory="/Milestone" Text='<%# DataBinder.Eval(Container.DataItem, "AffectedMilestoneName" )%>'
                                    ImageUrl='<%# DataBinder.Eval(Container.DataItem, "AffectedMilestoneImageUrl" )%>' runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="<%$ Resources:SharedResources, Status %>" Visible="false" SortExpression="StatusName">
                            <ItemStyle HorizontalAlign="center" />
                            <HeaderStyle HorizontalAlign="center" />
                            <ItemTemplate>
                                <it:TextImage ID="ctlStatus" ImageDirectory="/Status" Text='<%# DataBinder.Eval(Container.DataItem, "StatusName" )%>' ImageUrl='<%# DataBinder.Eval(Container.DataItem, "StatusImageUrl" )%>'
                                    runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="<%$ Resources:SharedResources, Priority %>" Visible="false" SortExpression="PriorityName">
                            <ItemStyle HorizontalAlign="center" />
                            <HeaderStyle HorizontalAlign="center" />
                            <ItemTemplate>
                                <it:TextImage ID="ctlPriority" ImageDirectory="/Priority" Text='<%# DataBinder.Eval(Container.DataItem, "PriorityName" )%>'
                                    ImageUrl='<%# DataBinder.Eval(Container.DataItem, "PriorityImageUrl" )%>' runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="<%$ Resources:SharedResources, Resolution %>" Visible="false" SortExpression="ResolutionName">
                            <ItemStyle HorizontalAlign="center" />
                            <HeaderStyle HorizontalAlign="center" />
                            <ItemTemplate>
                                <it:TextImage ID="ctlResolution" ImageDirectory="/Resolution" Text='<%# DataBinder.Eval(Container.DataItem, "ResolutionName" )%>'
                                    ImageUrl='<%# DataBinder.Eval(Container.DataItem, "ResolutionImageUrl" )%>' runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="<%$ Resources:SharedResources, DueDate%>" Visible="false" SortExpression="IssueDueDate">
                            <ItemTemplate>
                                <%#(DateTime)Eval("DueDate") == DateTime.MinValue ? "none" : Eval("DueDate", "{0:d}") %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="<%$ Resources:SharedResources, EstimationHours %>" Visible="false" SortExpression="IssueEstimation">
                            <ItemTemplate>
                                <%# DataBinder.Eval(Container.DataItem, "Estimation")%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="<%$ Resources:SharedResources, Progress %>" Visible="false" SortExpression="IssueProgress">
                            <ItemStyle HorizontalAlign="center" />
                            <HeaderStyle HorizontalAlign="center" />
                            <ItemTemplate>
                                <div id="Progress" runat="server" style="vertical-align: top; font-size: 8px; border: 1px solid #ccc; width: 100px; height: 7px;
                                    margin: 5px; text-align: center;">
                                    <div id="ProgressBar" runat='server' style="text-align: left; background-color: #C4EFA1; height: 7px;">
                                        &nbsp;</div>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="<%$ Resources:SharedResources, TimeLoggedHours %>" Visible="false" SortExpression="TimeLogged">
                            <ItemTemplate>
                                <%# DataBinder.Eval(Container.DataItem, "TimeLogged")%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="<%$ Resources:SharedResources, Created %>" SortExpression="DateCreated">
                            <ItemTemplate>
                                <%# DataBinder.Eval(Container.DataItem, "DateCreated", "{0:d}")%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="<%$ Resources:SharedResources, LastUpdate %>" SortExpression="LastUpdate">
                            <ItemTemplate>
                                <%# DataBinder.Eval(Container.DataItem, "LastUpdate", "{0:d}")%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="<%$ Resources:SharedResources, LastUpdateUser %>" SortExpression="LastUpdateDisplayName">
                            <ItemTemplate>
                                <%# DataBinder.Eval(Container.DataItem, "LastUpdateDisplayName")%>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </BNWC:GridView>
            </asp:Panel>
            <div class="pager">
                <asp:DataPager ID="pager" runat="server" PageSize="10" PagedControlID="gvIssues">
                    <Fields>
                        <BNWC:BugNetPagerField NextPageImageUrl="~/App_Themes/Default/Images/resultset_next.gif" PreviousPageImageUrl="~/App_Themes/Default/Images/resultset_previous.gif"
                            LastPageImageUrl="~/App_Themes/Default/Images/resultset_last.gif" FirstPageImageUrl="~/App_Themes/Default/Images/resultset_first.gif" />
                    </Fields>
                </asp:DataPager>
            </div>
        </td>
    </tr>
</table>
<div style="width: 100%; padding-top: 10px">
    <asp:Label ID="lblResults" ForeColor="Red" Font-Italic="True" runat="server" Text="<%$ Resources:SharedResources, NoIssueResults %>" />
</div>
