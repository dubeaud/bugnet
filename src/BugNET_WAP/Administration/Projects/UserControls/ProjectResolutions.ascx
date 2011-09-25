<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ProjectResolutions.ascx.cs" Inherits="BugNET.Administration.Projects.UserControls.ProjectResolutions" %>
<%@ Register TagPrefix="IT" TagName="PickImage" Src="~/UserControls/PickImage.ascx" %>
<div>
    <h2><asp:literal ID="ResolutionsTitle" runat="Server" meta:resourcekey="ResolutionsTitle" /></h2>
    <asp:Label id="lblError" ForeColor="red" EnableViewState="false" runat="Server" />
    <asp:CustomValidator Text="You must add at least one resolution" Display="dynamic" Runat="server" id="ResolutionValidation" OnServerValidate="ResolutionValidation_Validate" />
    <p>
        <asp:label ID="DescriptionLabel" runat="server" meta:resourcekey="DescriptionLabel" />
     </p>
     <br />
    <asp:UpdatePanel ID="updatepanel1" runat="server">
     <ContentTemplate>
	    <asp:DataGrid id="grdResolutions" SkinID="DataGrid"
	        OnUpdateCommand="grdResolutions_Update" 
	        OnEditCommand="grdResolutions_Edit" 
	        OnCancelCommand="grdResolutions_Cancel"
	        OnItemCommand="grdResolutions_ItemCommand" 
	        OnDeleteCommand="DeleteResolution" 
	        OnItemDataBound="grdResolutions_ItemDataBound"
	        width="100%" Runat="Server">
			    <Columns>
			        <asp:editcommandcolumn ItemStyle-Width="100px" edittext="<%$ Resources:SharedResources, Edit %>"  canceltext="<%$ Resources:SharedResources, Cancel %>" updatetext="<%$ Resources:SharedResources, Update %>" ButtonType="PushButton" ItemStyle-Wrap="false"  />
				    <asp:TemplateColumn HeaderText="Resolution">
					    <headerstyle horizontalalign="Left"></headerstyle>
					    <ItemTemplate>
						    <asp:Label id="lblResolutionName" runat="Server" />
					    </ItemTemplate>
					    <EditItemTemplate>
					       <asp:textbox runat="server" ID="txtResolutionName" />
					        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" Display="Dynamic" runat="server" 
                                ControlToValidate="txtResolutionName" 
                                ErrorMessage="Resolution name is required." SetFocusOnError="True"></asp:RequiredFieldValidator>
					    </EditItemTemplate>
				    </asp:TemplateColumn>
				    <asp:TemplateColumn HeaderText="Image">
					    <headerstyle horizontalalign="Center" ></headerstyle>
					    <itemstyle horizontalalign="Center" width="10%" Wrap="false"></itemstyle>
					    <ItemTemplate>
						    <asp:Image id="imgResolution" runat="Server" />
					    </ItemTemplate>
					    <EditItemTemplate>
					      <it:PickImage id="lstEditImages" ImageDirectory="/Resolution" runat="Server" />
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
					    <itemstyle horizontalalign="Right"  width="10%"></itemstyle>
					    <ItemTemplate>
						    <asp:Button id="btnDelete" CommandName="delete" Text="<%$ Resources:SharedResources, Delete %>"  ToolTip="<%$ Resources:SharedResources, Delete %>" runat="Server" />
					    </ItemTemplate>
				    </asp:TemplateColumn>
			    </Columns>
		    </asp:DataGrid>
            
            <div class="fieldgroup">  
                <h3><asp:Literal ID="AddNewResolutionLabel" runat="Server" meta:resourcekey="AddNewResolutionLabel" Text="Add New Resolution" /></h3>
                <ol>
                    <li>
                        <asp:label ID="ResolutionNameLabel" AssociatedControlID="txtName" runat="Server" Text="<%$ Resources:SharedResources, Name %>" />
                        <asp:TextBox id="txtName" Width="150" MaxLength="50" runat="Server" />   
                    </li>
                    <li>
                        <label for ="<%= lstImages.ClientID %>"><asp:Literal ID="Literal1" runat="server" Text="<%$ Resources:SharedResources, Image%>" /></label>  
                        <it:PickImage id="lstImages" ImageDirectory="/Resolution" runat="Server" />
                    </li>
                </ol>
            </div>
            <div class="submit">
                <asp:Button Text="Add Resolution"  OnClick="AddResolution" meta:resourcekey="AddResolutionButton" CausesValidation="false" runat="server" id="btnAdd" />
            </div>
       </ContentTemplate>
    </asp:UpdatePanel>
        
</div>
