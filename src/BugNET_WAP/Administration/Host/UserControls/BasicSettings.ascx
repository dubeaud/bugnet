<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="BasicSettings.ascx.cs" Inherits="BugNET.Administration.Host.UserControls.BasicSettings" %>
<h2>
    <asp:Literal ID="Title" runat="Server" Text="<%$ Resources:BasicSettings %>" /></h2>
<bn:Message ID="Message1" runat="server" Visible="false" />
<div class="form-horizontal">
    <div class="form-group">
        <asp:Label ID="lblApplicationTitle" CssClass="col-md-3 control-label" runat="server" AssociatedControlID="ApplicationTitle" Text="<%$ Resources:Title %>" />
        <div class="col-md-9">
            <asp:TextBox ID="ApplicationTitle" CssClass="form-control" runat="Server" MaxLength="500"></asp:TextBox>
        </div>
    </div>
    <div class="form-group">
        <asp:Label ID="label1" CssClass="col-md-3 control-label" runat="server" AssociatedControlID="WelcomeMessageHtmlEditor" Text="<%$ Resources:WelcomeMessage %>" />
        <div class="col-md-9">
            <bn:HtmlEditor ID="WelcomeMessageHtmlEditor" runat="server" />
        </div>
    </div>
    <div class="form-group">
        <asp:Label ID="label2" CssClass="col-md-3 control-label" runat="server" AssociatedControlID="DefaultUrl" Text="<%$ Resources:DefaultUrl %>" />
        <div class="col-md-9">
            <asp:TextBox ID="DefaultUrl" runat="Server" CssClass="form-control" />
        </div>
    </div>
    <div class="form-group">
        <asp:Label ID="lblEnableGravatar" CssClass="col-md-3 control-label" runat="server" AssociatedControlID="EnableGravatar" Text="[Enable Gravatar]" meta:resourcekey="lblEnableGravatar" />
        <div class="col-md-9">
            <div class="checkbox">
                <asp:CheckBox ID="EnableGravatar" runat="Server" />
            </div>
        </div>
    </div>
</div>