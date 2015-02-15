<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.master" CodeBehind="CloneProject.aspx.cs" Title="<%$ Resources:CloneProject %>" Inherits="BugNET.Administration.Projects.CloneProject" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
     <div class="page-header">
        <h1 class="page-title">
            <asp:Literal ID="CloneProjectTitle" runat="Server" Text="<%$ Resources:CloneProject %>" />
        </h1>
    </div>
    <p>
        <asp:Label ID="Label9" runat="server" meta:resourcekey="DescriptionLabel"></asp:Label>
    </p>
    <asp:Label ID="lblError" ForeColor="red" Font-Bold="true" EnableViewState="false" runat="Server" />
    <div class="form-horizontal">
        <div class="form-group">
            <asp:Label ID="Label1" runat="server" AssociatedControlID="ddlProjects" CssClass="col-md-4 control-label" meta:resourcekey="ExistingProjectNameLabel"></asp:Label>
            <div class="col-md-8">
                <asp:DropDownList ID="ddlProjects" CssClass="form-control" DataTextField="Name" DataValueField="Id" runat="Server"></asp:DropDownList>
            </div>
        </div>
        <div class="form-group">
            <asp:Label ID="Label2" runat="server" AssociatedControlID="txtNewProjectName" CssClass="col-md-4 control-label" meta:resourcekey="NewProjectNameLabel"></asp:Label>
            <div class="col-md-8">
                <asp:TextBox ID="txtNewProjectName" CssClass="form-control" runat="Server" />
                <asp:RequiredFieldValidator ControlToValidate="txtNewProjectName" Text="<%$ Resources:SharedResources, Required %>" runat="server" ID="RequiredFieldValidator1" />
            </div>
        </div>
        <div class="row">
            <asp:Button ID="btnClone" CssClass="btn btn-primary" Text="<%$ Resources:CloneProject %>" runat="Server" OnClick="btnClone_Click" />
            <asp:Button ID="btnCancel" CssClass="btn btn-danger" Text="<%$ Resources:SharedResources, Cancel %>" CausesValidation="false" OnClick="btnCancel_Click"
                runat="Server" />
        </div>
    </div>
</asp:Content>
