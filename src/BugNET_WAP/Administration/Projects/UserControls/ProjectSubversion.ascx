<%@ Control Language="c#" Inherits="BugNET.Administration.Projects.UserControls.ProjectSubversion" CodeBehind="ProjectSubversion.ascx.cs" %>


<h2>
    <asp:Literal ID="SubversionTitle" runat="Server" meta:resourcekey="SubversionTitle" /></h2>
<asp:Label ID="lblError" ForeColor="red" EnableViewState="false" runat="Server" />
<p class="desc">
    <asp:Label ID="Label9" runat="server" meta:resourcekey="DescriptionLabel"></asp:Label>
</p>
<div class="form-horizontal">
    <div class="form-group">
        <asp:Label ID="Label1" CssClass="col-md-2 control-label" AssociatedControlID="svnUrl" runat="server" Text="Subversion Url:" />
        <div class="col-md-10">
            <asp:TextBox ID="svnUrl" Columns="30" CssClass="form-control" runat="Server" />
        </div>
    </div>
    <h3>
        <asp:Literal ID="Literal3" runat="Server" meta:resourcekey="CreateATagTitle" /></h3>
        <asp:Label ID="createTagErrorLabel" ForeColor="red" EnableViewState="false" runat="Server" />
    <p class="desc">
        <asp:Label ID="Label3" runat="server" meta:resourcekey="SVNInfoLabel" Text="Create a tag of the trunk. This assumes that the root contains both a trunk and a tags directory. Your username and password are used for the single command only and never stored."></asp:Label>
    </p>
    <br />
    <div class="form-group">
        <asp:Label ID="Label4" CssClass="col-md-2 control-label" AssociatedControlID="tagName" runat="server" meta:resourcekey="TagNameLabel" Text="Tag Name:" />
        <div class="col-md-10">
            <asp:TextBox ID="tagName" CssClass="form-control" runat="Server" />
        </div>
    </div>
    <div class="form-group">
        <asp:Label ID="Label6" CssClass="col-md-2 control-label" AssociatedControlID="tagComment" runat="server" Text="Comment:" meta:resourcekey="CommentLabel" />
        <div class="col-md-10">
            <asp:TextBox ID="tagComment" TextMode="MultiLine" Wrap="false" CssClass="form-control" Height="60px" runat="Server" />
        </div>
    </div>
    <div class="form-group">
        <asp:Label ID="Label2" CssClass="col-md-2 control-label" AssociatedControlID="tagUserName" runat="server" Text="<%$ Resources:SharedResources, Username %>" />
        <div class="col-md-10">
            <asp:TextBox ID="tagUserName" CssClass="form-control" runat="Server" />
        </div>
    </div>
    <div class="form-group">
        <asp:Label ID="Label7" CssClass="col-md-2 control-label" AssociatedControlID="tagPassword" runat="server" Text="<%$ Resources:SharedResources, Password %>" />
        <div class="col-md-10">
            <asp:TextBox ID="tagPassword" CssClass="form-control" runat="Server" TextMode="Password" />
        </div>
    </div>
    <div class="form-group">
        <div class="col-md-offset-2 col-md-10">
            <asp:Button ID="createTagButton" runat="server" Text="Create Tag" meta:resourcekey="CreateTagButton" OnClick="createTagBttn_Click" CssClass="btn btn-primary" />
        </div>
    </div>
    <h3>
        <asp:Literal ID="Literal1" runat="Server" meta:resourcekey="NewRepositoryTitle" /></h3>
    <asp:Label ID="createErrorLbl" ForeColor="red" EnableViewState="false" runat="Server" />
    <p class="desc">
        <asp:Label ID="Label5" runat="server" meta:resourcekey="NewRepositoryDescription"></asp:Label>
    </p>
    <br />
    <div class="form-group">
        <asp:Label ID="Label8" CssClass="col-md-2 control-label" AssociatedControlID="repoName" runat="server" meta:resourcekey="NameLabel" Text="Name:" />
        <div class="col-md-10">
            <asp:TextBox ID="repoName" CssClass="form-control" runat="Server" />
        </div>
    </div>
    <div class="form-group">
        <div class="col-md-offset-2 col-md-10">
            <asp:Button ID="createRepoBttn" runat="server" CssClass="btn btn-primary" meta:resourcekey="CreateRepositoryButton" Text="Create Repository" OnClick="createRepoBttn_Click" />
        </div>
    </div>
    <h3>
        <asp:Literal ID="Literal2" runat="Server" meta:resourcekey="SVNCommandsTitle" /></h3>
    <div class="form-group">
        <div class="col-md-10">
            <asp:TextBox ID="svnOut" TextMode="MultiLine" CssClass="form-control" ReadOnly="true" Wrap="false" Enabled="false" Width="100%" Height="160px" runat="Server" />
        </div>
    </div>
</div>
