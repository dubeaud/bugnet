<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Attachments.ascx.cs" Inherits="BugNET.Issues.UserControls.Attachments" %>
<bn:Message ID="AttachmentsMessage" runat="server" />
<asp:Label ID="lblAttachments" Visible="False" Font-Italic="True" runat="server"></asp:Label>
<asp:DataGrid ID="AttachmentsDataGrid" Width="100%" runat="server" GridLines="None"
    UseAccessibleHeader="true" CssClass="table table-striped" AutoGenerateColumns="false"
    OnItemDataBound="AttachmentsDataGridItemDataBound"
    OnItemCommand="AttachmentsDataGridItemCommand">
    <Columns>
        <asp:TemplateColumn HeaderText="<%$ Resources:SharedResources, Name %>">
            <ItemTemplate>
                <a target="_blank" id="lnkAttachment" runat="server"></a>
            </ItemTemplate>
        </asp:TemplateColumn>
        <asp:TemplateColumn HeaderText="<%$ Resources:SharedResources, Size %>">
            <ItemTemplate>
                <asp:Label ID="lblSize" runat="server" />
            </ItemTemplate>
        </asp:TemplateColumn>
        <asp:BoundColumn HeaderText="<%$ Resources:SharedResources, Description %>" DataField="Description" />
        <asp:BoundColumn HeaderText="<%$ Resources:SharedResources, Creator %>" DataField="CreatorDisplayName">
        </asp:BoundColumn>
        <asp:BoundColumn HeaderText="<%$ Resources:SharedResources, Created %>" DataField="DateCreated" DataFormatString="{0:g}">
        </asp:BoundColumn>
        <asp:TemplateColumn>
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
        <asp:Panel ID="pnlAddAttachment" CssClass="form-horizontal" runat="server">
            <h3>
                <asp:Label ID="lblAddAttachment" runat="server" meta:resourcekey="lblAddAttachment" Text="Add Attachment"></asp:Label>
            </h3>
            
                <div class="form-group">
                    <asp:Label ID="Label1" runat="server" CssClass="col-md-2 control-label" Text="File" AssociatedControlID="AspUploadFile" meta:resourcekey="FileLabel" />
                    <div class="col-md-10">
                        <asp:FileUpload ID="AspUploadFile" runat="server" />
                        <p class="help-block"><asp:Literal ID="FileSizeLimit" runat="server"></asp:Literal></p>
                    </div>
                </div>
            <div class="form-group">
                <asp:Label ID="Label7" runat="server" CssClass="col-md-2 control-label" Text="Description:" AssociatedControlID="AttachmentDescription" meta:resourcekey="DescriptionLabel"/>
                <div class="col-md-10">
                    <asp:TextBox ID="AttachmentDescription" CssClass="form-control" runat="server" />
                </div>
            </div>
            <div class="form-group">
                <div class="col-md-offset-2 col-md-7">
                 <asp:Button ID="UploadButton" CssClass="btn btn-primary" runat="server" OnClick="UploadDocument" meta:resourcekey="btnAddAttachment" ValidationGroup="AddAttachment"
                    Text="Add Attachment" />
                </div>
            </div>
        </asp:Panel>    
    </ContentTemplate>
</asp:UpdatePanel>
