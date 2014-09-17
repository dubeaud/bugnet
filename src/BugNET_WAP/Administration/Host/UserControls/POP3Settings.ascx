<%@ Control AutoEventWireup="true" CodeBehind="POP3Settings.ascx.cs" Inherits="BugNET.Administration.Host.UserControls.POP3Settings" Language="C#" %>
<h2>
    <asp:Literal ID="Title" runat="Server" Text="<%$ Resources:POP3Settings %>" /></h2>
<div class="form-horizontal">
    <div class="form-group">
        <asp:Label ID="label13" CssClass="col-md-2 control-label" runat="server" AssociatedControlID="POP3ReaderEnabled" Text="<%$ Resources:Enable %>" />
        <div class="col-md-10">
            <div class="checkbox">
                <asp:CheckBox ID="POP3ReaderEnabled" runat="server"></asp:CheckBox>
            </div>
        </div>
    </div>
    <div class="form-group">
        <asp:Label ID="label14" CssClass="col-md-2 control-label" runat="server" AssociatedControlID="POP3Server" Text="<%$ Resources:Server %>" />
        <div class="col-md-10">
            <asp:TextBox ID="POP3Server" CssClass="form-control" runat="Server" />
        </div>
    </div>
    <div class="form-group">
        <asp:Label ID="label1" CssClass="col-md-2 control-label" runat="server" AssociatedControlID="POP3Port" Text="<%$ Resources:Port %>" />
        <div class="col-md-10">
            <asp:TextBox ID="POP3Port" CssClass="form-control" runat="Server" />
        </div>
    </div>
    <div class="form-group">
        <asp:Label ID="label15" CssClass="col-md-2 control-label" runat="server" AssociatedControlID="POP3Username" Text="<%$ Resources:SharedResources, Username %>" />
        <div class="col-md-10">
            <asp:TextBox ID="POP3Username" CssClass="form-control" runat="Server" />
        </div>
    </div>
    <div class="form-group">
        <asp:Label ID="label16" CssClass="col-md-2 control-label" runat="server" AssociatedControlID="POP3Password" Text="<%$ Resources:SharedResources, Password %>" />
        <div class="col-md-10">
            <asp:TextBox ID="POP3Password" CssClass="form-control" TextMode="Password" runat="Server" />
        </div>
    </div>
    <div class="form-group">
        <asp:Label ID="label29" CssClass="col-md-2 control-label" runat="server" AssociatedControlID="POP3UseSSL" Text="<%$ Resources:SSL %>" />
        <div class="col-md-10">
            <div class="checkbox">
                <asp:CheckBox ID="POP3UseSSL" runat="server" />
            </div>
        </div>
    </div>
    <div class="form-group">
        <asp:Label ID="label17" CssClass="col-md-2 control-label" runat="server" AssociatedControlID="POP3Interval" Text="<%$ Resources:PollingInterval %>" />
        <div class="col-md-10">
            <asp:TextBox ID="POP3Interval" CssClass="form-control" runat="Server" />
        </div>
    </div>
    <div class="form-group">
        <asp:Label ID="label18" CssClass="col-md-2 control-label" runat="server" AssociatedControlID="POP3DeleteMessages" Text="<%$ Resources:DeleteProcessedMessages %>" />
        <div class="col-md-10">
            <div class="checkbox">
                <asp:CheckBox ID="POP3DeleteMessages" runat="server"></asp:CheckBox>
            </div>
        </div>
    </div>
    <div class="form-group">
        <asp:Label ID="label2" CssClass="col-md-2 control-label" runat="server" AssociatedControlID="POP3ProcessAttachments" Text="<%$ Resources:POP3ProcessAttachments %>" />
        <div class="col-md-10">
            <div class="checkbox">
                <asp:CheckBox ID="POP3ProcessAttachments" runat="server"></asp:CheckBox>
            </div>
        </div>
    </div>
    <div class="form-group">
        <asp:Label ID="label19" CssClass="col-md-2 control-label" runat="server" AssociatedControlID="POP3InlineAttachedPictures" Text="<%$ Resources:POP3InlineAttachedPictures %>" />
        <div class="col-md-10">
            <div class="checkbox">
                <asp:CheckBox ID="POP3InlineAttachedPictures" runat="server"></asp:CheckBox>
            </div>
        </div>
    </div>
    <div class="form-group">
        <asp:Label ID="label20" CssClass="col-md-2 control-label" runat="server" AssociatedControlID="POP3BodyTemplate" Text="<%$ Resources:BodyTemplate %>" />
        <div class="col-md-10">
            <asp:TextBox ID="POP3BodyTemplate" CssClass="form-control" runat="Server" />
        </div>
    </div>
    <div class="form-group">
        <asp:Label ID="label21" CssClass="col-md-2 control-label" runat="server" AssociatedControlID="POP3ReportingUsername" Text="<%$ Resources:ReportingUsername %>" />
        <div class="col-md-10">
            <asp:TextBox ID="POP3ReportingUsername" CssClass="form-control" runat="Server" />
        </div>
    </div>
</div>
