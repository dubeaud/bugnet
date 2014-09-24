<%@ Page Language="c#" ValidateRequest="false" Inherits="BugNET.Issues.IssueDetail" MasterPageFile="~/Site.master"
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

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="Server">
    <bn:Message ID="Message1" runat="server" Width="100%" Visible="False" />
    <div class="form-horizontal" style="padding-top: 2em;">
        <div class="row">
            <div class="col-md-12">
                <div class="col-md-8">
                    <asp:Label ID="lblIssueNumber" Font-Bold="true" runat="server"></asp:Label>
                </div>
                <div class="pull-right">
                    <asp:LinkButton ID="lnkSave" CssClass="btn btn-primary" OnClick="LnkSaveClick" runat="server" Text="<%$ Resources:SharedResources, Save %>" />
                    <asp:LinkButton ID="lnkDone" CssClass="btn btn-primary" OnClick="LnkDoneClick" runat="server" Text="<%$ Resources:SharedIssueProperties, SaveReturnText %>" />
                    <asp:LinkButton ID="lnkCancel" CssClass="btn btn-default" OnClick="CancelButtonClick" CausesValidation="false" runat="server" Text="<%$ Resources:SharedResources, Cancel %>" />
                    <asp:LinkButton ID="lnkDelete" CssClass="btn btn-danger" OnClick="LnkDeleteClick" CausesValidation="false" runat="server" Text="<%$ Resources:SharedResources, Delete %>" />
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="col-md-1" id="VoteBox" runat="server">
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                            <div class="text-center" style="padding: 0px;">
                                <asp:Label ID="IssueVoteCount" runat="server" CssClass="count" Text="1" />
                            </div>
                        </div>
                        <div class="text-center" style="padding: 5px;">
                            <asp:LinkButton ID="VoteButton" OnClick="VoteButtonClick" CausesValidation="false" runat="server" Text="vote" meta:resourcekey="VoteButton" />
                            <asp:Label ID="VotedLabel" runat="Server" Text="<%$ Resources: Voted %>" />
                        </div>
                    </div>
                </div>
                <div class="col-md-11">
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                        <ContentTemplate>
                            <asp:ImageButton ID="EditTitle" Style="float: left; margin: 5px;" Visible="false" CssClass="icon" CommandName="Edit" CausesValidation="False"
                                OnClick="EditTitleClick" ImageAlign="middle" ImageUrl="~/images/pencil.gif" BorderWidth="0px" runat="server" />
                            <asp:Label ID="TitleLabel" Visible="false" runat="server" AssociatedControlID="TitleTextBox" meta:resourcekey="TitleLabel" />
                            <asp:TextBox ID="TitleTextBox" Visible="False" CssClass="form-control" runat="server" />
                            <asp:RequiredFieldValidator ControlToValidate="TitleTextBox" ErrorMessage="<%$ Resources:SharedIssueProperties, IssueTitleRequiredErrorMessage %>"
                                Text="<%$ Resources:SharedResources, Required %>" Display="Dynamic" CssClass="validation-error text-danger" runat="server" ID="TitleRequired" />

                            <h2 style="margin-top: 5px;">
                                <asp:Label ID="DisplayTitleLabel" runat="server" Visible="True" Text="Label"></asp:Label></h2>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6">
                <div class="form-group">
                    <div class="col-sm-4 text-right">
                        <asp:Label ID="DateCreatedLabel" Font-Bold="true" runat="server" CssClass="control-label" meta:resourcekey="DateCreatedLabel"></asp:Label>
                        <asp:Label ID="ByLabel" Font-Bold="true" runat="server" meta:resourcekey="ByLabel" Text="By" />
                    </div>
                    <div class="col-sm-7">
                        <asp:Label ID="lblReporter" CssClass="form-control-static" runat="server" />
                        <asp:Label ID="Label8" runat="server" meta:resourcekey="OnLabel" Text="On" />
                        <asp:Label ID="lblDateCreated" runat="server" />
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <div class="col-sm-4 text-right">
                        <asp:Label ID="LastModifiedLabel" Font-Bold="true" runat="server" meta:resourcekey="LastUpdateLabel"></asp:Label>
                        <asp:Label ID="Label2" Font-Bold="true" runat="server" meta:resourcekey="ByLabel" Text="By" />
                    </div>
                    <div class="col-sm-7">
                        <asp:Label ID="lblLastUpdateUser" runat="server" />
                        <asp:Label ID="Label9" runat="server" meta:resourcekey="OnLabel" Text="On" />
                        <asp:Label ID="lblLastModified" runat="server" />
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6" id="StatusField" runat="server">

                <div class="form-group">
                    <asp:Label ID="StatusLabel" CssClass="col-sm-4 control-label" runat="server" AssociatedControlID="DropStatus" Text="<%$Resources:SharedIssueProperties, StatusLabel %>" />
                    <div class="col-sm-7">
                        <it:PickStatus ID="DropStatus" runat="Server" DisplayDefault="true" />
                    </div>
                </div>
            </div>
            <div class="col-md-6" id="OwnedByField" runat="server">
                <div class="form-group">
                    <asp:Label ID="OwnerLabel" CssClass="col-sm-4 control-label" runat="server" AssociatedControlID="DropOwned" Text="<%$Resources:SharedIssueProperties, OwnedByLabel %>" />
                    <div class="col-sm-7">
                        <it:PickSingleUser ID="DropOwned" DisplayDefault="True" Required="false" runat="Server" />
                    </div>
                </div>
            </div>


            <div class="col-md-6" id="PriorityField" runat="server">

                <div class="form-group">
                    <asp:Label ID="PriorityLabel" CssClass="col-sm-4 control-label" runat="server" AssociatedControlID="DropPriority" Text="<%$Resources:SharedIssueProperties, PriorityLabel %>" />
                    <div class="col-sm-7">
                        <it:PickPriority ID="DropPriority" DisplayDefault="true" runat="Server" />
                    </div>
                </div>

            </div>
            <div class="col-md-6" id="AffectedMilestoneField" runat="server">
                <div class="form-group">
                    <asp:Label ID="Label4" CssClass="col-sm-4 control-label" AssociatedControlID="DropAffectedMilestone" Text="<%$Resources:SharedIssueProperties, AffectedMilestoneLabel %>" runat="server" />
                    <div class="col-sm-7">
                        <it:PickMilestone ID="DropAffectedMilestone" DisplayDefault="True" runat="Server" />
                    </div>
                </div>
            </div>
            <div class="col-md-6" id="AssignedToField" runat="server">
                <div class="form-group">
                    <asp:Label ID="AssignedToLabel" CssClass="col-sm-4 control-label" runat="server" AssociatedControlID="DropAssignedTo" Text="<%$Resources:SharedIssueProperties, AssignedToLabel %>" />
                    <div class="col-sm-7">
                        <it:PickSingleUser ID="DropAssignedTo" DisplayUnassigned="False" DisplayDefault="True" Required="false" runat="Server" />
                    </div>
                </div>
            </div>
            
            <div class="col-md-6" id="CategoryField" runat="server">
                <div class="form-group">
                    <asp:Label ID="CategoryLabel" CssClass="col-sm-4 control-label" AssociatedControlID="DropCategory" runat="server" Text="<%$Resources:SharedIssueProperties, CategoryLabel %>" />
                    <div class="col-sm-7">
                        <it:PickCategory ID="DropCategory" DisplayDefault="true" Required="false" runat="Server" />
                    </div>
                </div>
            </div>
            <div class="col-md-6" id="DueDateField" runat="server">
                <div class="form-group">
                    <asp:Label runat="server" CssClass="col-sm-4 control-label" AssociatedControlID="DueDatePicker:DateTextBox" ID="DueDateLabel" Text="<%$Resources:SharedIssueProperties, DueDateLabel %>" />
                    <div class="col-sm-7">
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
                <div class="form-group <%= !RangeValidator2.IsValid ? "has-error" : "" %>">
                    <asp:Label ID="EstimationLabel" CssClass="col-sm-4 control-label" runat="server" AssociatedControlID="txtEstimation" Text="<%$Resources:SharedIssueProperties, EstimationLabel %>" />
                    <div class="col-sm-3">
                        <div class="input-group">
                            <asp:TextBox ID="txtEstimation" CssClass="text-right form-control" runat="server" />
                            <span class="input-group-addon">
                                <asp:Label ID="HoursLabel" runat="server" Text="<%$Resources:SharedIssueProperties, HoursLabel %>" /></span>
                        </div>
                        <asp:RangeValidator ID="RangeValidator2" runat="server" ErrorMessage="<%$Resources:SharedIssueProperties, EstimationValidatorMessage %>" ControlToValidate="txtEstimation"
                            MaximumValue="999" MinimumValue="0" Type="Double" SetFocusOnError="True" Display="Dynamic" CssClass="validation-error text-danger" />
                    </div>
                </div>
            </div>
            <div class="col-md-6" id="ResolutionField" runat="server" >
                <div class="form-group">
                    <asp:Label ID="ResolutionLabel" CssClass="col-sm-4 control-label" runat="server" AssociatedControlID="DropResolution" Text="<%$Resources:SharedIssueProperties, ResolutionLabel %>" />
                    <div class="col-sm-7">
                        <it:PickResolution ID="DropResolution" DisplayDefault="True" runat="Server" />
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <asp:Label ID="LoggedLabel" Font-Bold="true" CssClass="col-sm-4 control-label" runat="server" Text="<%$Resources:SharedIssueProperties, LoggedLabel %>" />
                    <div class="col-sm-7">
                        <asp:Label ID="lblLoggedTime" runat="server" CssClass="text-right form-control-static" />
                        <asp:Label ID="Label1" runat="server" Text="<%$Resources:SharedIssueProperties, HoursLabel %>" />
                    </div>
                </div>
            </div>
            <div class="col-md-6" id="PrivateField" runat="server">
                <div class="form-group">
                    <asp:Label ID="PrivateLabel" CssClass="col-sm-4 control-label" AssociatedControlID="chkPrivate" runat="server" Text="<%$Resources:SharedIssueProperties, PrivateLabel %>" />
                    <div class="col-sm-7">
                        <div class="checkbox">
                            <asp:CheckBox ID="chkPrivate" runat="server" />
                        </div>
                    </div>
                </div>
            </div>
            <it:DisplayCustomFields ID="ctlCustomFields" EnableValidation="true" runat="server" />
        </div>
        <hr />
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <p>
                    <asp:ImageButton ID="EditDescription" Visible="false" CssClass="icon" OnClick="EditDescriptionClick" CausesValidation="False"
                        CommandName="Edit" ImageUrl="~/images/pencil.gif" BorderWidth="0px" runat="server" />&nbsp;<strong><asp:Label ID="DescriptionLabel"
                            runat="server" Text="<%$ Resources:SharedResources, Description %>" /></strong>
                </p>
                <div class="issueDescription">
                    <bn:HtmlEditor ID="DescriptionHtmlEditor" Visible="False" runat="server" />
                    <asp:Label ID="Description" Visible="True" runat="server" Text="Label" />
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>

        <it:IssueTabs ID="ctlIssueTabs" runat="server"></it:IssueTabs>
    </div>
</asp:Content>
