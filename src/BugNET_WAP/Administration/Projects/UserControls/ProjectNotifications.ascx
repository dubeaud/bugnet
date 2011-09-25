<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ProjectNotifications.ascx.cs" Inherits="BugNET.Administration.Projects.UserControls.ProjectNotifications" %>
<h2><asp:literal ID="NotificationsTitle" runat="Server" meta:resourcekey="NotificationsTitle" /></h2>
<p>
     <asp:label ID="DescriptionLabel" runat="server" meta:resourcekey="DescriptionLabel" />
     <br /><br /> 
</p>
 <BN:Message ID="Message" runat="server" /> 
  <table>
    <tr>
        <td style="font-weight:bold"><asp:label ID="Label1" runat="server" Text="<%$ Resources:AllUsers %>" /> </td>
        <td>&nbsp;</td>
        <td style="font-weight:bold"><asp:label ID="Label2" runat="server" Text="<%$ Resources:SelectedUsers %>" /> </td>
    </tr>
    <tr>
        <td style="height: 108px">
	        <asp:ListBox id="lstAllUsers" SelectionMode="Multiple" Runat="Server" Width="150" Height="110px" />
        </td>
        <td style="height: 108px">
	        <asp:Button Text="->"  CssClass="button" style="FONT:9pt Courier" Runat="server" id="Button1" onclick="AddUser" />
	        <br />
	        <asp:Button Text="<-"  CssClass="button" style="FONT:9pt Courier;clear:both;" Runat="server" id="Button2" onclick="RemoveUser" />
        </td>
        <td style="height: 108px">
	        <asp:ListBox id="lstSelectedUsers" SelectionMode="Multiple"  Runat="Server" Width="150" Height="110px" />
        </td>
    </tr>
</table>