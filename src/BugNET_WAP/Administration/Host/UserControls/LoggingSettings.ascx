<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="LoggingSettings.ascx.cs"
    Inherits="BugNET.Administration.Host.UserControls.LoggingSettings" %>
<h2>
    <asp:Literal ID="Title" runat="Server" Text="<%$ Resources:LoggingSettings %>" /></h2>
<bn:Message ID="Message1" runat="server" Visible="false" />
<div class="form-horizontal">
    <div class="form-group">
        <asp:Label ID="label23" CssClass="col-md-2 control-label" runat="server" AssociatedControlID="EmailErrors" Text="<%$ Resources:EmailErrorMessages %>" />
        <div class="col-md-10">
            <div class="checkbox">
                <asp:CheckBox ID="EmailErrors" runat="server"></asp:CheckBox>
            </div>
        </div>
    </div>
    <div class="form-group">
        <asp:Label ID="label24" runat="server" AssociatedControlID="ErrorLoggingEmail" CssClass="col-md-2 control-label"
            Text="<%$ Resources:FromAddress %>" />
        <div class="col-md-10">
            <asp:TextBox ID="ErrorLoggingEmail" CssClass="form-control" runat="Server" />
        </div>
    </div>
</div>
