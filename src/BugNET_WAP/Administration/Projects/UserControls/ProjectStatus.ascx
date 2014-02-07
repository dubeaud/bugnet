<%@ Control Language="c#" CodeBehind="ProjectStatus.ascx.cs" AutoEventWireup="True" Inherits="BugNET.Administration.Projects.UserControls.ProjectStatus" %>
<%@ Register TagPrefix="IT" TagName="PickImage" Src="~/UserControls/PickImage.ascx" %>

<h2>
    <asp:Literal ID="StatusTitle" runat="Server" Text="<%$ Resources:SharedResources, Status %>" /></h2>
<asp:CustomValidator Text="You must add at least one status" meta:resourcekey="StatusValidator" Display="Dynamic" runat="server"
    ID="CustomValidator1" OnServerValidate="ValidateStatus" />
<p>
    <asp:Label ID="DescriptionLabel" runat="server" meta:resourcekey="DescriptionLabel" />
</p>
<br />
<asp:UpdatePanel runat="server" ID="UpdatePanel1">
    <ContentTemplate>
        <bn:Message ID="ActionMessage" runat="server" Visible="False" />
        <asp:DataGrid
            ID="grdStatus"
            CssClass="table table-striped"
            UseAccessibleHeader="true"
            GridLines="None"
            AutoGenerateColumns="false"
            runat="Server"
            OnUpdateCommand="grdStatus_Update"
            OnEditCommand="grdStatus_Edit"
            OnCancelCommand="grdStatus_Cancel"
            OnItemCommand="grdStatus_ItemCommand"
            OnItemDataBound="grdStatus_ItemDataBound"
            OnDeleteCommand="grdStatus_Delete">
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
                                runat="server" />
                    </EditItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn HeaderText="Status">
                    <ItemTemplate>
                        <asp:Label ID="lblStatusName" runat="Server" />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox runat="server" ID="txtStatusName" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtStatusName" Display="Dynamic"
                            ErrorMessage="A status name is required." SetFocusOnError="True"></asp:RequiredFieldValidator>
                    </EditItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn HeaderText="Image">
                    <ItemTemplate>
                        <asp:Image ID="imgStatus" runat="Server" />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <IT:PickImage ID="lstEditImages" ImageDirectory="/Status" runat="Server" />
                    </EditItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn HeaderText="Is Closed State">
                    <ItemTemplate>
                        <asp:CheckBox ID="chkClosedState" runat="server" Enabled="false" />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:CheckBox ID="chkEditClosedState" runat="server" />
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
                <asp:Literal ID="AddNewStatusLabel" runat="Server" meta:resourcekey="AddNewStatusLabel" Text="Add New Status" /></h3>
            <div class="form-group">
                <asp:Label ID="StatusNameLabel" CssClass="control-label col-md-2" AssociatedControlID="txtName" runat="Server" Text="<%$ Resources:SharedResources, Name %>" />
                <div class="col-md-6">
                    <asp:TextBox ID="txtName" MaxLength="50" CssClass="form-control" runat="Server" />
                </div>
            </div>
            <div class="form-group">
                <asp:Label ID="ClosedStateLabel" runat="Server" Text="Is Closed State:" AssociatedControlID="chkClosedState" meta:resourcekey="IsClosedState"
                    CssClass="control-label col-md-2" />
                <div class="col-md-10">
                    <div class="checkbox">
                        <asp:CheckBox ID="chkClosedState" runat="server" />
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label for="<%= lstImages.ClientID %>" class="control-label col-md-2">
                    <asp:Literal ID="Literal1" runat="server" Text="<%$ Resources:SharedResources, Image%>" /></label>
                <div class="col-md-10">
                    <IT:PickImage ID="lstImages" ImageDirectory="/Status" runat="Server" />
                </div>
            </div>
            <div class="form-group">
                <div class="col-md-offset-2 col-md-10">
                    <asp:Button Text="Add Status" CssClass="btn btn-primary" meta:resourcekey="AddStatusButton" CausesValidation="false" runat="server" ID="Button1" OnClick="AddStatus" />
                </div>
            </div>
        </div>
    </ContentTemplate>
</asp:UpdatePanel>

