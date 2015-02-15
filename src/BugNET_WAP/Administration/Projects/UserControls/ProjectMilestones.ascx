<%@ Control Language="c#" Inherits="BugNET.Administration.Projects.UserControls.ProjectMilestones" CodeBehind="ProjectMilestones.ascx.cs" %>
<%@ Register TagPrefix="IT" TagName="PickImage" Src="~/UserControls/PickImage.ascx" %>

<h2>
    <asp:Literal ID="MilestonesTitle" runat="Server" meta:resourcekey="MilestonesTitle" /></h2>
<asp:CustomValidator Text="You must add at least one milestone" meta:resourcekey="MilestoneValidator" Display="dynamic" runat="server"
    ID="MilestoneValidation" OnServerValidate="MilestoneValidation_Validate" />
<p>
    <asp:Label ID="DescriptionLabel" runat="server" meta:resourcekey="DescriptionLabel" />
</p>
<br />
<asp:UpdatePanel ID="updatepanel1" runat="server">
    <ContentTemplate>
        <bn:Message ID="ActionMessage" runat="server" Visible="False" />
        <asp:DataGrid
            ID="grdMilestones"
            GridLines="None"
            UseAccessibleHeader="true"
            OnUpdateCommand="grdMilestones_Update"
            OnEditCommand="grdMilestones_Edit"
            OnCancelCommand="grdMilestones_Cancel"
            OnItemCommand="grdMilestones_ItemCommand"
            OnDeleteCommand="grdMilestones_Delete"
            OnItemDataBound="grdMilestones_ItemDataBound"
            runat="Server"
            AutoGenerateColumns="false"
            CssClass="table table-striped">
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
                <asp:TemplateColumn HeaderText="Milestone">
                    <ItemTemplate>
                        <asp:Label ID="lblMilestoneName" runat="Server" />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox runat="server" ID="txtMilestoneName" CssClass="form-control" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" Display="Dynamic" ControlToValidate="txtMilestoneName"
                            ErrorMessage="A name is required." SetFocusOnError="True" CssClass="text-danger validation-error"></asp:RequiredFieldValidator>
                    </EditItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn HeaderText="Image">
                    <ItemTemplate>
                        <asp:Image ID="imgMilestone" runat="Server" />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <IT:PickImage ID="lstEditImages" ImageDirectory="/Milestone" runat="Server" />
                    </EditItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn HeaderText="Due Date" ItemStyle-Wrap="false">
                    <ItemTemplate>
                        <asp:Label ID="lblMilestoneDueDate" runat="Server" />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <bn:PickDate ID="MilestoneDueDate" runat="server" />
                    </EditItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn HeaderText="Release Date">
                    <ItemTemplate>
                        <asp:Label ID="lblMilestoneReleaseDate" runat="Server" />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <bn:PickDate ID="MilestoneReleaseDate" runat="server" />
                    </EditItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn HeaderText="Is Completed">
                    <ItemTemplate>
                        <asp:CheckBox ID="chkCompletedMilestone" runat="server" Enabled="false" />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:CheckBox ID="chkEditCompletedMilestone" runat="server" />
                    </EditItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn HeaderText="Notes">
                    <ItemTemplate>
                        <asp:Label ID="lblMilestoneNotes" runat="Server" />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox runat="server" ID="txtMilestoneNotes" CssClass="form-control" TextMode="MultiLine" />
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
                <asp:Literal ID="AddNewMilestoneLabel" runat="Server" meta:resourcekey="AddNewMilestoneLabel" Text="Add New Milestone" /></h3>
            <div class="form-group">
                <asp:Label ID="MilestoneNameLabel" CssClass="control-label col-md-2" runat="Server" AssociatedControlID="txtName" Text="<%$ Resources:SharedResources, Name %>" />
                <div class="col-md-10">
                    <asp:TextBox ID="txtName" CssClass="form-control" MaxLength="50" runat="Server" />
                     <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" Display="Dynamic" ControlToValidate="txtName" ValidationGroup="AddMilestone"
                            ErrorMessage="A name is required." SetFocusOnError="True" CssClass="text-danger validation-error"></asp:RequiredFieldValidator>
                </div>
            </div>
            <div class="form-group">
                <label for="<%= lstImages.ClientID %>" class="control-label col-md-2">
                    <asp:Literal ID="Literal1" runat="server" Text="<%$ Resources:SharedResources, Image%>" /></label>
                <div class="col-md-10">
                    <IT:PickImage ID="lstImages" ImageDirectory="/Milestone" runat="Server" />
                </div>
            </div>
            <div class="form-group">
                <asp:Label ID="Label1" runat="Server" CssClass="control-label col-md-2" AssociatedControlID="DueDate:DateTextBox" Text="<%$ Resources:SharedResources, DueDate %>" />
                <div class="col-md-10">
                    <bn:PickDate ID="DueDate" runat="server" />
                </div>
            </div>
            <div class="form-group">
                <asp:Label ID="Label2" CssClass="control-label col-md-2" runat="Server" AssociatedControlID="ReleaseDate:DateTextBox" Text="<%$ Resources:SharedResources, ReleaseDate %>" />
                <div class="col-md-10">
                    <bn:PickDate ID="ReleaseDate" runat="server" />
                </div>
            </div>
            <div class="form-group">
                <asp:Label ID="lblCompletedMilestone" CssClass="control-label col-md-2" AssociatedControlID="chkCompletedMilestone" runat="Server" Text="<%$ Resources:SharedResources, CompletedMilestone %>" />
                <div class="col-md-10">
                    <div class="checkbox">
                        <asp:CheckBox ID="chkCompletedMilestone" runat="server" />
                    </div>
                </div>
            </div>
            <div class="form-group">
                <asp:Label ID="Label3" CssClass="control-label col-md-2" runat="Server" AssociatedControlID="txtMilestoneNotes" Text="<%$ Resources:SharedResources, Notes %>" />
                <div class="col-md-10">
                    <asp:TextBox ID="txtMilestoneNotes" CssClass="form-control" TextMode="MultiLine" Rows="3" runat="Server" />
                </div>
            </div>
            <div class="form-group">
                <div class="col-md-offset-2 col-md-10">
                    <asp:Button Text="Add Milestone" CssClass="btn btn-primary" meta:resourcekey="AddMilestoneButton" ValidationGroup="AddMilestone" OnClick="AddMilestone" runat="server"
                        ID="btnAdd" />
                </div>
            </div>
        </div>
    </ContentTemplate>
</asp:UpdatePanel>

