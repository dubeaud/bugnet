<%@ Page Language="c#" Inherits="BugNET.Administration.Projects.EditProject" ValidateRequest="false"
    meta:resourcekey="Page" Title="Project Administration" MasterPageFile="~/Site.master" CodeBehind="EditProject.aspx.cs" Async="true" %>

<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="MainContent">
    <div class="page-header">
        <h1 class="page-title">
            <asp:Literal ID="EditProjectTitle" runat="Server" meta:resourcekey="EditProjectTitle" />
            <small>
                <asp:Literal ID="litProjectName" runat="Server" />
            </small>
        </h1>
    </div>
    <div class="row">
        <div class="col-md-2">
            <asp:Repeater ID="AdminMenu" OnItemDataBound="AdminMenu_ItemDataBound" OnItemCommand="AdminMenu_ItemCommand" runat="server">
                <HeaderTemplate>
                    <ul class="nav nav-pills nav-stacked">
                </HeaderTemplate>
                <ItemTemplate>
                    <li runat="server" id="ListItem">
                        <asp:LinkButton ID="MenuButton" runat="server" CausesValidation="false"></asp:LinkButton></li>
                </ItemTemplate>
                <FooterTemplate>
                    </ul>
                </FooterTemplate>
            </asp:Repeater>
        </div>
        <div class="col-md-10">
            <asp:PlaceHolder ID="plhContent" runat="Server" />
        </div>
    </div>


    <bn:Message ID="Message1" runat="server" Visible="False" />
    <div class="row">
        <div class="col-md-offset-3 col-md-5">
            <asp:LinkButton ID="SaveButton" runat="server" CssClass="btn btn-primary" OnClick="SaveButton_Click" Text="<%$ Resources:SharedResources, Save %>" />
            <asp:LinkButton ID="RestoreButton" runat="server" CssClass="btn btn-default" CausesValidation="False" OnClick="RestoreButton_Click" Text="<%$ Resources:RestoreProject %>" />
            <a href="#" id="linkCloneProject" data-selector="CloneProject" data-toggle="modal" data-target="#cloneProjectModal" class="btn btn-default" runat="server">
                <asp:Literal ID="Literal1" runat="Server" Text="<%$ Resources:SharedResources, CloneProject %>" /></a>
        </div>
        <div class="col-md-4 text-right">
            <asp:LinkButton ID="DeleteButton" runat="server" CssClass="btn btn-danger" CausesValidation="False" OnClick="DeleteButton_Click" Text="<%$ Resources:DeleteProject %>" />
            <asp:LinkButton ID="DisableButton" runat="server" CssClass="btn btn-default btn-warning" CausesValidation="False" OnClick="DisableButton_Click" Text="<%$ Resources:DisableProject %>" />
        </div>
    </div>
    <div class="modal fade" id="cloneProjectModal" tabindex="-1" role="dialog" aria-labelledby="cloneProjectModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title" id="cloneProjectModalLabel">
                        <asp:Literal ID="Literal4" runat="Server" Text="<%$ Resources:SharedResources, CloneProject %>" /></h4>
                </div>
                <div class="modal-body">
                    <asp:Literal ID="Literal3" runat="Server" Text="<%$ Resources:SharedResources, CloneProjectInstructions %>" />
                    <br />
                    <asp:Label ID="lblError" ForeColor="red" Font-Bold="true" EnableViewState="false" runat="Server" />
                    <br />
                    <div class="form-horizontal">
                        <div class="form-group">
                            <asp:Label ID="Label1" runat="server" CssClass="col-md-4 control-label" meta:resourcekey="ExistingProjectNameLabel"></asp:Label>
                            <div class="col-md-6">
                                <asp:Label ID="lblExistingProjectName" CssClass="form-control-static" runat="server"></asp:Label>
                            </div>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="Label2" runat="server" CssClass="col-md-4 control-label" AssociatedControlID="txtNewProjectName" meta:resourcekey="NewProjectNameLabel"></asp:Label>
                            <div class="col-md-6">
                                <asp:TextBox ID="txtNewProjectName" CssClass="form-control" runat="Server" />
                            </div>
                        </div>
                    </div>
                    <br />
                    <p style="text-align: center;">
                    </p>
                </div>
                <div class="modal-footer">
                    <asp:Button ID="CancelButton" CausesValidation="False" CssClass="btn btn-default" data-dismiss="modal" runat="server" Text="<%$ Resources:SharedResources, Cancel %>" />
                    <asp:Button ID="OkButton" runat="server" CssClass="btn btn-primary" OnClick="OkButton_Click" Text="<%$ Resources:SharedResources, Ok %>" />
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <!-- /.modal -->
</asp:Content>
