<%@ Page Language="c#" ValidateRequest="false" Inherits="BugNET.Issues.IssueDetail"
    MasterPageFile="~/Shared/IssueDetail.master" Title=" " CodeBehind="IssueDetail.aspx.cs"
    AutoEventWireup="True" %>

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
        <div style="float: right; text-align: right;">
            <span style="padding-right: 5px;">
                <asp:ImageButton ID="imgSave" OnClick="lnkSave_Click" runat="server" CssClass="icon"
                    ImageUrl="~\images\disk.gif" />
                <asp:LinkButton ID="lnkSave" OnClick="lnkSave_Click" runat="server" Text="<%$ Resources:SharedResources, Save %>" />
            </span><span style="padding-right: 5px; padding-left: 10px; border-left: 1px dotted #ccc">
                <asp:ImageButton ID="imgDone" OnClick="lnkDone_Click" runat="server" CssClass="icon"
                    ImageUrl="~\images\disk.gif" />
                <asp:LinkButton ID="lnkDone" OnClick="lnkDone_Click" runat="server" meta:resourcekey="SaveReturn"
                    Text="Save &amp; Return" />
            </span><span style="padding-right: 5px; padding-left: 10px; border-left: 1px dotted #ccc">
                <asp:ImageButton ID="Imagebutton1" OnClick="CancelButtonClick" CausesValidation="false"
                    runat="server" CssClass="icon" ImageUrl="~\images\lt.gif" />
                <asp:LinkButton ID="LinkButton1" OnClick="CancelButtonClick" CausesValidation="false"
                    runat="server" Text="<%$ Resources:SharedResources, Cancel %>" />
            </span><span style="padding-left: 10px; padding-right: 5px; border-left: 1px dotted #ccc"
                runat="server" id="DeleteButton" visible="False">
                <asp:ImageButton ID="imgDelete" OnClick="lnkDelete_Click" runat="server" CssClass="icon"
                    ImageUrl="~\images\cross.gif" />
                <asp:LinkButton ID="lnkDelete" OnClick="lnkDelete_Click" CausesValidation="false"
                    runat="server" Text="<%$ Resources:SharedResources, Delete %>" />
            </span>
        </div>
        <div style="float: left; font-weight: bold;">
            <asp:Label ID="Label5" Font-Size="12px" runat="server" Text="Issue:" />
            <asp:Label ID="lblIssueNumber" Font-Size="12px" runat="server"></asp:Label>
        </div>
    </asp:Panel>
</asp:Content>


<asp:Content ID="Content1" ContentPlaceHolderID="IssueFields" runat="Server">
    <div style="background: #F1F2EC none repeat scroll 0 0;border: 1px solid #D7D7D7;margin-bottom: 20px; padding: 6px;">
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
                                            <asp:Label ID="Votes" runat="server" Text="vote" CssClass="votes" />
                                        </div>
                                        <div class="bottom">
                                            <asp:LinkButton ID="VoteButton" OnClick="VoteButton_Click" CausesValidation="false"
                                                runat="server" Text="vote" />
                                            <asp:Label ID="VotedLabel" runat="Server" Text="voted" />
                                        </div>
                                    </div>
                                </td>
                                <td style="vertical-align: top;">
                                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                        <ContentTemplate>
                                            <asp:ImageButton ID="EditTitle" Style="float: left; margin: 5px;" Visible="false"
                                                CssClass="icon" CommandName="Edit" CausesValidation="False" OnClick="EditTitle_Click"
                                                ImageAlign="middle" ImageUrl="~/images/pencil.gif" BorderWidth="0px" runat="server" />
                                            <asp:Label ID="TitleLabel" Visible="false" runat="server" AssociatedControlID="TitleTextBox"
                                                meta:resourcekey="TitleLabel"></asp:Label>
                                            <asp:TextBox ID="TitleTextBox" Visible="False" Width="95%" runat="server" />
                                            <asp:RequiredFieldValidator ControlToValidate="TitleTextBox" ErrorMessage="<%$ Resources:IssueTitleRequiredErrorMessage %>"
                                                Text="<%$ Resources:SharedResources, Required %>" Display="Dynamic"  CssClass="req" runat="server"
                                                ID="TitleRequired" />
                                            <ajaxToolkit:TextBoxWatermarkExtender ID="TBWE2" runat="server" TargetControlID="TitleTextBox"
                                                WatermarkText="<%$ Resources:IssueTitleWaterMark %>" WatermarkCssClass="issueTitleWatermarked" />
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
                    on
                    <asp:Label CssClass="small" ID="lblDateCreated" runat="server" />
                </td>
                <td colspan="2" style="padding-bottom: 13px;">
                    <asp:Label ID="LastModifiedLabel" runat="server" meta:resourcekey="LastUpdateLabel"></asp:Label>
                    <asp:Label ID="Label2" runat="server" meta:resourcekey="ByLabel" Text="By" />
                    <asp:Label ID="lblLastUpdateUser" runat="server" />
                    on
                    <asp:Label ID="lblLastModified" runat="server" />
                </td>
            </tr>
        
            <tr>
                <td style="width: 15%;">
                    <asp:Label ID="StatusLabel" runat="server" AssociatedControlID="DropStatus" meta:resourcekey="StatusLabel" />
                </td>
                <td style="width: 35%;">
                    <it:PickStatus ID="DropStatus" runat="Server" DisplayDefault="true" />
                </td>
                <td style="width: 15%;">
                    <asp:Label ID="OwnerLabel" runat="server" AssociatedControlID="DropOwned" meta:resourcekey="OwnedByLabel"
                        Text="Owned By:" />
                </td>
                <td style="width: 35%;">
                    <it:PickSingleUser ID="DropOwned" DisplayDefault="True"  runat="Server" />
                    <asp:CheckBox ID="chkNotifyOwner" runat="server" Text="Notify" Checked="True"></asp:CheckBox>
                </td>
            </tr>
            <tr>
                <td style="width: 15%;">
                    <asp:Label ID="PriorityLabel" runat="server" AssociatedControlID="DropPriority" meta:resourcekey="PriorityLabel"
                        Text="Priority:" />
                </td>
                <td style="width: 35%;">
                    <it:PickPriority ID="DropPriority" DisplayDefault="true" runat="Server" />
                </td>
                <td>
                    <asp:Label ID="Label4" AssociatedControlID="DropAffectedMilestone" meta:resourcekey="AffectedMilestoneLabel"
                        runat="server" />
                </td>
                <td>
                    <it:PickMilestone ID="DropAffectedMilestone" DisplayDefault="True" runat="Server" />
                </td>
            </tr>
            <tr>
                <td style="width: 15%;">
                    <asp:Label ID="AssignedToLabel" runat="server" AssociatedControlID="DropAssignedTo"
                        meta:resourcekey="AssignedToLabel" Text="Assigned To:" />
                </td>
                <td style="width: 35%;">
                    <it:PickSingleUser ID="DropAssignedTo" DisplayUnassigned="False" DisplayDefault="True"
                        Required="false" runat="Server" />
                    <asp:CheckBox ID="chkNotifyAssignedTo" runat="server" Text="Notify" Checked="True">
                    </asp:CheckBox>
                </td>
                <td style="width: 15%;">
                    <asp:Label ID="PrivateLabel" AssociatedControlID="chkPrivate" runat="server" meta:resourcekey="PrivateLabel"
                        Text="Private:" />
                </td>
                <td style="width: 35%;">
                    <asp:CheckBox ID="chkPrivate" runat="server" />
                </td>
            </tr>
            <tr>
                <td style="width: 15%;">
                    <asp:Label ID="CategoryLabel" AssociatedControlID="DropCategory" meta:resourcekey="CategoryLabel"
                        Text="Category:" runat="server" />
                </td>
                <td style="width: 35%;">
                    <it:PickCategory ID="DropCategory" DisplayDefault="true" Required="false" runat="Server" />
                </td>
                <td style="width: 15%;">
                    <asp:Label runat="server" AssociatedControlID="DueDatePicker:DateTextBox" ID="DueDateLabel"
                        meta:resourcekey="DueDateLabel" Text="Due Date:" />
                </td>
                <td style="width: 35%;">
                    <bn:PickDate ID="DueDatePicker" runat="server" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="IssueTypeLabel" AssociatedControlID="DropIssueType:ddlType" runat="server"
                        meta:resourcekey="IssueTypeLabel" />
                </td>
                <td>
                    <it:PickType ID="DropIssueType" DisplayDefault="True"  runat="Server" />
                </td>
                <td style="width: 15%;">
                    <asp:Label ID="Label3" runat="server" AssociatedControlID="DropOwned" meta:resourcekey="ProgressLabel"
                        Text="Percent Complete:" />
                </td>
                <td style="width: 35%;">
                    <span style="float: left; margin-left: 160px;">
                        <asp:Label ID="ProgressSlider_BoundControl" runat="server" />%</span>
                    <asp:TextBox ID="ProgressSlider" runat="server" Text="0" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="MilestoneLabel" AssociatedControlID="DropMilestone" meta:resourcekey="MilestoneLabel"
                        runat="server" />
                </td>
                <td>
                    <it:PickMilestone ID="DropMilestone" DisplayDefault="True" runat="Server" />
                </td>
                <td style="width: 15%;">
                    <asp:Label ID="EstimationLabel" runat="server" Text="Estimation:" meta:resourcekey="EstimationLabel"
                        AssociatedControlID="txtEstimation" />
                </td>
                <td style="width: 35%;">
                    <asp:TextBox ID="txtEstimation" Style="text-align: right;" Width="80px" runat="server" />
                    &nbsp;<small><asp:Label ID="HoursLabel" meta:resourcekey="HoursLabel" runat="server"
                        Text="hrs"></asp:Label></small>
                    <asp:RangeValidator ID="RangeValidator2" runat="server" ErrorMessage="Estimation must be a sensible number."
                        ControlToValidate="txtEstimation" MaximumValue="999" MinimumValue="0" SetFocusOnError="True"
                        Display="Dynamic"></asp:RangeValidator>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="ResolutionLabel" runat="server" AssociatedControlID="DropResolution"
                        meta:resourcekey="ResolutionLabel" Text="Resolution:" />
                </td>
                <td>
                    <it:PickResolution ID="DropResolution" DisplayDefault="True" runat="Server" />
                </td>
                <td runat="Server" id="TimeLoggedLabel" visible="false">
                    <asp:Label ID="LoggedLabel" runat="server" meta:resourcekey="LoggedLabel" Text="Logged:" />
                </td>
                <td runat="Server" id="TimeLogged" visible="false">
                    <asp:Label ID="lblLoggedTime" runat="server" Style="text-align: right;" />&nbsp;
                    <small>
                        <asp:Label ID="Label1" meta:resourcekey="HoursLabel" runat="server" Text="hrs" /></small>
                </td>
            </tr>
        </table>
        <it:DisplayCustomFields ID="ctlCustomFields" EnableValidation="true" runat="server" />
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <p style="margin-top: 8px; padding: 8px 0 8px 0; border-top: 1px solid #CCCCCC; overflow: auto;">
                    <asp:ImageButton ID="EditDescription" Visible="false" CssClass="icon" OnClick="EditDescription_Click"
                        CausesValidation="False" CommandName="Edit" ImageUrl="~/images/pencil.gif" BorderWidth="0px"
                        runat="server" />&nbsp;<strong><asp:Label ID="DescriptionLabel" runat="server" Text="<%$ Resources:SharedResources, Description %>"></asp:Label></strong>
                </p>
                <div class="issueDescription">
                    <bn:HtmlEditor ID="DescriptionHtmlEditor" Visible="False" runat="server" />
                    <asp:Label ID="Description" Visible="True" runat="server" Text="Label"></asp:Label>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        <asp:Panel ID="pnlAddAttachment" CssClass="fieldgroup" Visible="false" runat="server">
            <p style="padding: 8px 0 8px 0;">
                <strong>
                    <asp:Label ID="lblAddAttachment" runat="server" meta:resourcekey="Attachment" Text="Attachment"></asp:Label></strong></p>
            <ol>
                <li>
                    <asp:Label ID="Label6" runat="server" Text="File:" AssociatedControlID="AspUploadFile" />
                    <asp:FileUpload ID="AspUploadFile" runat="server" />
                </li>
                <li>
                    <asp:Label ID="Label7" runat="server" Text="Description:" AssociatedControlID="AttachmentDescription" />
                    <asp:TextBox ID="AttachmentDescription" Width="350px" runat="server" />&nbsp;<span
                        style="font-style: italic; font-size: 8pt">Optional</span> </li>
            </ol>
        </asp:Panel>
    </div>
    <ajaxToolkit:SliderExtender ID="SliderExtender2" runat="server" Steps="21" TargetControlID="ProgressSlider"
        BoundControlID="ProgressSlider_BoundControl" Orientation="Horizontal" TooltipText="{0}% Complete"
        EnableHandleAnimation="true" />
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="IssueTabs" runat="Server">
    <it:IssueTabs ID="ctlIssueTabs" runat="server" Visible="False"></it:IssueTabs>
</asp:Content>

