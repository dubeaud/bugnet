<%@ Control Language="C#" AutoEventWireup="true" Inherits="BugNET.Administration.Projects.UserControls.ProjectDefaultValues" CodeBehind="ProjectDefaultValues.ascx.cs" %>
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
<table class="table">
    <thead>
        <tr>
            <th colspan="2" class="text-center" rowspan="2">Default Value</th>
            <th colspan="2" class="text-center bg-info">Visibility</th>
        </tr>
        <tr>
            <th class="text-center">New Issue</th>
            <th class="text-center">Edit Issue</th>
            <th class="text-center">Notify</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>
                <asp:Label ID="StatusLabel" runat="server" AssociatedControlID="DropStatus" Text="<%$Resources:SharedIssueProperties, StatusLabel %>" /></td>
            <td>
                <it:PickStatus ID="DropStatus" runat="Server" DisplayDefault="true" />
            </td>
            <td class="text-center">
                <asp:CheckBox ID="chkStatusVisibility" runat="server" Checked="True" />
            </td>
            <td class="text-center">
                <asp:CheckBox ID="chkStatusEditVisibility" runat="server" Checked="True" />
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="OwnerLabel" runat="server" AssociatedControlID="DropOwned" Text="<%$Resources:SharedIssueProperties, OwnedByLabel %>" /></td>
            <td>
                <it:PickSingleUser ID="DropOwned" DisplayDefault="True" Required="False" runat="Server" />
            </td>
            <td class="text-center">
                <asp:CheckBox ID="chkOwnedByVisibility" runat="server" Checked="True" /></td>
            <td class="text-center">
                <asp:CheckBox ID="chkOwnedByEditVisibility" runat="server" Checked="True" /></td>
            <td class="text-center">
                <asp:CheckBox ID="chkNotifyOwner" runat="server" Checked="True" Text="<%$ Resources:SharedIssueProperties, NotifyCheckbox %>" /></td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="PriorityLabel" runat="server" AssociatedControlID="DropPriority" Text="<%$Resources:SharedIssueProperties, PriorityLabel %>" /></td>
            <td>
                <it:PickPriority ID="DropPriority" DisplayDefault="true" runat="Server" />
            </td>
            <td class="text-center">
                <asp:CheckBox ID="chkPriorityVisibility" runat="server" Checked="True" /></td>
            <td class="text-center">
                <asp:CheckBox ID="chkPriorityEditVisibility" runat="server" Checked="True" /></td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="Label4" AssociatedControlID="DropAffectedMilestone" runat="server" Text="<%$Resources:SharedIssueProperties, AffectedMilestoneLabel %>" /></td>
            <td>
                <it:PickMilestone ID="DropAffectedMilestone" DisplayDefault="True" runat="Server" />
            </td>
            <td class="text-center">
                <asp:CheckBox ID="chkAffectedMilestoneVisibility" runat="server" Checked="True" /></td>
            <td class="text-center">
                <asp:CheckBox ID="chkAffectedMilestoneEditVisibility" runat="server" Checked="True" /></td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="AssignedToLabel" runat="server" AssociatedControlID="DropAssignedTo" Text="<%$Resources:SharedIssueProperties, AssignedToLabel %>" /></td>
            <td>
                <it:PickSingleUser ID="DropAssignedTo" DisplayUnassigned="False" DisplayDefault="True" Required="false" runat="Server" />
            </td>
            <td class="text-center">
                <asp:CheckBox ID="chkAssignedToVisibility" runat="server" Checked="True" />
            </td>
            <td class="text-center">
                <asp:CheckBox ID="chkAssignedToEditVisibility" runat="server" Checked="True" /></td>
            <td class="text-center">
                <asp:CheckBox ID="chkNotifyAssignedTo" runat="server" Checked="True" Text="<%$ Resources:SharedIssueProperties, NotifyCheckbox %>" /></td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="PrivateLabel" AssociatedControlID="chkPrivate" runat="server" Text="<%$Resources:SharedIssueProperties, PrivateLabel %>" /></td>
            <td>
                <asp:CheckBox ID="chkPrivate" runat="server" /></td>
            <td class="text-center">
                <asp:CheckBox ID="chkPrivateVisibility" runat="server" Checked="True" /></td>
            <td class="text-center">
                <asp:CheckBox ID="chkPrivateEditVisibility" runat="server" Checked="True" /></td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="CategoryLabel" AssociatedControlID="DropCategory" runat="server" Text="<%$Resources:SharedIssueProperties, CategoryLabel %>" /></td>
            <td>
                <it:PickCategory ID="DropCategory" DisplayDefault="true" Required="false" runat="Server" />
            </td>
            <td class="text-center">
                <asp:CheckBox ID="chkCategoryVisibility" runat="server" Checked="True" /></td>
            <td class="text-center">
                <asp:CheckBox ID="chkCategoryEditVisibility" runat="server" Checked="True" /></td>
        </tr>
        <tr>
            <td>
                <asp:Label runat="server" AssociatedControlID="DueDate" ID="DueDateLabel" Text="<%$Resources:SharedIssueProperties, DueDateLabel %>" /></td>
            <td>
                <asp:TextBox ID="DueDate" Width="40" CssClass="form-control text-right" runat="server" />
                <small>
                    <asp:Label runat="server" ID="days" Text="<%$Resources:SharedIssueProperties, DaysLabel %>" />
                </small>
            </td>
            <td class="text-center">
                <asp:CheckBox ID="chkDueDateVisibility" runat="server" Checked="True" />
            </td>
            <td class="text-center">
                <asp:CheckBox ID="chkDueDateEditVisibility" runat="server" Checked="True" /></td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="IssueTypeLabel" AssociatedControlID="DropIssueType" runat="server" Text="<%$Resources:SharedIssueProperties, IssueTypeLabel %>" /></td>
            <td>
                <it:PickType ID="DropIssueType" DisplayDefault="True" runat="Server" />
            </td>
            <td class="text-center">
                <asp:CheckBox ID="chkTypeVisibility" runat="server" Checked="True" /></td>
            <td class="text-center">
                <asp:CheckBox ID="chkTypeEditVisibility" runat="server" Checked="True" /></td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="Label3" runat="server" AssociatedControlID="ProgressSlider" Text="<%$Resources:SharedIssueProperties, ProgressLabel %>" /></td>
            <td>
                <asp:TextBox ID="ProgressSlider" runat="server" CssClass="form-control" Text="0" /></td>
            <td class="text-center">
                <asp:CheckBox ID="chkPercentCompleteVisibility" runat="server" Checked="True" /></td>
            <td class="text-center">
                <asp:CheckBox ID="chkPercentCompleteEditVisibility" runat="server" Checked="True" /></td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="MilestoneLabel" AssociatedControlID="DropMilestone" runat="server" Text="<%$Resources:SharedIssueProperties, MilestoneLabel %>" /></td>
            <td>
                <it:PickMilestone ID="DropMilestone" DisplayDefault="True" runat="Server" />
            </td>
            <td class="text-center">
                <asp:CheckBox ID="chkMilestoneVisibility" runat="server" Checked="True" /></td>
            <td class="text-center">
                <asp:CheckBox ID="chkMilestoneEditVisibility" runat="server" Checked="True" /></td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="EstimationLabel" runat="server" AssociatedControlID="txtEstimation" Text="<%$Resources:SharedIssueProperties, EstimationLabel %>" /></td>
            <td>
                <asp:TextBox ID="txtEstimation" CssClass="form-control text-right" Width="80px" runat="server" />
                &nbsp;<small><asp:Label ID="HoursLabel" runat="server" Text="<%$Resources:SharedIssueProperties, HoursLabel %>" /></small>
                <asp:RangeValidator ID="RangeValidator2" runat="server" ErrorMessage="<%$Resources:SharedIssueProperties, EstimationValidatorMessage %>"
                    ControlToValidate="txtEstimation" MaximumValue="999" MinimumValue="0" Display="Dynamic" SetFocusOnError="True" ForeColor="Red" /></td>
            <td class="text-center">
                <asp:CheckBox ID="chkEstimationVisibility" runat="server" Checked="True" /></td>
            <td class="text-center">
                <asp:CheckBox ID="chkEstimationEditVisibility" runat="server" Checked="True" /></td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="ResolutionLabel" runat="server" AssociatedControlID="DropResolution" Text="<%$Resources:SharedIssueProperties, ResolutionLabel %>" /></td>
            <td>
                <it:PickResolution ID="DropResolution" DisplayDefault="True" runat="Server" />
            </td>
            <td class="text-center">
                <asp:CheckBox ID="chkResolutionVisibility" runat="server" Checked="True" /></td>
            <td class="text-center">
                <asp:CheckBox ID="chkResolutionEditVisibility" runat="server" Checked="True" /></td>
        </tr>
    </tbody>
</table>

