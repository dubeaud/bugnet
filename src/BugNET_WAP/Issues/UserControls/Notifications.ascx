<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Notifications.ascx.cs" Inherits="BugNET.Issues.UserControls.Notifications" %>
 <asp:label ID="lblDescription" meta:resourcekey="lblDescription" runat="server" Text="The following person(s) receive email notifications when this issue is updated:"></asp:label>
<asp:datagrid id="NotificationsDataGrid"  SkinID="DataGrid" width="600" style="margin-left:15px;margin-top:1px;" 
runat="server" AutoGenerateColumns="false" ShowHeader="false">
    <Columns>	
        <asp:boundcolumn headertext="" datafield="NotificationDisplayName" />
    </Columns>
</asp:datagrid>	
<asp:Panel ID="pnlNotificationAdmin" runat="server" meta:resourcekey="pnlNotificationAdmin" GroupingText="Add Remove Notifications (Managers Only)">
    <table style="padding:15px">
        <tr>
            <td rowspan="3">
                <asp:ListBox ID="lstProjectUsers" DataTextField="DisplayName" DataValueField="Username" runat="server" Rows="5" Width="170" SelectionMode="Single"></asp:ListBox>
            </td>
            <td>
                <asp:Button runat="server" ID="btnAddNot" Text="Add >>" meta:resourcekey="btnAddNot" style="border:1px outset;width:100px;" CausesValidation="false" OnClick="btnAddNot_Click" />
            </td>
            <td rowspan="3">
                <asp:ListBox ID="lstNotificationUsers"  DataTextField="NotificationDisplayName" DataValueField="NotificationUsername" runat="server" Rows="5" Width="170" SelectionMode="Single"></asp:ListBox>
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr>
            <td>
                <asp:Button runat="server" ID="btnDelNot" Text="<< Remove" CausesValidation="false" style="border:1px outset;width:100px;" OnClick="btnDelNot_Click" meta:resourcekey="btnDelNot"/>
            </td>
        </tr>
    </table>
</asp:Panel>
<asp:panel ID="pnlNotifications" runat="server" style="padding:15px 15px 15px 0px;">
    <asp:Button Text="Receive Notifications" meta:resourcekey="btnReceiveNotifications" OnClick="btnReceiveNotifications_Click" Runat="server" CausesValidation="false" id="btnReceiveNotifications" />
    &nbsp;
    <asp:Button Text="Don't Receive Notifications" meta:resourcekey="btnDontRecieveNotfictaions" OnClick="btnDontRecieveNotfictaions_Click" CausesValidation="false"  Runat="server" id="btnDontRecieveNotfictaions" />
</asp:panel>