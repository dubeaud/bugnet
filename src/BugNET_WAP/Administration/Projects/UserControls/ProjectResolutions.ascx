<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ProjectResolutions.ascx.cs" Inherits="BugNET.Administration.Projects.UserControls.ProjectResolutions" %>
<%@ Register TagPrefix="IT" TagName="PickImage" Src="~/UserControls/PickImage.ascx" %>
<div>
    <h2>
        <asp:Literal ID="ResolutionsTitle" runat="Server" meta:resourcekey="ResolutionsTitle" /></h2>
    <asp:CustomValidator Text="You must add at least one resolution" Display="dynamic" runat="server" ID="ResolutionValidation"
        OnServerValidate="ResolutionValidation_Validate" />
    <p>
        <asp:Label ID="DescriptionLabel" runat="server" meta:resourcekey="DescriptionLabel" />
    </p>
    <br />
    <asp:UpdatePanel ID="updatepanel1" runat="server">
        <ContentTemplate>
            <bn:Message ID="ActionMessage" runat="server" Visible="False" />
            <asp:DataGrid
                ID="grdResolutions"
                GridLines="None"
                OnUpdateCommand="grdResolutions_Update"
                OnEditCommand="grdResolutions_Edit"
                OnCancelCommand="grdResolutions_Cancel"
                OnItemCommand="grdResolutions_ItemCommand"
                OnDeleteCommand="grdResolutions_Delete"
                OnItemDataBound="grdResolutions_ItemDataBound"
                AutoGenerateColumns="false"
                UseAccessibleHeader="true"
                CssClass="table table-striped"
                runat="Server">
                <Columns>
                    <asp:TemplateColumn>
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
                                CssClass="icon" ImageUrl="~/images/cancel.gif" BorderWidth="0px" CommandName="Cancel" CausesValidation="false" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "Id") %>'
                                runat="server" />
                        </EditItemTemplate>
                    </asp:TemplateColumn>
                    <asp:TemplateColumn HeaderText="Resolution">
                        <ItemTemplate>
                            <asp:Label ID="lblResolutionName" runat="Server" />
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox runat="server" CssClass="form-control"  ID="txtResolutionName" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" Display="Dynamic" runat="server" ControlToValidate="txtResolutionName"
                                ErrorMessage="Resolution name is required." CssClass="text-danger validation-error" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </EditItemTemplate>
                    </asp:TemplateColumn>
                    <asp:TemplateColumn HeaderText="Image">
                        <ItemTemplate>
                            <asp:Image ID="imgResolution" runat="Server" />
                        </ItemTemplate>
                        <EditItemTemplate>
                            <IT:PickImage ID="lstEditImages" ImageDirectory="/Resolution" runat="Server" />
                        </EditItemTemplate>
                    </asp:TemplateColumn>
                    <asp:TemplateColumn HeaderText="Order">
                        <ItemTemplate>
                            <asp:ImageButton ID="MoveUp" ImageUrl="~/Images/up.gif" CommandName="up" CommandArgument="" runat="server" />
                            <asp:ImageButton ID="MoveDown" ImageUrl="~/Images/down.gif" CommandName="down" CommandArgument="" runat="server" />
                        </ItemTemplate>
                    </asp:TemplateColumn>
                    <asp:TemplateColumn>
                        <ItemTemplate>
                            <asp:ImageButton ID="cmdDelete" ToolTip="<%$ Resources:SharedResources, Delete %>" AlternateText="<%$ Resources:SharedResources, Delete %>"
                                CssClass="icon" ImageUrl="~/images/cross.gif" BorderWidth="0px" CommandName="Delete" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "Id") %>'
                                runat="server" />
                        </ItemTemplate>
                        <EditItemTemplate />
                    </asp:TemplateColumn>
                </Columns>
            </asp:DataGrid>
            <div class="form-horizontal">
                <h3>
                    <asp:Literal ID="AddNewResolutionLabel" runat="Server" meta:resourcekey="AddNewResolutionLabel" Text="Add New Resolution" /></h3>
                <div class="form-group">
                    <asp:Label ID="ResolutionNameLabel" CssClass="control-label col-md-2" AssociatedControlID="txtName" runat="Server" Text="<%$ Resources:SharedResources, Name %>" />
                    <div class="col-md-10">
                        <asp:TextBox ID="txtName" CssClass="form-control" MaxLength="50" runat="Server" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" Display="Dynamic" runat="server" ControlToValidate="txtName" ValidationGroup="Add"
                                ErrorMessage="Resolution name is required." CssClass="text-danger validation-error" SetFocusOnError="True"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="form-group">
                    <label for="<%= lstImages.ClientID %>" class="control-label col-md-2">
                        <asp:Literal ID="Literal1" runat="server" Text="<%$ Resources:SharedResources, Image%>" /></label>
                    <div class="col-md-10">
                        <IT:PickImage ID="lstImages" ImageDirectory="/Resolution" runat="Server" />
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-md-offset-2 col-md-10">
                        <asp:Button Text="Add Resolution" CssClass="btn btn-primary" OnClick="AddResolution" meta:resourcekey="AddResolutionButton" CausesValidation="true" ValidationGroup="Add"
                            runat="server" ID="btnAdd" />
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</div>
