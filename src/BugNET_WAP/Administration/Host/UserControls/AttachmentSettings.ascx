<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AttachmentSettings.ascx.cs" Inherits="BugNET.Administration.Host.UserControls.AttachmentSettings" %>
<h2><asp:literal ID="LogViewerTitle" runat="Server" Text="<%$ Resources:AttachmentSettings %>"  /></h2>
<bn:Message ID="Message1" runat="server" visible="false"  /> 
<div class="fieldgroup noborder">
    <ol>
        <li>
            <asp:Label ID="label25" runat="server" AssociatedControlID="AllowedFileExtentions" Text="<%$ Resources:AllowedFileExtentions %>" />
            <asp:TextBox id="AllowedFileExtentions"  Runat="Server" /> (separated by semi colon)
        </li>
        <li>
            <asp:Label ID="label1" runat="server" AssociatedControlID="FileSizeLimit"   Text="<%$ Resources:FileSizeLimit %>" />
            <asp:TextBox id="FileSizeLimit" Width="55px"  Runat="Server" /> (bytes)
        </li>
    </ol>
</div>
