<%@ Page language="c#" Inherits="BugNET.Errors.NotFound" MasterPageFile="~/Site.master"   meta:resourcekey="Page" Title="Resource Not Found" Codebehind="NotFound.aspx.cs" %>
<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="MainContent">
	<div style="padding:5px;">
	    <h1><asp:Localize runat="server" ID="Localize5" Text="Resource Not Found" meta:resourcekey="TitleLabel" /></h1>
		 <p style="margin-top:1em;margin-bottom:1em;"><asp:Label id="Label1" runat="server"  meta:resourcekey="Label1"  Text="The resource you were looking for is missing.  You could have been looking for an item which has been changed or deleted." /></p>
		 <p style="margin-top:1em"><asp:Label id="Label2" runat="server" meta:resourcekey="Label2"  Text="Please <a href='../Default.aspx'>Return to the home page</a> and contact the  administrator." /></p>
	</div>
</asp:Content>
	
