<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Shared/SingleColumn.master" CodeBehind="CloneProject.aspx.cs" Title="<%$ Resources:CloneProject %>" Inherits="BugNET.Administration.Projects.CloneProject" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server">
      <h1 class="page-title"><asp:literal ID="CloneProjectTitle" runat="Server" Text="<%$ Resources:CloneProject %>" /></h1>
        <p>
            <asp:Label ID="Label9" runat="server" meta:resourcekey="DescriptionLabel"></asp:Label>
		</p>
		<asp:Label id="lblError" ForeColor="red" Font-Bold="true" EnableViewState="false" Runat="Server" />
		<div class="fieldgroup" style="border:none">  
            <ol>
                <li>
                    <asp:Label ID="Label1" runat="server" AssociatedControlID="ddlProjects" meta:resourcekey="ExistingProjectNameLabel"></asp:Label>
				    <asp:DropDownList ID="ddlProjects" DataTextField="Name"  DataValueField="Id" runat="Server"></asp:DropDownList>
                </li>
                <li>
			        <asp:Label ID="Label2" runat="server" AssociatedControlID="txtNewProjectName" meta:resourcekey="NewProjectNameLabel"></asp:Label>
					<asp:TextBox id="txtNewProjectName" Runat="Server" />
					<asp:RequiredFieldValidator ControlToValidate="txtNewProjectName" Text="<%$ Resources:SharedResources, Required %>" Runat="server" id="RequiredFieldValidator1" />
                </li>
			</ol>
		</div>
		 <div class="submit">
			<asp:Button id="btnClone" Text="<%$ Resources:CloneProject %>" Runat="Server" OnClick="btnClone_Click" />
			&nbsp;&nbsp;
			<asp:Button id="btnCancel" Text="<%$ Resources:SharedResources, Cancel %>" CausesValidation="false" OnClick="btnCancel_Click"
				Runat="Server" />
		</div>
</asp:Content>
