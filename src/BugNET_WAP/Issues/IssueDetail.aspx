<%@ Page Language="c#" ValidateRequest="false" Inherits="BugNET.Issues.IssueDetail" MasterPageFile="~/Shared/IssueDetail.master"
    Title=" " CodeBehind="IssueDetail.aspx.cs" AutoEventWireup="True" Async="true" %>

<%@ Register TagPrefix="it" TagName="DisplayCustomFields" Src="~/UserControls/DisplayCustomFields.ascx" %>
<%@ Register TagPrefix="it" TagName="PickCategory" Src="~/UserControls/PickCategory.ascx" %>
<%@ Register TagPrefix="it" TagName="PickMilestone" Src="~/UserControls/PickMilestone.ascx" %>
<%@ Register TagPrefix="it" TagName="PickType" Src="~/UserControls/PickType.ascx" %>
<%@ Register TagPrefix="it" TagName="PickStatus" Src="~/UserControls/PickStatus.ascx" %>
<%@ Register TagPrefix="it" TagName="PickPriority" Src="~/UserControls/PickPriority.ascx" %>
<%@ Register TagPrefix="it" TagName="PickSingleUser" Src="~/UserControls/PickSingleUser.ascx" %>
<%@ Register TagPrefix="it" TagName="PickResolution" Src="~/UserControls/PickResolution.ascx" %>
<%@ Register TagPrefix="it" TagName="IssueTabs" Src="~/Issues/UserControls/IssueTabs.ascx" %>

<asp:Content ID="Content3" ContentPlaceHolderID="IssueHeader" runat="Server">
    <asp:ValidationSummary ID="ValidationSummary1" DisplayMode="BulletList" HeaderText="<%$ Resources:SharedResources, ValidationSummaryHeaderText %>"
        CssClass="validationSummary" runat="server" />
    <bn:Message ID="Message1" runat="server" Width="100%" Visible="False" />

    <asp:Panel ID="pnlBugNavigation" Style="height: 25px;" runat="server">
        <div class="float-right">
            <ul id="horizontal-list">
                <li id="IssueActionSave" runat="server">
                    <span style="padding-right: 5px; border-right: 1px dotted #ccc">
                        <asp:ImageButton ID="imgSave" OnClick="LnkSaveClick" runat="server" CssClass="icon" ImageUrl="~\images\disk.gif" alternatetext="<%$ Resources:SharedResources, Save %>" />
                        <asp:LinkButton ID="lnkSave" OnClick="LnkSaveClick" runat="server" Text="<%$ Resources:SharedResources, Save %>" />
                    </span>
                </li>
                <li id="IssueActionSaveAndReturn" runat="server">
                    <span style="padding-right: 5px; padding-left: 10px; border-right: 1px dotted #ccc">
                        <asp:ImageButton ID="imgDone" OnClick="LnkDoneClick" runat="server" CssClass="icon" ImageUrl="~\images\disk.gif" alternatetext="<%$ Resources:SharedIssueProperties, SaveReturnText %>" />
                        <asp:LinkButton ID="lnkDone" OnClick="LnkDoneClick" runat="server" Text="<%$ Resources:SharedIssueProperties, SaveReturnText %>" />
                    </span>
                </li>
                <li id="IssueActionDelete" runat="server">
                    <span style="padding-left: 10px; padding-right: 5px; border-right: 1px dotted #ccc">
                        <asp:ImageButton ID="imgDelete" OnClick="LnkDeleteClick" runat="server" CssClass="icon" ImageUrl="~\images\cross.gif" alternatetext="<%$ Resources:SharedResources, Delete %>" />
                        <asp:LinkButton ID="lnkDelete" OnClick="LnkDeleteClick" CausesValidation="false" runat="server" Text="<%$ Resources:SharedResources, Delete %>" />
                    </span>
                </li>
                <li id="IssueActionCancel" runat="server">
                    <span style="padding-right: 5px; padding-left: 10px;">
                        <asp:ImageButton ID="imgCancel" OnClick="CancelButtonClick" CausesValidation="false" runat="server" CssClass="icon" ImageUrl="~\images\lt.gif" alternatetext="<%$ Resources:SharedResources, Cancel %>" />
                        <asp:LinkButton ID="lnkCancel" OnClick="CancelButtonClick" CausesValidation="false" runat="server" Text="<%$ Resources:SharedResources, Cancel %>" />
                    </span>
                </li>
            </ul>
        </div>
        <div class="float-left text-bold">
            <asp:Label ID="IssueLabel" Font-Size="12px" runat="server" Text="<%$ Resources:SharedIssueProperties, IssueLabel %>" />
            <asp:Label ID="lblIssueNumber" Font-Size="12px" runat="server"></asp:Label>
        </div>
    </asp:Panel>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="IssueFields" runat="Server">
    <div style="background: #F1F2EC none repeat scroll 0 0; border: 1px solid #D7D7D7; margin-bottom: 20px; padding: 6px;">
        <table width="100%" class="issue-detail">
            <tr>
                <td colspan="4">
                    <table width="100%">
                        <tbody>
                            <tr>
                                <td valign="top" style="width: 5em;" id="VoteBox" runat="server">
                                    <div class="votebox">
                                        <div class="top">
                                            <asp:Label ID="IssueVoteCount" runat="server" CssClass="count" Text="1" />
                                            <asp:Label ID="Votes" runat="server" Text="<%$ Resources: Vote %>" CssClass="votes" />
                                        </div>
                                        <div class="bottom">
                                            <asp:LinkButton ID="VoteButton" OnClick="VoteButtonClick" CausesValidation="false" runat="server" Text="vote" meta:resourcekey="VoteButton" />
                                            <asp:Label ID="VotedLabel" runat="Server" Text="<%$ Resources: Voted %>" />
                                        </div>
                                    </div>
                                </td>
                                <td style="vertical-align: top;">
                                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                        <ContentTemplate>
                                            <asp:ImageButton ID="EditTitle" Style="float: left; margin: 5px;" Visible="false" CssClass="icon" CommandName="Edit" CausesValidation="False"
                                                OnClick="EditTitleClick" ImageAlign="middle" ImageUrl="~/images/pencil.gif" BorderWidth="0px" runat="server" />
                                            <asp:Label ID="TitleLabel" Visible="false" runat="server" AssociatedControlID="TitleTextBox" meta:resourcekey="TitleLabel"/>
                                            <asp:TextBox ID="TitleTextBox" Visible="False" Width="95%" runat="server" />
                                            <asp:RequiredFieldValidator ControlToValidate="TitleTextBox" ErrorMessage="<%$ Resources:SharedIssueProperties, IssueTitleRequiredErrorMessage %>"
                                                Text="<%$ Resources:SharedResources, Required %>" Display="Dynamic" CssClass="req" runat="server" ID="TitleRequired" />
                                            <ajaxToolkit:TextBoxWatermarkExtender ID="TBWE2" runat="server" TargetControlID="TitleTextBox" WatermarkText="<%$ Resources:SharedIssueProperties, IssueTitleWatermark %>"
                                                WatermarkCssClass="issueTitleWatermarked" />
                                            <h3 style="color: #606060; margin: 0; border: 0; font-size: 18px">
                                                <asp:Label ID="DisplayTitleLabel" runat="server" Visible="True" Text="Label"></asp:Label></h3>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="padding-bottom: 13px;">
                    <asp:Label ID="DateCreatedLabel" runat="server" meta:resourcekey="DateCreatedLabel"></asp:Label>
                    <asp:Label ID="ByLabel" runat="server" meta:resourcekey="ByLabel" Text="By" />
                    <asp:Label ID="lblReporter" runat="server" />
                    <asp:Label ID="Label8" runat="server" meta:resourcekey="OnLabel" Text="On" />
                    <asp:Label ID="lblDateCreated" runat="server" />
                </td>
                <td colspan="2" style="padding-bottom: 13px;">
                    <asp:Label ID="LastModifiedLabel" runat="server" meta:resourcekey="LastUpdateLabel"></asp:Label>
                    <asp:Label ID="Label2" runat="server" meta:resourcekey="ByLabel" Text="By" />
                    <asp:Label ID="lblLastUpdateUser" runat="server" />
                    <asp:Label ID="Label9" runat="server" meta:resourcekey="OnLabel" Text="On" />
                    <asp:Label ID="lblLastModified" runat="server" />
                </td>
            </tr>
            <tr>
                <td style="width: 15%;">
                    <asp:Label ID="StatusLabel" runat="server" AssociatedControlID="DropStatus" Text="<%$Resources:SharedIssueProperties, StatusLabel %>" />
                </td>
                <td style="width: 35%;">
                    <it:PickStatus ID="DropStatus" runat="Server" DisplayDefault="true" />
                </td>
                <td style="width: 15%;">
                    <asp:Label ID="OwnerLabel" runat="server" AssociatedControlID="DropOwned" Text="<%$Resources:SharedIssueProperties, OwnedByLabel %>" />
                </td>
                <td style="width: 35%;">
                    <it:PickSingleUser ID="DropOwned" DisplayDefault="True" Required="false" runat="Server" />
                </td>
            </tr>
            <tr>
                <td style="width: 15%;">
                    <asp:Label ID="PriorityLabel" runat="server" AssociatedControlID="DropPriority" Text="<%$Resources:SharedIssueProperties, PriorityLabel %>" />
                </td>
                <td style="width: 35%;">
                    <it:PickPriority ID="DropPriority" DisplayDefault="true" runat="Server" />
                </td>
                <td>
                    <asp:Label ID="Label4" AssociatedControlID="DropAffectedMilestone" Text="<%$Resources:SharedIssueProperties, AffectedMilestoneLabel %>" runat="server" />
                </td>
                <td>
                    <it:PickMilestone ID="DropAffectedMilestone" DisplayDefault="True" runat="Server" />
                </td>
            </tr>
            <tr>
                <td style="width: 15%;">
                    <asp:Label ID="AssignedToLabel" runat="server" AssociatedControlID="DropAssignedTo" Text="<%$Resources:SharedIssueProperties, AssignedToLabel %>" />
                </td>
                <td style="width: 35%;">
                    <it:PickSingleUser ID="DropAssignedTo" DisplayUnassigned="False" DisplayDefault="True" Required="false" runat="Server" />
                </td>
                <td style="width: 15%;">
                    <asp:Label ID="PrivateLabel" AssociatedControlID="chkPrivate" runat="server" Text="<%$Resources:SharedIssueProperties, PrivateLabel %>" />
                </td>
                <td style="width: 35%;">
                    <asp:CheckBox ID="chkPrivate" runat="server" />
                </td>
            </tr>
            <tr>
                <td style="width: 15%;">
                    <asp:Label ID="CategoryLabel" AssociatedControlID="DropCategory" runat="server" Text="<%$Resources:SharedIssueProperties, CategoryLabel %>"/>
                </td>
                <td style="width: 35%;">
                    <it:PickCategory ID="DropCategory" DisplayDefault="true" Required="false" runat="Server" />
                </td>
                <td style="width: 15%;">
                    <asp:Label runat="server" AssociatedControlID="DueDatePicker:DateTextBox" ID="DueDateLabel" Text="<%$Resources:SharedIssueProperties, DueDateLabel %>" />
                </td>
                <td style="width: 35%;">
                    <bn:PickDate ID="DueDatePicker" runat="server" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="IssueTypeLabel" AssociatedControlID="DropIssueType:ddlType" runat="server" Text="<%$Resources:SharedIssueProperties, IssueTypeLabel %>" />
                </td>
                <td>
                    <it:PickType ID="DropIssueType" DisplayDefault="True" runat="Server" />
                </td>
                <td style="width: 15%;">
                    <asp:Label ID="Label3" runat="server" AssociatedControlID="DropOwned" Text="<%$Resources:SharedIssueProperties, ProgressLabel %>" />
                </td>
                <td style="width: 35%;">
                    <span style="float: left; margin-left: 160px;">
                        <asp:Label ID="ProgressSlider_BoundControl" runat="server" />%</span>
                    <asp:TextBox ID="ProgressSlider" runat="server" Text="0" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="MilestoneLabel" AssociatedControlID="DropMilestone" runat="server" Text="<%$Resources:SharedIssueProperties, MilestoneLabel %>" />
                </td>
                <td>
                    <it:PickMilestone ID="DropMilestone" DisplayDefault="True" runat="Server" />
                </td>
                <td style="width: 15%;">
                    <asp:Label ID="EstimationLabel" runat="server" AssociatedControlID="txtEstimation" Text="<%$Resources:SharedIssueProperties, EstimationLabel %>" />
                </td>
                <td style="width: 35%;">
                    <asp:TextBox ID="txtEstimation" Style="text-align: right;" Width="80px" runat="server" />
                    &nbsp;<small><asp:Label ID="HoursLabel" runat="server" Text="<%$Resources:SharedIssueProperties, HoursLabel %>" /></small>
                    <asp:RangeValidator ID="RangeValidator2" runat="server" ErrorMessage="<%$Resources:SharedIssueProperties, EstimationValidatorMessage %>" ControlToValidate="txtEstimation"
                        MaximumValue="999" MinimumValue="0" SetFocusOnError="True" Display="Dynamic" ForeColor="Red"/>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="ResolutionLabel" runat="server" AssociatedControlID="DropResolution" Text="<%$Resources:SharedIssueProperties, ResolutionLabel %>" />
                </td>
                <td>
                    <it:PickResolution ID="DropResolution" DisplayDefault="True" runat="Server" />
                </td>
                <td runat="Server" id="TimeLoggedLabel" visible="false">
                    <asp:Label ID="LoggedLabel" runat="server" Text="<%$Resources:SharedIssueProperties, LoggedLabel %>" />
                </td>
                <td runat="Server" id="TimeLogged" visible="false">
                    <asp:Label ID="lblLoggedTime" runat="server" Style="text-align: right;" />&nbsp;&nbsp;<small>
                        <asp:Label ID="Label1" runat="server" Text="<%$Resources:SharedIssueProperties, HoursLabel %>" /></small>
                </td>
            </tr>
        </table>
        <it:DisplayCustomFields ID="ctlCustomFields" EnableValidation="true" runat="server" />
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <p style="margin-top: 8px; padding: 8px 0 8px 0; border-top: 1px solid #CCCCCC; overflow: auto;">
                    <asp:ImageButton ID="EditDescription" Visible="false" CssClass="icon" OnClick="EditDescriptionClick" CausesValidation="False"
                        CommandName="Edit" ImageUrl="~/images/pencil.gif" BorderWidth="0px" runat="server" />&nbsp;<strong><asp:Label ID="DescriptionLabel"
                            runat="server" Text="<%$ Resources:SharedResources, Description %>"/></strong>
                </p>
                <div class="issueDescription">
                    <bn:HtmlEditor ID="DescriptionHtmlEditor" Visible="False" runat="server" />
                    <asp:Label ID="Description" Visible="True" runat="server" Text="Label"/>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <ajaxToolkit:SliderExtender ID="SliderExtender2" runat="server" Steps="21" TargetControlID="ProgressSlider" BoundControlID="ProgressSlider_BoundControl"
        Orientation="Horizontal" TooltipText="<%$Resources:SharedIssueProperties, ProgressSliderTooltip %>" EnableHandleAnimation="true" /> 
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="IssueTabs" runat="Server">
    <it:IssueTabs ID="ctlIssueTabs" runat="server"></it:IssueTabs>
</asp:Content>
