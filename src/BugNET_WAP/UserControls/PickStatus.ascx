<%@ Control Language="c#" CodeBehind="PickStatus.ascx.cs" AutoEventWireup="True" Inherits="BugNET.UserControls.PickStatus" %>
<asp:DropDownList id="dropStatus" Runat="Server">
	<asp:ListItem Value="0">-- Select Status --</asp:ListItem>
</asp:DropDownList>
<asp:RequiredFieldValidator id="reqVal" Visible="false" ControlToValidate="dropStatus" InitialValue="0" Text="(required)" ErrorMessage="Status is required"
	Runat="Server" meta:resourcekey="reqVal" CssClass="req" />
