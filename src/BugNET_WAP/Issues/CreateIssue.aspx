<%@ Page Title="New Issue" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeBehind="CreateIssue.aspx.cs" Inherits="BugNET.Issues.CreateIssue" Async="true" meta:resourcekey="Page" %>

<%@ Register TagPrefix="it" TagName="DisplayCustomFields" Src="~/UserControls/DisplayCustomFields.ascx" %>
<%@ Register TagPrefix="it" TagName="PickCategory" Src="~/UserControls/PickCategory.ascx" %>
<%@ Register TagPrefix="it" TagName="PickMilestone" Src="~/UserControls/PickMilestone.ascx" %>
<%@ Register TagPrefix="it" TagName="PickType" Src="~/UserControls/PickType.ascx" %>
<%@ Register TagPrefix="it" TagName="PickStatus" Src="~/UserControls/PickStatus.ascx" %>
<%@ Register TagPrefix="it" TagName="PickPriority" Src="~/UserControls/PickPriority.ascx" %>
<%@ Register TagPrefix="it" TagName="PickSingleUser" Src="~/UserControls/PickSingleUser.ascx" %>
<%@ Register TagPrefix="it" TagName="PickResolution" Src="~/UserControls/PickResolution.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
     <div class="page-header">
        <h1 class="page-title">
            <asp:Literal ID="Literal1" runat="server" Text="New Issue" /> 
            <small>
                <asp:Literal ID="litProject" runat="Server" />
                <span>(<asp:Literal ID="litProjectCode" runat="Server"></asp:Literal>)</span>
            </small>
        </h1>
    </div>
    <div class="form-horizontal" style="padding-top:2em;">
        <bn:Message ID="Message1" runat="server" Width="100%" Visible="False" />
        <div class="row">
            <div class="col-md-12">
                <div class="form-group <%= !TitleRequired.IsValid ? "has-error" : "" %>">
                    <label for="TitleTextBox" class="control-label col-sm-2">Title</label>
                    <div class="col-sm-10">
                        <asp:TextBox ID="TitleTextBox" CssClass="form-control input-lg" placeholder="<%$ Resources:SharedIssueProperties, IssueTitleWatermark %>" runat="server" />
                        <asp:RequiredFieldValidator ControlToValidate="TitleTextBox" SetFocusOnError="true" ErrorMessage="<%$ Resources:SharedIssueProperties, IssueTitleRequiredErrorMessage %>"
                            Text="<%$ Resources:SharedResources, Required %>" Display="Dynamic" CssClass="text-danger validation-error" runat="server" ID="TitleRequired" />
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6" id="StatusField" runat="server">
                <div class="form-group">
                    <asp:Label ID="StatusLabel" runat="server" CssClass="col-sm-4 control-label" AssociatedControlID="DropStatus" Text="<%$Resources:SharedIssueProperties, StatusLabel %>" />
                    <div class="col-sm-7">
                        <it:PickStatus ID="DropStatus" runat="Server" DisplayDefault="true" />
                    </div>
                </div>
            </div>
            <div class="col-md-6" id="OwnedByField" runat="server">
                <div class="form-group">
                    <asp:Label ID="OwnerLabel" CssClass="col-sm-4 control-label" runat="server" AssociatedControlID="DropOwned" Text="<%$Resources:SharedIssueProperties, OwnedByLabel %>" />
                    <div class="col-sm-6">
                        <it:PickSingleUser ID="DropOwned" DisplayDefault="True" Required="false" runat="Server" />
                    </div>
                    <div class="col-sm-2">
                        <div class="checkbox">
                            <asp:CheckBox ID="chkNotifyOwner" runat="server" Checked="True" Text="<%$ Resources:SharedIssueProperties, NotifyCheckbox %>" />
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-6" id="PriorityField" runat="server">
                <div class="form-group">
                    <asp:Label ID="PriorityLabel" runat="server" CssClass="col-sm-4 control-label" AssociatedControlID="DropPriority" Text="<%$Resources:SharedIssueProperties, PriorityLabel %>" />
                    <div class="col-sm-7">
                        <it:PickPriority ID="DropPriority" DisplayDefault="true" runat="Server" />
                    </div>
                </div>
            </div>
            <div class="col-md-6" id="AffectedMilestoneField" runat="server">
                <div class="form-group">
                    <asp:Label ID="Label4" AssociatedControlID="DropAffectedMilestone" CssClass="col-sm-4 control-label" runat="server" Text="<%$Resources:SharedIssueProperties, AffectedMilestoneLabel %>" />
                    <div class="col-sm-7">
                        <it:PickMilestone ID="DropAffectedMilestone" DisplayDefault="True" runat="Server" />
                    </div>
                </div>
            </div>
            <div class="col-md-6" id="AssignedToField" runat="server">
                <div class="form-group">
                    <asp:Label ID="AssignedToLabel" runat="server" AssociatedControlID="DropAssignedTo" CssClass="col-sm-4 control-label" Text="<%$Resources:SharedIssueProperties, AssignedToLabel %>" />
                    <div class="col-sm-6">
                        <it:PickSingleUser ID="DropAssignedTo" DisplayUnassigned="False" DisplayDefault="True" Required="false" runat="Server" />
                    </div>
                    <div class="col-sm-2">
                        <div class="checkbox">
                            <asp:CheckBox ID="chkNotifyAssignedTo" runat="server" Checked="True" Text="<%$ Resources:SharedIssueProperties, NotifyCheckbox %>" />
                        </div>
                    </div>
                </div>
            </div> 
            <div class="col-md-6" id="CategoryField" runat="server">
                <div class="form-group">
                    <asp:Label ID="CategoryLabel" AssociatedControlID="DropCategory" CssClass="col-sm-4 control-label" runat="server" Text="<%$Resources:SharedIssueProperties, CategoryLabel %>" />
                    <div class="col-sm-7">
                        <it:PickCategory ID="DropCategory" DisplayDefault="true" Required="false" runat="Server" />
                    </div>
                </div>
            </div>
            <div class="col-md-6" id="DueDateField" runat="server">
                <div class="form-group">
                    <asp:Label runat="server" CssClass="col-sm-4 control-label" AssociatedControlID="DueDatePicker:DateTextBox" ID="DueDateLabel" Text="<%$Resources:SharedIssueProperties, DueDateLabel %>" />
                    <div class="col-sm-3">
                        <bn:PickDate ID="DueDatePicker" runat="server" />
                    </div>
                </div>
            </div>
            <div class="col-md-6" id="IssueTypeField" runat="server">
                <div class="form-group">
                    <asp:Label ID="IssueTypeLabel" CssClass="col-sm-4 control-label" AssociatedControlID="DropIssueType:ddlType" runat="server" Text="<%$Resources:SharedIssueProperties, IssueTypeLabel %>" />
                    <div class="col-sm-7">
                        <it:PickType ID="DropIssueType" DisplayDefault="True" runat="Server" />
                    </div>
                </div>
            </div>
            <div class="col-md-6" id="ProgressField" runat="server">
                <div class="form-group">
                    <asp:Label ID="Label3" CssClass="col-sm-4 control-label" runat="server" AssociatedControlID="DropOwned" Text="<%$Resources:SharedIssueProperties, ProgressLabel %>" />
                    <div class="col-sm-3">
                        <div class="input-group">
                            <asp:TextBox ID="ProgressSlider" CssClass="form-control text-right" runat="server" Text="0" />
                            <span class="input-group-addon">%</span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-6" id="MilestoneField" runat="server">
                <div class="form-group">
                    <asp:Label ID="MilestoneLabel" CssClass="col-sm-4 control-label" AssociatedControlID="DropMilestone" runat="server" Text="<%$Resources:SharedIssueProperties, MilestoneLabel %>" />
                    <div class="col-sm-7">
                        <it:PickMilestone ID="DropMilestone" DisplayDefault="True" runat="Server" />
                    </div>
                </div>
            </div>
            <div class="col-md-6" id="EstimationField" runat="server">
                <div class="form-group <%= !RangeValidator2.IsValid ? "has-error" : string.Empty %>">
                    <asp:Label ID="EstimationLabel" CssClass="col-sm-4 control-label" runat="server" AssociatedControlID="txtEstimation" Text="<%$Resources:SharedIssueProperties, EstimationLabel %>" />
                    <div class="col-sm-3">
                        <div class="input-group">
                            <asp:TextBox ID="txtEstimation" CssClass="form-control text-righ " runat="server" />
                            <span class="input-group-addon"><asp:Label ID="Label1" runat="server" Text="<%$Resources:SharedIssueProperties, HoursLabel %>" /></span>
                        </div>
                        <asp:RangeValidator ID="RangeValidator2" runat="server" ErrorMessage="<%$Resources:SharedIssueProperties, EstimationValidatorMessage %>" ControlToValidate="txtEstimation"
                                MaximumValue="999" MinimumValue="0" Type="Double" SetFocusOnError="True" Text="<%$Resources:SharedIssueProperties, EstimationValidatorMessage %>" CssClass="validation-error text-danger" Display="Dynamic" />
                    </div>
                </div>
            </div>
            <div class="col-md-6" id="ResolutionField" runat="server">
                <div class="form-group">
                    <asp:Label ID="ResolutionLabel" CssClass="col-sm-4 control-label" runat="server" AssociatedControlID="DropResolution" Text="<%$Resources:SharedIssueProperties, ResolutionLabel %>" />
                    <div class="col-sm-7">
                        <it:PickResolution ID="DropResolution" DisplayDefault="True" runat="server" />
                    </div>
                </div>
            </div>
            <div class="col-md-6" id="PrivateField" runat="server">
                <div class="form-group">
                    <asp:Label ID="PrivateLabel" AssociatedControlID="chkPrivate" runat="server" CssClass="col-sm-4 control-label" Text="<%$Resources:SharedIssueProperties, PrivateLabel %>" />
                    <div class="col-sm-7">
                        <div class="checkbox">
                            <asp:CheckBox ID="chkPrivate" runat="server" />
                        </div>
                    </div>
                </div>
            </div>
            <it:DisplayCustomFields ID="ctlCustomFields" EnableValidation="true" runat="server" />
        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="form-group">
                    <label class="control-label col-sm-2">Description</label>
                    <div class="col-sm-10">
                        <bn:HtmlEditor ID="DescriptionHtmlEditor" runat="server" />
                    </div>
                </div>
            </div>
        </div>
        <asp:Panel ID="pnlAddAttachment" Visible="false" runat="server">
            <div class="row">
                <div class="col-md-12">
                    <div class="form-group">
                        <asp:Label ID="lblAddAttachment" runat="server" CssClass="col-sm-2 control-label" AssociatedControlID="AspUploadFile" meta:resourcekey="AttachmentLabel" Text="Attachment" />
                        <div class="col-sm-10">
                            <asp:FileUpload ID="AspUploadFile" runat="server" />
                        </div>
                    </div>

                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <div class="form-group">
                        <asp:Label ID="Label7" runat="server" Text="Description:" CssClass="control-label col-sm-2" AssociatedControlID="AttachmentDescription" meta:resourcekey="AttachmentDescriptionLabel" />
                        <div class="col-sm-5">
                            <asp:TextBox ID="AttachmentDescription" CssClass="form-control" runat="server" placeholder="<%$ Resources:AttachmentOptionalLocalize.Text %>" />
                        </div>
                    </div>
                </div>
            </div>
        </asp:Panel>
        <div class="row">
            <div class="col-md-12">
                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                        <asp:LinkButton ID="lnkSave" CssClass="btn btn-primary" OnClick="LnkSaveClick" runat="server" Text="<%$ Resources:SharedResources, Save %>" />
                        <asp:LinkButton ID="lnkDone"  CssClass="btn btn-primary" OnClick="LnkDoneClick" runat="server" Text="<%$ Resources:SharedIssueProperties, SaveReturnText %>" />
                        <asp:LinkButton ID="lnkCancel" CssClass="btn btn-default" OnClick="CancelButtonClick" CausesValidation="false" runat="server" Text="<%$ Resources:SharedResources, Cancel %>" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
