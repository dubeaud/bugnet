<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AuthenticationSettings.ascx.cs"
    Inherits="BugNET.Administration.Host.UserControls.AuthenticationSettings" %>
<h2><asp:Literal ID="Title" runat="Server" Text="<%$ Resources:AuthenticationSettings %>" /></h2>
<asp:UpdatePanel ID="UpdatePanel1" runat="server" ChildrenAsTriggers="true">
    <ContentTemplate>
        <div class="fieldgroup noborder">
            <ol>
                <li>
                    <asp:Label ID="label2" runat="server" AssociatedControlID="UserAccountSource" Text="<%$ Resources:UserAccountSource %>" />
                    <div class="labelgroup">
                        <asp:RadioButtonList RepeatDirection="Horizontal"  OnSelectedIndexChanged="UserAccountSource_SelectedIndexChanged"
                            AutoPostBack="true" TextAlign="Left" ID="UserAccountSource" runat="server">
                            <asp:ListItem id="option3" runat="server" Value="None"  />
                            <asp:ListItem id="option1" runat="server" Value="WindowsSAM" />
                            <asp:ListItem id="option2" runat="server" Value="ActiveDirectory" />
                        </asp:RadioButtonList>
                    </div>
                </li>
                <li>
                    <asp:Label ID="label8" runat="server" AssociatedControlID="UserRegistration"
                        Text="User Registration" meta:resourceKey="UserRegistration" />
                    <div class="labelgroup">
                        <asp:RadioButtonList RepeatDirection="Horizontal"  TextAlign="Left" ID="UserRegistration" runat="server">
                            <asp:ListItem id="option4" runat="server"  meta:resourceKey="UserRegistration_None" Text="None" Value="0"  />
                            <asp:ListItem id="option5" runat="server"  meta:resourceKey="UserRegistration_Public" Text="Public" Value="1" />
                            <asp:ListItem id="option6" runat="server"   meta:resourceKey="UserRegistration_Verified" Text="Verified" Value="2" />
                        </asp:RadioButtonList>
                    </div>
                </li>
                <li id="trADPath" runat="server">
                    <asp:Label ID="label25" runat="server" AssociatedControlID="ADPath" Text="<%$ Resources:DomainPath %>" />
                    <asp:TextBox ID="ADPath" runat="Server" />
                </li>
                <li id="trADUserName" runat="server">
                    <asp:Label ID="label4" runat="server" AssociatedControlID="ADUserName" Text="<%$ Resources:SharedResources, Username %>" />
                    <asp:TextBox ID="ADUserName" runat="Server" />
                </li>
                <li id="trADPassword" runat="server">
                    <asp:Label ID="label5" runat="server" AssociatedControlID="ADPassword" Text="<%$ Resources:SharedResources, Password %>" />
                    <asp:TextBox TextMode="Password" ID="ADPassword" runat="Server" />
                </li>
                <li>
                    <asp:Label ID="label7" runat="server" AssociatedControlID="AnonymousAccess"
                        Text="Anonymous User Access" meta:resourceKey="AnonymousAccess" />
                    <div class="labelgroup">
                        <asp:RadioButtonList ID="AnonymousAccess" runat="server" RepeatDirection="Horizontal">
                            <asp:ListItem Text="<%$ Resources:SharedResources, Enable %>" Value="True" Selected="True" />
                            <asp:ListItem Text="<%$ Resources:SharedResources, Disable %>" Value="False"  />
                        </asp:RadioButtonList>
                    </div>
                </li>
                
                <li>
                    <asp:Label ID="label1" runat="server" AssociatedControlID="OpenIdAuthentication"
                        Text="<%$ Resources:OpenIdAuthentication %>" />
                    <div class="labelgroup">
                        <asp:RadioButtonList ID="OpenIdAuthentication" runat="server" RepeatDirection="Horizontal">
                            <asp:ListItem Text="<%$ Resources:SharedResources, Enable %>" Value="True" />
                            <asp:ListItem Text="<%$ Resources:SharedResources, Disable %>" Value="False" Selected="True" />
                        </asp:RadioButtonList>
                    </div>
                </li>
            </ol>
        </div>
    </ContentTemplate>
</asp:UpdatePanel>
