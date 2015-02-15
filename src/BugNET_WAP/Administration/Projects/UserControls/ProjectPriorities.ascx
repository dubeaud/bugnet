<%@ Control Language="c#" CodeBehind="ProjectPriorities.ascx.cs" AutoEventWireup="True" Inherits="BugNET.Administration.Projects.UserControls.ProjectPriorities" %>
<%@ Register TagPrefix="IT" TagName="PickImage" Src="~/UserControls/PickImage.ascx" %>
<div>
    <h2>
        <asp:Literal ID="PrioritiesTitle" runat="Server" meta:resourcekey="PrioritiesTitle" /></h2>
    <asp:CustomValidator Text="You must add at least one priority" meta:resourcekey="PriorityValidator" Display="dynamic" runat="server"
        ID="CustomValidator1" OnServerValidate="ValidatePriority" />
    <p>
        <asp:Label ID="DescriptionLabel" runat="server" meta:resourcekey="DescriptionLabel" />
    </p>
    <br />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <bn:Message ID="ActionMessage" runat="server" Visible="False" />
            <asp:DataGrid
                ID="grdPriorities"
                GridLines="None"
                CssClass="table table-striped"
                AutoGenerateColumns="false"
                runat="Server"
                OnUpdateCommand="grdPriorities_Update"
                OnEditCommand="grdPriorities_Edit"
                OnCancelCommand="grdPriorities_Cancel"
                OnItemCommand="grdPriorities_ItemCommand"
                OnDeleteCommand="grdPriorities_Delete"
                OnItemDataBound="grdPriorities_ItemDataBound">
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
                    <asp:TemplateColumn HeaderText="Priority">
                        <ItemTemplate>
                            <asp:Label ID="lblPriorityName" runat="Server" />
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox runat="server" ID="txtPriorityName" CssClass="form-control" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" ControlToValidate="txtPriorityName"
                                ErrorMessage="A priority name is required." SetFocusOnError="True" CssClass="text-danger validation-error"></asp:RequiredFieldValidator>
                        </EditItemTemplate>
                    </asp:TemplateColumn>
                    <asp:TemplateColumn HeaderText="Image">

                        <ItemTemplate>
                            <asp:Image ID="imgPriority" runat="Server" />
                        </ItemTemplate>
                        <EditItemTemplate>
                            <IT:PickImage ID="lstEditImages" ImageDirectory="/Priority" runat="Server" />
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
                    <asp:Literal ID="AddNewPriorityLabel" runat="Server" meta:resourcekey="AddNewPriorityLabel" Text="Add New Priority" /></h3>
                <div class="form-group">
                    <asp:Label ID="PriorityNameLabel" CssClass="control-label col-md-2" AssociatedControlID="txtName" runat="Server" Text="<%$ Resources:SharedResources, Name %>" />
                    <div class="col-md-6">
                        <asp:TextBox ID="txtName" CssClass="form-control" MaxLength="50" runat="Server" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" ControlToValidate="txtName" ValidationGroup="AddPriority"
                            ErrorMessage="A priority name is required." SetFocusOnError="True" CssClass="text-danger validation-error"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="form-group">
                    <label for="<%= lstImages.ClientID %>" class="control-label col-md-2">
                        <asp:Literal ID="Literal1" runat="server" Text="<%$ Resources:SharedResources, Image%>" /></label>
                    <div class="col-md-10">
                        <IT:PickImage ID="lstImages" ImageDirectory="/Priority" runat="Server" />
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-md-offset-2 col-md-10">
                        <asp:Button Text="Add Priority" CssClass="btn btn-primary" meta:resourcekey="AddPriorityButton" ValidationGroup="AddPriority" runat="server" ID="Button1"
                            OnClick="AddPriority" />
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</div>
