<%@ Page language="c#" Inherits="BugNET.Administration.Projects.EditProject"  ValidateRequest="false" meta:resourcekey="Page" Title="Project Administration" MasterPageFile="~/Shared/TwoColumn.master" Codebehind="EditProject.aspx.cs" %>

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
        </div>
    </div>
</asp:Content>
