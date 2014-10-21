<%@ Page language="c#" Inherits="BugNET.SvnBrowse.SubversionBrowser"  MasterPageFile="~/Site.master" Title="Source" MaintainScrollPositionOnPostback="true" Codebehind="SubversionBrowser.aspx.cs" %>

  
    <asp:Content ContentPlaceHolderID="PageTitle" runat="server" ID="content5">
    </asp:Content>
    
<asp:Content ContentPlaceHolderID="Content" runat="server" ID="content1">
      <iframe id="mainFrame" width="100%" height="1000" src="<%= RepoUrl %>" frameborder="0" scrolling="auto" marginheight="0" marginwidth="0"></iframe>
</asp:Content>

	