<%@ Page language="c#" Inherits="BugNET.Administration.Projects.ProjectList"  MasterPageFile="~/Site.master" meta:resourcekey="Page" Title="Project List" Codebehind="ProjectList.aspx.cs" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server" ID="Content1">
    <div class="page-header">
        <h1 class="page-title">
            <asp:literal ID="ProjectListTitle" runat="Server" meta:resourcekey="ProjectListTitle"  />
        </h1>
    </div>
    <div style="padding:10px 0 10px 0;" class="pull-left">
        <span id="NewProject" runat="server" style="padding-right:5px; border-right:1px dotted #ccc">
            <a  href='<%= ResolveUrl("~/Administration/Projects/AddProject") %>'><img style="border:none;" src='<%= ResolveUrl("~/Images/application_add.gif") %>' class="icon" /></a>
            <asp:HyperLink ID="lnkNewProject" runat="server"  NavigateUrl="~/Administration/Projects/AddProject" meta:resourcekey="CreateNewProject" Text="[Create New Project]"/>
        </span>
        &nbsp;
        <span id="CloneProject" runat="server">
            <a href='<%= ResolveUrl("~/Administration/Projects/CloneProject") %>'><img style="border:none;" src='<%= ResolveUrl("~/Images/application_double.gif") %>' class="icon" /></a>
            <asp:HyperLink ID="lnkCloneProject" runat="server"  NavigateUrl="~/Administration/Projects/CloneProject" Text="<%$ Resources:SharedResources, CloneProject %>"/>
        </span>
        &nbsp;
        <span id="CreateCustomViews" runat="server" style="padding-left:10px; border-left: 1px dotted #ccc">
            <asp:ImageButton ID="btnGenerateCustomFieldViews" runat="server" ImageUrl="~/Images/execute_sql.png" CssClass="icon" onclick="btnGenerateCustomFieldViews_Click"/>
            <asp:LinkButton ID="lbGenerateCustomFieldViews" runat="server" Text="<%$ Resources:GenerateCustomFieldViews %>" onclick="lbGenerateCustomFieldViews_Click"/>
        </span>
    </div>
    <div style="padding:0px 0 10px 0;" class="col-md-1 pull-right">
        <asp:DropDownList ID="dropView" CssClass="form-control" AutoPostBack="True" runat="Server" OnSelectedIndexChanged="ViewSelectedIndexChanged">
            <asp:ListItem Text="All" Value="All" meta:resourcekey="ListItem1" />
            <asp:ListItem Text="Active" Value="Active" Selected="True" meta:resourcekey="ListItem2" />
            <asp:ListItem Text="Inactive" Value="Inactive" meta:resourcekey="ListItem3" />
        </asp:DropDownList>
    </div>
    <bn:Message ID="PageMessage" runat="server" />
	<asp:DataGrid 
        id="dgProjects" 
        CssClass="table table-hover table-striped" GridLines="None"
        AutoGenerateColumns="false"
        UseAccessibleHeader="true" 
        AllowSorting="true" 
        runat="server" 
        onitemcreated="dgProjects_ItemCreated" 
        onitemdatabound="dgProjects_ItemDataBound" 
        onsortcommand="dgProjects_SortCommand">
		<columns>
			<asp:hyperlinkcolumn DataNavigateUrlField="Id" DataNavigateUrlFormatString="EditProject/{0}" DataTextField="Name" HeaderText="<%$ Resources:Project %>" SortExpression="Name" />
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
