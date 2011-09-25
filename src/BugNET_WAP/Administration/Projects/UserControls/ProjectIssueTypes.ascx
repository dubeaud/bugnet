<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ProjectIssueTypes.ascx.cs" Inherits="BugNET.Administration.Projects.UserControls.ProjectIssueTypes" %>
<%@ Register TagPrefix="IT" TagName="PickImage" Src="~/UserControls/PickImage.ascx" %>
<div>
    <h2><asp:literal ID="IssueTypesTitle" runat="Server" meta:resourcekey="IssueTypesTitle" /></h2>
      <asp:Label id="lblError" ForeColor="red" EnableViewState="false" runat="Server" />
    <asp:CustomValidator Text="You must add at least one issue type"  meta:resourcekey="IssueTypeValidator" Display="Dynamic" Runat="server" id="CustomValidator1" onservervalidate="ValidateIssueType" />
     <p>
	    <asp:label ID="DescriptionLabel" runat="server" meta:resourcekey="DescriptionLabel" />
    </p>
    <br />
  <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>   
			<asp:DataGrid id="grdIssueTypes"
			    SkinID="DataGrid"
				width="100%" 
				Runat="Server"
				 OnUpdateCommand="grdIssueTypes_Update" 
				 OnEditCommand="grdIssueTypes_Edit" 
				 OnCancelCommand="grdIssueTypes_Cancel"
				 OnItemCommand="grdIssueTypes_ItemCommand">
				<Columns>
				    <asp:editcommandcolumn edittext="<%$ Resources:SharedResources, Edit %>"  canceltext="<%$ Resources:SharedResources, Cancel %>" updatetext="<%$ Resources:SharedResources, Update %>" ButtonType="PushButton" ItemStyle-Wrap="false"  />
					<asp:TemplateColumn HeaderText="Issue Type">
						<headerstyle horizontalalign="Left"></headerstyle>
						<itemstyle width="20%"></itemstyle>
						<ItemTemplate>
							<asp:Label id="lblIssueTypeName" runat="Server" />
						</ItemTemplate>
						<EditItemTemplate>
			               <asp:textbox runat="server" ID="txtIssueTypeName" />
			                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"  Display="Dynamic"
                                ControlToValidate="txtIssueTypeName" 
                                ErrorMessage="Issue Type name is required." SetFocusOnError="True"></asp:RequiredFieldValidator>
			            </EditItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn HeaderText="Image">
						<headerstyle horizontalalign="Center"></headerstyle>
						<itemstyle horizontalalign="Center" width="40%" Wrap="false"></itemstyle>
						<ItemTemplate>
							<asp:Image id="imgIssueType" runat="Server" />
						</ItemTemplate>
						<EditItemTemplate>
			                <it:PickImage id="lstEditImages" ImageDirectory="/IssueType" runat="Server" />
			            </EditItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn HeaderText="Order">
			            <headerstyle horizontalalign="center" ></headerstyle>
			            <itemstyle horizontalalign="center" width="10%"></itemstyle>
			            <ItemTemplate>     
                            <asp:ImageButton ID="MoveUp" ImageUrl="~/Images/up.gif" CommandName="up" runat="server" />
                            <asp:ImageButton ID="MoveDown" ImageUrl="~/Images/down.gif" CommandName="down" runat="server" />
			            </ItemTemplate>
		            </asp:TemplateColumn>
					<asp:TemplateColumn>
						<headerstyle horizontalalign="Right" ></headerstyle>
						<itemstyle horizontalalign="Right" width="10%"></itemstyle>
						<ItemTemplate>
							<asp:Button id="btnDelete" CommandName="delete" Text="<%$ Resources:SharedResources, Delete %>"  ToolTip="<%$ Resources:SharedResources, Delete %>" runat="Server" />
						</ItemTemplate>
					</asp:TemplateColumn>
				</Columns>
			</asp:DataGrid>

            <div class="fieldgroup">  
	            <h3><asp:Literal ID="AddNewIssueTypeLabel" runat="Server" meta:resourcekey="AddNewIssueTypeLabel" Text="Add New Issue Type" /></h3>
		        <ol>
                    <li>
                        <asp:label ID="IssueTypeNameLabel" AssociatedControlID="txtName" runat="Server" Text="<%$ Resources:SharedResources, Name %>" />
	                    <asp:TextBox id="txtName"  Maxlength="50" runat="Server" />
                    </li>
                   <li>
                        <label for ="<%= lstImages.ClientID %>"><asp:Literal ID="Literal1" runat="server" Text="<%$ Resources:SharedResources, Image%>" /></label>          
                        <it:PickImage id="lstImages" ImageDirectory="/IssueType" runat="Server" />
                    </li>
                </ol>
            </div>
             <div class="submit">
                 <asp:Button Text="Add IssueType" meta:resourcekey="AddIssueTypeButton"  CausesValidation="false" runat="server" id="Button1" onclick="AddIssueType" />
            </div>    
        </ContentTemplate>
    </asp:UpdatePanel>
</div>