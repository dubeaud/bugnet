<%@ Control Language="c#" AutoEventWireup="True" Codebehind="NewProjectSummary.ascx.cs" Inherits="BugNET.Administration.Projects.UserControls.NewProjectSummary" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<h4><asp:literal ID="SummaryTitle" runat="Server" Text="<%$ Resources:Summary %>" /></h4>
<table cellpadding="20">
	<tr>
		<td>
			 <asp:label ID="DescriptionLabel" runat="server" meta:resourcekey="DescriptionLabel" />
		</td>
	</tr>
</table>