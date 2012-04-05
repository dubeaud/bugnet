<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AttachmentSettings.ascx.cs"
    Inherits="BugNET.Administration.Host.UserControls.AttachmentSettings" %>
<h2>
    <asp:Literal ID="LogViewerTitle" runat="Server" Text="<%$ Resources:AttachmentSettings %>" /></h2>
<bn:Message ID="Message1" runat="server" Visible="false" />
<div class="fieldgroup noborder">
    <ol>
        <li>
            <asp:Label ID="lblAllowedFileExtentions" runat="server" AssociatedControlID="AllowedFileExtentions"
                Text="<%$ Resources:AllowedFileExtentions %>" />
            <asp:TextBox ID="AllowedFileExtentions" runat="Server" />&nbsp;<asp:Localize ID="lclSeperation"
                runat="server" Text="[ (separated by semi colon)]" meta:resourcekey="lclSeperation" />
        </li>
        <li>
            <asp:Label ID="lblFileSizeLimit" runat="server" AssociatedControlID="FileSizeLimit"
                Text="<%$ Resources:FileSizeLimit %>" />
            <asp:TextBox ID="FileSizeLimit" Width="55px" runat="Server" />&nbsp;<asp:Localize
                ID="lclBytes" runat="server" Text=" [ (bytes)]" meta:resourcekey="lclBytes" />
        </li>
    </ol>
</div>
