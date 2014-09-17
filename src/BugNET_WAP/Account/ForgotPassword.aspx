<%@ Page Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" Inherits="BugNET.Account.ForgotPassword" Title="Forgot Password" Codebehind="ForgotPassword.aspx.cs" meta:resourcekey="Page" Async="true" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <h1><asp:Label ID="lblTitle" runat="server" Text="Forgot Your Password?" style="color: #666" meta:resourcekey="lblTitle" ></asp:Label></h1>
     <asp:PlaceHolder runat="server" ID="successMessage" Visible="false" ViewStateMode="Disabled">
         <asp:Localize runat="server" ID="Localize1" Text="<%$ Resources:SuccessLabel %>"  />
    </asp:PlaceHolder> 
    <asp:PlaceHolder runat="server" ID="forgotPassword" Visible="true">
        <p><asp:Label ID="lblInstructions" runat="server" Text="BugNET will send reset instructions to the email address associated with your account." meta:resourcekey="lblInstructions" /></p>
        <div class="form-horizontal">
            <div class="form-group">
                <asp:Label ID="UserNameLabel" runat="server" CssClass="col-md-2 control-label" AssociatedControlID="UserName" Text="<%$ Resources:SharedResources, Username %>" />
                <div class="col-md-5">
                    <asp:TextBox ID="UserName" CssClass="form-control" runat="server"  />
                    <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName"
                    ErrorMessage="<%$ Resources:UsernameRequiredErrorMessage %>" CssClass="text-danger validation-error" ToolTip="<%$ Resources:UsernameRequiredErrorMessage %>"></asp:RequiredFieldValidator>
                </div>
            </div>
            <div class="form-group">
                <div class="col-md-offset-2 col-md-10">
                    <asp:Button ID="SubmitButton" CssClass="btn btn-primary" runat="server" OnClick="SubmitButton_Click" Text="<%$ Resources:SharedResources, Submit %>" />
                </div>
            </div>
        </div>
    </asp:PlaceHolder>
    
   
</asp:Content>

