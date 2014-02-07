<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ProjectNotifications.ascx.cs" Inherits="BugNET.Administration.Projects.UserControls.ProjectNotifications" %>
<h2><asp:literal ID="NotificationsTitle" runat="Server" meta:resourcekey="NotificationsTitle" /></h2>
<p>
     <asp:label ID="DescriptionLabel" runat="server" meta:resourcekey="DescriptionLabel" />
     <br /><br /> 
</p>
 <BN:Message ID="Message" runat="server" /> 
<div class="row">
    <div class="col-md-5">
        <asp:label ID="Label1" runat="server" Font-Bold="true" Text="<%$ Resources:AllUsers %>" />
        <asp:ListBox id="lstAllUsers" SelectionMode="Multiple" Runat="Server" CssClass="form-control" Height="150px" />
    </div>
    <div class="col-md-2 text-center" style="padding-top:50px;">
        <asp:Button Text="->"  CssClass="btn btn-default" Runat="server" id="Button1" onclick="AddUser" />
	    <br /><br />
	    <asp:Button Text="<-"  CssClass="btn btn-default" Runat="server" id="Button2" onclick="RemoveUser" />       
    </div>
    <div class="col-md-5">
        <asp:label ID="Label2" runat="server" Text="<%$ Resources:SelectedUsers %>" /> 
        <asp:ListBox id="lstSelectedUsers" SelectionMode="Multiple"  Runat="Server" CssClass="form-control" Height="150px" />
    </div>
</div>