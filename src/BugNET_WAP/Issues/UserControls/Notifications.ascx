<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Notifications.ascx.cs" Inherits="BugNET.Issues.UserControls.Notifications" %>
 <asp:label ID="lblDescription" meta:resourcekey="lblDescription" runat="server" Text="The following person(s) receive email notifications when this issue is updated:"></asp:label>
<asp:datagrid id="NotificationsDataGrid" GridLines="None" CssClass="table table-striped"
runat="server" AutoGenerateColumns="false" ShowHeader="false">
    <Columns>	
        <asp:boundcolumn headertext="" datafield="NotificationDisplayName" />
    </Columns>
</asp:datagrid>	
<asp:Panel ID="pnlNotificationAdmin" runat="server" meta:resourcekey="pnlNotificationAdmin" GroupingText="Add Remove Notifications (Managers Only)">
    <div class="row">
        <div class="col-md-5">
            <asp:ListBox ID="lstProjectUsers" CssClass="form-control" DataTextField="DisplayName" DataValueField="Username" runat="server" Height="150px" SelectionMode="Single"></asp:ListBox>
        </div>
        <div class="col-md-2 text-center" style="padding-top: 50px;">
             <asp:Button runat="server" ID="btnAddNot" CssClass="btn btn-primary" Text="Add >>" meta:resourcekey="btnAddNot" CausesValidation="false" OnClick="btnAddNot_Click" />
            <br />
            <br />
            <asp:Button runat="server" ID="btnDelNot" Text="<< Remove" CausesValidation="false" CssClass="btn btn-primary" OnClick="btnDelNot_Click" meta:resourcekey="btnDelNot"/>
        </div>
         <div class="col-md-5">
            <asp:ListBox ID="lstNotificationUsers" CssClass="form-control"  DataTextField="NotificationDisplayName" DataValueField="NotificationUsername" runat="server" Height="150px" SelectionMode="Single"></asp:ListBox>
         </div>
    </div>
</asp:Panel>
<asp:panel ID="pnlNotifications" runat="server" style="padding:15px 15px 15px 0px;">
    <asp:Button Text="Receive Notifications" CssClass="btn btn-primary" meta:resourcekey="btnReceiveNotifications" OnClick="btnReceiveNotifications_Click" Runat="server" CausesValidation="false" id="btnReceiveNotifications" />
    &nbsp;
    <asp:Button Text="Don't Receive Notifications" CssClass="btn btn-primary" meta:resourcekey="btnDontRecieveNotfictaions" OnClick="btnDontRecieveNotfictaions_Click" CausesValidation="false"  Runat="server" id="btnDontRecieveNotfictaions" />
</asp:panel>