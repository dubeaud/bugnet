<%@ Page Language="c#" Inherits="BugNET.Administration.Projects.AddProject" ValidateRequest="false" meta:resourcekey="Page" MasterPageFile="~/Site.master" Title="Add Project" CodeBehind="AddProject.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
     <div class="page-header">
        <h1 class="page-title">
           <asp:Literal ID="NewProjectTitle" runat="Server" meta:resourcekey="NewProjectTitle" />
        (<asp:Literal ID="lblStepNumber" runat="Server" />)
        </h1>
    </div>
    <div>
        <asp:PlaceHolder ID="plhWizardStep" runat="Server" />
        <br />
        <br />
        <div class="row">
            <div class="text-left col-md-6">
                <asp:Button Text="<%$ Resources:SharedResources, Cancel %>" CssClass="btn btn-danger" CausesValidation="false" runat="server"
                    ID="btnCancel" ClientIDMode="Static" OnClick="btnCancel_Click" />
            </div>
            <div class="text-right col-md-6">
                <asp:Button ID="btnBack" CssClass="btn btn-primary" Text="<%$ Resources:Back %>" CausesValidation="false" runat="Server"
                    OnClick="btnBack_Click" />
                <asp:Button ID="btnNext" CssClass="btn btn-primary" Text="<%$ Resources:Next %>" runat="Server" OnClick="btnNext_Click" />
            </div>
        </div>
    </div>
    <script type="text/javascript">
        $(function () {
            $("#btnCancel").click(function (e) {
                e.preventDefault();
                BootstrapDialog.confirm('<%=GetLocalResourceObject("CancelConfirm") %> ', function (result) {
                    if (result) {
                        <%=this.Page.ClientScript.GetPostBackEventReference(new PostBackOptions(this.btnCancel))%>
                    } else {
                        return false;
                    }
                });
            });
        });
    </script>
</asp:Content>
