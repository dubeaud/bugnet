<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Attachments.ascx.cs" Inherits="BugNET.Issues.UserControls.Attachments" %>
 
    <BN:Message ID="AttachmentsMessage" runat="server" /> 
    <asp:label id="lblAttachments" visible="False" Font-Italic="True" 
        runat="server" meta:resourcekey="lblAttachments1"></asp:label>
    <asp:datagrid id="AttachmentsDataGrid" Width="100%" runat="server" 
        SkinID="DataGrid"
        OnItemDataBound="AttachmentsDataGrid_ItemDataBound"
        OnItemCommand="AttachmentsDataGrid_ItemCommand"
        meta:resourcekey="AttachmentsDataGrid">
        <columns>
            <asp:templatecolumn headertext="Name"  meta:resourcekey="NameColumn">
                <ItemStyle Width="150px" />
                <itemtemplate >
                    <a target="_blank" id="lnkAttachment" runat="server"></a>
                </itemtemplate>
            </asp:templatecolumn>
            <asp:TemplateColumn HeaderText="Size"  meta:resourcekey="SizeColumn">
                <ItemStyle Width="70px" />
                <ItemTemplate>
                    <asp:Label ID="lblSize" runat="server" meta:resourcekey="lblSize" />
                </ItemTemplate>
            </asp:TemplateColumn>
            <asp:boundcolumn headertext="Description" datafield="Description" meta:resourcekey="DescriptionColumn" />
            <asp:boundcolumn datafield="CreatorDisplayName" HeaderText="<%$ Resources:SharedResources, Creator %>" />
            <asp:boundcolumn HeaderText="<%$ Resources:SharedResources, Created %>" datafield="DateCreated" DataFormatString="{0:g}" />
            <asp:TemplateColumn>
                <ItemStyle Width="70px" />
                <ItemTemplate>
                    <asp:ImageButton AlternateText="<%$ Resources:SharedResources, Delete %>" CssClass="icon" 
                        id="lnkDeleteAttachment" 
                        ImageUrl="~/images/cross.gif" BorderWidth="0px" CommandName="Delete" 
                        CommandArgument='<%# DataBinder.Eval(Container.DataItem, "Id") %>' 
                        runat="server" /> 
                    <asp:LinkButton ID="cmdDeleteAttachment" 
                        CommandName="Delete" runat="server" CausesValidation="false"    
                        CommandArgument='<%# DataBinder.Eval(Container.DataItem, "Id") %>' 
                        Text="<%$ Resources:SharedResources, Delete %>">Delete</asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateColumn>	
        </columns>
    </asp:datagrid>
   
<asp:panel id="pnlAddAttachment" CssClass="fieldgroup" runat="server" meta:resourcekey="pnlAddAttachment1">	
    <h3>
        <asp:label ID="lblAddAttachment" runat="server" meta:resourcekey="lblAddAttachment" Text="Add Attachment"></asp:label>
    </h3> 
    <ol>
        <li>
            <asp:Label ID="Label1" runat="server" Text="File:" AssociatedControlID="AspUploadFile" />
            <asp:FileUpload ID="AspUploadFile" runat="server"  />
        </li>
        <li>
            <asp:Label ID="Label7" runat="server" Text="Description:" AssociatedControlID="AttachmentDescription" />
            <asp:TextBox ID="AttachmentDescription" Width="250px" runat="server" />
        </li>
    </ol>
   
    <div class="submit">
        <asp:Button ID="UploadButton" runat="server" OnClick="UploadDocument" meta:resourcekey="lblAddAttachment" ValidationGroup="AddAttachment" Text="Add Attachment" />
    </div>
</asp:panel>