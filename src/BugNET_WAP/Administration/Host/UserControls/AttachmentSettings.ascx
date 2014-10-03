<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AttachmentSettings.ascx.cs"
    Inherits="BugNET.Administration.Host.UserControls.AttachmentSettings" %>
<h2>
    <asp:Literal ID="LogViewerTitle" runat="Server" Text="<%$ Resources:AttachmentSettings %>" /></h2>
<bn:Message ID="Message1" runat="server" Visible="false" />
<div class="form-horizontal">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" ChildrenAsTriggers="true">
        <ContentTemplate>
            <div class="form-group">
                <asp:Label ID="Label4" AssociatedControlID="AllowAttachments"
                    CssClass="col-md-2 control-label" runat="server" meta:resourcekey="EnableAttachmentsLabel" Text="Enable Attachments"></asp:Label>
                <div class="col-md-10">
                    <div class="checkbox">
                        <asp:CheckBox CssClass="inputCheckBox" ID="AllowAttachments" AutoPostBack="true" OnCheckedChanged="AllowAttachmentsChanged" runat="server" />
                    </div>
                </div>
            </div>
            <div class="form-group" id="AttachmentStorageTypeRow" runat="server" visible="false">
                <asp:Label ID="Label10" CssClass="col-md-2 control-label"
                    AssociatedControlID="AttachmentStorageType" meta:resourcekey="AttachmentStorageTypeLabel" runat="server" Text="Storage Type"></asp:Label>
                <div class="col-md-8">
                    <asp:RadioButtonList ID="AttachmentStorageType" CssClass="radio" RepeatLayout="Flow" OnSelectedIndexChanged="AttachmentStorageType_Changed" RepeatDirection="Vertical" AutoPostBack="true" runat="server">
                        <asp:ListItem Text="Database" Selected="True" Value="2" meta:resourcekey="AttachmentStorageTypeDb" />
                        <asp:ListItem Text="File System" Value="1" meta:resourcekey="AttachmentStorageTypeFs" />
                    </asp:RadioButtonList>
                </div>
            </div>
            <div class="form-group" id="AttachmentUploadPathRow" runat="server" visible="false">
                <asp:Label CssClass="col-md-2 control-label" ID="Label5" AssociatedControlID="txtUploadPath" meta:resourcekey="UploadPath" runat="server" Text="Upload Path" />
                <div class="col-md-10">
                    <asp:TextBox ID="txtUploadPath" CssClass="form-control" runat="Server" Text="~\Uploads" />
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    <div class="form-group">
        <asp:Label ID="lblAllowedFileExtentions" CssClass="col-md-2 control-label" runat="server" AssociatedControlID="AllowedFileExtentions"
            Text="<%$ Resources:AllowedFileExtentions %>" />
        <div class="col-md-10">
            <asp:TextBox ID="AllowedFileExtentions" CssClass="form-control" runat="Server" />
            <p class="help-block">
                <asp:Localize ID="lclSeperation" runat="server" Text="[ (separated by semi colon)]" meta:resourcekey="lclSeperation" />
            </p>

        </div>
    </div>
    <div class="form-group">
        <asp:Label ID="lblFileSizeLimit" CssClass="col-md-2 control-label" runat="server" AssociatedControlID="FileSizeLimit"
            Text="<%$ Resources:FileSizeLimit %>" />
        <div class="col-md-10">
            <p class="form-control-static">
                <asp:Label ID="FileSizeLimit" runat="Server" />
            </p>
            <p class="help-block">
                <asp:Localize ID="lclBytes" runat="server" Text="" meta:resourcekey="lclBytes" />
            </p>
        </div>
    </div>
</div>

