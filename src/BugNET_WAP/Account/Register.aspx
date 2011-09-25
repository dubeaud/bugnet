<%@ Page language="c#" Inherits="BugNET.Account.Register" MasterPageFile="~/Shared/SingleColumn.master" Title="Register" Codebehind="Register.aspx.cs" meta:resourcekey="Page" %>
<%@ Register TagPrefix="cc2" Namespace="Clearscreen.SharpHIP" Assembly="Clearscreen.SharpHIP" %>

<asp:Content runat="server" ID="Content1" ContentPlaceHolderID="Content">
    
    <h1><asp:Label ID="TitleLabel" meta:resourcekey="TitleLabel" style="color: #666" runat="server" Text="Sign up for your new account"></asp:Label></h1>
    <p style="margin-top:10px;"><asp:Label ID="InstructionsLabel" runat="server"  
        meta:resourcekey="InstructionsLabel" Text="Please enter your details and confirm your password to register an account."></asp:Label></p>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server"  ValidationGroup="CreateUserWizard1" HeaderText="<%$ Resources:SharedResources, ValidationSummaryHeaderText %>" DisplayMode="BulletList"  CssClass="validationSummary"/>
    <asp:CreateUserWizard ID="CreateUserWizard1"  OnCreatingUser="CreatingUser" Width="600px"
    runat="server" ContinueDestinationPageUrl="~/Default.aspx" meta:resourcekey="CreateNewUserWizard"
    OnCreatedUser="CreateUserWizard1_CreatedUser"  >
        <WizardSteps>
            <asp:CreateUserWizardStep ID="CreateUserWizardStep0"  runat="server">
                <ContentTemplate>
                 <asp:Literal ID="ErrorMessage" runat="server" EnableViewState="False" />

                    <div class="fieldgroup">
                        <ol>
                            <li>
                              <asp:Label ID="UserNameLabel" runat="server"  
                                Text="<%$ Resources:SharedResources, Username %>" AssociatedControlID="UserName">Username:</asp:Label>
                                 <asp:TextBox ID="UserName" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="UserNameRequired" runat="server"  meta:resourcekey="UserNameRequired" ControlToValidate="UserName"
                                    ErrorMessage="<%$ Resources:UsernameRequiredErrorMessage %>" ToolTip="<%$ Resources:UsernameRequiredErrorMessage %>" ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                            </li>
                            <li>
                                <asp:Label ID="FirstNameLabel" runat="server" Text="<%$ Resources:SharedResources, FirstName %>" AssociatedControlID="FirstName">First Name:</asp:Label>
                                 <asp:TextBox ID="FirstName" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="FirstNameRequired" runat="server" meta:resourcekey="FirstNameRequired"  ControlToValidate="FirstName"
                                    ErrorMessage="<%$ Resources:FirstNameRequiredErrorMessage %>" ToolTip="<%$ Resources:FirstNameRequiredErrorMessage %>" ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                            </li>
                            <li>
                                <asp:Label ID="LastNameLabel" runat="server" Text="<%$ Resources:SharedResources, LastName %>" AssociatedControlID="FirstName">Last Name:</asp:Label>
                                 <asp:TextBox ID="LastName" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="LastNameRequired" runat="server" meta:resourcekey="LastNameRequired" ControlToValidate="LastName"
                                    ErrorMessage="<%$ Resources:LastNameRequiredErrorMessage %>" ToolTip="<%$ Resources:LastNameRequiredErrorMessage %>" ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                            </li>
                            <li>
                                <asp:Label ID="FullNameLabel" runat="server" AssociatedControlID="FullName" meta:resourcekey="FullNameLabel">Display Name:</asp:Label>
                                 <asp:TextBox ID="FullName" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="FullNameRequired" runat="server" meta:resourcekey="FullNameRequired" ControlToValidate="FullName"
                                    ErrorMessage="<%$ Resources:FullNameRequiredErrorMessage %>" ToolTip="<%$ Resources:FullNameRequiredErrorMessage %>" ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                            </li>
                            <li>
                                <asp:Label ID="PasswordLabel" runat="server" Text="<%$ Resources:SharedResources, Password %>" AssociatedControlID="Password">Password:</asp:Label>
                                <asp:TextBox ID="Password" runat="server" TextMode="Password"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" meta:resourcekey="PasswordRequired" ControlToValidate="Password"
                                    ErrorMessage="<%$ Resources:PasswordRequiredErrorMessage %>" ToolTip="<%$ Resources:PasswordRequiredErrorMessage %>" ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                            </li>
                            <li>
                                <asp:Label ID="ConfirmPasswordLabel" runat="server" Text="<%$ Resources:SharedResources, ConfirmPassword %>" AssociatedControlID="ConfirmPassword">Confirm Password:</asp:Label>
                                 <asp:TextBox ID="ConfirmPassword" runat="server" TextMode="Password"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="ConfirmPasswordRequired" meta:resourcekey="ConfirmPasswordRequired" runat="server" ControlToValidate="ConfirmPassword"
                                    ErrorMessage="<%$ Resources:ConfirmPasswordRequiredErrorMessage %>" ToolTip="<%$ Resources:ConfirmPasswordRequiredErrorMessage %>"
                                    ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                            </li>
                            <li>
                                <asp:Label ID="EmailLabel" runat="server" meta:resourcekey="EmailLabel" AssociatedControlID="Email">E-mail:</asp:Label>
                                <asp:TextBox ID="Email" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="EmailRequired"   runat="server"  Display="Dynamic" ControlToValidate="Email"
                                    ErrorMessage="<%$ Resources:EmailRequiredErrorMessage %>" ToolTip="<%$ Resources:EmailRequiredErrorMessage %>" ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                                 <asp:RegularExpressionValidator ID="regexEmailValid" runat="server" 
                                    ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"  ValidationGroup="CreateUserWizard1"
                                    ControlToValidate="Email" ErrorMessage="<%$ Resources:InvalidEmailErrorMessage %>" Text="<%$ Resources:InvalidEmailErrorMessage %>" />
                            </li>
                            <li>
                                <asp:Label ID="QuestionLabel" runat="server" AssociatedControlID="Question">
                                    Security Question:</asp:Label>
                                <asp:TextBox ID="Question" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="QuestionRequired" runat="server" ControlToValidate="Question"
                                    ErrorMessage="<%$ Resources:SecurityQuestionRequiredErrorMessage %>" ToolTip="<%$ Resources:SecurityQuestionRequiredErrorMessage %>"
                                    ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                            </li>
                            <li>
                                <asp:Label ID="AnswerLabel" runat="server" AssociatedControlID="Answer">
                                    Security Answer:</asp:Label>
                                  <asp:TextBox ID="Answer" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="AnswerRequired" runat="server" ControlToValidate="Answer"
                                    ErrorMessage="<%$ Resources: SecurityAnswerRequiredErrorMessage %>" ToolTip="<%$ Resources: SecurityAnswerRequiredErrorMessage %>"
                                    ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                                <asp:CompareValidator ID="PasswordCompare" runat="server" ToolTip="<%$ Resources:SharedResources, ConfirmPasswordErrorMessage %>" ErrorMessage="<%$ Resources:SharedResources, ConfirmPasswordErrorMessage %>" ControlToCompare="Password"
                                    ControlToValidate="ConfirmPassword"
                                    ValidationGroup="CreateUserWizard1">*</asp:CompareValidator>
                            </li>
                            <li>
                               <cc2:hipcontrol id="CapchaTest" runat="server" 
                                   TrustAuthenticatedUsers="False" AutoRedirect="False"  ImageWidth="160" ImageHeight="40" TextPatternColor="Blue" 
                                    JavascriptURLDetection="False" ValidationMode="ViewState" Width="300px" />
                            </li>
                        </ol>
                    </div>
                </ContentTemplate>
            </asp:CreateUserWizardStep>
           <asp:CompleteWizardStep ID="CompleteWizardStep1" runat="server">
                <ContentTemplate>
                    <asp:Panel ID="VerificationPanel" runat="server" Visible="false">
                        <strong><asp:Localize runat="server" ID="Localize1" Text="Thanks for registering with us" meta:resourcekey="VerificationInsructionsTitle" /></strong>
                        <br />
                        <asp:Localize runat="server" ID="Localize5" Text="Now wait for an email to be sent to the email address you specified with instructions to enable your account and login." meta:resourcekey="VerificationInsructions" />     
                    </asp:Panel>
                </ContentTemplate>
            </asp:CompleteWizardStep>
        </WizardSteps>
        <TitleTextStyle Font-Bold="True" HorizontalAlign="Left" Height="50px" Font-Size="18px" />
        <InstructionTextStyle Height="35px" />
    </asp:CreateUserWizard>
</asp:Content>
			


