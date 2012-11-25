<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserProfile.aspx.cs" MasterPageFile="~/Shared/TwoColumn.master"
    Title="User Profile" Inherits="BugNET.Account.UserProfile" meta:resourcekey="Page" %>

<asp:Content ID="Content3" runat="server" ContentPlaceHolderID="PageTitle">
    <h1 class="page-title">
        <asp:Literal ID="litUserProfile" runat="server" /> -
        <asp:Literal ID="litUserName" runat="Server" /></h1>
</asp:Content>
<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="Content">
    <asp:MultiView ID="ProfileView" ActiveViewIndex="0" runat="server">
        <asp:View ID="UserDetails" runat="server">
            <bn:Message ID="Message1" runat="server" Width="650px" Visible="False" />
            <h2><asp:Literal ID="Literal3" runat="server" Text="[Resource Needed]" meta:resourceKey="UserDetails" /></h2>
            <div class="fieldgroup  noborder">
                <ol>
                    <li>
                        <asp:Label ID="Label2" AssociatedControlID="UserName" runat="server" Text="<%$ Resources:SharedResources, Username %>" />
                        <asp:TextBox ID="UserName" ReadOnly="True" Enabled="false" runat="server" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" Display="Dynamic"
                            Text="<%$ Resources:SharedResources, Required %>" ControlToValidate="UserName" />
                    </li>
                    <li>
                        <asp:Label ID="Label1" AssociatedControlID="FirstName" runat="server" Text="<%$ Resources:SharedResources, FirstName %>" />
                        <asp:TextBox ID="FirstName" runat="server" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" Display="Dynamic"
                            Text="<%$ Resources:SharedResources, Required %>" ControlToValidate="FirstName" />
                    </li>
                    <li>
                        <asp:Label ID="Label3" AssociatedControlID="LastName" runat="server" Text="<%$ Resources:SharedResources, LastName %>" />
                        <asp:TextBox ID="LastName" runat="server" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" Display="Dynamic"
                            Text="<%$ Resources:SharedResources, Required %>" ControlToValidate="LastName"></asp:RequiredFieldValidator>
                    </li>
                    <li>
                        <asp:Label ID="Label5" AssociatedControlID="FullName" runat="server" Text="<%$ Resources:SharedResources, DisplayName %>" />
                        <asp:TextBox ID="FullName" runat="server" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" Display="Dynamic"
                            Text="<%$ Resources:SharedResources, Required %>" ControlToValidate="FullName"></asp:RequiredFieldValidator>
                    </li>
                    <li>
                        <asp:Label ID="Label4" AssociatedControlID="Email" runat="server" Text="<%$ Resources:SharedResources, Email %>" />
                        <asp:TextBox ID="Email" runat="server" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" Display="Dynamic"
                            Text="<%$ Resources:SharedResources, Required %>" ControlToValidate="Email" />
                        <asp:RegularExpressionValidator ID="regexEmailValid" runat="server" ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                            ControlToValidate="Email" ErrorMessage="Invalid Email Format" Text="Invalid Email Format" />
                    </li>
                </ol>
            </div>
            <div class="submit">
                <asp:ImageButton runat="server" ID="Image2" OnClick="SaveButton_Click" CssClass="icon"
                    ImageUrl="~/Images/disk.gif" />
                <asp:LinkButton ID="SaveButton" runat="server" CssClass="button" OnClick="SaveButton_Click"
                    Text="<%$ Resources:SharedResources, Save %>" />
                <asp:ImageButton runat="server" ID="Image4" OnClick="BackButton_Click" CausesValidation="false"
                    CssClass="icon" ImageUrl="~/Images/lt.gif" />
                <asp:LinkButton ID="BackButton" runat="server" CssClass="button" CausesValidation="false"
                    OnClick="BackButton_Click" Text="<%$ Resources:SharedResources, Return %>" />
            </div>
        </asp:View>
        <asp:View ID="ManagePassword" runat="server">
            <bn:Message ID="Message2" runat="server" Width="650px" Visible="False" />
            <h2><asp:Literal ID="Literal1" runat="server" Text="[Resource Needed]" meta:resourceKey="Password" /></h2>
            <div class="fieldgroup">
                <h3>
                    <asp:Label ID="Label12" runat="server" Text="<%$ Resources:SharedResources, ChangePassword %>"></asp:Label></h3>
                <ol>
                    <li>
                        <asp:Label ID="Label7" runat="server" AssociatedControlID="CurrentPassword" Text="Enter your old password:" meta:resourceKey="Label7" />
                        <asp:TextBox ID="CurrentPassword" runat="server" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="CurrentPassword"
                            SetFocusOnError="True" ErrorMessage="<%$ Resources:SharedResources, PasswordRequired %>" ToolTip="<%$ Resources:SharedResources, PasswordRequired %>"
                            ValidationGroup="pwdReset">*</asp:RequiredFieldValidator>
                    </li>
                    <li>
                        <asp:Label ID="Label11" AssociatedControlID="NewPassword" runat="server" Text="Enter your new password:"
                            meta:resourcekey="Label111" />
                        <asp:TextBox ID="NewPassword" runat="server" TextMode="Password" />
                        <asp:RequiredFieldValidator ID="rfvPassword" ValidationGroup="pwdReset" runat="server"
                            ControlToValidate="NewPassword" SetFocusOnError="True" Display="Dynamic">*</asp:RequiredFieldValidator>
                    </li>
                    <li>
                        <asp:Label ID="lblConfirmPassword" AssociatedControlID="ConfirmPassword" runat="server"
                            Text="<%$ Resources:SharedResources, ConfirmPassword %>" />
                        <asp:TextBox ID="ConfirmPassword" runat="server" TextMode="Password" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator7" ValidationGroup="pwdReset"
                            runat="server" ControlToValidate="ConfirmPassword" SetFocusOnError="True" Display="Dynamic">*</asp:RequiredFieldValidator>
                        <asp:CompareValidator ID="cvPasswords" runat="server" SetFocusOnError="True" ControlToValidate="NewPassword"
                            ControlToCompare="ConfirmPassword" ValidationGroup="pwdReset" ErrorMessage="<%$ Resources:SharedResources, ConfirmPasswordErrorMessage %>"></asp:CompareValidator>
                    </li>
                </ol>
            </div>
            <div class="fieldgroup">
                <h3>
                    <asp:Label ID="Label14" runat="server" Text="<%$ Resources:SharedResources, SecurityQuestion %>"></asp:Label>
                </h3>
                <ol>
                    <li>
                        <asp:Label ID="QuestionLabel" runat="server" AssociatedControlID="SecurityQuestion"
                            Text="<%$ Resources:SharedResources, SecurityQuestion %>" />
                        <asp:TextBox ID="SecurityQuestion" runat="server" />
                        <asp:RequiredFieldValidator ID="QuestionRequired" runat="server" ControlToValidate="SecurityQuestion"
                            SetFocusOnError="True" ErrorMessage="<%$ Resources:SharedResources,SecurityQuestionRequiredErrorMessage %>"
                            ToolTip="<%$ Resources:SharedResources,SecurityQuestionRequiredErrorMessage %>"
                            ValidationGroup="pwdReset">*</asp:RequiredFieldValidator>
                    </li>
                    <li>
                        <asp:Label ID="AnswerLabel" runat="server" AssociatedControlID="SecurityAnswer" Text="<%$ Resources:SharedResources, SecurityAnswer %>" />
                        <asp:TextBox ID="SecurityAnswer" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="AnswerRequired" runat="server" ControlToValidate="SecurityAnswer"
                            SetFocusOnError="True" ErrorMessage="<%$ Resources:SharedResources, SecurityAnswerRequiredErrorMessage %>"
                            ToolTip="<%$ Resources:SharedResources, SecurityAnswerRequiredErrorMessage %>" ValidationGroup="pwdReset">*</asp:RequiredFieldValidator>
                    </li>
                </ol>
            </div>
            <div class="submit">
                <asp:ImageButton runat="server" ID="ImageButton5" ValidationGroup="pwdReset" OnClick="SavePasswordSettings_Click"
                    CssClass="icon" ImageUrl="~/Images/disk.gif" />
                <asp:LinkButton ID="LinkButton4" OnClick="SavePasswordSettings_Click" ValidationGroup="pwdReset"
                    runat="server" Text="<%$ Resources:SharedResources, Save %>" />
                <asp:ImageButton runat="server" ID="ImageButton6" OnClick="BackButton_Click" CssClass="icon"
                    ImageUrl="~/Images/lt.gif" />
                <asp:LinkButton ID="Linkbutton5" runat="server" CssClass="button" OnClick="BackButton_Click"
                    Text="<%$ Resources:SharedResources, Return %>" />
            </div>
            <ajaxToolkit:PasswordStrength ID="PS" runat="server" TargetControlID="NewPassword"
                DisplayPosition="RightSide" StrengthIndicatorType="Text" PreferredPasswordLength="10"
                PrefixText="Strength:" TextCssClass="TextIndicator_TextBox1" MinimumNumericCharacters="0"
                MinimumSymbolCharacters="0" RequiresUpperAndLowerCaseCharacters="false" TextStrengthDescriptions="Very Poor;Weak;Average;Strong;Excellent"
                CalculationWeightings="50;15;15;20" meta:resourceKey="PasswordStrength" />
        </asp:View>
        <asp:View ID="Customize" runat="server">
            <bn:Message ID="Message3" runat="server" Width="650px" Visible="False" />
            <h2>
                <asp:Literal ID="Literal2" runat="server" Text="[Resource Needed]" meta:resourceKey="Preferences" /></h2>
            <div class="fieldgroup noborder">
                <ol>
                    <li>
                        <asp:Label ID="Label8" AssociatedControlID="IssueListItems" runat="server" Text="Issue Page Size:"
                            meta:resourcekey="lblItemPageSize" />
                        <asp:DropDownList ID="IssueListItems" runat="server">
                            <asp:ListItem Text="5" Value="5" />
                            <asp:ListItem Text="10" Value="10" />
                            <asp:ListItem Text="15" Value="15" />
                            <asp:ListItem Text="25" Value="25" />
                            <asp:ListItem Text="50" Value="50" />
                            <asp:ListItem Text="75" Value="75" />
                            <asp:ListItem Text="100" Value="100" />
                            <asp:ListItem Text="250" Value="250" />
                        </asp:DropDownList>
                    </li>
                    <li>
                        <asp:Label ID="Label6" AssociatedControlID="ddlPreferredLocale" runat="server" Text="Preferred Locale:" meta:resourcekey="PreferredLocale" />
                        <asp:DropDownList ID="ddlPreferredLocale" DataTextField="Text" DataValueField="Value"
                            runat="server">
                        </asp:DropDownList>
                    </li>
                </ol>
            </div>
            <div class="submit">
                <asp:ImageButton runat="server" ID="ImageButton2" OnClick="SaveCustomSettings_Click"
                    CssClass="icon" ImageUrl="~/Images/disk.gif" />
                <asp:LinkButton ID="SaveCustomSettings" OnClick="SaveCustomSettings_Click" runat="server"
                    Text="<%$ Resources:SharedResources, Save %>" />
                <asp:ImageButton runat="server" ID="ImageButton1" OnClick="BackButton_Click" CssClass="icon"
                    ImageUrl="~/Images/lt.gif"  />
                <asp:LinkButton ID="Linkbutton1" runat="server" CssClass="button" OnClick="BackButton_Click"
                    Text="<%$ Resources:SharedResources, Return %>" />
            </div>
        </asp:View>
        <asp:View ID="Notifications" runat="server">
            <bn:Message ID="Message4" runat="server" Width="650px" Visible="False" />
            <h2><asp:literal ID="Label13" runat="server" meta:resourcekey="Notifications" Text="[Resource Needed]" /></h2>
            <div class="fieldgroup  noborder">
                <ol>
                    <li>
                        <asp:CheckBox ID="AllowNotifications" runat="server" Text="[Resource Needed]" meta:resourceKey="AllowNotifications" />
                    </li>
                </ol>
                <table style="width: 650px;" border="0" summary="update customize table">
                    <tr>
                        <td colspan="3">
                            <asp:Literal ID="Literal4" runat="server" Text="[Resource Needed]" meta:resourceKey="ReceiveProjectNotifications" />
                            <br />
                            <br />
                        </td>
                    </tr>
                    <tr>
                        <td style="font-weight: bold">
                            <asp:Literal ID="Literal5" runat="server" Text="[Resource Needed]" meta:resourceKey="AllProjects" />
                        </td>
                        <td>
                            &nbsp;
                        </td>
                        <td style="font-weight: bold">
                            <asp:Literal ID="Literal6" runat="server" Text="[Resource Needed]" meta:resourceKey="SelectedProjects" />
                        </td>
                    </tr>
                    <tr>
                        <td style="height: 108px; width: 110px;">
                            <asp:ListBox ID="lstAllProjects" SelectionMode="Multiple" runat="Server" Width="150"
                                Height="110px" />
                        </td>
                        <td style="height: 108px; text-align: center;">
                            <asp:Button Text="->" CssClass="button" Style="font: 9pt Courier; width: 40px;" runat="server"
                                ID="Button1" OnClick="AddProjectNotification" />
                            <br />
                            <asp:Button Text="<-" CssClass="button" Style="font: 9pt Courier; clear: both; width: 40px;"
                                runat="server" ID="Button2" OnClick="RemoveProjectNotification" />
                        </td>
                        <td style="height: 108px;">
                            <asp:ListBox ID="lstSelectedProjects" SelectionMode="Multiple" runat="Server" Width="150"
                                Height="110px" />
                        </td>
                    </tr>
                </table>
            </div>
            <div class="submit" style="margin-top:1em;">
                <asp:ImageButton runat="server" ID="ImageButton3" OnClick="SaveCustomSettings_Click"
                    CssClass="icon" ImageUrl="~/Images/disk.gif" />
                <asp:LinkButton ID="LinkButton2" OnClick="SaveCustomSettings_Click" runat="server"
                    Text="<%$ Resources:SharedResources, Save %>" />
                <asp:ImageButton runat="server" ID="ImageButton7" OnClick="BackButton_Click" CssClass="icon"
                    ImageUrl="~/Images/lt.gif"  />
                <asp:LinkButton ID="Linkbutton6" runat="server" CssClass="button" OnClick="BackButton_Click"
                    Text="<%$ Resources:SharedResources, Return %>" />
            </div>
        </asp:View>
    </asp:MultiView>
</asp:Content>
<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="Left">
    <asp:BulletedList ID="BulletedList4" DisplayMode="LinkButton" CssClass="sideMenu"
        runat="server" OnClick="BulletedList4_Click1">
        <asp:ListItem style="background-image: url('../images/user_edit.gif')" meta:resourceKey="UserDetails">User Details</asp:ListItem>
        <asp:ListItem style="background-image: url('../images/key.gif')" meta:resourceKey="Password">Password</asp:ListItem>
        <asp:ListItem style="background-image: url('../images/application_edit.gif')" meta:resourceKey="Preferences">Preferences</asp:ListItem>
        <asp:ListItem style="background-image: url('../images/email_go.gif')" meta:resourceKey="Notifications">Notifications</asp:ListItem>
    </asp:BulletedList>
</asp:Content>
