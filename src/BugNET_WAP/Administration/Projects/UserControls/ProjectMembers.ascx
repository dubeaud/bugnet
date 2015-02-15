<%@ Control Language="c#" Inherits="BugNET.Administration.Projects.UserControls.ProjectMembers" CodeBehind="ProjectMembers.ascx.cs" %>

<h2>
    <asp:Literal ID="ProjectMembersTitle" runat="Server" meta:resourcekey="ProjectMembersTitle" /></h2>
<p>
    <asp:Label ID="DescriptionLabel" runat="server" meta:resourcekey="DescriptionLabel" />
</p>
<br />
<asp:UpdatePanel ID="UpdatePanel1" RenderMode="inline" runat="Server">
    <ContentTemplate>
        <div class="row">
            <div class="col-md-5">
                <asp:Label ID="Label1" CssClass="control-label" Font-Bold="true" runat="server" meta:resourcekey="AllUsersLabel" />

                <asp:ListBox ID="lstAllUsers" CssClass="form-control" SelectionMode="Multiple" Height="150px" runat="Server" />
            </div>
            <div class="col-md-2 text-center" style="padding-top: 50px;">
                <button ID="Button4" type="button" class="btn btn-default" onserverclick="AddUser" runat="server">
                  <span class="glyphicon glyphicon-chevron-right"></span>
                </button>
                <br />
                <br />
                <button ID="Button1" type="button" class="btn btn-default" onserverclick="RemoveUser" runat="server">
                  <span class="glyphicon glyphicon-chevron-left"></span>
                </button>
            </div>
            <div class="col-md-5">
                <asp:Label ID="Label2" runat="server" CssClass="control-label" Font-Bold="true" meta:resourcekey="SelectedUsersLabel" />
                <asp:ListBox ID="lstSelectedUsers" CssClass="form-control" SelectionMode="Multiple" runat="Server" Height="150px" />
            </div>
        </div>
    </ContentTemplate>
</asp:UpdatePanel>
<div>
    <br />
    <h3>
        <asp:Literal ID="Literal1" runat="Server" meta:resourcekey="AssignUserTitle" /></h3>
</div>
<p>
    <asp:Label ID="Label3" runat="server" meta:resourcekey="AssignUsersDescription" />
</p>
<br />

<asp:UpdatePanel ID="UpdatePanel2" RenderMode="inline" runat="Server">
    <ContentTemplate>
        <div class="row" style="margin-bottom: 15px;">
            <div class="form-group">
                <asp:Label ID="Label4" runat="server" AssociatedControlID="ddlProjectMembers" Text="<%$ Resources:SharedResources, Username %>" CssClass="control-label col-md-2" />
                <div class="col-md-10">
                    <asp:DropDownList CssClass="form-control" AutoPostBack="True" ID="ddlProjectMembers" DataTextField="DisplayName" DataValueField="UserName" runat="Server" />
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-5">
                <div class="form-group">
                    <asp:Label ID="Label5" AssociatedControlID="lstAllRoles" runat="server" Font-Bold="true" CssClass="control-label" meta:resourcekey="AllRolesLabel" />
                    <asp:ListBox ID="lstAllRoles" runat="Server" CssClass="form-control" Height="150px" />
                </div>
            </div>
            <div class="col-md-2 text-center" style="padding-top: 50px;">
                <button ID="Button3" type="button" class="btn btn-default" runat="server">
                  <span class="glyphicon glyphicon-chevron-right"></span>
                </button>
                <br />
                <br />
                 <button ID="Button5" type="button" class="btn btn-default" runat="server">
                  <span class="glyphicon glyphicon-chevron-left"></span>
                </button>
            </div>
            <div class="col-md-5">
                <asp:Label ID="Label6" runat="server" meta:resourcekey="AssignedRolesLabel" Font-Bold="true" CssClass="control-label" />
                <asp:ListBox ID="lstSelectedRoles" runat="Server" CssClass="form-control" Height="150px" />
            </div>
        </div>
    </ContentTemplate>
</asp:UpdatePanel>


