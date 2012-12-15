<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Attachments.ascx.cs" Inherits="BugNET.Issues.UserControls.Attachments" %>
<bn:Message ID="AttachmentsMessage" runat="server" />
<asp:Label ID="lblAttachments" Visible="False" Font-Italic="True" runat="server"></asp:Label>
<asp:DataGrid ID="AttachmentsDataGrid" Width="100%" runat="server" SkinID="DataGrid" OnItemDataBound="AttachmentsDataGridItemDataBound"
    OnItemCommand="AttachmentsDataGridItemCommand">
    <Columns>
        <asp:TemplateColumn HeaderText="<%$ Resources:SharedResources, Name %>">
            <ItemStyle Width="250" />
            <ItemTemplate>
                <a target="_blank" id="lnkAttachment" runat="server"></a>
            </ItemTemplate>
        </asp:TemplateColumn>
        <asp:TemplateColumn HeaderText="<%$ Resources:SharedResources, Size %>">
            <ItemStyle Width="70" />
            <ItemTemplate>
                <asp:Label ID="lblSize" runat="server" />
            </ItemTemplate>
        </asp:TemplateColumn>
        <asp:BoundColumn HeaderText="<%$ Resources:SharedResources, Description %>" DataField="Description" />
        <asp:BoundColumn HeaderText="<%$ Resources:SharedResources, Creator %>" DataField="CreatorDisplayName">
            <ItemStyle Width="200" />
        </asp:BoundColumn>
        <asp:BoundColumn HeaderText="<%$ Resources:SharedResources, Created %>" DataField="DateCreated" DataFormatString="{0:g}">
            <ItemStyle Width="150" />
        </asp:BoundColumn>
        <asp:TemplateColumn>
            <ItemStyle Width="16" />
            <ItemTemplate>
                <asp:ImageButton ID="cmdDelete" ToolTip="<%$ Resources:SharedResources, Delete %>" AlternateText="<%$ Resources:SharedResources, Delete %>" CssClass="icon" ImageUrl="~/images/cross.gif"
                    BorderWidth="0px" CommandName="Delete" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "Id") %>' runat="server" Visible="false" />
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
                    <asp:Label ID="Label1" runat="server" Text="File:" AssociatedControlID="AspUploadFile" meta:resourcekey="FileLabel" />
                    <asp:FileUpload ID="AspUploadFile" runat="server" />
                </li>
                <li>
                    <asp:Label ID="Label7" runat="server" Text="Description:" AssociatedControlID="AttachmentDescription" meta:resourcekey="DescriptionLabel"/>
                    <asp:TextBox ID="AttachmentDescription" Width="350" runat="server" />
                </li>
            </ol>
            <div class="submit">
                <asp:Button ID="UploadButton" runat="server" OnClick="UploadDocument" meta:resourcekey="btnAddAttachment" ValidationGroup="AddAttachment"
                    Text="Add Attachment" />
            </div>
        </asp:Panel>    
    </ContentTemplate>
</asp:UpdatePanel>
