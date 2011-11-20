<%@ Control Language="c#" Inherits="BugNET.Administration.Projects.UserControls.ProjectMilestones" CodeBehind="ProjectMilestones.ascx.cs" %>
<%@ Register TagPrefix="IT" TagName="PickImage" Src="~/UserControls/PickImage.ascx" %>
<div>
    <h2><asp:Literal ID="MilestonesTitle" runat="Server" meta:resourcekey="MilestonesTitle" /></h2>
    <asp:Label ID="lblError" ForeColor="red" EnableViewState="false" runat="Server" />
    <asp:CustomValidator Text="You must add at least one milestone" meta:resourcekey="MilestoneValidator" Display="dynamic" runat="server"
        ID="MilestoneValidation" OnServerValidate="MilestoneValidation_Validate" />
    <p>
        <asp:Label ID="DescriptionLabel" runat="server" meta:resourcekey="DescriptionLabel" />
    </p>
    <br />
    <asp:UpdatePanel ID="updatepanel1" runat="server">
        <ContentTemplate>
            <BN:Message ID="ActionMessage" runat="server" Visible="False"  />
            <asp:DataGrid 
                ID="grdMilestones" 
                SkinID="DataGrid" 
                OnUpdateCommand="grdMilestones_Update" 
                OnEditCommand="grdMilestones_Edit"
                OnCancelCommand="grdMilestones_Cancel" 
                OnItemCommand="grdMilestones_ItemCommand" 
                OnDeleteCommand="grdMilestones_Delete" 
                OnItemDataBound="grdMilestones_ItemDataBound"
                runat="Server"
                Width="100%">
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
                    <asp:TemplateColumn HeaderText="Milestone">
                        <HeaderStyle HorizontalAlign="Left" Width="25%" />
                        <ItemStyle HorizontalAlign="Left" Width="25%" />
                        <ItemTemplate>
                            <asp:Label ID="lblMilestoneName" runat="Server" />
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox runat="server" ID="txtMilestoneName" Width="125" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" Display="Dynamic" ControlToValidate="txtMilestoneName"
                                ErrorMessage="A name is required." SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </EditItemTemplate>
                    </asp:TemplateColumn>
                    <asp:TemplateColumn HeaderText="Image">
                        <HeaderStyle HorizontalAlign="Center" />
                        <ItemStyle HorizontalAlign="Center" Wrap="false" />
                        <ItemTemplate>
                            <asp:Image ID="imgMilestone" runat="Server" />
                        </ItemTemplate>
                        <EditItemTemplate>
                            <IT:PickImage ID="lstEditImages" ImageDirectory="/Milestone" runat="Server" />
                        </EditItemTemplate>
                    </asp:TemplateColumn>
                    <asp:TemplateColumn HeaderText="Due Date" ItemStyle-Wrap="false">
                        <HeaderStyle HorizontalAlign="Center" Width="120" />
                        <ItemStyle HorizontalAlign="Center" Width="120" />
                        <ItemStyle Width="15%"></ItemStyle>
                        <ItemTemplate>
                            <asp:Label ID="lblMilestoneDueDate" runat="Server" />
                        </ItemTemplate>
                        <EditItemTemplate>
                            <bn:PickDate ID="MilestoneDueDate" runat="server" />
                        </EditItemTemplate>
                    </asp:TemplateColumn>
                    <asp:TemplateColumn HeaderText="Release Date">
                        <HeaderStyle HorizontalAlign="Center" Width="120" Wrap="false" />
                        <ItemStyle HorizontalAlign="Center" Width="120" Wrap="false" />
                        <ItemTemplate>
                            <asp:Label ID="lblMilestoneReleaseDate" runat="Server" />
                        </ItemTemplate>
                        <EditItemTemplate>
                            <bn:PickDate ID="MilestoneReleaseDate" runat="server" />
                        </EditItemTemplate>
                    </asp:TemplateColumn>
                    <asp:TemplateColumn HeaderText="Is Completed">
                        <HeaderStyle HorizontalAlign="Center" Width="110" Wrap="false" />
                        <ItemStyle HorizontalAlign="Center" Width="110" Wrap="false" />
                        <ItemTemplate>
                            <asp:CheckBox ID="chkCompletedMilestone" runat="server" Enabled="false" />
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:CheckBox ID="chkEditCompletedMilestone" runat="server" />
                        </EditItemTemplate>
                    </asp:TemplateColumn>
                    <asp:TemplateColumn HeaderText="Notes">
                        <ItemStyle Width="35%"></ItemStyle>
                        <ItemTemplate>
                            <asp:Label ID="lblMilestoneNotes" runat="Server" />
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox runat="server" ID="txtMilestoneNotes" TextMode="MultiLine" />
                        </EditItemTemplate>
                    </asp:TemplateColumn>
                    <asp:TemplateColumn HeaderText="Order">
                        <HeaderStyle HorizontalAlign="Center" Width="100" Wrap="false" />
                        <ItemStyle HorizontalAlign="Center" Width="100" Wrap="false" />
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
                    <asp:Literal ID="AddNewMilestoneLabel" runat="Server" meta:resourcekey="AddNewMilestoneLabel" Text="Add New Milestone" /></h3>
                <ol>
                    <li>
                        <asp:Label ID="MilestoneNameLabel" runat="Server" AssociatedControlID="txtName" Text="<%$ Resources:SharedResources, Name %>" />
                        <asp:TextBox ID="txtName" Width="150" MaxLength="50" runat="Server" />
                        <asp:RequiredFieldValidator Text="*" Display="Dynamic" ValidationGroup="Update" ControlToValidate="txtName" runat="server"
                            ID="RequiredFieldValidator4" />
                    </li>
                    <li>
                        <label for="<%= lstImages.ClientID %>">
                            <asp:Literal ID="Literal1" runat="server" Text="<%$ Resources:SharedResources, Image%>" /></label>
                        <IT:PickImage ID="lstImages" ImageDirectory="/Milestone" runat="Server" />
                    </li>
                    <li>
                        <asp:Label ID="Label1" runat="Server" AssociatedControlID="DueDate:DateTextBox" Text="<%$ Resources:SharedResources, DueDate %>" />
                        <bn:PickDate ID="DueDate" runat="server" />
                    </li>
                    <li>
                        <asp:Label ID="Label2" runat="Server" AssociatedControlID="ReleaseDate:DateTextBox" Text="<%$ Resources:SharedResources, ReleaseDate %>" />
                        <bn:PickDate ID="ReleaseDate" runat="server" />
                    </li>
                    <li>
                        <asp:Label ID="lblCompletedMilestone" AssociatedControlID="chkCompletedMilestone" runat="Server" Text="<%$ Resources:SharedResources, CompletedMilestone %>" />
                        <asp:CheckBox ID="chkCompletedMilestone" runat="server" />
                    </li>
                    <li>
                        <asp:Label ID="Label3" runat="Server" AssociatedControlID="txtMilestoneNotes" Text="<%$ Resources:SharedResources, Notes %>" />
                        <asp:TextBox ID="txtMilestoneNotes" TextMode="MultiLine" Width="250" Height="75" runat="Server" />
                    </li>
                </ol>
            </div>
            <div class="submit">
                <asp:Button Text="Add Milestone" meta:resourcekey="AddMilestoneButton" OnClick="AddMilestone" CausesValidation="false" runat="server"
                    ID="btnAdd" />
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</div>
