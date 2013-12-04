<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PasswordReset.aspx.cs" MasterPageFile="~/Site.master" Inherits="BugNET.Account.PasswordReset" meta:resourceKey="Page" %>

<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="MainContent">
    <h2><%: Title %>.</h2>
    <asp:PlaceHolder runat="server" ID="message" Visible="false" ViewStateMode="Disabled">
        <div class="alert alert-success"><%: Message %></div>
    </asp:PlaceHolder>
    <p>
        <asp:Label ID="Label1" runat="server" meta:resourcekey="ConfirmLabel" /></p>
    <br />
    <div class="row">
        <div class="col-md-8">
             <div class="form-horizontal">
                <asp:ValidationSummary runat="server" ShowModelStateErrors="true" CssClass="text-danger" />
                <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="password" CssClass="col-md-2 control-label" meta:resourcekey="PasswordLabel">Password</asp:Label>
                    <div class="col-md-10">
                        <asp:TextBox runat="server" ID="Password" TextMode="Password" CssClass="form-control" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="password"  data-valmsg-for="MainContent_Password"
                            CssClass="text-danger" ErrorMessage="The password field is required."
                            Display="Dynamic" ValidationGroup="SetPassword" />
                        <asp:Label runat="server" ID="newPasswordMessage" CssClass="text-danger"
                            AssociatedControlID="password" />
                    </div>
                </div>
                <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="confirmPassword" CssClass="col-md-2 control-label" meta:resourcekey="ConfirmPasswordLabel">Confirm password</asp:Label>
                    <div class="col-md-10">
                        <asp:TextBox runat="server" ID="ConfirmPassword" TextMode="Password" CssClass="form-control" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="ConfirmPassword"
                            CssClass="text-danger" Display="Dynamic" ErrorMessage="The confirm password field is required."
                            ValidationGroup="SetPassword" />
                        <asp:CompareValidator runat="server" ControlToCompare="Password" ControlToValidate="ConfirmPassword"
                            CssClass="text-danger" Display="Dynamic" ErrorMessage="The password and confirmation password do not match."
                            ValidationGroup="SetPassword" />
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-md-offset-2 col-md-10">
                        <asp:Button ID="Submit" OnClick="Submit_Click" ValidationGroup="SetPassword"  Text="<%$ Resources:SharedResources, Submit %>" CssClass="btn btn-default" runat="server" />
                    </div>
                </div>
            </div>
        </div>
    </div>

    
</asp:Content>
