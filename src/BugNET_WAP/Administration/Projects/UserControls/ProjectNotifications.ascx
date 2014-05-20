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
       <button ID="Button1" type="button" class="btn btn-default" onserverclick="AddUser" runat="server">
          <span class="glyphicon glyphicon-chevron-right"></span>
       </button>
       <br />
       <br />
       <button ID="Button2" type="button" class="btn btn-default" onserverclick="RemoveUser" runat="server">
          <span class="glyphicon glyphicon-chevron-left"></span>
       </button>  
    </div>
    <div class="col-md-5">
        <asp:label ID="Label2" runat="server" Font-Bold="true" Text="<%$ Resources:SelectedUsers %>" /> 
        <asp:ListBox id="lstSelectedUsers" SelectionMode="Multiple"  Runat="Server" CssClass="form-control" Height="150px" />
    </div>
</div>