<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="PickDate.ascx.cs" Inherits="BugNET.UserControls.PickDate" %>
<asp:TextBox ID="DateTextBox" Width="80" runat="server" ValidationGroup="grpDate" />
<asp:Image ID="imgCalendar" runat="Server" CssClass="icon" ImageUrl="~/images/calendar.gif" />
<ajaxToolkit:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="DateTextBox"
    PopupButtonID="imgCalendar" />
<asp:CompareValidator ID="CompareValidator1" runat="server" Display="Dynamic" ControlToValidate="DateTextBox"
    ErrorMessage="* Enter a valid date" Operator="DataTypeCheck" Type="Date" />
