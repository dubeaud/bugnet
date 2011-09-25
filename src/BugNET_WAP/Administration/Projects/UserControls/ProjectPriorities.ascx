<%@ Control Language="c#" CodeBehind="ProjectPriorities.ascx.cs" AutoEventWireup="True" Inherits="BugNET.Administration.Projects.UserControls.ProjectPriorities" %>
<%@ Register TagPrefix="IT" TagName="PickImage" Src="~/UserControls/PickImage.ascx" %>
<div>
    <h2><asp:literal ID="PrioritiesTitle" runat="Server" meta:resourcekey="PrioritiesTitle" /></h2>
    <asp:Label id="lblError" ForeColor="red" EnableViewState="false" runat="Server" />
    <asp:CustomValidator Text="You must add at least one priority" meta:resourcekey="PriorityValidator" Display="dynamic" Runat="server" id="CustomValidator1" onservervalidate="ValidatePriority" />
    <p><asp:label ID="DescriptionLabel" runat="server" meta:resourcekey="DescriptionLabel" /></p>
    <br />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>  
			<asp:DataGrid id="grdPriorities"
				SkinID="DataGrid"
				width="100%" 
				Runat="Server"
				OnUpdateCommand="grdPriorities_Update" 
				OnEditCommand="grdPriorities_Edit" 
				OnCancelCommand="grdPriorities_Cancel"
				OnItemCommand="grdPriorities_ItemCommand">
				<Columns>
					<asp:editcommandcolumn edittext="<%$ Resources:SharedResources, Edit %>"  canceltext="<%$ Resources:SharedResources, Cancel %>" updatetext="<%$ Resources:SharedResources, Update %>" ButtonType="PushButton" ItemStyle-Wrap="false" /> 				    
					<asp:TemplateColumn HeaderText="Priority">
						<headerstyle horizontalalign="Left"></headerstyle>
						<itemstyle cssclass="gridFirstItem"></itemstyle>
						<ItemTemplate>
							<asp:Label id="lblPriorityName" runat="Server" />
						</ItemTemplate>
						<EditItemTemplate>
				            <asp:textbox runat="server" ID="txtPriorityName" />
				            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic"
                                ControlToValidate="txtPriorityName" ErrorMessage="A priority name is required." 
                                SetFocusOnError="True"></asp:RequiredFieldValidator>
				        </EditItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn HeaderText="Image">
						<headerstyle horizontalalign="Center"></headerstyle>
						<itemstyle horizontalalign="Center" Wrap="false"></itemstyle>
						<ItemTemplate>
							<asp:Image id="imgPriority" runat="Server" />
						</ItemTemplate>
						<EditItemTemplate>
					            <it:PickImage id="lstEditImages" ImageDirectory="/Priority" runat="Server" />
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
                <h3><asp:Literal ID="AddNewPriorityLabel" runat="Server" meta:resourcekey="AddNewPriorityLabel" Text="Add New Priority" /></h3> 
                <ol>
                    <li>
                        <asp:label ID="PriorityNameLabel" AssociatedControlID="txtName" runat="Server" Text="<%$ Resources:SharedResources, Name %>" />
                        <asp:TextBox id="txtName" MaxLength="50" runat="Server" />
                    </li>
                    <li>
                        <label for ="<%= lstImages.ClientID %>"><asp:Literal ID="Literal1" runat="server" Text="<%$ Resources:SharedResources, Image%>" /></label>
                       
                            <it:PickImage id="lstImages" ImageDirectory="/Priority" runat="Server" />
                       
                    </li>
                </ol>
            </div>
                <div class="submit">
                    <asp:Button Text="Add Priority" meta:resourcekey="AddPriorityButton" CausesValidation="false" runat="server"
			    id="Button1" onclick="AddPriority" />
            </div> 
        </ContentTemplate>
    </asp:UpdatePanel>
</div>