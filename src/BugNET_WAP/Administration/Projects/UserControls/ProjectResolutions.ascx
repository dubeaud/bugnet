<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ProjectResolutions.ascx.cs" Inherits="BugNET.Administration.Projects.UserControls.ProjectResolutions" %>
<%@ Register TagPrefix="IT" TagName="PickImage" Src="~/UserControls/PickImage.ascx" %>
<div>
    <h2><asp:Literal ID="ResolutionsTitle" runat="Server" meta:resourcekey="ResolutionsTitle" /></h2>
    <asp:CustomValidator Text="You must add at least one resolution" Display="dynamic" runat="server" ID="ResolutionValidation"
        OnServerValidate="ResolutionValidation_Validate" />
    <p>
        <asp:Label ID="DescriptionLabel" runat="server" meta:resourcekey="DescriptionLabel" />
    </p>
    <br />
    <asp:UpdatePanel ID="updatepanel1" runat="server">
        <ContentTemplate>
            <BN:Message ID="ActionMessage" runat="server" Visible="False"  />
            <asp:DataGrid 
                ID="grdResolutions" 
                SkinID="DataGrid" 
                OnUpdateCommand="grdResolutions_Update" 
                OnEditCommand="grdResolutions_Edit"
                OnCancelCommand="grdResolutions_Cancel" 
                OnItemCommand="grdResolutions_ItemCommand" 
                OnDeleteCommand="grdResolutions_Delete"
                OnItemDataBound="grdResolutions_ItemDataBound" 
                Width="100%" 
                runat="Server">
                <Columns>
                    <asp:TemplateColumn>
                        <HeaderStyle HorizontalAlign="Right" Width="45" />
                        <ItemStyle HorizontalAlign="Right" Width="45" Wrap="false" />
                        <ItemTemplate>
                            <asp:ImageButton ID="cmdEdit" ToolTip="<%$ Resources:SharedResources, Edit %>" AlternateText="<%$ Resources:SharedResources, Edit %>"
                                CssClass="icon" ImageUrl="~/images/pencil.gif" BorderWidth="0px" CommandName="Edit" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "Id") %>'
                                runat="server" />
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:ImageButton ID="cmdUpdate" ToolTip="<%$ Resources:SharedResources, Update %>" AlternateText="<%$ Resources:SharedResources, Update %>"
                                CssClass="icon" ImageUrl="~/images/disk.gif" BorderWidth="0px" CommandName="Update" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "Id") %>'
                                runat="server" />&nbsp;
                            <asp:ImageButton ID="cmdCancel" ToolTip="<%$ Resources:SharedResources, Cancel %>" AlternateText="<%$ Resources:SharedResources, Cancel %>"
                                CssClass="icon" ImageUrl="~/images/cancel.gif" BorderWidth="0px" CommandName="Cancel" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "Id") %>'
                                runat="server" />
                        </EditItemTemplate>
                    </asp:TemplateColumn>
                    <asp:TemplateColumn HeaderText="Resolution">
                        <HeaderStyle HorizontalAlign="Left" />
                        <ItemStyle HorizontalAlign="Left" />
                        <ItemTemplate>
                            <asp:Label ID="lblResolutionName" runat="Server" />
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox runat="server" ID="txtResolutionName" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" Display="Dynamic" runat="server" ControlToValidate="txtResolutionName"
                                ErrorMessage="Resolution name is required." SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </EditItemTemplate>
                    </asp:TemplateColumn>
                    <asp:TemplateColumn HeaderText="Image">
                        <HeaderStyle HorizontalAlign="Center" />
                        <ItemStyle HorizontalAlign="Center" Wrap="false" />
                        <ItemTemplate>
                            <asp:Image ID="imgResolution" runat="Server" />
                        </ItemTemplate>
                        <EditItemTemplate>
                            <IT:PickImage ID="lstEditImages" ImageDirectory="/Resolution" runat="Server" />
                        </EditItemTemplate>
                    </asp:TemplateColumn>
                    <asp:TemplateColumn HeaderText="Order">
                        <HeaderStyle HorizontalAlign="Center" Width="125" />
                        <ItemStyle HorizontalAlign="Center" Width="125" />
                        <ItemTemplate>
                            <asp:ImageButton ID="MoveUp" ImageUrl="~/Images/up.gif" CommandName="up" CommandArgument="" runat="server" />
                            <asp:ImageButton ID="MoveDown" ImageUrl="~/Images/down.gif" CommandName="down" CommandArgument="" runat="server" />
                        </ItemTemplate>
                    </asp:TemplateColumn>
                    <asp:TemplateColumn>
                        <ItemStyle Wrap="false" HorizontalAlign="Center" Width="16" />
                        <ItemTemplate>
                            <asp:ImageButton ID="cmdDelete" ToolTip="<%$ Resources:SharedResources, Delete %>" AlternateText="<%$ Resources:SharedResources, Delete %>"
                                CssClass="icon" ImageUrl="~/images/cross.gif" BorderWidth="0px" CommandName="Delete" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "Id") %>'
                                runat="server" />
                        </ItemTemplate>
                        <EditItemTemplate />
                    </asp:TemplateColumn>
                </Columns>
            </asp:DataGrid>
            <div class="fieldgroup">
                <h3>
                    <asp:Literal ID="AddNewResolutionLabel" runat="Server" meta:resourcekey="AddNewResolutionLabel" Text="Add New Resolution" /></h3>
                <ol>
                    <li>
                        <asp:Label ID="ResolutionNameLabel" AssociatedControlID="txtName" runat="Server" Text="<%$ Resources:SharedResources, Name %>" />
                        <asp:TextBox ID="txtName" Width="150" MaxLength="50" runat="Server" />
                    </li>
                    <li>
                        <label for="<%= lstImages.ClientID %>">
                            <asp:Literal ID="Literal1" runat="server" Text="<%$ Resources:SharedResources, Image%>" /></label>
                        <IT:PickImage ID="lstImages" ImageDirectory="/Resolution" runat="Server" />
                    </li>
                </ol>
            </div>
            <div class="submit">
                <asp:Button Text="Add Resolution" OnClick="AddResolution" meta:resourcekey="AddResolutionButton" CausesValidation="false"
                    runat="server" ID="btnAdd" />
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</div>
