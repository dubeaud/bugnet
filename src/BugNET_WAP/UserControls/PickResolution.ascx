<%@ Control Language="c#" Inherits="BugNET.UserControls.PickResolution" Codebehind="PickResolution.ascx.cs" %>
<asp:DropDownList id="ddlResolution" runat="Server" />
<asp:RequiredFieldValidator id="reqVal" Visible="false"  Display="dynamic" ControlToValidate="ddlResolution" InitialValue="0" Text="(required)"
	Runat="Server" meta:resourcekey="reqVal" />
