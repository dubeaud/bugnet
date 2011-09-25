<%@ Page Language="C#" MasterPageFile="~/Shared/SingleColumn.master" AutoEventWireup="true" Inherits="BugNET.Account.ForgotPassword" Title="Forgot Password" Codebehind="ForgotPassword.aspx.cs" meta:resourcekey="Page" %>
<%@ Register TagPrefix="cc2" Namespace="Clearscreen.SharpHIP" Assembly="Clearscreen.SharpHIP" %>

<asp:Content ID="Content2" ContentPlaceHolderID="Content" Runat="Server">
    <asp:PasswordRecovery ID="PasswordRecovery1" OnSendingMail="PasswordRecovery1_SendingMail"  maildefinition-from="userAdmin@your.site.name.here"  Runat="server">
        <MailDefinition From="userAdmin@your.site.name.here"></MailDefinition>
        <QuestionTemplate>            
            <h1><asp:Label ID="lblIdentityConfirmation" runat="server" Text="Identity Confirmation" style="color: #666" /></h1>          
            <p style="margin-top:1.5em;">Answer the following question to receive your password.</p>
            <asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal>
            <div class="fieldgroup" style="border:none;">
                <ol>                           
                    <li>
                        <span class="label"><asp:Localize runat="server" ID="Localize1" Text="<%$ Resources:SharedResources, Username %>" /></span>
                        <asp:Literal ID="UserName" runat="server"></asp:Literal>
                    </li>
                    <li> 
                        <span class="label"><asp:Localize runat="server" ID="Localize2" meta:resourceKey="QuestionLabel" /></span>
                        <asp:Literal ID="Question" runat="server"></asp:Literal>
                    </li>
                    <li>
                        <asp:Label ID="AnswerLabel" runat="server" AssociatedControlID="Answer"><asp:Localize runat="server" ID="Localize3" meta:resourceKey="AnswerLabel" /></asp:Label>
                        <asp:TextBox ID="Answer" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="AnswerRequired" runat="server" 
                            ControlToValidate="Answer" ErrorMessage="Answer is required." 
                            ToolTip="Answer is required." ValidationGroup="PasswordRecovery1">*</asp:RequiredFieldValidator>
                    </li>
                </ol>
            </div>
            <div class="submit">
                <asp:Button ID="SubmitButton" runat="server" CommandName="Submit" Text="<%$ Resources:SharedResources, Submit %>" 
                            ValidationGroup="PasswordRecovery1" />
            </div>     
        </QuestionTemplate>
        <SuccessTemplate>
            <h1><asp:Label ID="lblPasswordSentSuccess" runat="server" Text="<%$ Resources:SuccessLabel %>" style="color: #666" /></h1>
            <div>
                <asp:Localize runat="server" ID="Localize1" Text="<%$ Resources:PasswordReminderSuccess %>" />
            </div>
        </SuccessTemplate>
        <UserNameTemplate>
            <h1> <asp:Label ID="lblTitle" runat="server" Text="Forgot Your Password?" style="color: #666" meta:resourcekey="lblTitle" ></asp:Label></h1>
             <div class="fieldgroup" style="border:none;">
                <ol>                           
                    <li> <asp:Label ID="lblInstructions" runat="server" Text="Enter your Username to receive your password." meta:resourcekey="lblInstructions" /></li>
                    <li>
                        <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName" Text="<%$ Resources:SharedResources, Username %>" />
                        <asp:TextBox ID="UserName" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" 
                            ControlToValidate="UserName" ErrorMessage="<%$ Resources:SharedResources, UsernameRequiredErrorMessage %>" 
                            ToolTip="<%$ Resources:SharedResources, UsernameRequiredErrorMessage %>" ValidationGroup="PasswordRecovery1">*</asp:RequiredFieldValidator>
                    </li>
                    <li>
                        <asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal>
                    </li>
                </ol>
            </div>
            <div class="submit">
                <asp:Button ID="SubmitButton" runat="server" CommandName="Submit" Text="<%$ Resources:SharedResources, Submit %>" 
                    ValidationGroup="PasswordRecovery1" />
            </div>
        </UserNameTemplate>
    </asp:PasswordRecovery>

</asp:Content>

