<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Shared/SingleColumn.master"
    Title="Login" CodeBehind="Login.aspx.cs" Inherits="BugNET.Account.Login" %>
<%@ Register Assembly="DotNetOpenAuth" Namespace="DotNetOpenAuth.OpenId.RelyingParty" TagPrefix="rp" %>
<%@ Register Src="~/UserControls/LoginControl.ascx" TagName="LoginControl" TagPrefix="uc1" %>

<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="Content">
    <h1><asp:Localize runat="server" ID="Localize5" Text="Login" meta:resourcekey="LoginLabel" /></h1>
    <asp:ValidationSummary ID="ValidationSummary1" DisplayMode="BulletList" ValidationGroup="ctl00$Login1" HeaderText="Please correct the following"
        CssClass="validationSummary" runat="server" />
    <asp:Panel ID="LoginPanel" runat="server">
        <asp:Label ID="loginFailedLabel"  meta:resourcekey="LoginFailed"   
            runat="server" EnableViewState="False" Text="Login failed: "
            Visible="False" Font-Bold="True" ForeColor="Red" />
        <asp:Label ID="loginCanceledLabel" runat="server"  
            meta:resourcekey="LoginCancelled" EnableViewState="False" Text="Login cancelled"
            Visible="False" Font-Bold="True" ForeColor="Red" />
        <asp:Panel ID="pnlOpenIDLogin" runat="server" Visible="false">
            <p style="margin: 1em 0 2em 0">
                <strong>
                    <asp:LinkButton ID="ShowNormal" runat="server" meta:resourcekey="ShowNormal" OnClick="btnShowNormal_Click" Text="Standard Login" /></strong>
            </p>
            <p>
                <strong><asp:Localize runat="server" ID="Localize1" Text="You can login using your OpenID" meta:resourcekey="LoginOpenIDAccount" /></strong></p>
            <rp:OpenIdLogin ID="OpenIdLogin1" runat="server" EnableRequestProfile="true" RequestNickname="Require"
                OnLoggedIn="OpenIdLogin1_LoggedIn" RequestEmail="Require" 
                RequestFullName="Require" onloggingin="OpenIdLogin1_LoggingIn" />
        </asp:Panel>
        <asp:Panel ID="pnlNormalLogin" runat="server" Visible="true">
            <p style="margin: 1em 0 2em 0">
                <strong>
                    <asp:LinkButton ID="btnShowOpenID" runat="server" meta:resourcekey="ShowOpenID"  OnClick="btnShowOpenID_Click" Text="OpenID Login" /></strong>
            </p>
            <p>
                <strong><asp:Localize runat="server" ID="Localize2" Text="You can login with your member account" meta:resourcekey="LoginMemberAccount" /></strong>
            </p>
            <uc1:LoginControl ID="LoginControl1" runat="server" />
        </asp:Panel>
        <asp:Panel ID="RegisterPanel" runat="server">
            <h2><asp:Localize runat="server" ID="Localize4" Text="OR" meta:resourcekey="OR" /></h2>
            <p>
                <strong><asp:Localize runat="server" ID="Localize3" Text="If you don&#39;t have an account yet you can" meta:resourcekey="NoAccount" />
                    <asp:HyperLink ID="CreateUserLink" runat="server" meta:resourcekey="CreateUserLink" NavigateUrl="~/Account/Register.aspx">click here to get one</asp:HyperLink>.</strong></p>
        </asp:Panel>
    </asp:Panel>
    <p><asp:Label ID="lblLoggedIn" runat="server" meta:resourcekey="AlreadyLoggedIn" Visible="false"><br />You are already logged in.</asp:Label></p>
    <p>&nbsp;</p>
</asp:Content>
