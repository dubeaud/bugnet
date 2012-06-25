<%@ Control Language="C#" AutoEventWireup="true" Inherits="BugNET.UserControls.Banner" CodeBehind="Banner.ascx.cs" %>
<div id="dashboard">
    <asp:LoginView ID="LoginView1" runat="server">
        <LoggedInTemplate>
            <span style="padding-left: 15px;">
                <asp:LinkButton ID="Profile" runat="server" OnClick="Profile_Click" CausesValidation="false">
                    <asp:Image ID="EditProfile" runat="server" CssClass="icon" Style="padding-right: 2px;" Visible="false" ImageUrl="~/images/user.gif" />
                    <asp:LoginName ID="LoginName1" FormatString='<%# DisplayName %>' runat="server" />
                </asp:LinkButton>
                <asp:Label ID="lblBar" runat="server" Text=" | " />
                <asp:LoginStatus ID="LoginStatus1" LogoutPageUrl="~/Default.aspx" LogoutAction="Redirect" meta:resourcekey="LoginStatus1"
                    runat="server" />
            </span>
        </LoggedInTemplate>
        <AnonymousTemplate>
            <span style="padding-left: 15px;">
                <asp:HyperLink ID="lnkRegister" NavigateUrl="~/Account/Register.aspx" runat="server" Text="Register" meta:resourcekey="lnkRegister"></asp:HyperLink>
                <asp:Label ID="lblBar" runat="server" Text=" | " />
                <asp:LoginStatus ID="LoginStatus1" runat="server" meta:resourcekey="LoginStatus1" />
            </span>
        </AnonymousTemplate>
    </asp:LoginView>
    <asp:Panel ID="Panel1" runat="server" DefaultButton="btnSearch">
        <p id="search">
            <asp:Label ID="QuickError" Visible="false" runat="server" ForeColor="Red" />
            &nbsp;<asp:TextBox ID="txtIssueId" Height="12" Width="80" runat="Server" />
            <asp:LinkButton ID="btnSearch" OnClick="btnSearch_Click" CausesValidation="false" runat="server" Text="Search" meta:resourcekey="btnSearch" />
            &nbsp;|
        </p>
    </asp:Panel>
    <p id="help">
        <a target="_blank" href="http://bugnetproject.com/Documentation/tabid/57/topic/User%20Guide/Default.aspx">
            <asp:Localize runat="server" ID="HelpText" Text="Help" meta:resourcekey="Help" /></a>
    </p>
</div>
<div id="header">
    <h1 class="title">
        <asp:HyperLink ID="lnkLogo" runat="server" NavigateUrl="~/Default.aspx">
            <asp:Image CssClass="logo" runat="server" SkinID="Logo" ID="Logo" AlternateText="Logo" /><asp:Literal ID="AppTitle" runat="server"></asp:Literal>
        </asp:HyperLink>
    </h1>
    <script type="text/javascript">

        $(document).ready(function () {
            $("ul.sf-menu").supersubs({
                minWidth: 15,   // minimum width of sub-menus in em units 
                maxWidth: 16,   // maximum width of sub-menus in em units 
                extraWidth: 5     // extra width can ensure lines don't sometimes turn over 
                // due to slight rounding differences and font-family 
            }).superfish();  // call supersubs first, then superfish, so that subs are 
            // not display:none when measuring. Call before initialising 
            // containing tabs for same reason. 
        }); 
 
    </script>

    <div id="mainMenu">
        <asp:Literal ID="litSucker" Visible="true" runat="server"></asp:Literal>
    </div>
</div>
<asp:Panel ID="pnlHeaderNav" CssClass="header-nav" runat="server">
    <asp:DropDownList CssClass="header-nav-ddl" ID="ddlProject" OnSelectedIndexChanged="ddlProject_SelectedIndexChanged" AutoPostBack="true"
        runat="server">
        <asp:ListItem Text="BugNET" Value="BugNET"></asp:ListItem>
    </asp:DropDownList>
</asp:Panel>
<div id="BreadCrumb" class="breadcrumb" runat="server" clientmode="Static">
    <asp:SiteMapPath ID="SiteMapPath1" PathSeparator=" > " runat="server" SkipLinkText=""/>
</div>
