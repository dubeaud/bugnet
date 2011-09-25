<%@ Control Language="c#" CodeBehind="ProjectStatus.ascx.cs" AutoEventWireup="True" Inherits="BugNET.Administration.Projects.UserControls.ProjectStatus" %>
<%@ Register TagPrefix="IT" TagName="PickImage" Src="~/UserControls/PickImage.ascx" %>
 <div>
    <h2><asp:literal ID="StatusTitle" runat="Server" Text="<%$ Resources:SharedResources, Status %>" /></h2>
    <asp:Label id="lblError" ForeColor="red" EnableViewState="false" runat="Server" />
	<asp:CustomValidator Text="You must add at least one status" meta:resourcekey="StatusValidator" Display="Dynamic" Runat="server" id="CustomValidator1" onservervalidate="ValidateStatus" />
     <p>
	    <asp:label ID="DescriptionLabel" runat="server" meta:resourcekey="DescriptionLabel" />
	</p>
    <br />
    <asp:UpdatePanel runat="server" ID="UpdatePanel1">
        <ContentTemplate>
		    <asp:DataGrid id="grdStatus" 
			    SkinID="DataGrid"
			    width="100%" 
			    Runat="Server"
			    OnUpdateCommand="grdStatus_Update" 
			    OnEditCommand="grdStatus_Edit" 
			    OnCancelCommand="grdStatus_Cancel"
			    OnItemCommand="grdStatus_ItemCommand">
			    <Columns>
				    <asp:editcommandcolumn edittext="<%$ Resources:SharedResources, Edit %>"  canceltext="<%$ Resources:SharedResources, Cancel %>" updatetext="<%$ Resources:SharedResources, Update %>" ButtonType="PushButton" ItemStyle-Wrap="false"  /> 
				    <asp:TemplateColumn HeaderText="Status">
					    <headerstyle horizontalalign="Left" cssclass="gridHeader"></headerstyle>
					    <itemstyle width="20%"></itemstyle>
					    <ItemTemplate>
						    <asp:Label id="lblStatusName" runat="Server" />
					    </ItemTemplate>
					    <EditItemTemplate>
					        <asp:textbox runat="server" ID="txtStatusName" />
					        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                                ControlToValidate="txtStatusName" Display="Dynamic" ErrorMessage="A status name is required." 
                                SetFocusOnError="True"></asp:RequiredFieldValidator>
					    </EditItemTemplate>
				    </asp:TemplateColumn>
				    <asp:TemplateColumn HeaderText="Image">
					    <headerstyle horizontalalign="Center"></headerstyle>
					    <itemstyle horizontalalign="Center" width="50%" Wrap="false"></itemstyle> 
					    <ItemTemplate>
						    <asp:Image id="imgStatus" runat="Server" />
					    </ItemTemplate>
					    <EditItemTemplate>
					        <it:PickImage id="lstEditImages" ImageDirectory="/Status" runat="Server" />
					    </EditItemTemplate>
				    </asp:TemplateColumn>
				    <asp:TemplateColumn HeaderText="Is Closed State">
					    <headerstyle horizontalalign="Center" ></headerstyle>
					    <itemstyle horizontalalign="Center" width="20%"></itemstyle>
					    <ItemTemplate>
						    <asp:CheckBox ID="chkClosedState" runat="server" Enabled="false" />
					    </ItemTemplate>
					    <EditItemTemplate>
					        <asp:CheckBox ID="chkEditClosedState" runat="server"  />
					    </EditItemTemplate>
				    </asp:TemplateColumn>
				    <asp:TemplateColumn HeaderText="Order">
					    <headerstyle horizontalalign="center"></headerstyle>
					    <itemstyle horizontalalign="center" width="10%"></itemstyle>
					    <ItemTemplate>     
                            <asp:ImageButton ID="MoveUp" ImageUrl="~/Images/up.gif" CommandName="up" runat="server" />
                            <asp:ImageButton ID="MoveDown" ImageUrl="~/Images/down.gif" CommandName="down" runat="server" />
					    </ItemTemplate>
				    </asp:TemplateColumn>
				    <asp:TemplateColumn>
					    <headerstyle horizontalalign="Right"></headerstyle>
					    <itemstyle horizontalalign="Right" width="10%"></itemstyle>
					    <ItemTemplate>
						    <asp:Button id="btnDelete" CommandName="delete" Text="<%$ Resources:SharedResources, Delete %>"  ToolTip="<%$ Resources:SharedResources, Delete %>"
							    runat="Server" />
					    </ItemTemplate>
				    </asp:TemplateColumn>
			    </Columns>
			</asp:DataGrid>
  
            <div class="fieldgroup">                     
                <h3><asp:Literal ID="AddNewStatusLabel" runat="Server" meta:resourcekey="AddNewStatusLabel" Text="Add New Status" /></h3>                           
                <ol>   
                    <li> 
                        <asp:label ID="StatusNameLabel" AssociatedControlID="txtName" runat="Server" Text="<%$ Resources:SharedResources, Name %>"   />
                        <asp:TextBox id="txtName"  Maxlength="50" runat="Server" />
                    </li> 
                    <li>
                        <asp:label ID="ClosedStateLabel" runat="Server" Text="Is Closed State:" AssociatedControlID="chkClosedState"  meta:resourcekey="IsClosedState" />
                        <asp:CheckBox ID="chkClosedState" runat="server" />
                    </li>
                    <li>
                        <label for ="<%= lstImages.ClientID %>"><asp:Literal ID="Literal1" runat="server" Text="<%$ Resources:SharedResources, Image%>" /></label>
                        <it:PickImage id="lstImages" ImageDirectory="/Status" runat="Server" />
                    </li>
                </ol>   
            </div> 
            <div class="submit">
                <asp:Button Text="Add Status" meta:resourcekey="AddStatusButton" CausesValidation="false" runat="server"
					    id="Button1" onclick="AddStatus" />
            </div>           
    </ContentTemplate>
    </asp:UpdatePanel>
</div>
