<%@ Control Language="c#" Inherits="BugNET.Administration.Projects.UserControls.ProjectDescription" Codebehind="ProjectDescription.ascx.cs" %>
<%@ Register TagPrefix="it" TagName="PickSingleUser" Src="~/UserControls/PickSingleUser.ascx" %>
<div>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server"  DisplayMode="BulletList"  HeaderText="<%$ Resources:SharedResources, ValidationSummaryHeaderText %>" CssClass="validationSummary" />
	<h2>Details</h2>
	<asp:Label id="lblError" ForeColor="red" EnableViewState="false" runat="Server" />
	<p class="desc"><asp:Label ID="Label9" runat="server" meta:resourcekey="ProjectDescription" Text="Enter the details for the project."/></p>
	 <div class="fieldgroup" style="border:none">  
        <ol>
            <li>
                <asp:Label ID="Label1" AssociatedControlID="txtName" meta:resourcekey="ProjectName"  runat="server" Text="Project Name:" /><span class="req">*</span>
                <asp:TextBox id="txtName" Columns="30" runat="Server" />
                <asp:RequiredFieldValidator Text="<%$ Resources:SharedResources, Required %>" 
                    SetFocusOnError="True" ErrorMessage="Project Name is required" meta:resourcekey="ProjectNameRequiredFieldValidator"
                    ControlToValidate="txtName" Runat="server" id="ProjectNameRequiredFieldValidator" />
            </li>
            <li>
                <asp:Label ID="Label2" AssociatedControlID="ProjectDescriptionHtmlEditor" meta:resourcekey="Description" 
                    Text="Description:" runat="server" /><span class="req">*</span>        
                <div style="display:inline-block;">
                    <bn:HtmlEditor id="ProjectDescriptionHtmlEditor" Width="450" runat="server"  />
                    <asp:RequiredFieldValidator Text="<%$ Resources:SharedResources, Required %>" ErrorMessage="Description is required"  Display="Dynamic"
                        SetFocusOnError="True" ControlToValidate="ProjectDescriptionHtmlEditor" Runat="server" id="RequiredFieldValidator2" /> 
                </div>
            </li>
           <li>       
                <asp:Label ID="Label3" AssociatedControlID="ProjectCode" meta:resourcekey="ProjectCodeLabel"  runat="server" Text="Project Code:" /><span class="req">*</span>
                <asp:TextBox id="ProjectCode" runat="Server" />
                <asp:RequiredFieldValidator Text="<%$ Resources:SharedResources, Required %>" 
                    ControlToValidate="ProjectCode"  meta:resourcekey="ProjectCodeValidator" Runat="server" id="RequiredFieldValidator3" />
            </li>
            <li>
                <asp:Label ID="Label6" AssociatedControlID="ProjectManager" runat="server" meta:resourcekey="ProjectManagerLabel" Text="Manager:" /><span class="req">*</span>            
                <asp:dropdownlist id="ProjectManager" DataTextField="DisplayName" DataValueField="Username" Runat="Server" />
                <asp:RequiredFieldValidator Text="<%$ Resources:SharedResources, Required %>" InitialValue="" 
                    ControlToValidate="ProjectManager"  Runat="server" id="RequiredFieldValidator4" meta:resourcekey="ProjectManagerValidator" />
           </li>
            <li>
                <asp:Label ID="Label7" AssociatedControlID="chkAllowIssueVoting" runat="server" meta:resourcekey="AllowIssueVotingLabel" Text="Allow Issue Voting:"></asp:Label>          
                <asp:checkbox cssclass="inputCheckBox" Checked="true"  id="chkAllowIssueVoting"  runat="server"/>
            </li>
             <li>
                <asp:Label ID="Label11" AssociatedControlID="ProjectImageUploadFile" runat="server"  Text="Project Image:"></asp:Label>
                <asp:FileUpload ID="ProjectImageUploadFile"  runat="server"  />
                <div style="margin:1em 0 0 14em;width:100px;text-align:center;">
                    <asp:Image runat="server" ID="ProjectImage" Height="62" Width="62"  />
                    <br />
                    <asp:LinkButton ID="RemoveProjectImage" runat="server" Text="Remove" OnClick="RemoveProjectImage_Click"></asp:LinkButton>              
                </div>    
            </li>
        </ol>
    </div>
    <div class="fieldgroup">  
        <h3>Security</h3>
        <ol>
            <li>
                <asp:Label ID="Label8" AssociatedControlID="rblAccessType"  meta:resourcekey="AccessTypeLabel" runat="server" Text="Access Type:"></asp:Label>
                <div class="labelgroup">
                    <asp:radiobuttonlist cssclass="checkboxlist" id="rblAccessType" RepeatDirection="Horizontal" runat="server">
	                    <asp:listitem value="Public" />
	                    <asp:listitem value="Private" />
                    </asp:radiobuttonlist>
                </div>
            </li>
        </ol>
    </div>
    <div class="fieldgroup">  
        <h3>Issue Attachments</h3>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server" ChildrenAsTriggers="true">
            <ContentTemplate>
                <ol>
                    <li>
                        <asp:Label ID="Label4" AssociatedControlID="AllowAttachments" runat="server" meta:resourcekey="EnableAttachmentsLabel" Text="Enable Attachments:"></asp:Label>
                        <asp:checkbox cssclass="inputCheckBox"  id="AllowAttachments" AutoPostBack="true" OnCheckedChanged="AllowAttachmentsChanged" runat="server"/>
                    </li>
                    <li id="AttachmentStorageTypeRow" runat="server" visible="false">
                        <asp:Label ID="Label10" AssociatedControlID="AttachmentStorageType" meta:resourcekey="AttachmentStorageTypeLabel" runat="server" Text="Storage Type:"></asp:Label>
                         <div class="labelgroup">
                            <asp:RadioButtonList ID="AttachmentStorageType"  OnSelectedIndexChanged="AttachmentStorageType_Changed"  RepeatDirection="Horizontal" AutoPostBack="true" runat="server">
                                <asp:ListItem Text="Database (recommended)" Selected="True" Value="2" />
                                <asp:ListItem Text="File System" Value="1" />
                            </asp:RadioButtonList>
                        </div>
                    </li>
                    <li id="AttachmentUploadPathRow" runat="server" visible="false">
                        <asp:Label CssClass="col1" ID="Label5" AssociatedControlID="txtUploadPath" meta:resourcekey="UploadPath" runat="server" Text="Upload Path:" />
                        ~\Uploads\&nbsp;<asp:TextBox id="txtUploadPath" Width="300px" runat="Server" Text="" />
                        <asp:CustomValidator ID="validUploadPath" runat="server" 
                            ControlToValidate="txtUploadPath" 
                            onservervalidate="validUploadPath_ServerValidate">Upload path is not valid</asp:CustomValidator>
                    </li>
                </ol>  
            </ContentTemplate>
        </asp:UpdatePanel>  
    </div>
</div>