<%@ Control Language="c#" AutoEventWireup="True" Codebehind="NewProjectIntro.ascx.cs" Inherits="BugNET.Administration.Projects.UserControls.NewProjectIntro" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<h4><asp:literal ID="IntroTitle" runat="Server" meta:resourcekey="IntroTitle" /></h4>
<table cellpadding="10">
	<tr>
		<td>
		    <asp:label ID="DescriptionLabel" runat="server" meta:resourcekey="DescriptionLabel" />
			<br />
			<br />
			<asp:CheckBox id="chkSkip" class="checkboxlist" Text="<%$ Resources:SkipIntro %>" Runat="Server" />
		</td>
	</tr>
</table>
