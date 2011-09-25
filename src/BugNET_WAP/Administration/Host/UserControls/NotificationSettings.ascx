<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="NotificationSettings.ascx.cs"
    Inherits="BugNET.Administration.Host.UserControls.NotificationSettings" %>
<h2>
    <asp:Literal ID="Title" runat="Server" Text="<%$ Resources:NotificationSettings %>" /></h2>
<div class="fieldgroup noborder">
    <ol>
        <li>
            <asp:Label ID="label1" runat="server" AssociatedControlID="AdminNotificationUser"
                Text="<%$ Resources:AdminNotificationUser %>" />
            <asp:DropDownList ID="AdminNotificationUser" runat="server" />
        </li>
        <li>
            <asp:Label ID="label9" runat="server" AssociatedControlID="cblNotificationTypes"
                Text="<%$ Resources:EnableNotificationTypes %>" />
            <div class="checkbox">
                <asp:CheckBoxList ID="cblNotificationTypes" RepeatLayout="Flow" RepeatDirection="Vertical"
                    TextAlign="Right" runat="server">
                </asp:CheckBoxList>
            </div>
        </li>
    </ol>
</div>
