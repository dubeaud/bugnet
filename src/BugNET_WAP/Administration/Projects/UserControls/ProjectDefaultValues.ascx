<%@ Control Language="C#" AutoEventWireup="true" Inherits="BugNET.Administration.Projects.UserControls.ProjectDefaultValues" Codebehind="ProjectDefaultValues.ascx.cs" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="AjaxToolkit" %> 

<%@ Register TagPrefix="it" TagName="DisplayCustomFields" Src="~/UserControls/DisplayCustomFields.ascx" %>
<%@ Register TagPrefix="it" TagName="PickCategory" Src="~/UserControls/PickCategory.ascx" %>
<%@ Register TagPrefix="it" TagName="PickMilestone" Src="~/UserControls/PickMilestone.ascx" %>
<%@ Register TagPrefix="it" TagName="PickType" Src="~/UserControls/PickType.ascx" %>
<%@ Register TagPrefix="it" TagName="PickStatus" Src="~/UserControls/PickStatus.ascx" %>
<%@ Register TagPrefix="it" TagName="PickPriority" Src="~/UserControls/PickPriority.ascx" %>
<%@ Register TagPrefix="it" TagName="PickSingleUser" Src="~/UserControls/PickSingleUser.ascx" %>
<%@ Register TagPrefix="it" TagName="PickResolution" Src="~/UserControls/PickResolution.ascx" %>
<%@ Register TagPrefix="it" TagName="IssueTabs" Src="~/Issues/UserControls/IssueTabs.ascx" %>

<h2>
    <asp:Literal ID="TitleLabel" runat="Server" meta:resourcekey="TitleLabel" />
</h2>
<p>
    <asp:Label ID="DescriptionLabel" runat="server" meta:resourcekey="DescriptionLabel" />
</p>

 <div style="background: #F1F2EC none repeat scroll 0 0; border: 1px solid #D7D7D7; margin-bottom: 20px; padding: 6px;">

     <%-- Wait fix for BGN-2226 --%>
<%--    <script type="text/javascript">
        $(document).ready(function () {
            $('.dateField').datepick({ showOn: 'button',
                buttonImageOnly: true, buttonImage: '<%=ResolveUrl("~/Images/calendar.gif")%>'
            });
        });
    </script>--%>

    <table width="100%" class="issue-detail">
        <tr>
            <td style="width: 15%;">
                <asp:Label ID="StatusLabel" runat="server" AssociatedControlID="DropStatus" Text="<%$Resources:SharedIssueProperties, StatusLabel %>" />
            </td>
            <td style="width: 35%;">
                <it:PickStatus ID="DropStatus" runat="Server"  DisplayDefault="true" />
                <asp:CheckBox ID="chkStatusVisibility" runat="server" Checked="True" meta:ResourceKey="VisibilityCheckBox" />
            </td>
            <td style="width: 15%;">
                <asp:Label ID="OwnerLabel" runat="server" AssociatedControlID="DropOwned" Text="<%$Resources:SharedIssueProperties, OwnedByLabel %>" />
            </td>
            <td style="width: 25%;">
                <it:PickSingleUser ID="DropOwned" DisplayDefault="True" Required="False" runat="Server" />
                <asp:CheckBox ID="chkOwnedByVisibility" runat="server" Checked="True" meta:ResourceKey="VisibilityCheckBox" />
                <asp:CheckBox ID="chkNotifyOwner" runat="server" Checked="True" Text="<%$ Resources:SharedIssueProperties, NotifyCheckbox %>" />
            </td>
        </tr>
        <tr>
            <td style="width: 15%;">
                <asp:Label ID="PriorityLabel" runat="server" AssociatedControlID="DropPriority" Text="<%$Resources:SharedIssueProperties, PriorityLabel %>" />
            </td>
            <td style="width: 35%;">
                <it:PickPriority ID="DropPriority" DisplayDefault="true" runat="Server" />
                <asp:CheckBox ID="chkPriorityVisibility" runat="server" Checked="True" meta:ResourceKey="VisibilityCheckBox" />
            </td>
            <td>
                <asp:Label ID="Label4" AssociatedControlID="DropAffectedMilestone" runat="server" Text="<%$Resources:SharedIssueProperties, AffectedMilestoneLabel %>" />
            </td>
            <td>
                <it:PickMilestone ID="DropAffectedMilestone" DisplayDefault="True" runat="Server" />
                <asp:CheckBox ID="chkAffectedMilestoneVisibility" runat="server" Checked="True" meta:ResourceKey="VisibilityCheckBox" />
            </td>
        </tr>
        <tr>
            <td style="width: 15%;">
                <asp:Label ID="AssignedToLabel" runat="server" AssociatedControlID="DropAssignedTo" Text="<%$Resources:SharedIssueProperties, AssignedToLabel %>" />
            </td>
            <td style="width: 35%;">
                <it:PickSingleUser ID="DropAssignedTo" DisplayUnassigned="False" DisplayDefault="True"
                    Required="false" runat="Server" />
                <asp:CheckBox ID="chkAssignedToVisibility" runat="server" Checked="True" meta:ResourceKey="VisibilityCheckBox" />
                <asp:CheckBox ID="chkNotifyAssignedTo" runat="server" Checked="True" Text="<%$ Resources:SharedIssueProperties, NotifyCheckbox %>" />
            </td>
            <td style="width: 15%;">
                <asp:Label ID="PrivateLabel" AssociatedControlID="chkPrivate" runat="server" Text="<%$Resources:SharedIssueProperties, PrivateLabel %>" />
            </td>
            <td style="width: 35%;">
                <asp:CheckBox ID="chkPrivate" runat="server" />
                <asp:CheckBox ID="chkPrivateVisibility" runat="server" Checked="True" meta:ResourceKey="VisibilityCheckBox" />
            </td>
        </tr>
        <tr>
            <td style="width: 15%;">
                <asp:Label ID="CategoryLabel" AssociatedControlID="DropCategory" runat="server" Text="<%$Resources:SharedIssueProperties, CategoryLabel %>" />
            </td>
            <td style="width: 35%;">
                <it:PickCategory ID="DropCategory" DisplayDefault="true" Required="false" runat="Server" />
                <asp:CheckBox ID="chkCategoryVisibility" runat="server" Checked="True" meta:ResourceKey="VisibilityCheckBox"/>
            </td>
            <td style="width: 15%;">
                <asp:Label runat="server" AssociatedControlID="DueDate" ID="DueDateLabel" Text="<%$Resources:SharedIssueProperties, DueDateLabel %>" />
            </td>
            <td style="width: 35%;">
                <asp:TextBox ID="DueDate" Width="40" Style="text-align: right;" runat="server" />
                <small><asp:Label runat="server" AssociatedControlID="DueDate" ID="days" Text="<%$Resources:SharedIssueProperties, DaysLabel %>" /></small>
                <asp:CheckBox ID="chkDueDateVisibility" runat="server" Checked="True" meta:ResourceKey="VisibilityCheckBox" />
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="IssueTypeLabel"  AssociatedControlID="DropIssueType" runat="server" Text="<%$Resources:SharedIssueProperties, IssueTypeLabel %>" />
            </td>
            <td>
                <it:PickType ID="DropIssueType" DisplayDefault="True" runat="Server" />
                <asp:CheckBox ID="chkTypeVisibility" runat="server" Checked="True" meta:ResourceKey="VisibilityCheckBox" />
            </td>
            <td style="width: 15%;">
                <asp:Label ID="Label3" runat="server" AssociatedControlID="ProgressSlider" Text="<%$Resources:SharedIssueProperties, ProgressLabel %>" />
            </td>
            <td style="width: 35%;">
                <span style="float: left; margin-left: 160px;">
                    <asp:Label ID="ProgressSlider_BoundControl" runat="server" />%
                    <asp:CheckBox ID="chkPercentCompleteVisibility" runat="server" Checked="True" meta:ResourceKey="VisibilityCheckBox" />
                </span>
                <asp:TextBox ID="ProgressSlider" runat="server" Text="0" />
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="MilestoneLabel" AssociatedControlID="DropMilestone" runat="server" Text="<%$Resources:SharedIssueProperties, MilestoneLabel %>" />
            </td>
            <td>
                <it:PickMilestone ID="DropMilestone" DisplayDefault="True" runat="Server" />
                <asp:CheckBox ID="chkMilestoneVisibility" runat="server" Checked="True" meta:ResourceKey="VisibilityCheckBox" />
            </td>
            <td style="width: 15%;">
                <asp:Label ID="EstimationLabel" runat="server" AssociatedControlID="txtEstimation" Text="<%$Resources:SharedIssueProperties, EstimationLabel %>"/>
            </td>
            <td style="width: 35%;">
                <asp:TextBox ID="txtEstimation" Style="text-align: right;" Width="80px" runat="server" />
                &nbsp;<small><asp:Label ID="HoursLabel" runat="server" Text="<%$Resources:SharedIssueProperties, HoursLabel %>" /></small>
                    <asp:CheckBox ID="chkEstimationVisibility" runat="server" Checked="True" meta:ResourceKey="VisibilityCheckBox" />
                <asp:RangeValidator ID="RangeValidator2" runat="server" ErrorMessage="<%$Resources:SharedIssueProperties, EstimationValidatorMessage %>"
                    ControlToValidate="txtEstimation" MaximumValue="999" MinimumValue="0" Display="Dynamic" SetFocusOnError="True" ForeColor="Red" />
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="ResolutionLabel" runat="server" AssociatedControlID="DropResolution" Text="<%$Resources:SharedIssueProperties, ResolutionLabel %>" />
            </td>
            <td>
                <it:PickResolution ID="DropResolution" DisplayDefault="True" runat="Server" />
                <asp:CheckBox ID="chkResolutionVisibility" runat="server" Checked="True" meta:ResourceKey="VisibilityCheckBox" />
            </td>
            <td runat="Server" id="TimeLoggedLabel" visible="false">
                <asp:Label ID="LoggedLabel" runat="server" Text="<%$Resources:SharedIssueProperties, LoggedLabel %>" />
            </td>
            <td runat="Server" id="TimeLogged" visible="false">
                <asp:Label ID="lblLoggedTime" runat="server" Style="text-align: right;" />&nbsp;
                <small>
                    <asp:Label ID="Label2" runat="server" Text="<%$Resources:SharedIssueProperties, HoursLabel %>" /></small>
            </td>
        </tr>
    </table>

    <ajaxToolkit:SliderExtender ID="SliderExtender2" runat="server" Steps="21" TargetControlID="ProgressSlider"
        BoundControlID="ProgressSlider_BoundControl" Orientation="Horizontal" TooltipText="<%$Resources:SharedIssueProperties, ProgressSliderTooltip %>"
        EnableHandleAnimation="true" />
</div>

