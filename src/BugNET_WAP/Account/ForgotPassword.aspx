<%@ Page Language="C#" MasterPageFile="~/Shared/SingleColumn.master" AutoEventWireup="true" Inherits="BugNET.Account.ForgotPassword" Title="Forgot Password" Codebehind="ForgotPassword.aspx.cs" meta:resourcekey="Page" Async="true" %>

<asp:Content ID="Content2" ContentPlaceHolderID="Content" Runat="Server">
    <h1><asp:Label ID="lblTitle" runat="server" Text="Forgot Your Password?" style="color: #666" meta:resourcekey="lblTitle" ></asp:Label></h1>
     <asp:PlaceHolder runat="server" ID="successMessage" Visible="false" ViewStateMode="Disabled">
         <asp:Localize runat="server" ID="Localize1" Text="<%$ Resources:SuccessLabel %>"  />
    </asp:PlaceHolder> 
    <asp:PlaceHolder runat="server" ID="forgotPassword" Visible="true">
        <br />
        <asp:Label ID="lblInstructions" runat="server" Text="BugNET will send reset instructions to the email address associated with your account." meta:resourcekey="lblInstructions" />
        <br />
        <br />
        <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName" Text="<%$ Resources:SharedResources, Username %>" />
        &nbsp;
        <asp:TextBox ID="UserName" runat="server"  />
        <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName"
            ErrorMessage="<%$ Resources:UsernameRequiredErrorMessage %>" ToolTip="<%$ Resources:UsernameRequiredErrorMessage %>">*</asp:RequiredFieldValidator>
        <br />
        <br />
        <asp:Button ID="SubmitButton" runat="server" OnClick="SubmitButton_Click" Text="<%$ Resources:SharedResources, Submit %>" />
    </asp:PlaceHolder>
    
   
</asp:Content>

