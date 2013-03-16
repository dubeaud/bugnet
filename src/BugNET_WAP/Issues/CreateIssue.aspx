<%@ Page Title="New Issue" Language="C#" MasterPageFile="~/Shared/IssueDetail.master" AutoEventWireup="true" CodeBehind="CreateIssue.aspx.cs" Inherits="BugNET.Issues.CreateIssue" Async="true" %>

<%@ Register TagPrefix="it" TagName="DisplayCustomFields" Src="~/UserControls/DisplayCustomFields.ascx" %>
<%@ Register TagPrefix="it" TagName="PickCategory" Src="~/UserControls/PickCategory.ascx" %>
<%@ Register TagPrefix="it" TagName="PickMilestone" Src="~/UserControls/PickMilestone.ascx" %>
<%@ Register TagPrefix="it" TagName="PickType" Src="~/UserControls/PickType.ascx" %>
<%@ Register TagPrefix="it" TagName="PickStatus" Src="~/UserControls/PickStatus.ascx" %>
<%@ Register TagPrefix="it" TagName="PickPriority" Src="~/UserControls/PickPriority.ascx" %>
<%@ Register TagPrefix="it" TagName="PickSingleUser" Src="~/UserControls/PickSingleUser.ascx" %>
<%@ Register TagPrefix="it" TagName="PickResolution" Src="~/UserControls/PickResolution.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="IssueHeader" runat="Server">
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
                        <asp:ImageButton ID="imgDone" OnClick="LnkDoneClick" runat="server" CssClass="icon" ImageUrl="~\images\disk.gif" alternatetext="<%$ Resources:SaveReturn.Text %>" />
                        <asp:LinkButton ID="lnkDone" OnClick="LnkDoneClick" runat="server" meta:resourcekey="SaveReturn" Text="Save &amp; Return" />
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
            <asp:Label ID="IssueLabel" Font-Size="12px" runat="server" Text="Issue:" meta:resourcekey="IssueLabel" />
            <asp:Label ID="lblIssueNumber" Font-Size="12px" runat="server"></asp:Label>
        </div>
    </asp:Panel>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="IssueFields" runat="Server">
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
                                            <asp:Label ID="VotedLabel" runat="Server" Text="<%$ Resources: Voted %>" />
                                        </div>
                                    </div>
                                </td>
                                <td style="vertical-align: top;"> 
                                    <asp:Label ID="TitleLabel" runat="server" AssociatedControlID="TitleTextBox" meta:resourcekey="TitleLabel"></asp:Label>
                                    <asp:TextBox ID="TitleTextBox" Width="95%" runat="server" />
                                    <asp:RequiredFieldValidator ControlToValidate="TitleTextBox" ErrorMessage="<%$ Resources:IssueTitleRequiredErrorMessage %>"
                                                Text="<%$ Resources:SharedResources, Required %>" Display="Dynamic" CssClass="req" runat="server" ID="TitleRequired" />
                                    <ajaxToolkit:TextBoxWatermarkExtender ID="TBWE2" runat="server" TargetControlID="TitleTextBox" WatermarkText="<%$ Resources:IssueTitleWaterMark %>"
                                                WatermarkCssClass="issueTitleWatermarked" />
                                </td>
                            </tr>
                        </tbody>
                    </table>
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
                    <asp:Label ID="OwnerLabel" runat="server" AssociatedControlID="DropOwned" meta:resourcekey="OwnedByLabel" Text="Owned By:" />
                </td>
                <td style="width: 35%;">
                    <it:PickSingleUser ID="DropOwned" DisplayDefault="True" Required="false" runat="Server" />
                    <asp:CheckBox ID="chkNotifyOwner" runat="server" Text="Notify" Checked="True" meta:resourceKey="NotifyCheckBox"></asp:CheckBox>
                </td>
            </tr>
            <tr>
                <td style="width: 15%;">
                    <asp:Label ID="PriorityLabel" runat="server" AssociatedControlID="DropPriority" meta:resourcekey="PriorityLabel" Text="Priority:" />
                </td>
                <td style="width: 35%;">
                    <it:PickPriority ID="DropPriority" DisplayDefault="true" runat="Server" />
                </td>
                <td>
                    <asp:Label ID="Label4" AssociatedControlID="DropAffectedMilestone" meta:resourcekey="AffectedMilestoneLabel" runat="server" />
                </td>
                <td>
                    <it:PickMilestone ID="DropAffectedMilestone" DisplayDefault="True" runat="Server" />
                </td>
            </tr>
            <tr>
                <td style="width: 15%;">
                    <asp:Label ID="AssignedToLabel" runat="server" AssociatedControlID="DropAssignedTo" meta:resourcekey="AssignedToLabel" Text="Assigned To:" />
                </td>
                <td style="width: 35%;">
                    <it:PickSingleUser ID="DropAssignedTo" DisplayUnassigned="False" DisplayDefault="True" Required="false" runat="Server" />
                    <asp:CheckBox ID="chkNotifyAssignedTo" runat="server" Text="Notify" Checked="True" meta:resourceKey="NotifyCheckBox"></asp:CheckBox>
                </td>
                <td style="width: 15%;">
                    <asp:Label ID="PrivateLabel" AssociatedControlID="chkPrivate" runat="server" meta:resourcekey="PrivateLabel" Text="Private:" />
                </td>
                <td style="width: 35%;">
                    <asp:CheckBox ID="chkPrivate" runat="server" />
                </td>
            </tr>
            <tr>
                <td style="width: 15%;">
                    <asp:Label ID="CategoryLabel" AssociatedControlID="DropCategory" meta:resourcekey="CategoryLabel" Text="Category:" runat="server" />
                </td>
                <td style="width: 35%;">
                    <it:PickCategory ID="DropCategory" DisplayDefault="true" Required="false" runat="Server" />
                </td>
                <td style="width: 15%;">
                    <asp:Label runat="server" AssociatedControlID="DueDatePicker:DateTextBox" ID="DueDateLabel" meta:resourcekey="DueDateLabel"
                        Text="Due Date:" />
                </td>
                <td style="width: 35%;">
                    <bn:PickDate ID="DueDatePicker" runat="server" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="IssueTypeLabel" AssociatedControlID="DropIssueType:ddlType" runat="server" meta:resourcekey="IssueTypeLabel" />
                </td>
                <td>
                    <it:PickType ID="DropIssueType" DisplayDefault="True" runat="Server" />
                </td>
                <td style="width: 15%;">
                    <asp:Label ID="Label3" runat="server" AssociatedControlID="DropOwned" meta:resourcekey="ProgressLabel" Text="Percent Complete:" />
                </td>
                <td style="width: 35%;">
                    <span style="float: left; margin-left: 160px;">
                        <asp:Label ID="ProgressSlider_BoundControl" runat="server" />%</span>
                    <asp:TextBox ID="ProgressSlider" runat="server" Text="0" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="MilestoneLabel" AssociatedControlID="DropMilestone" meta:resourcekey="MilestoneLabel" runat="server" />
                </td>
                <td>
                    <it:PickMilestone ID="DropMilestone" DisplayDefault="True" runat="Server" />
                </td>
                <td style="width: 15%;">
                    <asp:Label ID="EstimationLabel" runat="server" Text="Estimation:" meta:resourcekey="EstimationLabel" AssociatedControlID="txtEstimation" />
                </td>
                <td style="width: 35%;">
                    <asp:TextBox ID="txtEstimation" Style="text-align: right;" Width="80px" runat="server" />
                    &nbsp;<small><asp:Label ID="HoursLabel" meta:resourcekey="HoursLabel" runat="server" Text="hrs"></asp:Label></small>
                    <asp:RangeValidator ID="RangeValidator2" runat="server" ErrorMessage="Estimation must be a sensible number." ControlToValidate="txtEstimation"
                        MaximumValue="999" MinimumValue="0" SetFocusOnError="True" Display="Dynamic"></asp:RangeValidator>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="ResolutionLabel" runat="server" AssociatedControlID="DropResolution" meta:resourcekey="ResolutionLabel" Text="Resolution:" />
                </td>
                <td>
                    <it:PickResolution ID="DropResolution" DisplayDefault="True" runat="Server" />
                </td>
                <td runat="Server" id="TimeLoggedLabel" visible="false">
                    <asp:Label ID="LoggedLabel" runat="server" meta:resourcekey="LoggedLabel" Text="Logged:" />
                </td>
                <td runat="Server" id="TimeLogged" visible="false">
                    <asp:Label ID="lblLoggedTime" runat="server" Style="text-align: right;" />&nbsp; <small>
                        <asp:Label ID="Label1" meta:resourcekey="HoursLabel" runat="server" Text="hrs" /></small>
                </td>
            </tr>
        </table>
        <it:DisplayCustomFields ID="ctlCustomFields" EnableValidation="true" runat="server" />
        <div class="issueDescription">
            <bn:HtmlEditor ID="DescriptionHtmlEditor" runat="server" />
        </div>
        <asp:Panel ID="pnlAddAttachment" CssClass="fieldgroup" Visible="false" runat="server">
            <p style="padding: 8px 0 8px 0;">
                <strong>
                    <asp:Label ID="lblAddAttachment" runat="server" meta:resourcekey="Attachment" Text="Attachment"></asp:Label></strong></p>
            <ol>
                <li>
                    <asp:Label ID="Label6" runat="server" Text="File:" AssociatedControlID="AspUploadFile" meta:resourcekey="AttachmentFileLabel" />
                    <asp:FileUpload ID="AspUploadFile" runat="server" />
                </li>
                <li>
                    <asp:Label ID="Label7" runat="server" Text="Description:" AssociatedControlID="AttachmentDescription" meta:resourcekey="AttachmentDescriptionLabel"/>
                    <asp:TextBox ID="AttachmentDescription" Width="350px" runat="server" />&nbsp;<span style="font-style: italic; font-size: 8pt"><asp:Localize ID="Localize1" runat="server" Text="Optional" meta:resourcekey="AttachmentOptionalLocalize" /></span>
                </li>
            </ol>
        </asp:Panel>
    </div>
    <ajaxToolkit:SliderExtender ID="SliderExtender2" runat="server" Steps="21" TargetControlID="ProgressSlider" BoundControlID="ProgressSlider_BoundControl"
        Orientation="Horizontal" TooltipText="{0}% Complete" EnableHandleAnimation="true"  meta:resourcekey="ProgressSlider"/>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="IssueTabs" runat="server">
</asp:Content>
