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

<div class="form-horizontal">
    <div class="form-group">
        <asp:Label ID="StatusLabel" runat="server" CssClass="control-label col-md-2" AssociatedControlID="DropStatus" Text="<%$Resources:SharedIssueProperties, StatusLabel %>" />
        <div class="col-md-5">
            <it:PickStatus ID="DropStatus" runat="Server" DisplayDefault="true" />
        </div>
        <div class="col-md-4">
            <div class="checkbox">
                <asp:CheckBox ID="chkStatusVisibility" runat="server" Checked="True" meta:ResourceKey="VisibilityCheckBox" />
            </div>
        </div>
    </div>
    <div class="form-group">
        <asp:Label ID="OwnerLabel" runat="server" CssClass="control-label col-md-2" AssociatedControlID="DropOwned" Text="<%$Resources:SharedIssueProperties, OwnedByLabel %>" />
        <div class="col-md-5">
            <it:PickSingleUser ID="DropOwned" DisplayDefault="True" Required="False" runat="Server" />
        </div>
        <div class="col-md-2">
            <div class="checkbox">
                <asp:CheckBox ID="chkOwnedByVisibility" runat="server" Checked="True" meta:ResourceKey="VisibilityCheckBox" />
            </div>
        </div>
        <div class="col-md-2">
            <div class="checkbox">
                <asp:CheckBox ID="chkNotifyOwner" runat="server" Checked="True" Text="<%$ Resources:SharedIssueProperties, NotifyCheckbox %>" />
            </div>
        </div>
    </div>
    <div class="form-group">
        <asp:Label ID="PriorityLabel" CssClass="control-label col-md-2" runat="server" AssociatedControlID="DropPriority" Text="<%$Resources:SharedIssueProperties, PriorityLabel %>" />
        <div class="col-md-5">
           <it:PickPriority ID="DropPriority" DisplayDefault="true" runat="Server" />
        </div>
        <div class="col-md-4">
            <div class="checkbox">
                <asp:CheckBox ID="chkPriorityVisibility" runat="server" Checked="True" meta:ResourceKey="VisibilityCheckBox" />
            </div>
        </div>
    </div>
    <div class="form-group">
        <asp:Label ID="Label4" CssClass="control-label col-md-2" AssociatedControlID="DropAffectedMilestone" runat="server" Text="<%$Resources:SharedIssueProperties, AffectedMilestoneLabel %>" />
        <div class="col-md-5">
           <it:PickMilestone ID="DropAffectedMilestone" DisplayDefault="True" runat="Server" />
        </div>
        <div class="col-md-4">
            <div class="checkbox">
                <asp:CheckBox ID="chkAffectedMilestoneVisibility" runat="server" Checked="True" meta:ResourceKey="VisibilityCheckBox" />
            </div>
        </div>
    </div>
    <div class="form-group">
        <asp:Label ID="AssignedToLabel" CssClass="control-label col-md-2" runat="server" AssociatedControlID="DropAssignedTo" Text="<%$Resources:SharedIssueProperties, AssignedToLabel %>" />
        <div class="col-md-5">
            <it:PickSingleUser ID="DropAssignedTo" DisplayUnassigned="False" DisplayDefault="True" Required="false" runat="Server" />
        </div>
        <div class="col-md-2">
            <div class="checkbox">
                <asp:CheckBox ID="chkAssignedToVisibility" runat="server" Checked="True" meta:ResourceKey="VisibilityCheckBox" />
            </div>
        </div>
        <div class="col-md-2">
            <div class="checkbox">
                <asp:CheckBox ID="chkNotifyAssignedTo" runat="server" Checked="True" Text="<%$ Resources:SharedIssueProperties, NotifyCheckbox %>" />
            </div>
        </div>
    </div>
    <div class="form-group">
        <asp:Label ID="PrivateLabel" CssClass="control-label col-md-2" AssociatedControlID="chkPrivate" runat="server" Text="<%$Resources:SharedIssueProperties, PrivateLabel %>" />
        <div class="col-md-5">
            <div class="checkbox">
                <asp:CheckBox ID="chkPrivate" runat="server" />
            </div>
        </div>
        <div class="col-md-4">
            <div class="checkbox">
                <asp:CheckBox ID="chkPrivateVisibility" runat="server" Checked="True" meta:ResourceKey="VisibilityCheckBox" />
            </div>
        </div>
    </div>
    <div class="form-group">
        <asp:Label ID="CategoryLabel" CssClass="control-label col-md-2" AssociatedControlID="DropCategory" runat="server" Text="<%$Resources:SharedIssueProperties, CategoryLabel %>" />
        <div class="col-md-5">
            <it:PickCategory ID="DropCategory" DisplayDefault="true" Required="false" runat="Server" />
        </div>
        <div class="col-md-4">
            <div class="checkbox">
                <asp:CheckBox ID="chkCategoryVisibility" runat="server" Checked="True" meta:ResourceKey="VisibilityCheckBox" />
            </div>
        </div>
    </div>
    <div class="form-group">
        <asp:Label runat="server" CssClass="control-label col-md-2" AssociatedControlID="DueDate" ID="DueDateLabel" Text="<%$Resources:SharedIssueProperties, DueDateLabel %>" />
        <div class="col-md-5">
            <asp:TextBox ID="DueDate" Width="40" CssClass="form-control text-right" runat="server" />
            <small>
               <asp:Label runat="server" ID="days" Text="<%$Resources:SharedIssueProperties, DaysLabel %>" />
            </small>
        </div>
        <div class="col-md-4">
            <div class="checkbox">
               <asp:CheckBox ID="chkDueDateVisibility" runat="server" Checked="True" meta:ResourceKey="VisibilityCheckBox" />
            </div>
        </div>
    </div>
    <div class="form-group">
        <asp:Label ID="IssueTypeLabel" CssClass="control-label col-md-2" AssociatedControlID="DropIssueType" runat="server" Text="<%$Resources:SharedIssueProperties, IssueTypeLabel %>" />
        <div class="col-md-5">
            <it:PickType ID="DropIssueType" DisplayDefault="True" runat="Server" />
        </div>
        <div class="col-md-4">
            <div class="checkbox">
                <asp:CheckBox ID="chkTypeVisibility" runat="server" Checked="True" meta:ResourceKey="VisibilityCheckBox" />
            </div>
        </div>
    </div>
    <div class="form-group">
        <asp:Label ID="Label3" CssClass="control-label col-md-2" runat="server" AssociatedControlID="ProgressSlider" Text="<%$Resources:SharedIssueProperties, ProgressLabel %>" />
        <div class="col-md-5">
            <asp:TextBox ID="ProgressSlider" runat="server" CssClass="form-control" Text="0" />
        </div>
        <div class="col-md-4">
            <div class="checkbox">
                <asp:CheckBox ID="chkPercentCompleteVisibility" runat="server" Checked="True" meta:ResourceKey="VisibilityCheckBox" />
            </div>
        </div>
    </div>
    <div class="form-group">
        <asp:Label ID="MilestoneLabel" CssClass="control-label col-md-2" AssociatedControlID="DropMilestone" runat="server" Text="<%$Resources:SharedIssueProperties, MilestoneLabel %>" />
        <div class="col-md-5">
            <it:PickMilestone ID="DropMilestone" DisplayDefault="True" runat="Server" />
        </div>
        <div class="col-md-4">
            <div class="checkbox">
                <asp:CheckBox ID="chkMilestoneVisibility" runat="server" Checked="True" meta:ResourceKey="VisibilityCheckBox" />
            </div>
        </div>
    </div>
    <div class="form-group">
        <asp:Label ID="EstimationLabel" CssClass="control-label col-md-2" runat="server" AssociatedControlID="txtEstimation" Text="<%$Resources:SharedIssueProperties, EstimationLabel %>" />
        <div class="col-md-5">
            <asp:TextBox ID="txtEstimation" CssClass="form-control text-right" Width="80px" runat="server" />
            &nbsp;<small><asp:Label ID="HoursLabel" runat="server" Text="<%$Resources:SharedIssueProperties, HoursLabel %>" /></small>
            <asp:RangeValidator ID="RangeValidator2" runat="server" ErrorMessage="<%$Resources:SharedIssueProperties, EstimationValidatorMessage %>"
               ControlToValidate="txtEstimation" MaximumValue="999" MinimumValue="0" Display="Dynamic" SetFocusOnError="True" ForeColor="Red" />
        </div>
        <div class="col-md-4">
            <div class="checkbox">
                <asp:CheckBox ID="chkEstimationVisibility" runat="server" Checked="True" meta:ResourceKey="VisibilityCheckBox" />
            </div>
        </div>
    </div>
    <div class="form-group">
        <asp:Label ID="ResolutionLabel" CssClass="control-label col-md-2" runat="server" AssociatedControlID="DropResolution" Text="<%$Resources:SharedIssueProperties, ResolutionLabel %>" />
        <div class="col-md-5">
            <it:PickResolution ID="DropResolution" DisplayDefault="True" runat="Server" />
        </div>
        <div class="col-md-4">
            <div class="checkbox">
                <asp:CheckBox ID="chkResolutionVisibility" runat="server" Checked="True" meta:ResourceKey="VisibilityCheckBox" />
            </div>
        </div>
    </div>
</div>

