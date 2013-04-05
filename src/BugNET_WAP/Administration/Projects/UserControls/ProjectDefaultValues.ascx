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
 <div style="background: #F1F2EC none repeat scroll 0 0; border: 1px solid #D7D7D7;
        margin-bottom: 20px; padding: 6px;">
        
    <script type="text/javascript">
        $(document).ready(function () {
            $('.dateField').datepick({ showOn: 'button',
                buttonImageOnly: true, buttonImage: '<%=ResolveUrl("~/Images/calendar.gif")%>'
            });
        });
    </script>

    <table width="100%" class="issue-detail">
        <tr>
            <td style="width: 15%;">
                <asp:Label ID="StatusLabel" runat="server" AssociatedControlID="DropStatus" Text="Status" />
            </td>
            <td style="width: 35%;">
                <it:PickStatus ID="DropStatus" runat="Server"  DisplayDefault="true" />
                <asp:CheckBox ID="chkStatusVisibility" runat="server" Text="Visibility" Checked="True"></asp:CheckBox>
            </td>                       
            <td style="width: 15%;">
                <asp:Label ID="OwnerLabel" runat="server" AssociatedControlID="DropOwned" meta:resourcekey="OwnedByLabel"
                    Text="Owned By:" />
            </td>
            <td style="width: 25%;">
                <it:PickSingleUser ID="DropOwned" DisplayDefault="True" Required="False" runat="Server" />
                <asp:CheckBox ID="chkOwnedByVisibility" runat="server" Text="Visibility" Checked="True"></asp:CheckBox>
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
                <asp:CheckBox ID="chkPriorityVisibility" runat="server" Text="Visibility" Checked="True"></asp:CheckBox>
            </td>
            <td>
                <asp:Label ID="Label4" AssociatedControlID="DropAffectedMilestone" Text="Affected Milestone"
                    runat="server" />
            </td>
            <td>
                <it:PickMilestone ID="DropAffectedMilestone" DisplayDefault="True" runat="Server" />
                <asp:CheckBox ID="chkAffectedMilestoneVisibility" runat="server" Text="Visibility" Checked="True"></asp:CheckBox>
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
                <asp:CheckBox ID="chkAssignedToVisibility" runat="server" Text="Visibility" Checked="True"></asp:CheckBox>
                <asp:CheckBox ID="chkNotifyAssignedTo" runat="server" Text="Notify" Checked="True">
                </asp:CheckBox>
            </td>
            <td style="width: 15%;">
                <asp:Label ID="PrivateLabel" AssociatedControlID="chkPrivate" runat="server" meta:resourcekey="PrivateLabel"
                    Text="Private:" />
            </td>
            <td style="width: 35%;">
                <asp:CheckBox ID="chkPrivate" runat="server" />
                <asp:CheckBox ID="chkPrivateVisibility" runat="server" Text="Visibility" Checked="True"></asp:CheckBox>
            </td>
        </tr>
        <tr>
            <td style="width: 15%;">
                <asp:Label ID="CategoryLabel" AssociatedControlID="DropCategory" meta:resourcekey="CategoryLabel"
                    Text="Category:" runat="server" />
            </td>
            <td style="width: 35%;">
                <it:PickCategory ID="DropCategory" DisplayDefault="true" Required="false" runat="Server" />
                <asp:CheckBox ID="chkCategoryVisibility" runat="server" Text="Visibility" Checked="True"></asp:CheckBox>
            </td>
            <td style="width: 15%;">
                <asp:Label runat="server" AssociatedControlID="DueDate" ID="DueDateLabel" meta:resourcekey="DueDateLabel"
                    Text="Due Date:" />
            </td>
            <td style="width: 35%;">
                <asp:TextBox ID="DueDate" Width="40" Style="text-align: right;" runat="server"></asp:TextBox>
                <asp:Label runat="server" AssociatedControlID="DueDate" ID="days" 
                    Text="days" />
                <asp:CheckBox ID="chkDueDateVisibility" runat="server" Text="Visibility" Checked="True"></asp:CheckBox>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="IssueTypeLabel"  AssociatedControlID="DropIssueType" runat="server"
                    Text="Type" />
            </td>
            <td>
                <it:PickType ID="DropIssueType" DisplayDefault="True"  runat="Server" />
                <asp:CheckBox ID="chkTypeVisibility" runat="server" Text="Visibility" Checked="True"></asp:CheckBox>
            </td>
            <td style="width: 15%;">
                <asp:Label ID="Label3" runat="server" AssociatedControlID="DropOwned" meta:resourcekey="ProgressLabel"
                    Text="Percent Complete:" />
            </td>
            <td style="width: 35%;">
                <span style="float: left; margin-left: 160px;">
                    <asp:Label ID="ProgressSlider_BoundControl" runat="server" />%                        
                    <asp:CheckBox ID="chkPercentCompleteVisibility" runat="server" Text="Visibility" Checked="True"></asp:CheckBox>
                </span>
                <asp:TextBox ID="ProgressSlider" runat="server" Text="0" />
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="MilestoneLabel" AssociatedControlID="DropMilestone" Text="Milestone"
                    runat="server" />
            </td>
            <td>
                <it:PickMilestone ID="DropMilestone" DisplayDefault="True" runat="Server" />
                <asp:CheckBox ID="chkMilestoneVisibility" runat="server" Text="Visibility" Checked="True"></asp:CheckBox>
            </td>
            <td style="width: 15%;">
                <asp:Label ID="EstimationLabel" runat="server" Text="Estimation:" meta:resourcekey="EstimationLabel"
                    AssociatedControlID="txtEstimation" />
            </td>
            <td style="width: 35%;">
                <asp:TextBox ID="txtEstimation" Style="text-align: right;" Width="80px" runat="server" />
                &nbsp;<small><asp:Label ID="HoursLabel" meta:resourcekey="HoursLabel" runat="server"
                    Text="hrs"></asp:Label></small>
                    <asp:CheckBox ID="chkEstimationVisibility" runat="server" Text="Visibility" Checked="True"></asp:CheckBox>
                <asp:RangeValidator ID="RangeValidator2" runat="server" ErrorMessage="Estimation must be a sensible number."
                    ControlToValidate="txtEstimation" MaximumValue="999" MinimumValue="0" Display="Dynamic" SetFocusOnError="True"></asp:RangeValidator>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="ResolutionLabel" runat="server" AssociatedControlID="DropResolution"
                    meta:resourcekey="ResolutionLabel" Text="Resolution:" />
            </td>
            <td>
                <it:PickResolution ID="DropResolution" DisplayDefault="True" runat="Server" />
                <asp:CheckBox ID="chkResolutionVisibility" runat="server" Text="Visibility" Checked="True"></asp:CheckBox>
            </td>
            <td runat="Server" id="TimeLoggedLabel" visible="false">
                <asp:Label ID="LoggedLabel" runat="server" meta:resourcekey="LoggedLabel" Text="Logged:" />
            </td>
            <td runat="Server" id="TimeLogged" visible="false">
                <asp:Label ID="lblLoggedTime" runat="server" Style="text-align: right;" />&nbsp;
                <small>
                    <asp:Label ID="Label2" meta:resourcekey="HoursLabel" runat="server" Text="hrs" /></small>
            </td>
        </tr>
    </table>

    <ajaxToolkit:SliderExtender ID="SliderExtender2" runat="server" Steps="21" TargetControlID="ProgressSlider"
        BoundControlID="ProgressSlider_BoundControl" Orientation="Horizontal" TooltipText="{0}% Complete"
        EnableHandleAnimation="true" />
</div>

