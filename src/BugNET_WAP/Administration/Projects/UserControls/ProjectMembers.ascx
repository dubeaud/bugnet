<%@ Control Language="c#" Inherits="BugNET.Administration.Projects.UserControls.ProjectMembers" Codebehind="ProjectMembers.ascx.cs" %>
	<div>
		<h2><asp:literal ID="ProjectMembersTitle" runat="Server" meta:resourcekey="ProjectMembersTitle" /></h2>
		<p><asp:label ID="DescriptionLabel" runat="server" meta:resourcekey="DescriptionLabel" /></p>
        <br />
		<asp:UpdatePanel ID="UpdatePanel1" RenderMode="inline" runat="Server">
	        <ContentTemplate> 		
			    <table>
				    <tr>
				        <td style="font-weight:bold"><asp:label ID="Label1" runat="server" meta:resourcekey="AllUsersLabel" /></td>
				        <td>&nbsp;</td>
				        <td style="font-weight:bold"><asp:label ID="Label2" runat="server" meta:resourcekey="SelectedUsersLabel" /></td>
			        </tr>
			        <tr>
				        <td style="height: 108px">
					        <asp:ListBox id="lstAllUsers" SelectionMode="Multiple" Runat="Server" Width="150" Height="110px" />
				        </td>
				        <td style="height: 108px">
					        <asp:Button Text="->"  CssClass="button" style="FONT:9pt Courier" Runat="server" id="Button1" onclick="AddUser" />
					        <br />
					        <asp:Button Text="<-"  CssClass="button" style="FONT:9pt Courier;clear:both;" Runat="server" id="Button2" onclick="RemoveUser" />
				        </td>
				        <td style="height: 108px">
					        <asp:ListBox id="lstSelectedUsers" SelectionMode="Multiple"  Runat="Server" Width="150" Height="110px" />
				        </td>
			        </tr>
		        </table>
		    </ContentTemplate>
		</asp:UpdatePanel>
		<div>
            <br />
			<h3><asp:literal ID="Literal1" runat="Server" meta:resourcekey="AssignUserTitle" /></h3>
		</div>
		<p>	
		    <asp:label ID="Label3" runat="server" meta:resourcekey="AssignUsersDescription" /> 
		</p>
		<div>
		    <asp:UpdatePanel ID="UpdatePanel2" RenderMode="inline" runat="Server">
	            <ContentTemplate> 	
		            <table>
		    	        <tr>
				            <td style="width: 147px;height:40px;">
					           <asp:label ID="Label4" runat="server" Text="<%$ Resources:SharedResources, Username %>" />
				            </td>
				            <td colspan="2">                   
				                <asp:dropdownlist AutoPostBack="True" id="ddlProjectMembers" DataTextField="DisplayName" DataValueField="UserName" Runat="Server" Width="177px"  />
				                <ajaxToolkit:ListSearchExtender ID="ListSearchExtender2" PromptPosition="bottom" runat="server"
                                    TargetControlID="ddlProjectMembers" PromptCssClass="ListSearchExtenderPrompt" />
				            </td>
			            </tr>
			            <tr>
				            <td style="font-weight:bold; width: 147px;"><asp:label ID="Label5" runat="server" meta:resourcekey="AllRolesLabel" /></td>
				            <td>&nbsp;</td>
				            <td style="font-weight:bold"><asp:label ID="Label6" runat="server" meta:resourcekey="AssignedRolesLabel" /></td>
			            </tr>
			            <tr>
				            <td style="width: 147px; height: 113px">
					            <asp:ListBox id="lstAllRoles" Runat="Server" Width="150" Height="110px" />
				            </td>
				            <td style="height: 113px">
					            <asp:Button Text="->"  CssClass="button" style="FONT:9pt Courier;" Runat="server" id="Button3" />
					            <br />
					            <asp:Button Text="<-"  CssClass="button" style="FONT:9pt Courier;clear:both;" Runat="server" id="Button4" />
				            </td>
				            <td style="height: 113px">
					            <asp:ListBox id="lstSelectedRoles" Runat="Server" Width="150" Height="110px" />
				            </td>
			            </tr>
		            </table>
		        </ContentTemplate>
		    </asp:UpdatePanel>
	    </div>
    </div>


