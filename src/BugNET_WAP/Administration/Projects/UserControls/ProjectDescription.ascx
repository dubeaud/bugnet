<%@ Control Language="c#" Inherits="BugNET.Administration.Projects.UserControls.ProjectDescription" CodeBehind="ProjectDescription.ascx.cs" %>
<%@ Register TagPrefix="it" TagName="PickSingleUser" Src="~/UserControls/PickSingleUser.ascx" %>

<h2>
    <asp:Literal ID="DetailsTitle" runat="Server" meta:resourcekey="DetailsTitle" /></h2>
<asp:Label ID="lblError" ForeColor="red" EnableViewState="false" runat="Server" />
<p class="desc">
    <asp:Label ID="Label9" runat="server" meta:resourcekey="ProjectDescription" Text="Enter the details for the project." />
</p>
<div class="form-horizontal">
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" DisplayMode="BulletList" HeaderText="<%$ Resources:SharedResources, ValidationSummaryHeaderText %>" CssClass="validationSummary" />

    <div class="form-group">
        <asp:Label ID="Label1" AssociatedControlID="txtName" meta:resourcekey="ProjectName" CssClass="col-md-2 control-label" runat="server" Text="Project Name:" />
        <div class="col-md-10">
            <asp:TextBox ID="txtName" CssClass="form-control" runat="Server" />
            <asp:RequiredFieldValidator Text="<%$ Resources:SharedResources, Required %>" Display="Dynamic"
                SetFocusOnError="True" ErrorMessage="Project Name is required" meta:resourcekey="ProjectNameRequiredFieldValidator"
                ControlToValidate="txtName" runat="server" ID="ProjectNameRequiredFieldValidator" />
        </div>
    </div>
    <div class="form-group">
        <asp:Label ID="Label2" AssociatedControlID="ProjectDescriptionHtmlEditor" CssClass="col-md-2 control-label" meta:resourcekey="Description"
            Text="Description:" runat="server" />
        <div class="col-md-10">
            <bn:HtmlEditor ID="ProjectDescriptionHtmlEditor" runat="server" />
            <asp:RequiredFieldValidator Text="<%$ Resources:SharedResources, Required %>" ErrorMessage="Description is required" Display="Dynamic"
                SetFocusOnError="True" ControlToValidate="ProjectDescriptionHtmlEditor" runat="server" ID="RequiredFieldValidator2" />
        </div>
    </div>
    <div class="form-group">
        <asp:Label ID="Label3" AssociatedControlID="ProjectCode" meta:resourcekey="ProjectCodeLabel" CssClass="col-md-2 control-label" runat="server" Text="Project Code:" />
        <div class="col-md-10">
            <asp:TextBox ID="ProjectCode" CssClass="form-control" runat="Server" />
            <asp:RequiredFieldValidator Text="<%$ Resources:SharedResources, Required %>" Display="Dynamic"
                ControlToValidate="ProjectCode" meta:resourcekey="ProjectCodeValidator" runat="server" ID="RequiredFieldValidator3" />
        </div>
    </div>
    <div class="form-group">
        <asp:Label ID="Label6" AssociatedControlID="ProjectManager" runat="server" CssClass="col-md-2 control-label" meta:resourcekey="ProjectManagerLabel" Text="Manager:" />
        <div class="col-md-10">
            <asp:DropDownList ID="ProjectManager" CssClass="form-control" DataTextField="DisplayName" DataValueField="Username" runat="Server" />
            <asp:RequiredFieldValidator Text="<%$ Resources:SharedResources, Required %>" InitialValue="" Display="Dynamic"
                ControlToValidate="ProjectManager" runat="server" ID="RequiredFieldValidator4" meta:resourcekey="ProjectManagerValidator" />
        </div>
    </div>
    <div class="form-group">
        <asp:Label ID="Label7" AssociatedControlID="chkAllowIssueVoting" runat="server" CssClass="col-md-2 control-label" meta:resourcekey="AllowIssueVotingLabel" Text="Allow Issue Voting:"></asp:Label>
        <div class="col-md-10">
            <div class="checkbox">
                <asp:CheckBox Checked="true" ID="chkAllowIssueVoting" runat="server" />
            </div>
        </div>
    </div>
    <div class="form-group">
        <asp:Label ID="Label4" AssociatedControlID="AllowAttachments"
            CssClass="col-md-2 control-label" runat="server" meta:resourcekey="EnableAttachmentsLabel" Text="Enable Attachments:"></asp:Label>
        <div class="col-md-10">
            <div class="checkbox">
                <asp:CheckBox CssClass="inputCheckBox" ID="AllowAttachments" runat="server" />
            </div>
            <p class="help-block">
                <asp:Localize ID="lclAttachments" runat="server" Text="Allows file attachments to issues" meta:resourcekey="lclAttachments" />
            </p>
        </div>
    </div>
    <div class="form-group">
        <asp:Label ID="Label11" AssociatedControlID="ProjectImageUploadFile" CssClass="col-md-2 control-label" runat="server" meta:resourcekey="ProjectImageLabel" Text="Project Image:"></asp:Label>
        <div class="col-md-5">
            <asp:FileUpload ID="ProjectImageUploadFile" runat="server" />
        </div>
    </div>
	<div class="form-group" id="AttachmentStorageTypeRow" runat="server">
		<asp:Label ID="Label12" CssClass="col-md-2 control-label"
			AssociatedControlID="AttachmentStorageType" meta:resourcekey="AttachmentStorageTypeLabel" runat="server" Text="Storage Type"></asp:Label>
		<div class="col-md-8">
			<asp:RadioButtonList ID="AttachmentStorageType" CssClass="radio" RepeatLayout="Flow" RepeatDirection="Vertical" runat="server">
				<asp:ListItem Text="Database" Selected="True" Value="2" meta:resourcekey="AttachmentStorageTypeDb" />
				<asp:ListItem Text="File System" Value="1" meta:resourcekey="AttachmentStorageTypeFs" />
			</asp:RadioButtonList>
		</div>
	</div>
    <div class="form-group">
        <div class="col-md-2 col-md-offset-2">
            <asp:Image runat="server" ID="ProjectImage" Height="62" Width="62" />
            <br />
            <asp:LinkButton ID="RemoveProjectImage" runat="server" Text="<%$ Resources:SharedResources, Remove %>" OnClick="RemoveProjectImage_Click"></asp:LinkButton>
        </div>
    </div>
    <h3><asp:Literal ID="Literal1" runat="Server" meta:resourcekey="SecurityTitle" /></h3>
    <div class="form-group">
        <asp:Label ID="Label8" AssociatedControlID="rblAccessType" meta:resourcekey="AccessTypeLabel"
            CssClass="col-md-2 control-label" runat="server" Text="Access Type:"></asp:Label>
        <div class="col-md-10">
            <asp:RadioButtonList  RepeatLayout="Flow" ID="rblAccessType" CssClass="radio" RepeatDirection="Vertical" runat="server">
                <asp:ListItem Value="Public" meta:resourcekey="PublicListItem" />
                <asp:ListItem Value="Private" Selected="True" meta:resourcekey="PrivateListItem" />
            </asp:RadioButtonList>
        </div>
    </div>
</div>

