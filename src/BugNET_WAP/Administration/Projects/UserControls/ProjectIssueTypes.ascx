<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ProjectIssueTypes.ascx.cs" Inherits="BugNET.Administration.Projects.UserControls.ProjectIssueTypes" %>
<%@ Register TagPrefix="IT" TagName="PickImage" Src="~/UserControls/PickImage.ascx" %>
<div>
    <h2>
        <asp:Literal ID="IssueTypesTitle" runat="Server" meta:resourcekey="IssueTypesTitle" /></h2>
    <asp:CustomValidator Text="You must add at least one issue type" meta:resourcekey="IssueTypeValidator" Display="Dynamic" runat="server" ID="CustomValidator1" OnServerValidate="ValidateIssueType" />
    <p>
        <asp:Label ID="DescriptionLabel" runat="server" meta:resourcekey="DescriptionLabel" />
    </p>
    <br />
    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>
            <bn:Message ID="ActionMessage" runat="server" Visible="False" />
            <asp:DataGrid
                ID="grdIssueTypes"
                CssClass="table table-striped"
                GridLines="None"
                runat="Server"
                UseAccessibleHeader="true"
                AutoGenerateColumns="false"
                OnUpdateCommand="grdIssueTypes_Update"
                OnEditCommand="grdIssueTypes_Edit"
                OnCancelCommand="grdIssueTypes_Cancel"
                OnItemCommand="grdIssueTypes_ItemCommand"
                OnItemDataBound="grdIssueTypes_ItemDataBound"
                OnDeleteCommand="grdIssueTypes_Delete">
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
                                CssClass="icon" ImageUrl="~/images/cancel.gif" BorderWidth="0px" CommandName="Cancel" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "Id") %>'
                                runat="server" CausesValidation="false" />
                        </EditItemTemplate>
                    </asp:TemplateColumn>
                    <asp:TemplateColumn HeaderText="Issue Type">
                        <ItemTemplate>
                            <asp:Label ID="lblIssueTypeName" runat="Server" />
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox runat="server" ID="txtIssueTypeName" CssClass="form-control" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" ControlToValidate="txtIssueTypeName" CssClass="text-danger validation-error"
                                ErrorMessage="Issue Type name is required." SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </EditItemTemplate>
                    </asp:TemplateColumn>
                    <asp:TemplateColumn HeaderText="Image">
                        <ItemTemplate>
                            <asp:Image ID="imgIssueType" runat="Server" />
                        </ItemTemplate>
                        <EditItemTemplate>
                            <IT:PickImage ID="lstEditImages" ImageDirectory="/IssueType" runat="Server" />
                        </EditItemTemplate>
                    </asp:TemplateColumn>
                    <asp:TemplateColumn HeaderText="Order">
                        <ItemTemplate>
                            <asp:ImageButton ID="MoveUp" ImageUrl="~/Images/up.gif" CommandName="up" runat="server" />
                            <asp:ImageButton ID="MoveDown" ImageUrl="~/Images/down.gif" CommandName="down" runat="server" />
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
                    <asp:Literal ID="AddNewIssueTypeLabel" runat="Server" meta:resourcekey="AddNewIssueTypeLabel" Text="Add New Issue Type" /></h3>
                <div class="form-group">

                    <asp:Label ID="IssueTypeNameLabel" CssClass="col-md-2 control-label"
                        AssociatedControlID="txtName" runat="Server" Text="<%$ Resources:SharedResources, Name %>" />
                    <div class="col-md-10">
                        <asp:TextBox ID="txtName" CssClass="form-control" MaxLength="50" runat="Server" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" ControlToValidate="txtName" CssClass="text-danger validation-error"
                            ErrorMessage="Issue Type name is required." SetFocusOnError="True" ValidationGroup="AddIssueType"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="form-group">
                    <label for="<%= lstImages.ClientID %>" class="col-md-2 control-label">
                        <asp:Literal ID="Literal1" runat="server" Text="<%$ Resources:SharedResources, Image%>" /></label>
                    <div class="col-md-10">
                        <IT:PickImage ID="lstImages" ImageDirectory="/IssueType" runat="Server" />
                    </div>

                </div>
                <div class="form-group">
                    <div class="col-md-offset-2 col-md-10">
                        <asp:Button Text="Add IssueType" CssClass="btn btn-primary" meta:resourcekey="AddIssueTypeButton" ValidationGroup="AddIssueType" runat="server" ID="Button1"
                            OnClick="AddIssueType" />
                    </div>
                </div>
            </div>

        </ContentTemplate>
    </asp:UpdatePanel>
</div>
