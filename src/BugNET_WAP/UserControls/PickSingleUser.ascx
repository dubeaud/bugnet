<%@ Control Language="c#" Inherits="BugNET.UserControls.PickSingleUser" Codebehind="PickSingleUser.ascx.cs" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:DropDownList id="ddlUsers" DataTextField="DisplayName" DataValueField="UserName"  runat="Server" />
<asp:RequiredFieldValidator id="reqVal" Display="dynamic" ControlToValidate="ddlUsers" Text="(required)" Runat="Server" meta:resourcekey="reqVal" />

