<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Attachments.ascx.cs" Inherits="BugNET.Issues.UserControls.Attachments" %>
<bn:Message ID="AttachmentsMessage" runat="server" />
<asp:Label ID="lblAttachments" Visible="False" Font-Italic="True" runat="server"></asp:Label>
<asp:DataGrid ID="AttachmentsDataGrid" Width="100%" runat="server" SkinID="DataGrid" OnItemDataBound="AttachmentsDataGrid_ItemDataBound"
    OnItemCommand="AttachmentsDataGrid_ItemCommand">
    <Columns>
        <asp:TemplateColumn HeaderText="<%$ Resources:SharedResources, Name %>">
            <ItemStyle Width="150px" />
            <ItemTemplate>
                <a target="_blank" id="lnkAttachment" runat="server"></a>
            </ItemTemplate>
        </asp:TemplateColumn>
        <asp:TemplateColumn HeaderText="<%$ Resources:SharedResources, Size %>">
            <ItemStyle Width="70px" />
            <ItemTemplate>
                <asp:Label ID="lblSize" runat="server" />
            </ItemTemplate>
        </asp:TemplateColumn>
        <asp:BoundColumn HeaderText="<%$ Resources:SharedResources, Description %>" DataField="Description" />
        <asp:BoundColumn HeaderText="<%$ Resources:SharedResources, Creator %>" DataField="CreatorDisplayName" />
        <asp:BoundColumn HeaderText="<%$ Resources:SharedResources, Created %>" DataField="DateCreated" DataFormatString="{0:g}" />
        <asp:TemplateColumn>
            <ItemStyle Width="16px" />
            <ItemTemplate>
                <asp:ImageButton ToolTip="<%$ Resources:SharedResources, Delete %>" AlternateText="<%$ Resources:SharedResources, Delete %>" CssClass="icon" ID="lnkDeleteAttachment" ImageUrl="~/images/cross.gif"
                    BorderWidth="0px" CommandName="Delete" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "Id") %>' runat="server" />
            </ItemTemplate>
        </asp:TemplateColumn>
    </Columns>
</asp:DataGrid>
<asp:UpdatePanel ID="upFile" runat="server">
    <Triggers>
        <asp:PostBackTrigger ControlID="UploadButton" />
    </Triggers>
    <ContentTemplate>
        <asp:Panel ID="pnlAddAttachment" CssClass="fieldgroup" runat="server">
            <h3>
                <asp:Label ID="lblAddAttachment" runat="server" meta:resourcekey="lblAddAttachment" Text="Add Attachment"></asp:Label>
            </h3>
            <ol>
                <li>
                    <asp:Label ID="Label1" runat="server" Text="File:" AssociatedControlID="AspUploadFile" />
                    <asp:FileUpload ID="AspUploadFile" runat="server" />
                </li>
                <li>
                    <asp:Label ID="Label7" runat="server" Text="Description:" AssociatedControlID="AttachmentDescription" />
                    <asp:TextBox ID="AttachmentDescription" Width="250px" runat="server" />
                </li>
            </ol>
            <div class="submit">
                <asp:Button ID="UploadButton" runat="server" OnClick="UploadDocument" meta:resourcekey="lblAddAttachment" ValidationGroup="AddAttachment"
                    Text="Add Attachment" />
            </div>
        </asp:Panel>    
    </ContentTemplate>
</asp:UpdatePanel>
