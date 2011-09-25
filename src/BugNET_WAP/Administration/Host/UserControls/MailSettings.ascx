<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MailSettings.ascx.cs"
    Inherits="BugNET.Administration.Host.UserControls.MailSettings" %>
<h2>
    <asp:Literal ID="Title" runat="Server" Text="<%$ Resources:MailSettings %>" /></h2>
<asp:UpdatePanel ID="UpdatePanel1" runat="server" ChildrenAsTriggers="true">
    <ContentTemplate>
        <div class="fieldgroup noborder">
            <ol>
                <li>
                    <asp:Label ID="label9" runat="server" AssociatedControlID="SMTPServer" Text="<%$ Resources:Server %>" />
                    <asp:TextBox ID="SMTPServer" runat="Server" MaxLength="256" />
                    &nbsp;
                    <asp:LinkButton ID="TestEmailSettings" runat="server" OnClick="TestEmailSettings_Click">Test</asp:LinkButton>
                    <asp:Label ID="lblEmail" runat="server" Font-Bold="true" />
                </li>
                <li>
                    <asp:Label ID="label26" runat="server" AssociatedControlID="SMTPPort" CssClass="col1b"
                        Text="<%$ Resources:Port %>" />
                    <asp:TextBox ID="SMTPPort" Width="50px" runat="Server" />
                </li>
                <li>
                    <asp:Label ID="label22" runat="server" AssociatedControlID="HostEmail" Text="<%$ Resources:HostEmail %>" />
                    <asp:TextBox ID="HostEmail" runat="Server" />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" Display="Dynamic"
                        Text="<%$ Resources:SharedResources, Required %>" ControlToValidate="HostEmail" />
                    <asp:RegularExpressionValidator ID="regexEmailValid" runat="server" ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                        ControlToValidate="HostEmail" ErrorMessage="Invalid Email Format" Text="Invalid Email Format" />
                </li>
                <li>
                    <asp:Label ID="label27" runat="server" AssociatedControlID="SMTPUseSSL" CssClass="col1b"
                        Text="SSL" />
                    <asp:CheckBox ID="SMTPUseSSL" runat="server" />
                </li>
                <li>
                    <asp:Label ID="label10" runat="server" AssociatedControlID="SMTPEnableAuthentication"
                        Text="<%$ Resources:EnableAuthentication %>" />
                    <asp:CheckBox ID="SMTPEnableAuthentication" AutoPostBack="true" OnCheckedChanged="SMTPEnableAuthentication_CheckChanged"
                        runat="server"></asp:CheckBox>
                </li>
                <li id="trSMTPUsername" runat="server">
                    <asp:Label ID="label11" runat="server" AssociatedControlID="SMTPUsername" Text="<%$ Resources:SharedResources, Username %>" />
                    <asp:TextBox ID="SMTPUsername" runat="Server" />
                </li>
                <li id="trSMTPPassword" runat="server">
                    <asp:Label ID="label12" runat="server" AssociatedControlID="SMTPPassword" Text="<%$ Resources:SharedResources, Password %>" />
                    <asp:TextBox ID="SMTPPassword" TextMode="Password" runat="Server" />
                </li>
                <li id="trSMTPDomain" runat="server">
                    <asp:Label ID="label3" runat="server" AssociatedControlID="SMTPDomain" Text="Domain" />
                    <asp:TextBox ID="SMTPDomain" runat="Server" />
                </li>
                <li>
                    <asp:Label ID="label1" runat="server" AssociatedControlID="SMTPEmailFormat" CssClass="col1b"
                        Text="<%$ Resources:EmailFormat %>" />
                    <div class="labelgroup">
                        <asp:RadioButtonList ID="SMTPEmailFormat" runat="server" RepeatDirection="Horizontal">
                            <asp:ListItem Value="1" Text="Text" Selected="True" />
                            <asp:ListItem Value="2" Text="HTML" />
                        </asp:RadioButtonList>
                    </div>
                </li>
                <li>
                    <asp:Label ID="label2" runat="server" AssociatedControlID="SMTPEmailTemplateRoot"
                        Text="<%$ Resources:EmailTemplateRoot %>" />
                    <asp:TextBox ID="SMTPEmailTemplateRoot" runat="Server" />
                </li>
            </ol>
        </div>
    </ContentTemplate>
</asp:UpdatePanel>
