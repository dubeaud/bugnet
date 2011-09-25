<%@ Control Language="c#" Inherits="BugNET.UserControls.PickCategory" Codebehind="PickCategory.ascx.cs" %>
<asp:DropDownList id="ddlComps" runat="Server" >
</asp:DropDownList>
<asp:RequiredFieldValidator id="reqVal" ControlToValidate="ddlComps" 
    InitialValue="-1" Text="(required)"
	Runat="Server" Display="Dynamic" meta:resourcekey="reqVal"/>
