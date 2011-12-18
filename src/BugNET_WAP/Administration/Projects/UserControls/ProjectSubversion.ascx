<%@ Control Language="c#" Inherits="BugNET.Administration.Projects.UserControls.ProjectSubversion" Codebehind="ProjectSubversion.ascx.cs" %>

<div>
	<h2><asp:literal ID="SubversionTitle" runat="Server" meta:resourcekey="SubversionTitle" /></h2>
	<asp:Label id="lblError" ForeColor="red" EnableViewState="false" runat="Server" />
	<p class="desc"><asp:Label ID="Label9" runat="server" meta:resourcekey="DescriptionLabel"></asp:Label></p>
	 <div class="fieldgroup" style="border:none">  
       <ol>
            <li>
                <asp:Label ID="Label1"  CssClass="col1" AssociatedControlID="svnUrl" runat="server" Text="Subversion Url:" />
                <asp:TextBox id="svnUrl" Columns="30" runat="Server" />
            </li>
       </ol>
    </div>  
   <div class="fieldgroup">  
	    <h3>Create a Tag</h3>
        <asp:Label id="createTagErrorLabel" ForeColor="red" EnableViewState="false" runat="Server" />
        <p class="desc" ><asp:Label ID="Label3" runat="server" meta:resourcekey="SVNInfoLabel" Text="Create a tag of the trunk. This assumes that the root contains both a trunk and a tags directory. Your username and password are used for the single command only and never stored."></asp:Label></p>
        <br />
	    <ol>
            <li>
                <asp:Label ID="Label4" CssClass="col1" AssociatedControlID="tagName" runat="server" Text="Tag Name:" />
                <asp:TextBox id="tagName" Columns="30" runat="Server" />
            </li>
            <li>
                <asp:Label ID="Label6" CssClass="col1" AssociatedControlID="tagComment" runat="server" Text="Comment:" meta:resourcekey="CommentLabel" />
                <asp:TextBox id="tagComment" TextMode="MultiLine" Wrap="false" Width="300px" Height="60px" runat="Server" />
            </li>      
            <li>
                <asp:Label ID="Label2" CssClass="col1" AssociatedControlID="tagUserName" runat="server" Text="<%$ Resources:SharedResources, Username %>" />
                <asp:TextBox id="tagUserName" Columns="30" runat="Server" />
            </li>
            <li>
                <asp:Label ID="Label7" CssClass="col1" AssociatedControlID="tagPassword" runat="server" Text="<%$ Resources:SharedResources, Password %>" />
                <asp:TextBox id="tagPassword" Columns="30" runat="Server" TextMode="Password" />
            </li>
        </ol>
    </div>
    <div class="submit">
        <asp:Button ID="createTagButton" runat="server" Text="Create Tag" meta:resourcekey="CreateTagButton" OnClick="createTagBttn_Click" style="width:120px" />
    </div>
     
     <div class="fieldgroup">  
        <h3><asp:literal ID="Literal1" runat="Server" meta:resourcekey="NewRepositoryTitle" /></h3>
        <asp:Label id="createErrorLbl" ForeColor="red" EnableViewState="false" runat="Server" />
	    <p class="desc"><asp:Label ID="Label5" runat="server" meta:resourcekey="NewRepositoryDescription"></asp:Label></p>
        <br />
        <ol>
            <li>
                <asp:Label ID="Label8" CssClass="col1" AssociatedControlID="repoName" runat="server" Text="Name:" />
                <asp:TextBox id="repoName" Columns="30" runat="Server" />
            </li>
        </ol> 
    </div>
    <div class="submit">
        <asp:Button ID="createRepoBttn" runat="server" meta:resourcekey="CreateRepositoryButton" Text="Create Repository" OnClick="createRepoBttn_Click" style="width:120px" />
    </div>
        
   <div class="fieldgroup">
        <h3><asp:literal ID="Literal2" runat="Server" meta:resourcekey="SVNCommandsTitle" /></h3>
        <ol>
            <li>
                <asp:TextBox id="svnOut" TextMode="MultiLine" ReadOnly="true" Wrap="false" Enabled="false"  Width="100%" Height="160px" runat="Server" />
            </li>
        </ol>
    </div>
</div>