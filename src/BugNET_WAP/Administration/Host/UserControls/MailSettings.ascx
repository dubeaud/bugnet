<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MailSettings.ascx.cs"
    Inherits="BugNET.Administration.Host.UserControls.MailSettings" %>
<h2>
    <asp:Literal ID="Title" runat="Server" Text="<%$ Resources:MailSettings %>" /></h2>
<asp:UpdatePanel ID="UpdatePanel1" runat="server" ChildrenAsTriggers="true">
    <ContentTemplate>
        <div class="form-horizontal">
            <div class="form-group">
                <asp:Label ID="lblSMTPServer" CssClass="col-md-2 control-label" runat="server" AssociatedControlID="SMTPServer" Text="<%$ Resources:Server %>" />
                <div class="col-md-7">
                    <asp:TextBox ID="SMTPServer" CssClass="form-control" runat="Server" />
                </div>
                <div class="col-md-1">
                    <asp:LinkButton ID="TestEmailSettings" runat="server" OnClick="TestEmailSettings_Click" Text="[Test]" meta:resourcekey="TestEmailSettings" />
                    <asp:Label ID="lblEmail" runat="server" Font-Bold="true" />
                </div>
            </div>
            <div class="form-group">
                <asp:Label ID="lblSMTPPort" runat="server" AssociatedControlID="SMTPPort" CssClass="col-md-2 control-label" Text="<%$ Resources:Port %>" />
                <div class="col-md-10">
                    <asp:TextBox ID="SMTPPort" CssClass="form-control" runat="Server" />
                </div>
            </div>
            <div class="form-group">
                <asp:Label ID="lblHostEmail" CssClass="col-md-2 control-label" runat="server" AssociatedControlID="HostEmail" Text="<%$ Resources:HostEmail %>" />
                <div class="col-md-10">
                    <asp:TextBox ID="HostEmail" CssClass="form-control" runat="Server" />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" Display="Dynamic" Text="<%$ Resources:SharedResources, Required %>" ControlToValidate="HostEmail" />
                    <asp:RegularExpressionValidator ID="regexEmailValid" runat="server" ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ControlToValidate="HostEmail" ErrorMessage="[Invalid Email Format]" Text="[Invalid Email Format]" meta:resourcekey="regexEmailValid" />
                </div>
            </div>
            <div class="form-group">
                <asp:Label ID="lblSSL" runat="server" AssociatedControlID="SMTPUseSSL" CssClass="col-md-2 control-label" Text="[SSL]" meta:resourcekey="lblSSL" />
                <div class="col-md-10">
                    <div class="checkbox">
                        <asp:CheckBox ID="SMTPUseSSL" runat="server" />
                    </div>
                </div>
            </div>
            <div class="form-group">
                <asp:Label ID="lblSMTPEnableAuthentication" CssClass="col-md-2 control-label" runat="server" AssociatedControlID="SMTPEnableAuthentication" Text="<%$ Resources:EnableAuthentication %>" />
                <div class="col-md-10">
                    <div class="checkbox">
                        <asp:CheckBox ID="SMTPEnableAuthentication" AutoPostBack="true" OnCheckedChanged="SMTPEnableAuthentication_CheckChanged" runat="server" />
                    </div>
                </div>
            </div>
            <div class="form-group" id="trSMTPUsername" runat="server">
                <asp:Label ID="lblSMTPUsername" CssClass="col-md-2 control-label" runat="server" AssociatedControlID="SMTPUsername" Text="<%$ Resources:SharedResources, Username %>" />
                <div class="col-md-10">
                    <asp:TextBox ID="SMTPUsername" CssClass="form-control" runat="Server" />
                </div>
            </div>
            <div class="form-group" id="trSMTPPassword" runat="server">
                <asp:Label ID="lblSMTPPassword" CssClass="col-md-2 control-label" runat="server" AssociatedControlID="SMTPPassword" Text="<%$ Resources:SharedResources, Password %>" />
                <div class="col-md-10">
                    <asp:TextBox ID="SMTPPassword" CssClass="form-control" TextMode="Password" runat="Server" />
                </div>
            </div>
            <div class="form-group" id="trSMTPDomain" runat="server">
                <asp:Label ID="lblSMTPDomain" CssClass="col-md-2 control-label" runat="server" AssociatedControlID="SMTPDomain" Text="[Domain]" meta:resourcekey="lblSMTPDomain" />
                <div class="col-md-10">
                    <asp:TextBox ID="SMTPDomain" CssClass="form-control" runat="Server" /></div>
            </div>
            <div class="form-group">
                <asp:Label ID="lblSMTPEmailFormat" runat="server" AssociatedControlID="SMTPEmailFormat" CssClass="col-md-2 control-label" Text="<%$ Resources:EmailFormat %>" />
                <div class="col-md-10">
                    <asp:RadioButtonList ID="SMTPEmailFormat" runat="server" RepeatLayout="Flow" CssClass="radio" RepeatDirection="Horizontal">
                        <asp:ListItem Value="1" Text="Text" Selected="True" meta:resourcekey="SMTPEmailFormat_Text" />
                        <asp:ListItem Value="2" Text="HTML" meta:resourcekey="SMTPEmailFormat_HTML" />
                    </asp:RadioButtonList>
                </div>
            </div>
            <div class="form-group">
                <asp:Label ID="lblSMTPEmailTemplateRoot" CssClass="col-md-2 control-label" runat="server" AssociatedControlID="SMTPEmailTemplateRoot" Text="<%$ Resources:EmailTemplateRoot %>" />
                <div class="col-md-10">
                    <asp:TextBox ID="SMTPEmailTemplateRoot" CssClass="form-control" runat="Server" /></div>
            </div>
        </div>
    </ContentTemplate>
</asp:UpdatePanel>
