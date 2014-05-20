<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="PickDate.ascx.cs" Inherits="BugNET.UserControls.PickDate" %>
<div class="input-group">
  <asp:TextBox ID="DateTextBox" runat="server" ValidationGroup="grpDate" CssClass="form-control" />
  <span class="input-group-addon"><asp:Image ID="imgCalendar" runat="Server" CssClass="icon" ImageUrl="~/images/calendar.gif" /></span>
</div>
<ajaxToolkit:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="DateTextBox"
    PopupButtonID="imgCalendar" />
<asp:CompareValidator ID="CompareValidator1" runat="server" Display="Dynamic" ControlToValidate="DateTextBox"
    ErrorMessage="<%$ Resources:InvalidDateErrorMessage %>" Text="<%$ Resources:InvalidDateErrorMessage %>" CssClass="text-danger" Operator="DataTypeCheck" Type="Date" />
