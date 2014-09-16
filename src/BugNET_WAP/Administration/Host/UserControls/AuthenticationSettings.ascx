<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AuthenticationSettings.ascx.cs"
    Inherits="BugNET.Administration.Host.UserControls.AuthenticationSettings" %>
<h2>
    <asp:Literal ID="Title" runat="Server" Text="<%$ Resources:AuthenticationSettings %>" /></h2>
<asp:UpdatePanel ID="UpdatePanel1" runat="server" ChildrenAsTriggers="true">
    <ContentTemplate>
        <div class="form-horizontal">
            <div class="form-group">
                <asp:Label ID="label2" runat="server" CssClass="col-md-2 control-label" AssociatedControlID="UserAccountSource" Text="<%$ Resources:UserAccountSource %>" />
                <div class="col-md-10">
                    <asp:RadioButtonList RepeatDirection="Horizontal" CssClass="radio" OnSelectedIndexChanged="UserAccountSource_SelectedIndexChanged"
                        AutoPostBack="true" RepeatLayout="Flow" ID="UserAccountSource" runat="server">
                        <asp:ListItem runat="server" Value="None" meta:resourceKey="UserAccountSource_None" />
                        <asp:ListItem runat="server" Value="WindowsSAM" meta:resourceKey="UserAccountSource_WindowsSAM" />
                        <asp:ListItem runat="server" Value="ActiveDirectory" meta:resourceKey="UserAccountSource_AD" />
                    </asp:RadioButtonList>
                </div>
            </div>
            <div class="form-group">
                <asp:Label ID="label8" CssClass="col-md-2 control-label" runat="server" AssociatedControlID="UserRegistration"
                    Text="User Registration" meta:resourceKey="UserRegistration" />
                <div class="col-md-10">
                    <asp:RadioButtonList RepeatDirection="Horizontal" CssClass="radio" RepeatLayout="Flow" ID="UserRegistration" runat="server">
                        <asp:ListItem runat="server" meta:resourceKey="UserRegistration_None" Text="None" Value="0" />
                        <asp:ListItem runat="server" meta:resourceKey="UserRegistration_Verified" Text="Verified" Value="2" />
                    </asp:RadioButtonList>
                </div>
            </div>
            <div class="form-group" id="trADPath" runat="server">
                <asp:Label ID="label25" CssClass="col-md-2 control-label" runat="server" AssociatedControlID="ADPath" Text="<%$ Resources:DomainPath %>" />
                <div class="col-md-10">
                    <asp:TextBox ID="ADPath" CssClass="form-control" runat="Server" />
                </div>
            </div>
            <div class="form-group" id="trADUserName" runat="server">
                <asp:Label ID="label4" CssClass="col-md-2 control-label" runat="server" AssociatedControlID="ADUserName" Text="<%$ Resources:SharedResources, Username %>" />
                <div class="col-md-10">
                    <asp:TextBox ID="ADUserName" CssClass="form-control" runat="Server" />
                </div>
            </div>
            <div class="form-group" id="trADPassword" runat="server">
                <asp:Label ID="label5" CssClass="col-md-2 control-label" runat="server" AssociatedControlID="ADPassword" Text="<%$ Resources:SharedResources, Password %>" />
                <div class="col-md-10">
                    <asp:TextBox TextMode="Password" ID="ADPassword" CssClass="form-control" runat="Server" />
                </div>
            </div>
            <div class="form-group">
                <asp:Label ID="label7" CssClass="col-md-2 control-label" runat="server" AssociatedControlID="AnonymousAccess"
                    Text="Anonymous User Access" meta:resourceKey="AnonymousAccess" />
                <div class="col-md-10">
                    <asp:RadioButtonList ID="AnonymousAccess" CssClass="radio" RepeatLayout="Flow" runat="server" RepeatDirection="Horizontal">
                        <asp:ListItem Text="<%$ Resources:SharedResources, Enable %>" Value="True" Selected="True" />
                        <asp:ListItem Text="<%$ Resources:SharedResources, Disable %>" Value="False" />
                    </asp:RadioButtonList>
                </div>
            </div>
            <h3><asp:Literal ID="literal1" runat="server" Text="<%$ Resources:OAuthOpenID %>"/></h3>
            <hr>
            <h4>Facebook</h4>
            <div class="form-group">
                <asp:Label ID="label13" CssClass="col-md-2 control-label" runat="server" AssociatedControlID="FacebookAuthentication" Text="<%$ Resources:SharedResources, Enable %>" />
                <div class="col-md-10">
                    <div class="checkbox">
                        <asp:CheckBox ID="FacebookAuthentication" runat="server"></asp:CheckBox>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <asp:Label ID="label3" CssClass="col-md-2 control-label" runat="server" AssociatedControlID="FacebookAppId"
                    Text="<%$ Resources:FacebookAppId %>" />
                 <div class="col-md-10">
                    <asp:TextBox ID="FacebookAppId" CssClass="form-control" runat="Server" />
                </div>
            </div>
            <div class="form-group">
                <asp:Label ID="label6" CssClass="col-md-2 control-label" runat="server" AssociatedControlID="FacebookAppSecret"
                    Text="<%$ Resources:FacebookAppSecret %>" />
                 <div class="col-md-10">
                    <asp:TextBox ID="FacebookAppSecret" CssClass="form-control" TextMode="Password" runat="Server" />
                </div>
            </div>
            <h4>Twitter</h4>
            <div class="form-group">
                <asp:Label ID="label9" CssClass="col-md-2 control-label" runat="server" AssociatedControlID="TwitterAuthentication" Text="<%$ Resources:SharedResources, Enable %>" />
                <div class="col-md-10">
                    <div class="checkbox">
                        <asp:CheckBox ID="TwitterAuthentication" runat="server"></asp:CheckBox>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <asp:Label ID="label10" CssClass="col-md-2 control-label" runat="server" AssociatedControlID="TwitterConsumerKey"
                    Text="<%$ Resources:TwitterConsumerKey %>" />
                 <div class="col-md-10">
                    <asp:TextBox ID="TwitterConsumerKey" CssClass="form-control" runat="Server" />
                </div>
            </div>

            <div class="form-group">
                <asp:Label ID="label11" CssClass="col-md-2 control-label" runat="server" AssociatedControlID="TwitterConsumerSecret"
                    Text="<%$ Resources:TwitterConsumerSecret %>" />
                 <div class="col-md-10">
                    <asp:TextBox ID="TwitterConsumerSecret" CssClass="form-control" TextMode="Password" runat="Server" />
                </div>
            </div>
            <h4>Google</h4>
            <div class="form-group">
                <asp:Label ID="label12" CssClass="col-md-2 control-label" runat="server" AssociatedControlID="GoogleAuthentication" Text="<%$ Resources:SharedResources, Enable %>" />
                <div class="col-md-10">
                    <div class="checkbox">
                        <asp:CheckBox ID="GoogleAuthentication" runat="server"></asp:CheckBox>
                    </div>
                </div>
            </div>
            <h4>Microsoft Account</h4>
            <div class="form-group">
                <asp:Label ID="label14" CssClass="col-md-2 control-label" runat="server" AssociatedControlID="MicrosoftAuthentication" Text="<%$ Resources:SharedResources, Enable %>" />
                <div class="col-md-10">
                    <div class="checkbox">
                        <asp:CheckBox ID="MicrosoftAuthentication" runat="server"></asp:CheckBox>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <asp:Label ID="label15" CssClass="col-md-2 control-label" runat="server" AssociatedControlID="MicrosoftClientId"
                    Text="<%$ Resources:MicrosoftClientId %>" />
                 <div class="col-md-10">
                    <asp:TextBox ID="MicrosoftClientId" CssClass="form-control" runat="Server" />
                </div>
            </div>
            <div class="form-group">
                <asp:Label ID="label16" CssClass="col-md-2 control-label" runat="server" AssociatedControlID="MicrosoftClientSecret"
                    Text="<%$ Resources:MicrosoftClientSecret %>" />
                 <div class="col-md-10">
                    <asp:TextBox ID="MicrosoftClientSecret" CssClass="form-control" TextMode="Password" runat="Server" />
                </div>
            </div>
        </div>
    </ContentTemplate>
</asp:UpdatePanel>
