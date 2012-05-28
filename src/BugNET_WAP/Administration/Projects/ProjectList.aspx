<%@ Page language="c#" Inherits="BugNET.Administration.Projects.ProjectList"  MasterPageFile="~/Shared/SingleColumn.master" meta:resourcekey="Page" Title="Project List" Codebehind="ProjectList.aspx.cs" %>
<asp:Content ContentPlaceHolderID="content" runat="server" ID="Content1">
    <h1 class="page-title"><asp:literal ID="ProjectListTitle" runat="Server" meta:resourcekey="ProjectListTitle"  /></h1>
    <div style="padding:0px 0 10px 0;">
        <span id="NewProject" runat="server" style="padding-right:5px; border-right:1px dotted #ccc">
            <a  href='<%= ResolveUrl("~/Administration/Projects/AddProject.aspx") %>'><img style="border:none;" src='<%= ResolveUrl("~/Images/application_add.gif") %>' class="icon" /></a>
            <asp:HyperLink ID="lnkNewProject" runat="server"  NavigateUrl="~/Administration/Projects/AddProject.aspx" meta:resourcekey="CreateNewProject" Text="[Create New Project]"/>
        </span>
        &nbsp;
        <span id="CloneProject" runat="server">
            <a href='<%= ResolveUrl("~/Administration/Projects/CloneProject.aspx") %>'><img style="border:none;" src='<%= ResolveUrl("~/Images/application_double.gif") %>' class="icon" /></a>
            <asp:HyperLink ID="lnkCloneProject" runat="server"  NavigateUrl="~/Administration/Projects/CloneProject.aspx" Text="<%$ Resources:SharedResources, CloneProject %>"/>
        </span>
        &nbsp;
        <span id="CreateCustomViews" runat="server" style="padding-left:10px; border-left: 1px dotted #ccc">
            <asp:ImageButton ID="btnGenerateCustomFieldViews" runat="server" ImageUrl="~/Images/execute_sql.png" CssClass="icon" onclick="btnGenerateCustomFieldViews_Click"/>
            <asp:LinkButton ID="lbGenerateCustomFieldViews" runat="server" Text="<%$ Resources:GenerateCustomFieldViews %>" onclick="lbGenerateCustomFieldViews_Click"/>
        </span>
    </div>
    <bn:Message ID="PageMessage" runat="server" />
	<asp:DataGrid 
        id="dgProjects" 
        Width="100%" 
        SkinID="DataGrid" 
        AllowSorting="true" 
        runat="server" 
        onitemcreated="dgProjects_ItemCreated" 
        onitemdatabound="dgProjects_ItemDataBound" 
        onsortcommand="dgProjects_SortCommand">
		<columns>
			<asp:hyperlinkcolumn DataNavigateUrlField="Id" DataNavigateUrlFormatString="EditProject.aspx?pid={0}&amp;tid=1" DataTextField="Name" HeaderText="<%$ Resources:Project %>" SortExpression="Name" />
			<asp:BoundColumn HeaderText="<%$ Resources:SharedResources, Description %>" DataField ="Description" SortExpression="Description" />
			<asp:BoundColumn HeaderText="<%$ Resources:ProjectManager %>" DataField="ManagerDisplayName" SortExpression="Manager"/>
			<asp:templatecolumn HeaderText="<%$ Resources:SharedResources, Created %>" SortExpression="Created">
				<itemtemplate>
					<asp:label id="lblCreated" runat="server"></asp:label>
				</itemtemplate>
			</asp:templatecolumn>
			<asp:BoundColumn HeaderText="<%$ Resources:CreatedBy %>" DataField="CreatorDisplayName" SortExpression="Creator"/>
			<asp:templatecolumn HeaderText="<%$ Resources:Disabled %>" SortExpression="Disabled">
				<itemtemplate>
					<asp:label id="lblActive" runat="server"></asp:label>	
				</itemtemplate>
			</asp:templatecolumn>
		</columns>
	</asp:DataGrid>
</asp:Content>
