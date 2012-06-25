<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Shared/SingleColumn.master" Title="Login" CodeBehind="Login.aspx.cs"
    Inherits="BugNET.Account.Login" %>

<%@ Register Src="~/UserControls/LoginControl.ascx" TagName="LoginControl" TagPrefix="uc1" %>
<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="Content">
    <h1><asp:Localize runat="server" ID="Localize5" Text="Login" meta:resourcekey="LoginLabel" /></h1>
    <asp:Panel ID="LoginPanel" runat="server">
        <asp:Label ID="loginFailedLabel" meta:resourcekey="LoginFailed" runat="server" EnableViewState="False" Text="Login failed: " Visible="False" Font-Bold="True" ForeColor="Red" />
        <asp:Label ID="loginCanceledLabel" runat="server" meta:resourcekey="LoginCancelled" EnableViewState="False" Text="Login cancelled" Visible="False" Font-Bold="True" ForeColor="Red" />
    </asp:Panel>
    <p>
        <asp:Label ID="lblLoggedIn" runat="server" meta:resourcekey="AlreadyLoggedIn" Visible="false"><br />You are already logged in.</asp:Label>
    </p>
    <p>&nbsp;</p>
    <div id="login-widget">
        <div id="login-widget-content">
            <asp:ValidationSummary ID="ValidationSummary1" DisplayMode="BulletList" ValidationGroup="ctl00$Login1" HeaderText="Please correct the following" CssClass="validationSummary" runat="server" />
            <asp:Menu 
                ID="LoginTabsMenu" 
                OnMenuItemClick="LoginTabsMenu_Click" 
                runat="server" 
                IncludeStyleBlock="false" 
                ViewStateMode="Enabled"
                RenderingMode="List">
                <StaticMenuStyle CssClass="issueTabs" />
                <StaticMenuItemStyle CssClass="issueTab" />
                <StaticSelectedStyle CssClass="issueTabSelected" />
                <Items> 
                    <asp:MenuItem Text="<%$ Resources:ShowNormal.Text %>" ToolTip="<%$ Resources:ShowNormal.Text %>" Value="0" Selected="True" ></asp:MenuItem> 
                    <asp:MenuItem Text="<%$ Resources:ShowOpenID.Text %>" ToolTip="<%$ Resources:ShowOpenID.Text %>" Value="1"></asp:MenuItem> 
                </Items> 
            </asp:Menu>
            <asp:MultiView  
                ID="MultiView1" 
                runat="server" 
                ActiveViewIndex="0"> 
                <asp:View ID="tab1" runat="server">
                    <div class="login-tab">
                        <div style="font-weight: bold;">
                            <asp:Localize runat="server" ID="Localize2" Text="You can login with your member account" meta:resourcekey="LoginMemberAccount" />
                        </div>
                        <uc1:LoginControl ID="LoginControl1" runat="server" />
                    </div>
                </asp:View> 
                <asp:View ID="tab2" runat="server"> 
                    <div class="login-tab">
                        <div style="padding: 0 0 20px 0; font-weight: bold;">
                            <asp:Localize runat="server" ID="Localize1" Text="You can login using your OpenID" meta:resourcekey="LoginOpenIDAccount" />
                        </div>
                        <openAuth:OpenIdLogin ID="OpenIdLogin1" runat="server" EnableRequestProfile="true" RequestNickname="Require" OnLoggedIn="OpenIdLogin1_LoggedIn"
                            RequestEmail="Require" RequestFullName="Require" OnLoggingIn="OpenIdLogin1_LoggingIn" />
                    </div>
                </asp:View> 
            </asp:MultiView> 
        </div>
    </div>
</asp:Content>
