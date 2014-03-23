<%@ Page Language="c#" Inherits="BugNET.Administration.Projects.AddProject" ValidateRequest="false" meta:resourcekey="Page" MasterPageFile="~/Site.master" Title="Add Project" CodeBehind="AddProject.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1>
        <asp:Literal ID="NewProjectTitle" runat="Server" meta:resourcekey="NewProjectTitle" />
        (<asp:Literal ID="lblStepNumber" runat="Server" />)</h1>
    <div>
        <asp:PlaceHolder ID="plhWizardStep" runat="Server" />
        <br />
        <br />
        <div class="row">
            <div class="pull-left">
                <asp:Button Text="<%$ Resources:SharedResources, Cancel %>" CssClass="btn btn-danger" CausesValidation="false" runat="server"
                    ID="btnCancel" OnClick="btnCancel_Click" />
            </div>
            <div class="pull-right">
                <asp:Button ID="btnBack" CssClass="btn btn-primary" Text="<%$ Resources:Back %>" CausesValidation="false" runat="Server"
                    OnClick="btnBack_Click" />
                <asp:Button ID="btnNext" CssClass="btn btn-primary" Text="<%$ Resources:Next %>" runat="Server" OnClick="btnNext_Click" />
            </div>
        </div>
    </div>
</asp:Content>
