<%@ Page language="c#" Inherits="BugNET.Administration.Projects.AddProject" ValidateRequest="false" meta:resourcekey="Page" MasterPageFile="~/Shared/SingleColumn.master" Title="Add Project" Codebehind="AddProject.aspx.cs" %>
  
<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server">
    <h1><asp:literal ID="NewProjectTitle" runat="Server" meta:resourcekey="NewProjectTitle"  /> (<asp:Literal id="lblStepNumber" runat="Server" />)</h1>
	<div style="width:750px;margin-right:10px;padding-top:10px;">
		<asp:PlaceHolder id="plhWizardStep" runat="Server" />
		<br/>
		<br/>
		<div style="float:left">
			<asp:Button Text="<%$ Resources:SharedResources, Cancel %>"  CssClass="button" CausesValidation="false" runat="server" id="btnCancel" />
		</div>
		<div style="float:right">
			<asp:Button id="btnBack"  CssClass="button" Text="<%$ Resources:Back %>" CausesValidation="false" runat="Server" />
			&nbsp;
			<asp:Button id="btnNext"  CssClass="button" Text="<%$ Resources:Next %>" runat="Server" />
		</div>	
	</div>	
</asp:Content>
