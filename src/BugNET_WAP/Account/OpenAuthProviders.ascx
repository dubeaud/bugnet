<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="OpenAuthProviders.ascx.cs" Inherits="BugNET.Account.OpenAuthProviders" %>
<%@ Import Namespace="Microsoft.AspNet.Membership.OpenAuth" %>
<div id="socialLoginList" runat="server">
    <h4>Use another service to log in.</h4>
    <hr />
    <asp:ListView runat="server" ID="providersList" ViewStateMode="Disabled">
        <ItemTemplate>
            <button type="submit" class="btn btn-default btn-signup" name="provider" value="<%# HttpUtility.HtmlAttributeEncode(Item<ProviderDetails>().ProviderName) %>"
                id="<%# HttpUtility.HtmlAttributeEncode(Item<ProviderDetails>().ProviderName) %>-button" title="Log in using your <%# HttpUtility.HtmlAttributeEncode(Item<ProviderDetails>().ProviderDisplayName) %> account.">
                <i></i>
                <span>Sign in with <%# HttpUtility.HtmlEncode(Item<ProviderDetails>().ProviderDisplayName) %></span>
            </button>
        </ItemTemplate>
    </asp:ListView>
</div>