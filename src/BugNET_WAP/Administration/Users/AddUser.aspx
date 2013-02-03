<%@ Page Language="C#" MasterPageFile="~/Shared/SingleColumn.master" AutoEventWireup="true"
    CodeBehind="AddUser.aspx.cs" Inherits="BugNET.Administration.Users.AddUser" meta:resourceKey="Page" Async="true" %>

<asp:Content ID="Content3" ContentPlaceHolderID="Content" runat="server">
    <h1 class="page-title">
        <asp:Localize ID="Localize1" runat="server" Text="<%$ Resources:AddUser %>"></asp:Localize>
    </h1>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" DisplayMode="BulletList" HeaderText="<%$ Resources:SharedResources, ValidationSummaryHeaderText %>"  CssClass="validationSummary"/>
    <bn:Message ID="MessageContainer" runat="server" Visible="false" />
    <div class="fieldgroup">
        <ol>
            <li> <asp:Label ID="DescriptionLabel" runat="server" meta:resourcekey="DescriptionLabel" /></li>
            <li> 
                <asp:Label ID="Label2" AssociatedControlID="UserName" runat="server" Text="<%$ Resources:SharedResources, Username %>" />
                <asp:TextBox ID="UserName" runat="server" />
                <asp:RequiredFieldValidator ID="rfvUserName" runat="server" ErrorMessage="<%$ Resources:UserNameRequiredErrorMessage %>" Text=" *"
                    Display="Dynamic" ControlToValidate="UserName"></asp:RequiredFieldValidator>
            </li>
            <li>
                <asp:Label ID="Label1" AssociatedControlID="FirstName" runat="server" Text="<%$ Resources:SharedResources,FirstName %>" />
                <asp:TextBox ID="FirstName" runat="server" />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Text=" *"
                    ErrorMessage="<%$ Resources:FirstNameRequiredErrorMessage %>" ControlToValidate="FirstName" Display="Dynamic"></asp:RequiredFieldValidator>
            </li>
            <li>
                <asp:Label ID="Label3"  AssociatedControlID="LastName" runat="server"
                    Text="<%$ Resources:SharedResources,LastName %>" />
                <asp:TextBox ID="LastName" runat="server" />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" Text=" *"
                    ErrorMessage="<%$ Resources:LastNameRequiredErrorMessage %>" ControlToValidate="LastName" Display="Dynamic"></asp:RequiredFieldValidator>
            </li>
            <li>
                <asp:Label ID="Label5"  AssociatedControlID="DisplayName" runat="server"
                    Text="<%$ Resources:SharedResources,DisplayName %>" />
                <asp:TextBox ID="DisplayName" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="<%$ Resources:DisplayNameRequiredErrorMessage %>"
                    Text=" *" ControlToValidate="DisplayName"
                    Display="Dynamic"></asp:RequiredFieldValidator>
            </li>
            <li>
                <asp:Label ID="Label40"  AssociatedControlID="Email" runat="server"
                    Text="<%$ Resources:SharedResources,Email %>" />
                 <asp:TextBox ID="Email" runat="server" />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="<%$ Resources:EmailRequiredErrorMessage %>"
                    Text=" *" ControlToValidate="Email" Display="Dynamic"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="regexEmailValid" runat="server"  
                    ValidationExpression="[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+(?:[A-Z]{2}|com|org|net|edu|gov|mil|biz|info|mobi|name|aero|asia|jobs|museum)\b"
                    ControlToValidate="Email"  ErrorMessage="<%$ Resources:EmailFormatErrorMessage %>" Text="Invalid Email Format" />
            </li>
            <li id="SecretQuestionRow" runat="server" visible="false">
                <asp:Label ID="Label4" runat="server" AssociatedControlID="SecretQuestion" Text="<%$ Resources:SecurityQuestion %>" />
                <asp:TextBox runat="server" ID="SecretQuestion" MaxLength="128" TabIndex="104" Columns="30" />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="<%$ Resources:QuestionRequiredErrorMessage %>" Text=" *"
                    ControlToValidate="SecretQuestion" Display="Dynamic" EnableClientScript="true"></asp:RequiredFieldValidator>
            </li>
            <li id="SecretAnswerRow" runat="server" visible="false">
                <asp:Label ID="Label6" runat="server" AssociatedControlID="SecretAnswer" Text="<%$ Resources:SecretAnswer %>" />
                <asp:TextBox runat="server" ID="SecretAnswer" MaxLength="128" TabIndex="105" Columns="30" />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" Text=" *"
                    ControlToValidate="SecretAnswer" ErrorMessage="<%$ Resources:QuestionAnswerRequiredErrorMessage %>" Display="Dynamic" EnableClientScript="true"></asp:RequiredFieldValidator>
            </li>
            <li>
                <h3><asp:Literal ID="Literal1" runat="Server" Text="<%$ Resources:SharedResources,Password %>" /></h3>
            </li>
            <li>
                <asp:Literal ID="Literal2" runat="Server" Text="<%$ Resources:PasswordDescription %>" />
            </li>
            <li>
                <asp:Label ID="Label10" AssociatedControlID="chkRandomPassword"  runat="server" Text="<%$ Resources:RandomPassword %>" />
                <asp:CheckBox ID="chkRandomPassword" runat="server" AutoPostBack="true" OnCheckedChanged="RandomPasswordCheckChanged" />
            </li>
            <li>
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <ol style="margin:0;padding:0;">
                            <li>
                            <asp:Label ID="Label42" AssociatedControlID="Password" runat="server" Text="<%$ Resources:SharedResources,Password %>" />
                            <asp:TextBox ID="Password" TextMode="password" runat="server" />
                            <asp:RequiredFieldValidator ID="rvPassword" runat="server" ErrorMessage="<%$ Resources:PasswordRequiredErrorMessage %>" Text=" *" EnableClientScript="true"
                                ControlToValidate="Password" Display="Dynamic"></asp:RequiredFieldValidator>
                            </li>
                            <li>
                                <asp:Label ID="Label41" AssociatedControlID="ConfirmPassword" runat="server" Text="<%$ Resources:ConfirmPassword %>" />
                                <asp:TextBox ID="ConfirmPassword" TextMode="password" runat="server" />
                                <asp:RequiredFieldValidator ID="rvConfirmPassword" runat="server" ErrorMessage="<%$ Resources:ConfirmPasswordRequiredErrorMessage %>"
                                    EnableClientScript="true" ControlToValidate="ConfirmPassword" Text=" *"
                                    Display="Dynamic"></asp:RequiredFieldValidator>
                                 <asp:CompareValidator ID="cvPassword"
                                    Display="dynamic" ControlToCompare="ConfirmPassword" ControlToValidate="Password" Text=" *"
                                    runat="server" ErrorMessage="<%$ Resources:ConfirmPasswordError %>"></asp:CompareValidator>
                            </li>
                        </ol>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="chkRandomPassword" />
                    </Triggers>
                </asp:UpdatePanel>
            </li>  
            <li>
                <asp:Label ID="Label7" runat="server" AssociatedControlID="ActiveUser" Text="<%$ Resources:ActiveUser %>" />
                <asp:CheckBox runat="server" ID="ActiveUser" Text="" TabIndex="106" Checked="True" />
            </li>
        </ol>
    </div>
    <p style="margin:2em 1em 1em 0;clear:both;border-top: 1px solid #cccccc;padding-top: 10px;">
        <asp:ImageButton runat="server" ImageUrl="~/Images/disk.gif" CssClass="icon" AlternateText="<%$ Resources:AddNewUser %>" OnClick="AddNewUserClick" ID="AddNewUserButton" />
        <asp:LinkButton ID="AddNewUserLink" runat="server" Text="<%$ Resources:AddNewUser %>" OnClick="AddNewUserClick" />
        &nbsp;
        <asp:ImageButton runat="server" ImageUrl="~/Images/lt.gif" CssClass="icon" CausesValidation="false" AlternateText="<%$ Resources:BackToUserList %>" ID="ImageButton3" OnClick="CmdCancelClick" />
        <asp:HyperLink ID="ReturnLink" runat="server" NavigateUrl="~/Administration/Users/UserList.aspx" Text="<%$ Resources:BackToUserList %>"></asp:HyperLink>
    </p>
</asp:Content>
