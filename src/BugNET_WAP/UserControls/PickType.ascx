<%@ Control Language="c#" Inherits="BugNET.UserControls.PickType" Codebehind="PickType.ascx.cs" %>
<asp:DropDownList id="ddlType" runat="Server" CssClass="form-control" />
<asp:RequiredFieldValidator id="reqVal" Display="dynamic" Visible="false" ControlToValidate="ddlType" InitialValue="0" Text="(required)" ErrorMessage="Type is required"
	Runat="Server" meta:resourcekey="reqVal"  CssClass="text-danger validation-error" />
