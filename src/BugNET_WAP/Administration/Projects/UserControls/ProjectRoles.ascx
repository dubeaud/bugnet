<%@ Control Language="c#" Inherits="BugNET.Administration.Projects.UserControls.ProjectRoles" Codebehind="ProjectRoles.ascx.cs" %>

    <asp:HiddenField runat="server" ID="txtProjectID" Value="0"/>

    <asp:Label id="lblError" ForeColor="red" EnableViewState="false" runat="Server" />
    <h2><asp:literal ID="RolesTitle" runat="Server" meta:resourcekey="RolesTitle" /></h2>
	<asp:panel id="Roles" Visible="True" CssClass="myform" runat="server">
	   
	    <p class="desc">
	         <asp:label ID="DescriptionLabel" runat="server" meta:resourcekey="DescriptionLabel" />
	    </p>    
        <br />
	    <asp:GridView HorizontalAlign="Left" OnRowCommand="gvRoles_RowCommand" SkinID="GridView" ID="gvRoles" runat="server" AutoGenerateColumns="False" DataSourceID="SecurityRoles">
            <Columns>
                <asp:TemplateField>
                    <ItemStyle Width="20px" />
                    <ItemTemplate>
                        <asp:ImageButton ID="cmdEditRole" runat="server" CommandName="EditRole"  CommandArgument='<%# Eval("Id") %>' ImageUrl="~\images\pencil.gif"
                          ImageAlign="Top" />
                    </ItemTemplate>
               </asp:TemplateField>
               <asp:BoundField HeaderStyle-HorizontalAlign="Left" ItemStyle-Width="200px" DataField="Name" HeaderText="<%$ Resources:SharedResources, Name %>" />
               <asp:BoundField HeaderStyle-HorizontalAlign="Left" ItemStyle-Width="200px" DataField="Description" HeaderText="<%$ Resources:SharedResources, Description %>"  />
               <asp:CheckBoxField HeaderStyle-HorizontalAlign="Left" DataField="AutoAssign" HeaderText="Auto Assignment" meta:resourcekey="AutoAssignmentColumnHeader" />
            </Columns>
        </asp:GridView>
        <div style="margin-top:1em">
            <asp:ImageButton runat="server" OnClick="AddRole_Click" ImageUrl="~/Images/shield_add.gif" CssClass="icon" meta:resourcekey="AddNewRole" AlternateText="Add Role" ID="add" />
            <asp:LinkButton ID="cmdAddRole" OnClick="AddRole_Click" runat="server" meta:resourcekey="AddNewRole" Text="Add New Role" />
        </div>
    <asp:ObjectDataSource ID="SecurityRoles" runat="server" SelectMethod="GetByProjectId" TypeName="BugNET.BLL.RoleManager">
        <SelectParameters>
              <asp:ControlParameter ControlID="txtProjectID" Name="projectId" PropertyName="Value" Type="Int32" />
          </SelectParameters>
    </asp:ObjectDataSource>

 </asp:panel>

<asp:panel id="AddRole" CssClass="myform" Visible="False" runat="server">  
	<!--<h3> <asp:Label ID="RoleNameTitle" meta:resourcekey="RoleNameTitle" runat="server"> </asp:Label></h3>-->
	<p>
       <asp:label ID="Label6" runat="server" meta:resourcekey="NewRoleDescriptionLabel" /> 
    </p>
    
    <asp:Label ID="Label1" ForeColor="Red" runat="server"></asp:Label>
    <div class="fieldgroup" style="border:none;">  
	    <ol>
            <li>
                <asp:Label ID="Label2" CssClass="col1"  AssociatedControlID="txtRoleName"  meta:resourcekey="RoleName" runat="server" Text="Role Name:"></asp:Label>
                <asp:TextBox ID="txtRoleName" runat="server" Width="300px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvRoleName" runat="server" ControlToValidate="txtRoleName"
                    ErrorMessage="(required)" SetFocusOnError="True"></asp:RequiredFieldValidator>
            </li>
            <li>
                <asp:Label ID="Label4" AssociatedControlID="txtDescription" Text="<%$ Resources:SharedResources, Description %>" runat="server"></asp:Label>
                <asp:TextBox ID="txtDescription" TextMode="multiLine" Height="100px" Width="300px" runat="server"></asp:TextBox>
            </li>
            <li>
                <asp:Label ID="Label5" AssociatedControlID="chkAutoAssign" Text="Auto Assignment" meta:resourcekey="AutoAssignment"  runat="server"></asp:Label>
                <asp:checkbox id="chkAutoAssign" runat="server" />
            </li>
        </ol>
     </div>
    <br />
    <br />
     <h5><asp:Label ID="Label3" meta:resourcekey="PermissionsTitle" runat="server" /></h5>
     <div>
     <fieldset>
        <legend>Issue Tracking</legend>
        <ul class="permissions">
            <li><asp:checkbox  id="chkAddIssue" Text="Add issues" meta:resourcekey="AddIssues" runat="server"></asp:checkbox></li>
            <li><asp:checkbox  id="chkEditIssue" Text="Edit issues" meta:resourcekey="EditIssues" runat="server"></asp:checkbox></li>
            <li><asp:checkbox  id="chkDeleteIssue" Text="Delete issues" meta:resourcekey="DeleteIssues" runat="server"></asp:checkbox></li>
            <li><asp:checkbox  id="chkEditIssueDescription" Text="Edit issue descriptions" meta:resourcekey="EditIssueDescriptions" runat="server"></asp:checkbox></li>
            <li><asp:checkbox  id="chkEditIssueSummary" Text="Edit issue titles" meta:resourcekey="EditIssueTitles" runat="server"></asp:checkbox></li>
            <li><asp:checkbox  id="chkChangeIssueStatus" Text="Change issue status" meta:resourcekey="ChangeIssueStatus" runat="server"></asp:checkbox></li>
            <li><asp:checkbox  id="chkAddComment" Text="Add comments" meta:resourcekey="AddComments" runat="server"></asp:checkbox></li>
            <li><asp:checkbox  id="chkDeleteComment" Text="Delete comments" meta:resourcekey="DeleteComments" runat="server"></asp:checkbox></li>
            <li><asp:checkbox  id="chkEditComment" Text="Edit comments" meta:resourcekey="EditComments" runat="server"></asp:checkbox></li>
            <li><asp:checkbox  id="chkEditOwnComment" Text="Edit own comments" meta:resourcekey="EditOwnComments" runat="server"></asp:checkbox></li>
            <li><asp:checkbox  id="chkAddAttachment" Text="Add attachments" meta:resourcekey="AddAttachments" runat="server"></asp:checkbox></li>
            <li><asp:checkbox  id="chkDeleteAttachment" Text="Delete attachments" meta:resourcekey="DeleteAttachments" runat="server"></asp:checkbox></li>          
            <li><asp:checkbox  id="chkAddSubIssue" Text="Add sub issues" meta:resourcekey="AddSubIssues" runat="server"></asp:checkbox></li>
            <li><asp:checkbox  id="chkAddRelated" Text="Add related issues" meta:resourcekey="AddRelatedIssues" runat="server"></asp:checkbox></li>
            <li><asp:checkbox  id="chkAddParentIssue" Text="Add parent issues" meta:resourcekey="AddParentIssues" runat="server"></asp:checkbox></li>
            <li><asp:checkbox  id="chkDeleteSubIssue" Text="Delete sub issues" meta:resourcekey="DeleteSubIssues" runat="server"></asp:checkbox></li>
            <li><asp:checkbox  id="chkDeleteRelated" Text="Delete related issues" meta:resourcekey="DeleteRelatedIssues" runat="server"></asp:checkbox></li>
            <li><asp:checkbox  id="chkCloseIssue" Text="Close issues" meta:resourcekey="CloseIssues" runat="server"></asp:checkbox></li>
            <li><asp:checkbox  id="chkAssignIssue" Text="Assign issues" meta:resourcekey="AssignIssues" runat="server"></asp:checkbox></li>
            <li><asp:checkbox  id="chkSubscribeIssue" Text="Subscribe issues" meta:resourcekey="SubscribeIssues" runat="server"></asp:checkbox></li> 
            <li><asp:checkbox  id="chkAddTimeEntry" Text="Add time entries" meta:resourcekey="AddTimeEntries" runat="server"></asp:checkbox></li> 
            <li><asp:checkbox  id="chkDeleteTimeEntry" Text="Delete time entries" meta:resourcekey="DeleteTimeEntries" runat="server"></asp:checkbox></li>   
            <li><asp:checkbox  id="chkDeleteParentIssue" Text="Delete parent issues" meta:resourcekey="DeleteParentIssues" runat="server"></asp:checkbox></li> 
            <li><asp:checkbox  id="chkReOpenIssue" Text="Re-Open Issue" meta:resourcekey="ReOpenIssues" runat="server"></asp:checkbox></li> 
        </ul>    
     </fieldset>
     <fieldset>
         <legend><asp:literal ID="Literal1" runat="Server" Text="Queries" meta:resourcekey="Queries"></asp:literal></legend>  
        <ul class="permissions">
            <li><asp:checkbox  id="chkAddQuery" Text="Add queries" meta:resourcekey="AddQueries" runat="server"></asp:checkbox></li>
            <li><asp:checkbox  id="chkEditQuery" Text="Edit queries" meta:resourcekey="EditQueries" runat="server"></asp:checkbox></li>
            <li><asp:checkbox  id="chkDeleteQuery" Text="Delete queries" meta:resourcekey="DeleteQueries" runat="server"></asp:checkbox></li>
        </ul>
     </fieldset>
     <fieldset>
        <legend><asp:literal ID="lit1" runat="Server" Text="<%$ Resources:SharedResources,Project %>"></asp:literal></legend>
         <ul class="permissions">
            <li><asp:checkbox id="chkEditProject" Text="Edit project" meta:resourcekey="EditProject" runat="server"></asp:checkbox></li>
            <!--<li><asp:checkbox  id="Checkbox8" Text="Manage members" runat="server"></asp:checkbox></li>-->
            <li><asp:checkbox  id="chkDeleteProject" Text="Delete project" meta:resourcekey="DeleteProject" runat="server"></asp:checkbox></li>
            <li><asp:checkbox  id="chkCloneProject" Text="Clone project" meta:resourcekey="CloneProject" runat="server"></asp:checkbox></li>
            <li><asp:checkbox  id="chkCreateProject" Text="Create project" meta:resourcekey="CreateProject" runat="server"></asp:checkbox></li>
            <li><asp:checkbox  id="chkViewProjectCalendar" Text="View calendar" meta:resourcekey="ViewCalendar" runat="server"></asp:checkbox></li>
         </ul>
     </fieldset>
    <%--  <fieldset>
        <legend>Repository</legend>
         <ul class="permissions">
            <li><asp:checkbox id="Checkbox26" Text="Browse repository" runat="server"></asp:checkbox></li>
            <li><asp:checkbox id="Checkbox27" Text="Manage repository" runat="server"></asp:checkbox></li>
         </ul>
     </fieldset>--%>
     </div>
    <br />
    <br />
    <div align="center">
        <asp:ImageButton runat="server" id="ImageButton1" OnClick="cmdAddUpdateRole_Click" CssClass="icon"  ImageUrl="~/Images/disk.gif" />
        <asp:LinkButton ID="cmdAddUpdateRole" OnClick="cmdAddUpdateRole_Click" runat="server" CausesValidation="True" meta:resourcekey="AddRoleButton" Text="Add Role" />
        <asp:ImageButton runat="server" id="Image1" OnClick="cmdCancel_Click" CssClass="icon"  ImageUrl="~/Images/lt.gif" />
        <asp:LinkButton ID="cmdCancel" OnClick="cmdCancel_Click" runat="server" CausesValidation="False" Text="<%$ Resources:SharedResources, Cancel %>" />
        <asp:imagebutton runat="server" OnClick="cmdDelete_Click" id="cancel" CssClass="icon" ImageUrl="~/Images/shield_delete.gif" />
        <asp:LinkButton ID="cmdDelete" OnClick="cmdDelete_Click" runat="server" CausesValidation="False" meta:resourcekey="DeleteRoleButton" Text="Delete Role" />
    </div>
</asp:panel>
	
