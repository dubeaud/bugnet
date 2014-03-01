<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AttachmentSettings.ascx.cs"
    Inherits="BugNET.Administration.Host.UserControls.AttachmentSettings" %>
<h2>
    <asp:Literal ID="LogViewerTitle" runat="Server" Text="<%$ Resources:AttachmentSettings %>" /></h2>
<bn:Message ID="Message1" runat="server" Visible="false" />
<div class="form-horizontal">
    <div class="form-group">        
            <asp:Label ID="lblAllowedFileExtentions" CssClass="col-md-2 control-label" runat="server" AssociatedControlID="AllowedFileExtentions"
                Text="<%$ Resources:AllowedFileExtentions %>" />
        <div class="col-md-5">
            <asp:TextBox ID="AllowedFileExtentions" CssClass="form-control" runat="Server" />&nbsp;<asp:Localize ID="lclSeperation"
                runat="server" Text="[ (separated by semi colon)]" meta:resourcekey="lclSeperation" />
            </div>
        </div>
        <div class="form-group">
            <asp:Label ID="lblFileSizeLimit" CssClass="col-md-2 control-label" runat="server" AssociatedControlID="FileSizeLimit"
                Text="<%$ Resources:FileSizeLimit %>" />
            <div class="col-md-5">
            <asp:TextBox ID="FileSizeLimit"  CssClass="form-control" runat="Server" />&nbsp;<asp:Localize
                ID="lclBytes" runat="server" Text=" [ (bytes)]" meta:resourcekey="lclBytes" />
                </div>
        </div>
    </div>
</div>
