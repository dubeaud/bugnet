<%@ Page Language="C#" Title="Register an external login" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="RegisterExternalLogin.aspx.cs" 
    Inherits="BugNET.Account.RegisterExternalLogin" Async="true" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <h3>Register with your <%: ProviderDisplayName %> account</h3>

    <asp:Label runat="server" ID="providerMessage" CssClass="field-validation-error" />
    
    <asp:PlaceHolder runat="server" ID="userNameForm">
       <div class="form-horizontal">
            <h4>Association Form</h4>
            <hr />
            <asp:ValidationSummary runat="server" ShowModelStateErrors="true" CssClass="text-danger" />
            <p class="text-info">
                You've authenticated with <strong><%: ProviderDisplayName %></strong> as
                <strong><%: ProviderUserName %></strong>. Please enter a user name below for the current site
                and click the Log in button.
            </p>
            <div class="form-group">
                <asp:Label runat="server" AssociatedControlID="userName" CssClass="col-md-2 control-label">User name</asp:Label>
                <div class="col-md-10">
                    <asp:TextBox runat="server" ID="userName" CssClass="form-control" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="userName"
                        Display="Dynamic" CssClass="text-danger" ErrorMessage="User name is required" />
                    <asp:Label runat="server" ID="userNameMessage" CssClass="field-validation-error" />
                </div>
            </div>
           <div class="form-group">
                <asp:Label runat="server" AssociatedControlID="email" CssClass="col-md-2 control-label">Email</asp:Label>
                <div class="col-md-10">
                    <asp:TextBox runat="server" ID="email" CssClass="form-control" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="email"
                        Display="Dynamic" CssClass="text-danger" ErrorMessage="Email is required" />
                    <asp:ModelErrorMessage runat="server" ModelStateKey="UserName" CssClass="text-error" />
              <%--      <asp:Label runat="server" ID="emailMessage" CssClass="field-validation-error" />--%>
                </div>
            </div>
            <div class="form-group">
                <div class="col-md-offset-2 col-md-10">
                    <asp:Button runat="server" Text="Log in" CssClass="btn btn-default" OnClick="LogIn_Click" />&nbsp;
                    <asp:Button runat="server" Text="Cancel" CausesValidation="false" CssClass="btn" OnClick="cancel_Click" />
                </div>
            </div>
        </div>
    </asp:PlaceHolder>
</asp:Content>
