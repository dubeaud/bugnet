<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="OpenAuthProviders.ascx.cs" Inherits="BugNET.Account.OpenAuthProviders" %>
<%@ Import Namespace="Microsoft.AspNet.Membership.OpenAuth" %>
<div id="socialLoginList" runat="server">
    <h4><asp:Localize runat="server" Text="[Resource required]" meta:resourcekey="UseAnotherService"/></h4>
    <hr />
    <asp:ListView runat="server" ID="providersList" ViewStateMode="Disabled">
        <ItemTemplate>
            <button type="submit" class="btn btn-default btn-signup" name="provider" value="<%# HttpUtility.HtmlAttributeEncode(Item<ProviderDetails>().ProviderName) %>"
                id="<%# HttpUtility.HtmlAttributeEncode(Item<ProviderDetails>().ProviderName) %>-button" title="<%# HttpUtility.HtmlAttributeEncode(GetLocalizedTitleAttribute()) %>">
                <i></i>
                <span><%# HttpUtility.HtmlEncode(GetLocalizedText()) %></span>
            </button>
        </ItemTemplate>
    </asp:ListView>
</div>