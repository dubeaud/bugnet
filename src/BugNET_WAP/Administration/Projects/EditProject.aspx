<%@ Page language="c#" Inherits="BugNET.Administration.Projects.EditProject"  ValidateRequest="false" 
    meta:resourcekey="Page" Title="Project Administration" MasterPageFile="~/Shared/TwoColumn.master" Codebehind="EditProject.aspx.cs" Async="true" %>

<asp:Content ID="Content3" runat="server" ContentPlaceHolderID="PageTitle">
    <h1 class="page-title"><asp:literal ID="EditProjectTitle" runat="Server" meta:resourcekey="EditProjectTitle"  /> - <asp:Literal id="litProjectName" runat="Server"/></h1>
</asp:Content>

<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="Left">
     <ul class="sideMenu">
        <asp:Repeater ID="AdminMenu" OnItemDataBound="AdminMenu_ItemDataBound" OnItemCommand="AdminMenu_ItemCommand" runat="server">
           <ItemTemplate>
                <li runat="server" id="ListItem"><asp:LinkButton ID="MenuButton" runat="server" CausesValidation="false" ></asp:LinkButton></li>
           </ItemTemplate>
        </asp:Repeater>
    </ul>
</asp:Content>

<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="Content">
	<div>
	    <BN:Message ID="Message1" runat="server" Visible="False"  />
        <asp:PlaceHolder id="plhContent" Runat="Server" />     
        <div style="margin:2em 0 0 0;border-top:1px solid #ddd;padding-top:5px;clear:both;">
            <asp:ImageButton runat="server" id="Image2" onclick="SaveButton_Click" CssClass="icon"  ImageUrl="~/Images/disk.gif" />
            <asp:linkbutton id="SaveButton" runat="server"  CssClass="button" onclick="SaveButton_Click"  Text="<%$ Resources:SharedResources, Save %>" />
            &nbsp;
            <asp:imageButton runat="server" onclick="DeleteButton_Click" id="Image1" CssClass="icon"  ImageUrl="~/Images/cross.gif" />
            <asp:linkbutton id="DeleteButton" runat="server"  CssClass="button" causesvalidation="False" onclick="DeleteButton_Click" Text="<%$ Resources:DeleteProject %>" />
             &nbsp;
            <asp:imageButton runat="server" onclick="DisableButton_Click" id="DisableImage" CssClass="icon"  ImageUrl="~/Images/disable.gif" />
            <asp:linkbutton id="DisableButton" runat="server"  CssClass="button" causesvalidation="False" onclick="DisableButton_Click" Text="<%$ Resources:DisableProject %>" />
             &nbsp;
            <asp:imageButton runat="server" onclick="RestoreButton_Click" id="ImageButton1" CssClass="icon"  ImageUrl="~/Images/restore.gif" />
            <asp:linkbutton id="RestoreButton" runat="server"  CssClass="button" causesvalidation="False" onclick="RestoreButton_Click" Text="<%$ Resources:RestoreProject %>" />
            &nbsp;
            <img id="imgCloneProject" data-selector="CloneProject" alt="<%$ Resources:SharedResources, CloneProject %>" src="~/Images/application_double.gif" class="icon cursor-hand" runat="server" />
            <a href="#" id="linkCloneProject" data-selector="CloneProject" runat="server"><asp:Literal ID="Literal1" runat="Server" Text="<%$ Resources:SharedResources, CloneProject %>" /></a>             
        </div>
    </div>
    <asp:LinkButton ID="lbCloneProject" runat="server" Text="nil" Style="display: none" />
    <asp:Panel ID="pnlCloneProjectForm" runat="server" CssClass="ModalPopup" Width="50%">
        <asp:Panel ID="pnlHeader" runat="server" CssClass="ModalHeader">
            <asp:Literal ID="Literal2" runat="Server" Text="<%$ Resources:SharedResources, CloneProject %>" />
        </asp:Panel>
        <asp:Literal ID="Literal3" runat="Server" Text="<%$ Resources:SharedResources, CloneProjectInstructions %>" />
        <br />
		<asp:Label id="lblError" ForeColor="red" Font-Bold="true" EnableViewState="false" Runat="Server" />
        <br />
        <table width="100%">
            <tr>
                <td style="width: 150px"><asp:Label ID="Label1" runat="server" meta:resourcekey="ExistingProjectNameLabel"></asp:Label></td>
                <td><asp:Label ID="lblExistingProjectName" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td style="width: 150px"><asp:Label ID="Label2" runat="server" AssociatedControlID="txtNewProjectName" meta:resourcekey="NewProjectNameLabel"></asp:Label></td>
                <td><asp:TextBox id="txtNewProjectName" Runat="Server" /></td>
            </tr>
        </table>
        <br />
        <p style="text-align: center;">
            <asp:Button ID="OkButton" runat="server" OnClick="OkButton_Click" Text="<%$ Resources:SharedResources, Ok %>"  />
            <asp:Button ID="CancelButton" CausesValidation="False" runat="server" Text="<%$ Resources:SharedResources, Cancel %>" />
        </p>
    </asp:Panel>
    <ajaxToolkit:ModalPopupExtender ID="mpeCloneProject" runat="server" TargetControlID="lbCloneProject" PopupControlID="pnlCloneProjectForm"
        BackgroundCssClass="modalBackground" CancelControlID="CancelButton" DropShadow="false" BehaviorID="showCloneProject" />
    <script type="text/javascript">
    
        $(document).ready(function(){
            $('[data-selector="CloneProject"]').each(function () {
                $(this).click(function () {
                    $find('showCloneProject').show(); // $find is the ajaxcontrol toolkit version of jquery find;
                                                        // it works better with the toolkit
                    return false;
                });
            });
         });
    </script>
</asp:Content>
