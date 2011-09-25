<%@ Control Language="c#" Inherits="BugNET.Administration.Projects.UserControls.ProjectMilestones" Codebehind="ProjectMilestones.ascx.cs" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<%@ Register TagPrefix="IT" TagName="PickImage" Src="~/UserControls/PickImage.ascx" %>
<div>
    <h2><asp:literal ID="MilestonesTitle" runat="Server" meta:resourcekey="MilestonesTitle" /></h2>
    <asp:Label id="lblError" ForeColor="red" EnableViewState="false" runat="Server" />
    <asp:CustomValidator Text="You must add at least one milestone" meta:resourcekey="MilestoneValidator" Display="dynamic" Runat="server" id="MilestoneValidation" OnServerValidate="MilestoneValidation_Validate" />
    <p>
        <asp:label ID="DescriptionLabel" runat="server" meta:resourcekey="DescriptionLabel" />
     </p>
     <br />
    <asp:UpdatePanel ID="updatepanel1" runat="server">
     <ContentTemplate>
	    <asp:DataGrid id="grdMilestones" SkinID="DataGrid" 
	        OnUpdateCommand="grdMilestones_Update" 
	        OnEditCommand="grdMilestones_Edit" 
	        OnCancelCommand="grdMilestones_Cancel" 
	        OnItemCommand="grdMilestones_ItemCommand" 
	        OnDeleteCommand="DeleteMilestone" 
	        OnItemDataBound="grdMilestones_ItemDataBound" Runat="Server">
			    <Columns>
			        <asp:editcommandcolumn edittext="<%$ Resources:SharedResources, Edit %>"  canceltext="<%$ Resources:SharedResources, Cancel %>" updatetext="<%$ Resources:SharedResources, Update %>" ButtonType="PushButton" ItemStyle-Wrap="false"  />
				    <asp:TemplateColumn HeaderText="Milestone">
					    <itemstyle width="15%"></itemstyle>
					    <ItemTemplate>
						    <asp:Label id="lblMilestoneName" runat="Server" />
					    </ItemTemplate>
					    <EditItemTemplate>
					       <asp:textbox runat="server" ID="txtMilestoneName" />
					        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server"  Display="Dynamic"
                                ControlToValidate="txtMilestoneName" ErrorMessage="A name is required." 
                                SetFocusOnError="True"></asp:RequiredFieldValidator>
					    </EditItemTemplate>
				    </asp:TemplateColumn>
				    <asp:TemplateColumn HeaderText="Image">
					    <headerstyle horizontalalign="Center"></headerstyle>
					    <itemstyle horizontalalign="Center" width="30%" Wrap="false"></itemstyle>
					    <ItemTemplate>
						    <asp:Image id="imgMilestone" runat="Server" />
					    </ItemTemplate>
					    <EditItemTemplate>
					      <it:PickImage id="lstEditImages" ImageDirectory="/Milestone" runat="Server" />
					    </EditItemTemplate>
				    </asp:TemplateColumn>
				    <asp:TemplateColumn HeaderText="Due Date" ItemStyle-Wrap="false">
					    <headerstyle horizontalalign="Right"></headerstyle>
					    <ItemStyle HorizontalAlign="Right" />
					    <itemstyle width="15%"></itemstyle>
					    <ItemTemplate>
						    <asp:Label id="lblMilestoneDueDate" runat="Server" />
					    </ItemTemplate>
					    <EditItemTemplate>
					        <bn:PickDate ID="MilestoneDueDate"  runat="server" />
					    </EditItemTemplate>
				    </asp:TemplateColumn>
				    <asp:TemplateColumn HeaderText="Release Date" ItemStyle-Wrap="false">
					    <headerstyle horizontalalign="Right"></headerstyle>
					    <ItemStyle HorizontalAlign="Right" />
					    <itemstyle width="15%"></itemstyle>
					    <ItemTemplate>
						    <asp:Label id="lblMilestoneReleaseDate" runat="Server" />
					    </ItemTemplate>
					    <EditItemTemplate>
                            <bn:PickDate ID="MilestoneReleaseDate"  runat="server" />
					    </EditItemTemplate>
				    </asp:TemplateColumn>
				    <asp:TemplateColumn HeaderText="Completed">
					    <headerstyle horizontalalign="Center" ></headerstyle>
					    <itemstyle horizontalalign="Center" width="20%"></itemstyle>
					    <ItemTemplate>
						    <asp:CheckBox ID="chkCompletedMilestone" runat="server" Enabled="false" />
					    </ItemTemplate>
					    <EditItemTemplate>
		                   <asp:CheckBox ID="chkEditCompletedMilestone" runat="server"  />
		                </EditItemTemplate>
				    </asp:TemplateColumn>
				    <asp:TemplateColumn HeaderText="Notes">
					    <itemstyle width="35%"></itemstyle>
					    <ItemTemplate>
						    <asp:Label id="lblMilestoneNotes" runat="Server" />
					    </ItemTemplate>
					    <EditItemTemplate>
					       <asp:textbox runat="server" ID="txtMilestoneNotes" TextMode="MultiLine" />
					    </EditItemTemplate>
				    </asp:TemplateColumn>
				    <asp:TemplateColumn HeaderText="Order">
					    <headerstyle horizontalalign="center"></headerstyle>
					    <itemstyle horizontalalign="center" width="10%"></itemstyle>
					    <ItemTemplate>     
                            <asp:ImageButton ID="MoveUp" ImageUrl="~/Images/up.gif" CommandName="up" CommandArgument="" runat="server" />
                            <asp:ImageButton ID="MoveDown" ImageUrl="~/Images/down.gif" CommandName="down" CommandArgument="" runat="server" />
					    </ItemTemplate>
				    </asp:TemplateColumn>
				    <asp:TemplateColumn>
					    <headerstyle horizontalalign="Right"></headerstyle>
					    <itemstyle horizontalalign="Right" width="10%"></itemstyle>
					    <ItemTemplate>
						    <asp:Button id="btnDelete" CommandName="delete" Text="<%$ Resources:SharedResources, Delete %>"  ToolTip="<%$ Resources:SharedResources, Delete %>" runat="Server" />
					    </ItemTemplate>
				    </asp:TemplateColumn>
			    </Columns>
		    </asp:DataGrid>

            <div class="fieldgroup">
                <h3><asp:Literal ID="AddNewMilestoneLabel" runat="Server" meta:resourcekey="AddNewMilestoneLabel" Text="Add New Milestone" /></h3>  
                <ol>
                    <li>
                        <asp:label ID="MilestoneNameLabel" runat="Server" AssociatedControlID="txtName" Text="<%$ Resources:SharedResources, Name %>" />
                        <asp:TextBox id="txtName" Width="150" MaxLength="50"  runat="Server" /> 
                        <asp:RequiredFieldValidator Text="*"  Display="Dynamic"  ValidationGroup="Update" ControlToValidate="txtName" Runat="server" id="RequiredFieldValidator4" />   
                    </li>
                    <li>
                        <label for ="<%= lstImages.ClientID %>"><asp:Literal ID="Literal1" runat="server" Text="<%$ Resources:SharedResources, Image%>" /></label>                  
                        <it:PickImage id="lstImages" ImageDirectory="/Milestone" runat="Server" />

                    </li>
                    <li>
                        <asp:label ID="Label1" runat="Server"  AssociatedControlID="DueDate:DateTextBox" Text="<%$ Resources:SharedResources, DueDate %>" />
                        <bn:PickDate ID="DueDate"  runat="server" />
                    </li>
                    <li>
                        <asp:label ID="Label2" runat="Server" AssociatedControlID="ReleaseDate:DateTextBox" Text="<%$ Resources:SharedResources, ReleaseDate %>" />
                        <bn:PickDate ID="ReleaseDate" runat="server" />
                    </li>
                    <li>
                        <asp:label ID="lblCompletedMilestone" AssociatedControlID="chkCompletedMilestone" runat="Server"  Text="<%$ Resources:SharedResources, CompletedMilestone %>" />
                        <asp:CheckBox ID="chkCompletedMilestone" runat="server" />
                    </li>
                    <li>
                        <asp:label ID="Label3" runat="Server" AssociatedControlID="txtMilestoneNotes" Text="<%$ Resources:SharedResources, Notes %>" />
                         <asp:TextBox id="txtMilestoneNotes" TextMode="MultiLine" Width="250" Height="75"  runat="Server" /> 
                    </li>
                </ol>
            </div>
            <div class="submit">
                <asp:Button Text="Add Milestone" meta:resourcekey="AddMilestoneButton"  OnClick="AddMilestone" CausesValidation="false" runat="server" id="btnAdd" />
            </div> 
        </ContentTemplate>
    </asp:UpdatePanel>     
</div>
