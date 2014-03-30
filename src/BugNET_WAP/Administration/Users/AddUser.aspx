<%@ Page Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeBehind="AddUser.aspx.cs" Inherits="BugNET.Administration.Users.AddUser" meta:resourceKey="Page" Async="true" %>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="page-header">
        <h1 class="page-title">
            <asp:Localize ID="Localize1" runat="server" Text="<%$ Resources:AddUser %>"></asp:Localize>
        </h1>
    </div>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" DisplayMode="BulletList" HeaderText="<%$ Resources:SharedResources, ValidationSummaryHeaderText %>" CssClass="text-danger" />
    <bn:Message ID="MessageContainer" runat="server" Visible="false" />
    <div class="form-horizontal">
        <div class="form-group">
            <asp:Label ID="DescriptionLabel" runat="server" meta:resourcekey="DescriptionLabel" />
        </div>
        <div class="form-group">
            <asp:Label ID="Label2" CssClass="control-label col-md-4" AssociatedControlID="UserName" runat="server" Text="<%$ Resources:SharedResources, Username %>" />
            <div class="col-md-8">
                <asp:TextBox ID="UserName" CssClass="form-control" runat="server" />
                <asp:RequiredFieldValidator ID="rfvUserName" runat="server" ErrorMessage="<%$ Resources:UserNameRequiredErrorMessage %>" CssClass="text-danger" Text=" *"
                    Display="Dynamic" ControlToValidate="UserName"></asp:RequiredFieldValidator>
            </div>
        </div>
        <div class="form-group">
            <asp:Label ID="Label1" CssClass="control-label col-md-4" AssociatedControlID="FirstName" runat="server" Text="<%$ Resources:SharedResources,FirstName %>" />
            <div class="col-md-8">
                <asp:TextBox ID="FirstName" CssClass="form-control" runat="server" />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Text=" *" CssClass="text-danger"
                    ErrorMessage="<%$ Resources:FirstNameRequiredErrorMessage %>" ControlToValidate="FirstName" Display="Dynamic"></asp:RequiredFieldValidator>
            </div>
        </div>
        <div class="form-group">
            <asp:Label ID="Label3" CssClass="control-label col-md-4" AssociatedControlID="LastName" runat="server"
                Text="<%$ Resources:SharedResources,LastName %>" />
            <div class="col-md-8">
                <asp:TextBox ID="LastName" CssClass="form-control" runat="server" />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" Text=" *"
                    ErrorMessage="<%$ Resources:LastNameRequiredErrorMessage %>" CssClass="text-danger" ControlToValidate="LastName" Display="Dynamic"></asp:RequiredFieldValidator>
            </div>
        </div>
        <div class="form-group">
            <asp:Label ID="Label5" CssClass="control-label col-md-4" AssociatedControlID="DisplayName" runat="server"
                Text="<%$ Resources:SharedResources,DisplayName %>" />
            <div class="col-md-8">
                <asp:TextBox ID="DisplayName" CssClass="form-control" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" CssClass="text-danger" ErrorMessage="<%$ Resources:DisplayNameRequiredErrorMessage %>"
                    Text=" *" ControlToValidate="DisplayName"
                    Display="Dynamic"></asp:RequiredFieldValidator>
            </div>
        </div>
        <div class="form-group">
            <asp:Label ID="Label40" CssClass="control-label col-md-4" AssociatedControlID="Email" runat="server"
                Text="<%$ Resources:SharedResources,Email %>" />
            <div class="col-md-8">
                <asp:TextBox ID="Email" CssClass="form-control" runat="server" />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="<%$ Resources:EmailRequiredErrorMessage %>"
                    Text=" *" ControlToValidate="Email" Display="Dynamic" CssClass="text-danger"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="regexEmailValid" runat="server"
                    ValidationExpression="^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$"
                    ControlToValidate="Email" ErrorMessage="<%$ Resources:EmailFormatErrorMessage %>" Text="Invalid Email Format" />
            </div>
        </div>
        <div class="form-group" id="SecretQuestionRow" runat="server" visible="false">
            <asp:Label ID="Label4" runat="server" CssClass="control-label col-md-4" AssociatedControlID="SecretQuestion" Text="<%$ Resources:SecurityQuestion %>" />
            <asp:TextBox runat="server" ID="SecretQuestion" MaxLength="128" TabIndex="104" Columns="30" />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" CssClass="text-danger" ErrorMessage="<%$ Resources:QuestionRequiredErrorMessage %>" Text=" *"
                ControlToValidate="SecretQuestion" Display="Dynamic" EnableClientScript="true"></asp:RequiredFieldValidator>
        </div>
        <div class="form-group" id="SecretAnswerRow" runat="server" visible="false">
            <asp:Label ID="Label6" runat="server" CssClass="control-label col-md-4" AssociatedControlID="SecretAnswer" Text="<%$ Resources:SecretAnswer %>" />
            <asp:TextBox runat="server" ID="SecretAnswer" MaxLength="128" TabIndex="105" Columns="30" />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" CssClass="text-danger" runat="server" Text=" *"
                ControlToValidate="SecretAnswer" ErrorMessage="<%$ Resources:QuestionAnswerRequiredErrorMessage %>" Display="Dynamic" EnableClientScript="true"></asp:RequiredFieldValidator>
        </div>
        <h3>
            <asp:Literal ID="Literal1" runat="Server" Text="<%$ Resources:SharedResources,Password %>" /></h3>
        <div>
            <asp:Literal ID="Literal2" runat="Server" Text="<%$ Resources:PasswordDescription %>" /></div>
        <div class="form-group">
            <asp:Label ID="Label10" AssociatedControlID="chkRandomPassword" CssClass="control-label col-md-4" runat="server" Text="<%$ Resources:RandomPassword %>" />
            <div class="col-md-8">
                <div class="checkbox">
                    <asp:CheckBox ID="chkRandomPassword" runat="server" AutoPostBack="true" OnCheckedChanged="RandomPasswordCheckChanged" />
                </div>
            </div>
        </div>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <div class="form-group">
                    <asp:Label ID="Label42" AssociatedControlID="Password" CssClass="control-label col-md-4" runat="server" Text="<%$ Resources:SharedResources,Password %>" />
                    <div class="col-md-8">
                        <asp:TextBox ID="Password" TextMode="password" CssClass="form-control" runat="server" />
                        <asp:RequiredFieldValidator ID="rvPassword" runat="server" CssClass="text-danger" ErrorMessage="<%$ Resources:PasswordRequiredErrorMessage %>" Text=" *" EnableClientScript="true"
                            ControlToValidate="Password" Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="form-group">
                    <asp:Label ID="Label41" AssociatedControlID="ConfirmPassword" CssClass="control-label col-md-4" runat="server" Text="<%$ Resources:ConfirmPassword %>" />
                    <div class="col-md-8">
                        <asp:TextBox ID="ConfirmPassword" TextMode="password" CssClass="form-control" runat="server" />
                        <asp:RequiredFieldValidator ID="rvConfirmPassword" runat="server" CssClass="text-danger" ErrorMessage="<%$ Resources:ConfirmPasswordRequiredErrorMessage %>"
                            EnableClientScript="true" ControlToValidate="ConfirmPassword" Text=" *"
                            Display="Dynamic"></asp:RequiredFieldValidator>
                        <asp:CompareValidator ID="cvPassword"
                            Display="dynamic" ControlToCompare="ConfirmPassword" CssClass="text-danger" ControlToValidate="Password" Text=" *"
                            runat="server" ErrorMessage="<%$ Resources:ConfirmPasswordError %>"></asp:CompareValidator>
                    </div>
                </div>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="chkRandomPassword" />
            </Triggers>
        </asp:UpdatePanel>
        <div class="form-group">
            <asp:Label ID="Label7" runat="server" CssClass="control-label col-md-4" AssociatedControlID="ActiveUser" Text="<%$ Resources:ActiveUser %>" />
            <div class="col-md-8">
                <div class="checkbox">
                    <asp:CheckBox runat="server" ID="ActiveUser" Text="" TabIndex="106" Checked="True" />
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <asp:LinkButton ID="AddNewUserLink" CssClass="btn btn-primary" runat="server" Text="<%$ Resources:AddNewUser %>" OnClick="AddNewUserClick" />
        <asp:HyperLink ID="ReturnLink" runat="server" CssClass="btn btn-default" NavigateUrl="~/Administration/Users/UserList.aspx" Text="<%$ Resources:BackToUserList %>"></asp:HyperLink>
    </div>
</asp:Content>
