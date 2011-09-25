<%@ Page language="c#" Inherits="BugNET.Errors.SomethingMissing" MasterPageFile="~/Shared/SingleColumn.master" Title="More Information Required" Codebehind="SomethingMissing.aspx.cs" %>
<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="Content">
	<h1><asp:literal ID="litTitle" runat="server" Text="More Information Required" /></h1>
	<p style="margin-top:1em"><asp:Label id="Label1" runat="server" Text="The resource you were looking is requesting more information. For example, if you are accessing a list for a project, without having selected a project." /></p>
	<p style="margin-top:1em"><asp:Label id="Label2" runat="server" Text="Please <a href='../Default.aspx'>return to the home page</a> and try again or contact the administrator." /></p>
</asp:Content>
	
