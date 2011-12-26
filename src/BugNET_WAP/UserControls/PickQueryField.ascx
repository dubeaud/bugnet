<%@ Control Language="c#" ClassName="PickQueryField" CodeBehind="PickQueryField.ascx.cs" AutoEventWireup="True" Inherits="BugNET.UserControls.PickQueryField" %>
<%@ Register TagPrefix="bn" TagName="PickDate" Src="~/UserControls/PickDate.ascx" %>
<tr>
	<td>
		<asp:DropDownList id="dropBooleanOperator" runat="Server">
			<asp:ListItem Text="AND" />
            <asp:ListItem Text="AND (" />
			<asp:ListItem Text="OR" />
            <asp:ListItem Text="OR (" />
			<asp:ListItem Text="AND NOT" />
			<asp:ListItem Text="OR NOT" />
            <asp:ListItem Text=")" />
		</asp:DropDownList>
	</td>
	<td>
		<asp:DropDownList id="dropField" AutoPostBack="True" Runat="Server" onselectedindexchanged="dropFieldSelectedIndexChanged">
			<asp:ListItem Text="-- Select Field --" value="0" />
			<asp:ListItem Text="Issue Id" value="IssueId" />
			<asp:ListItem Text="Title" value="IssueTitle" />
			<asp:ListItem Text="Description" value="IssueDescription" />
			<asp:ListItem Text="Type" value="IssueTypeId" />
			<asp:ListItem Text="Category" value="IssueCategoryId" />
			<asp:ListItem Text="Priority" value="IssuePriorityId" />
			<asp:ListItem Text="Milestone" value="IssueMilestoneId" />
			<asp:ListItem Text="Status" value="IssueStatusId" />
			<asp:ListItem Text="Assigned" value="IssueAssignedUserId" />
			<asp:ListItem Text="Owner" value="IssueOwnerUserId" />
			<asp:ListItem Text="Creator" value="IssueCreatorUserId" />
			<asp:ListItem Text="Date Created" value="DateCreated" />
			<asp:ListItem Text="Last Update" value="LastUpdate" />
		    <asp:ListItem Text="Resolution" value="IssueResolutionId" />
		    <asp:ListItem Text="Affected Milestone" value="IssueAffectedMilestoneId" />
		    <asp:ListItem Text="Due Date" value="IssueDueDate" />
		    <asp:ListItem Text="Votes" Value="IssueVotes" />
			<asp:ListItem Text="Custom Fields" Value="CustomFieldName" /> 			 
		</asp:DropDownList>
	</td>
	<td>
		<asp:DropDownList id="dropComparisonOperator" Runat="Server">
			<asp:ListItem Text="EQUALS" Value="=" />
            <asp:ListItem Text="NOT EQUALS" Value="<>" />
			<asp:ListItem Text="LIKE" Value="LIKE" />
			<asp:ListItem Text="GREATER THAN" Value="&gt;" />
			<asp:ListItem Text="LESS THAN" Value="&lt;" />
		</asp:DropDownList>
	</td>
	<td>
		<asp:DropDownList id="dropValue" Runat="Server" />
		<asp:TextBox id="txtValue" Visible="false" Runat="Server" />
	    <bn:PickDate ID="DateValue" runat="server" Visible="false" />
	</td>
</tr>
