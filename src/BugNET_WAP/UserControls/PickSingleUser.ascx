<%@ Control Language="c#" Inherits="BugNET.UserControls.PickSingleUser" Codebehind="PickSingleUser.ascx.cs" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:DropDownList id="ddlUsers" DataTextField="DisplayName" DataValueField="UserName" CssClass="form-control validation-error" runat="Server" />
<asp:RequiredFieldValidator id="reqVal" Display="dynamic" ControlToValidate="ddlUsers" Text="(required)" Runat="Server" CssClass="text-danger validation-error" meta:resourcekey="reqVal" />

