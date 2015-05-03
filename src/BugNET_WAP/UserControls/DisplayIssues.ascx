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
<%@ Register TagPrefix="it" TagName="PickDate" Src="~/UserControls/PickDate.ascx" %>
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
<asp:Panel ID="OptionsContainerPanel" runat="server" CssClass="issueListOptionsContainer">
    <div>
        <div id="rightButtonContainer" class="pull-right">
            <a href="#" id="showColumns" class="btn btn-primary">
                <i class="fa fa-columns"></i>
                <asp:Label ID="Label12" meta:resourcekey="SelectColumnsLinkButton" runat="server"></asp:Label>
            </a>
            <button class="btn btn-primary" runat="server" causesvalidation="false" onserverclick="ExportExcelButton_Click">
                <i class="fa fa-download"></i>
                <asp:Literal runat="server" Text="<%$ Resources:ExportExcelButton.Text%>" />
            </button>
            <asp:HyperLink ID="lnkRSS" runat="server" CssClass="btn btn-primary"><i class="fa fa-rss"></i> RSS</asp:HyperLink>
        </div>
        <asp:Panel ID="LeftButtonContainerPanel" CssClass="leftButtonContainerPanel" runat="server">
            <asp:Label ID="ForSelectedLabel" runat="server" Text="For Selected" meta:resourceKey="ForSelectedLabel" />&nbsp;<span id="EditIssueProperties"><a href="#" id="editProperties">
                <asp:Label ID="EditPropertiesLabel" meta:resourcekey="EditPropertiesLabel" Text="Test" runat="server"></asp:Label>
            </a></span>
        </asp:Panel>
    </div>
    <div id="SetProperties" style="display: none;">
        <h4>
            <asp:Label ID="Label10" runat="server" meta:resourcekey="SetPropertiesLabel"></asp:Label></h4>
        <div class="form-horizontal">
            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <asp:Label ID="Label1" runat="server" CssClass="control-label col-md-4" AssociatedControlID="dropCategory:ddlComps" Text="<%$ Resources:SharedResources, Category %>"></asp:Label>
                        <div class="col-md-8">
                            <it:PickCategory ID="dropCategory" DisplayDefault="true" Required="false" runat="server" />
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <asp:Label ID="Label2" runat="server" AssociatedControlID="dropOwner:ddlUsers" CssClass="control-label col-md-4" Text="<%$ Resources:SharedResources, Owner %>"></asp:Label>
                        <div class="col-md-8">
                            <it:PickSingleUser ID="dropOwner" DisplayDefault="true" Required="false" runat="server" />
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <asp:Label ID="Label3" runat="server" CssClass="col-md-4 control-label" AssociatedControlID="dropMilestone:ddlMilestone" Text="<%$ Resources:SharedResources, Milestone %>"></asp:Label>
                        <div class="col-md-8">
                            <it:PickMilestone ID="dropMilestone" DisplayDefault="true" Required="false" runat="server" />
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <asp:Label ID="Label11" AssociatedControlID="dropAffectedMilestone:ddlMilestone" CssClass="col-md-4 control-label" runat="server" Text="<%$ Resources:SharedResources, AffectedMilestone %>"></asp:Label>
                        <div class="col-md-8">
                            <it:PickMilestone ID="dropAffectedMilestone" DisplayDefault="true" Required="false" runat="server" />
                        </div>
                    </div>

                </div>
            </div>
            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <asp:Label ID="Label4" runat="server" CssClass="col-md-4 control-label" AssociatedControlID="dropType:ddlType" Text="<%$ Resources:SharedResources, Type %>"></asp:Label>
                        <div class="col-md-8">
                            <it:PickType ID="dropType" DisplayDefault="true" Required="false" runat="server" />
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <asp:Label ID="Label5" runat="server" CssClass="col-md-4 control-label" AssociatedControlID="dropResolution:ddlResolution" Text="<%$ Resources:SharedResources, Resolution %>" />
                        <div class="col-md-8">
                            <it:PickResolution ID="dropResolution" DisplayDefault="true" Required="false" runat="server" />
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <asp:Label ID="Label6" runat="server" CssClass="col-md-4 control-label" AssociatedControlID="dropPriority:ddlPriority" Text="<%$ Resources:SharedResources, Priority %>" />
                        <div class="col-md-8">
                            <it:PickPriority ID="dropPriority" DisplayDefault="true" Required="false" runat="server" />
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <asp:Label ID="Label7" runat="server" CssClass="col-md-4 control-label" AssociatedControlID="dropStatus:dropStatus" Text="<%$ Resources:SharedResources, Status %>" />
                        <div class="col-md-8">
                            <it:PickStatus ID="dropStatus" DisplayDefault="true" Required="false" runat="server" />
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <asp:Label ID="Label8" runat="server" CssClass="col-md-4 control-label" AssociatedControlID="dropAssigned:ddlUsers" Text="<%$ Resources:SharedResources, Assigned %>" />
                        <div class="col-md-8">
                            <it:PickSingleUser ID="dropAssigned" DisplayDefault="true" Required="false" runat="server" />
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <asp:Label ID="Label9" runat="server" CssClass="col-md-4 control-label" AssociatedControlID="DueDate:DateTextBox" Text="<%$ Resources:SharedResources, DueDate %>" />
                        <div class="col-md-8">
                            <it:PickDate ID="DueDate" runat="server" />
                            &nbsp;<asp:CheckBox ID="chkDueDateReset" runat="server" />&nbsp;<span><asp:Literal ID="litResetDueDate" meta:resourcekey="litResetDueDate" runat="server"></asp:Literal></span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <it:DisplayCustomFields ID="ctlCustomFields" runat="server" />
        <div>
            <asp:Button ID="SaveIssues" runat="server" CssClass="btn btn-primary" OnClick="SaveIssues_Click" Text="<%$ Resources:SharedResources, Save %>" />
            <input type="button" id="CancelEditProperties" class="btn btn-default" onclick="$('#SetProperties').toggle();" runat="server" value="<%$ Resources:SharedResources, Cancel%>" />
        </div>
    </div>

    <asp:Panel ID="SelectColumnsPanel" Visible="False" runat="Server">
        <div id="ChangeColumns" style="display: none;">
            <h4>
                <asp:Literal ID="Literal3" runat="server" meta:resourcekey="SelectColumnsLiteral"></asp:Literal></h4>
            <div>
                <asp:CheckBoxList ID="lstIssueColumns" Width="100%" CssClass="checkbox-list" RepeatColumns="7" CellPadding="0" CellSpacing="0" runat="server" RepeatDirection="Horizontal">
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
                <asp:Button ID="SaveButton" runat="server" Text="<%$ Resources:SharedResources, Save %>" CssClass="btn btn-primary" OnClick="SaveClick"></asp:Button>
                <input type="button" id="Button1" onclick="$('#ChangeColumns').toggle();" class="btn btn-default" runat="server" value="<%$ Resources:SharedResources, Cancel%>" />
            </div>
        </div>
    </asp:Panel>
</asp:Panel>

<asp:Panel ID="ScrollPanel" runat="server" ScrollBars="Horizontal" Width="100%">
    <BNWC:GridView
        ID="gvIssues"
        ClientIDMode="Predictable"
        CssClass="table table-hover"
        AllowPaging="True"
        AllowSorting="True"
        GridLines="None"
        DataKeyNames="Id"
        UseAccessibleHeader="true"
        EnableMultiColumnSorting="True"
        ShowSortSequence="True"
        PagerStyle-HorizontalAlign="right"
        SortAscImageUrl="~/images/bullet_arrow_up.png"
        SortDescImageUrl="~/images/bullet_arrow_down.png"
        OnRowDataBound="gvIssues_RowDataBound"
        OnSorting="gvIssues_Sorting"
        AutoGenerateColumns="false"
        OnPageIndexChanging="gvIssues_PageIndexChanging"
        runat="server">
        <Columns>
            <asp:TemplateField>
                <HeaderTemplate>
                    <asp:CheckBox ID="cbSelectAllHeader" runat="server" onclick="checkAll();" />
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:CheckBox ID="cbSelectAll" runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <ItemTemplate>
                    <span runat="server" id="PrivateIssue"><i class="fa fa-lock"></i><span class="sr-only">Private</span></span>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:HyperLinkField HeaderText="<%$ Resources:SharedResources, Id %>" SortExpression="iv.[IssueId]"
                DataNavigateUrlFormatString="~/Issues/IssueDetail.aspx?id={0}" DataNavigateUrlFields="Id" DataTextField="FullId">
                <HeaderStyle Wrap="False" />
                <ItemStyle Wrap="False" />
            </asp:HyperLinkField>
            <asp:HyperLinkField HeaderStyle-HorizontalAlign="Left" HeaderText="<%$ Resources:SharedResources, Title %>" SortExpression="IssueTitle"
                DataNavigateUrlFormatString="~/Issues/IssueDetail.aspx?id={0}" DataNavigateUrlFields="Id" DataTextField="Title">
                <ControlStyle Width="250" />
            </asp:HyperLinkField>
            <asp:TemplateField HeaderText="<%$ Resources:SharedResources, Project %>" Visible="false" SortExpression="ProjectName">
                <ItemTemplate>
                    <%# DataBinder.Eval(Container.DataItem, "ProjectName")%>
                </ItemTemplate>
                <HeaderStyle Wrap="False" />
                <ItemStyle Wrap="False" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="<%$ Resources:SharedResources, Votes %>" Visible="false" SortExpression="IssueVotes">
                <ItemTemplate>
                    <%# DataBinder.Eval(Container.DataItem, "Votes")%>
                </ItemTemplate>
                <HeaderStyle Wrap="False" />
                <ItemStyle Wrap="False" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="<%$ Resources:SharedResources, Category %>" Visible="false" SortExpression="CategoryName">
                <ItemTemplate>
                    <%# DataBinder.Eval(Container.DataItem, "CategoryName")%>
                </ItemTemplate>
                <HeaderStyle Wrap="False" />
                <ItemStyle Wrap="False" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="<%$ Resources:SharedResources, Creator %>" Visible="false" SortExpression="CreatorDisplayName">
                <ItemTemplate>
                    <%# DataBinder.Eval(Container.DataItem, "CreatorDisplayName")%>
                </ItemTemplate>
                <HeaderStyle Wrap="False" />
                <ItemStyle Wrap="False" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="<%$ Resources:SharedResources, Owner %>" Visible="false" SortExpression="OwnerDisplayName">
                <ItemTemplate>
                    <%# DataBinder.Eval(Container.DataItem, "OwnerDisplayName")%>
                </ItemTemplate>
                <HeaderStyle Wrap="False" />
                <ItemStyle Wrap="False" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="<%$ Resources:SharedResources, Assigned %>" Visible="false" SortExpression="AssignedDisplayName">
                <ItemTemplate>
                    <div id="AssignedUser" runat="server">
                        <%# DataBinder.Eval(Container.DataItem, "AssignedDisplayName" )%>
                    </div>
                </ItemTemplate>
                <HeaderStyle Wrap="False" />
                <ItemStyle Wrap="False" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="<%$ Resources:SharedResources, Type %>" Visible="false" SortExpression="IssueTypeSortOrder">
                <ItemTemplate>
                    <it:TextImage ID="ctlType" ImageDirectory="/IssueType" Text='<%# DataBinder.Eval(Container.DataItem, "IssueTypeName" )%>'
                        ImageUrl='<%# DataBinder.Eval(Container.DataItem, "IssueTypeImageUrl" )%>' runat="server" />
                </ItemTemplate>
                <ItemStyle CssClass="text-center" />
                <HeaderStyle CssClass="text-center" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="<%$ Resources:SharedResources, Milestone %>" Visible="false" SortExpression="MilestoneSortOrder">
                <ItemTemplate>
                    <it:TextImage ID="ctlMilestone" ImageDirectory="/Milestone" Text='<%# DataBinder.Eval(Container.DataItem, "MilestoneName" )%>'
                        ImageUrl='<%# DataBinder.Eval(Container.DataItem, "MilestoneImageUrl" )%>' runat="server" />
                </ItemTemplate>
                <ItemStyle CssClass="text-center" />
                <HeaderStyle CssClass="text-center" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="<%$ Resources:SharedResources, AffectedMilestone %>" Visible="false" SortExpression="AffectedMilestoneSortOrder">
                <ItemTemplate>
                    <it:TextImage ID="ctlAffectedMilestone" ImageDirectory="/Milestone" Text='<%# DataBinder.Eval(Container.DataItem, "AffectedMilestoneName" )%>'
                        ImageUrl='<%# DataBinder.Eval(Container.DataItem, "AffectedMilestoneImageUrl" )%>' runat="server" />
                </ItemTemplate>
                <ItemStyle CssClass="text-center" />
                <HeaderStyle CssClass="text-center" Wrap="False" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="<%$ Resources:SharedResources, Status %>" Visible="false" SortExpression="StatusSortOrder">
                <ItemTemplate>
                    <it:TextImage ID="ctlStatus" ImageDirectory="/Status" Text='<%# DataBinder.Eval(Container.DataItem, "StatusName" )%>' ImageUrl='<%# DataBinder.Eval(Container.DataItem, "StatusImageUrl" )%>'
                        runat="server" />
                </ItemTemplate>
                <ItemStyle CssClass="text-center" />
                <HeaderStyle CssClass="text-center" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="<%$ Resources:SharedResources, Priority %>" Visible="false" SortExpression="PrioritySortOrder">
                <ItemTemplate>
                    <it:TextImage ID="ctlPriority" ImageDirectory="/Priority" Text='<%# DataBinder.Eval(Container.DataItem, "PriorityName" )%>'
                        ImageUrl='<%# DataBinder.Eval(Container.DataItem, "PriorityImageUrl" )%>' runat="server" />
                </ItemTemplate>
                <ItemStyle CssClass="text-center" />
                <HeaderStyle CssClass="text-center" Wrap="False" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="<%$ Resources:SharedResources, Resolution %>" Visible="false" SortExpression="ResolutionSortOrder">
                <ItemTemplate>
                    <it:TextImage ID="ctlResolution" ImageDirectory="/Resolution" Text='<%# DataBinder.Eval(Container.DataItem, "ResolutionName" )%>'
                        ImageUrl='<%# DataBinder.Eval(Container.DataItem, "ResolutionImageUrl" )%>' runat="server" />
                </ItemTemplate>
                <ItemStyle CssClass="text-center" />
                <HeaderStyle CssClass="text-center" Wrap="False" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="<%$ Resources:SharedResources, DueDate%>" Visible="false" SortExpression="IssueDueDate">
                <ItemTemplate>
                    <%# GetDueDate(Container.DataItem) %>
                </ItemTemplate>
                <HeaderStyle Wrap="False" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="<%$ Resources:SharedResources, EstimationHours %>" Visible="false" SortExpression="IssueEstimation">
                <ItemTemplate>
                    <%# DataBinder.Eval(Container.DataItem, "Estimation")%>
                </ItemTemplate>
                <HeaderStyle Wrap="False" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="<%$ Resources:SharedResources, Progress %>" Visible="false" SortExpression="IssueProgress">
                <ItemTemplate>
                    <div class="progress">
                        <div class="progress-bar progress-bar-success" id="ProgressBar" runat="server" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100">
                            <%# DataBinder.Eval(Container.DataItem, "Progress" )%>%
                        </div>
                    </div>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="<%$ Resources:SharedResources, TimeLoggedHours %>" Visible="false" SortExpression="TimeLogged">
                <ItemTemplate>
                    <%# DataBinder.Eval(Container.DataItem, "TimeLogged")%>
                </ItemTemplate>
                <HeaderStyle Wrap="False" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="<%$ Resources:SharedResources, Created %>" SortExpression="DateCreated">
                <ItemTemplate>
                    <%# DataBinder.Eval(Container.DataItem, "DateCreated", "{0:d}")%>
                </ItemTemplate>
                <HeaderStyle Wrap="False" />
                <ItemStyle Wrap="False" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="<%$ Resources:SharedResources, LastUpdate %>" SortExpression="LastUpdate">
                <ItemTemplate>
                    <%# DataBinder.Eval(Container.DataItem, "LastUpdate", "{0:d}")%>
                </ItemTemplate>
                <HeaderStyle Wrap="False" />
                <ItemStyle Wrap="False" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="<%$ Resources:SharedResources, LastUpdateUser %>" SortExpression="LastUpdateDisplayName">
                <ItemTemplate>
                    <%# DataBinder.Eval(Container.DataItem, "LastUpdateDisplayName")%>
                </ItemTemplate>
                <HeaderStyle Wrap="False" />
                <ItemStyle Wrap="False" />
            </asp:TemplateField>
        </Columns>
    </BNWC:GridView>
</asp:Panel>

<asp:DataPager ID="pager" runat="server" PageSize="10"  PagedControlID="gvIssues">
    <Fields>
        <BNWC:BugNetPagerField />
    </Fields>
</asp:DataPager>

<asp:Label ID="lblResults" ForeColor="Red" Font-Italic="True" runat="server" Text="<%$ Resources:SharedResources, NoIssueResults %>" />

<br/>
<br />