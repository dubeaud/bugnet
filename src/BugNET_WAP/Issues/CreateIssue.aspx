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
                                    <asp:TextBox ID="TitleTextBox" Width="100%" runat="server" />
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
        </table>
        <div class="issue-form" style="margin-left:4px;width:96%">
            <div class="grid_1">
               <asp:Label ID="StatusLabel" runat="server" AssociatedControlID="DropStatus" meta:resourcekey="StatusLabel" />
            </div>
            <div class="grid_2">
                <it:PickStatus ID="DropStatus" runat="Server" DisplayDefault="true" />
            </div>
            <div class="grid_3">
                <asp:Label ID="OwnerLabel" runat="server" AssociatedControlID="DropOwned" meta:resourcekey="OwnedByLabel" Text="Owned By:" />
            </div>
            <div class="grid_4">
               <it:PickSingleUser ID="DropOwned" DisplayDefault="True" Required="false" runat="Server" />
                <asp:CheckBox ID="chkNotifyOwner" runat="server" Text="Notify" Checked="True" meta:resourceKey="NotifyCheckBox"></asp:CheckBox>
            </div>
            <div class="grid_1">
                <asp:Label ID="PriorityLabel" runat="server" AssociatedControlID="DropPriority" meta:resourcekey="PriorityLabel" Text="Priority:" />
            </div>
            <div class="grid_2">
                <it:PickPriority ID="DropPriority" DisplayDefault="true" runat="Server" />
            </div>
            <div class="grid_3">
                <asp:Label ID="Label4" AssociatedControlID="DropAffectedMilestone" meta:resourcekey="AffectedMilestoneLabel" runat="server" />
            </div>
            <div class="grid_4">
                 <it:PickMilestone ID="DropAffectedMilestone" DisplayDefault="True" runat="Server" />
            </div>
            <div class="grid_1">
                <asp:Label ID="AssignedToLabel" runat="server" AssociatedControlID="DropAssignedTo" meta:resourcekey="AssignedToLabel" Text="Assigned To:" />
            </div>
            <div class="grid_2">
                <it:PickSingleUser ID="DropAssignedTo" DisplayUnassigned="False" DisplayDefault="True" Required="false" runat="Server" />
                <asp:CheckBox ID="chkNotifyAssignedTo" runat="server" Text="Notify" Checked="True" meta:resourceKey="NotifyCheckBox"></asp:CheckBox>
            </div>
             <div class="grid_3">
                <asp:Label ID="PrivateLabel" AssociatedControlID="chkPrivate" runat="server" meta:resourcekey="PrivateLabel" Text="Private:" />
            </div>
            <div class="grid_4"><asp:CheckBox ID="chkPrivate" runat="server" CssClass="checkbox" /></div>
            <div class="grid_1">
                <asp:Label ID="CategoryLabel" AssociatedControlID="DropCategory" meta:resourcekey="CategoryLabel" Text="Category:" runat="server" />
            </div>
            <div class="grid_2">
                  <it:PickCategory ID="DropCategory" DisplayDefault="true" Required="false" runat="Server" />
            </div>

            <div class="grid_3">
                <asp:Label runat="server" AssociatedControlID="DueDatePicker:DateTextBox" ID="DueDateLabel" meta:resourcekey="DueDateLabel"
                            Text="Due Date:" />
            </div>
            <div class="grid_4">
                  <bn:PickDate ID="DueDatePicker" runat="server" />
            </div>
            <div class="grid_1">
                <asp:Label ID="IssueTypeLabel" AssociatedControlID="DropIssueType:ddlType" runat="server" meta:resourcekey="IssueTypeLabel" />
            </div>
            <div class="grid_2">
                 <it:PickType ID="DropIssueType" DisplayDefault="True" runat="Server" />
            </div>
            <div class="grid_3">
                <asp:Label ID="Label3" runat="server" AssociatedControlID="DropOwned" meta:resourcekey="ProgressLabel" Text="Percent Complete:" />
            </div>
            <div class="grid_4">
                <span class="float-left" style="margin-left:160px;" id="PercentLabel" runat="server">
                    <asp:Label ID="ProgressSlider_BoundControl" runat="server" />%</span>
                <asp:TextBox ID="ProgressSlider" runat="server" Text="0" />
            </div>
            <div class="grid_1">
                <asp:Label ID="MilestoneLabel" AssociatedControlID="DropMilestone" meta:resourcekey="MilestoneLabel" runat="server" />
            </div>
            <div class="grid_2">
                 <it:PickMilestone ID="DropMilestone" DisplayDefault="True" runat="Server" />
            </div>
            <div class="grid_3">
                <asp:Label ID="EstimationLabel" runat="server" Text="Estimation:" meta:resourcekey="EstimationLabel" AssociatedControlID="txtEstimation" />
            </div>
            <div class="grid_4">
                <asp:TextBox ID="txtEstimation" Style="text-align: right;" Width="80px" runat="server" /><small><asp:Label ID="HoursLabel" meta:resourcekey="HoursLabel" runat="server" Text="hrs"></asp:Label></small>
                <asp:RangeValidator ID="RangeValidator2" runat="server" ErrorMessage="Estimation must be a sensible number." ControlToValidate="txtEstimation"
                            MaximumValue="999" MinimumValue="0" SetFocusOnError="True" Display="Dynamic"></asp:RangeValidator>
            </div>
            <div class="grid_1">
                <asp:Label ID="ResolutionLabel" runat="server" AssociatedControlID="DropResolution" meta:resourcekey="ResolutionLabel" Text="Resolution:" />
            </div>
            <div class="grid_2">
                <it:PickResolution ID="DropResolution" DisplayDefault="True" runat="Server" />
            </div>
            <div class="grid_3">
                <asp:Label ID="LoggedLabel" runat="server" meta:resourcekey="LoggedLabel" Text="Logged:" />
            </div>
            <div class="grid_4">
                 <asp:Label ID="lblLoggedTime" runat="server" Style="text-align: right;" /><small>
                <asp:Label ID="Label1" meta:resourcekey="HoursLabel" runat="server" Text="hrs" /></small>
            </div>
        </div>
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
