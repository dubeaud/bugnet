<%@ Page Title="" Language="C#" MasterPageFile="~/Shared/TwoColumn.Master" AutoEventWireup="true" CodeBehind="EditUser.aspx.cs" Inherits="BugNET.Administration.Users.EditUser" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageTitle" runat="server">
    <h1 class="page-title"><asp:literal ID="SectionTitle" runat="Server" meta:resourcekey="SectionTitle"  /> - <asp:Literal id="litUserTitleName" runat="Server"/></h1>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Left" runat="server">
     <ul class="sideMenu">
        <asp:Repeater ID="AdminMenu" OnItemDataBound="AdminMenuItemDataBound" OnItemCommand="AdminMenuItemCommand" runat="server">
           <ItemTemplate>
                <li runat="server" id="ListItem"><asp:LinkButton ID="MenuButton" runat="server" CausesValidation="false" ></asp:LinkButton></li>
           </ItemTemplate>
        </asp:Repeater>
    </ul>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Content" runat="server">
	<div>
        <asp:PlaceHolder id="plhContent" Runat="Server" />     
    </div>
</asp:Content>
