<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="NotificationSettings.ascx.cs"
    Inherits="BugNET.Administration.Host.UserControls.NotificationSettings" %>
<h2>
    <asp:Literal ID="Title" runat="Server" Text="<%$ Resources:NotificationSettings %>" /></h2>
<div class="form-horizontal">
    <div class="form-group">
        <asp:Label ID="label1" CssClass="col-md-4 control-label" runat="server" AssociatedControlID="AdminNotificationUser"
            Text="<%$ Resources:AdminNotificationUser %>" />
        <div class="col-md-8">
            <asp:DropDownList ID="AdminNotificationUser" CssClass="form-control" runat="server" />
        </div>
    </div>
</div>
