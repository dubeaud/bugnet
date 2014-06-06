<%@ Page Title="Log in" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="BugNET.Account.Login" meta:resourcekey="Page"%>
<%@ Register Src="~/Account/OpenAuthProviders.ascx" TagPrefix="uc" TagName="OpenAuthProviders" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <h2><%: Title %></h2>
    <div class="row">
        <div class="col-md-8">
            <section id="loginForm">
                <asp:Login runat="server" ViewStateMode="Disabled" RenderOuterTable="false">
                    <LayoutTemplate>
                        <div class="form-horizontal">
                            <h4><asp:Localize runat="server" meta:resourceKey="UseLocalAccount" Text="[Resource Required]"/></h4>
                            <hr />
                              <asp:PlaceHolder runat="server" ID="ErrorMessage" Visible="false">
                                <p class="text-danger">
                                    <asp:Literal runat="server" ID="FailureText" />
                                </p>
                            </asp:PlaceHolder>
                            <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="UserName" CssClass="col-md-4 control-label" Text="<%$ Resources:SharedResources, UserName%>">User name</asp:Label>
                                <div class="col-md-5">
                                    <asp:TextBox runat="server" ID="UserName" CssClass="form-control" />
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="UserName"
                                        CssClass="text-danger" ErrorMessage="<%$ Resources:SharedResources, UsernameRequiredErrorMessage%>" />
                                </div>
                            </div>
                            <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="Password" CssClass="col-md-4 control-label" Text="<%$ Resources:SharedResources, Password%>">Password</asp:Label>
                                <div class="col-md-5">
                                    <asp:TextBox runat="server" ID="Password" TextMode="Password" CssClass="form-control" />
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="Password" CssClass="text-danger" ErrorMessage="<%$ Resources:SharedResources, PasswordRequiredErrorMessage%>" />
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-md-offset-2 col-md-10">
                                    <div class="checkbox">
                                        <asp:CheckBox runat="server" ID="RememberMe" />
                                        <asp:Label runat="server" AssociatedControlID="RememberMe" meta:resourceKey="RememberMe" Text="[Resource Required]" />
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-md-offset-2 col-md-10">
                                    <asp:Button runat="server" CommandName="Login" CssClass="btn btn-primary" meta:resourceKey="LoginButton" Text="[Resource Required]" />
                                </div>
                            </div>
                        </div>
                  </LayoutTemplate>
                </asp:Login>
                <p>
                    <asp:HyperLink ID="PasswordRecoveryLink" runat="server" meta:resourcekey="PasswordRecoveryLink" NavigateUrl="~/Account/ForgotPassword">Forgot your password?</asp:HyperLink>
                </p>
                <p>
                     <asp:Localize runat="server" ID="Register_Localize" />
                </p>
                
            </section>
        </div>

        <div class="col-md-4">
            <section id="socialLoginForm">
                <uc:OpenAuthProviders runat="server" ID="OpenAuthLogin" />
            </section>
        </div>
    </div>
    
</asp:Content>
