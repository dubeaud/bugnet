<%@ Control Language="c#" Inherits="BugNET.UserControls.PickType" Codebehind="PickType.ascx.cs" %>
<asp:DropDownList id="ddlType" runat="Server" />
<asp:RequiredFieldValidator id="reqVal" Display="dynamic" Visible="false" ControlToValidate="ddlType" InitialValue="0" Text="(required)" ErrorMessage="Type is required"
	Runat="Server" meta:resourcekey="reqVal" />
