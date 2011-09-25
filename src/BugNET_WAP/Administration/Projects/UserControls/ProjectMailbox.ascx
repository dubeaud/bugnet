<%@ Register TagPrefix="it" TagName="PickType" Src="~/UserControls/PickType.ascx" %>
<%@ Register TagPrefix="it" TagName="PickSingleUser" Src="~/UserControls/PickSingleUser.ascx" %>
<%@ Control Language="c#" Inherits="BugNET.Administration.Projects.UserControls.Mailboxes" Codebehind="ProjectMailbox.ascx.cs" %>

<h2>Mailboxes</h2>
<p class="desc"><asp:label id="lblMailboxes" runat="server" visible="false" /></p>
<asp:datagrid id="dtgMailboxes" runat="server" SkinID="DataGrid" Width="100%"
    OnUpdateCommand="dtgMailboxes_Update" 
	OnEditCommand="dtgMailboxes_Edit" 
	OnCancelCommand="dtgMailboxes_Cancel"
     OnItemDataBound="dtgMailboxes_ItemDataBound"
    CellPadding="3" GridLines="None" BorderWidth="0" autogeneratecolumns="False">
	<Columns>
        <asp:editcommandcolumn edittext="<%$ Resources:SharedResources, Edit %>"  canceltext="<%$ Resources:SharedResources, Cancel %>" updatetext="<%$ Resources:SharedResources, Update %>" ButtonType="PushButton" ValidationGroup="Update" ItemStyle-Wrap="false"  />
        <asp:TemplateColumn HeaderText="Email Address">
			<headerstyle horizontalalign="Left"></headerstyle>
			<ItemTemplate>
				<asp:Label id="EmailAddressLabel" runat="Server" />
			</ItemTemplate>
			<EditItemTemplate>
			    <asp:textbox runat="server" ID="txtEmailAddress" />
			    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ValidationGroup="Update" runat="server"  Display="Dynamic"
                    ControlToValidate="txtEmailAddress" 
                    ErrorMessage="Email address is required." SetFocusOnError="True"></asp:RequiredFieldValidator>
			</EditItemTemplate>
		</asp:TemplateColumn>
        <asp:TemplateColumn HeaderText="Assign To">
			<headerstyle horizontalalign="Left"></headerstyle>
			<ItemTemplate>
				<asp:Label id="AssignToLabel" runat="Server" />
			</ItemTemplate>
			<EditItemTemplate>
			   <it:picksingleuser id="IssueAssignedUser"   Runat="Server"  DisplayDefault="true"></it:picksingleuser>
			</EditItemTemplate>
		</asp:TemplateColumn>
        <asp:TemplateColumn HeaderText="Issue Type">
			<headerstyle horizontalalign="Left"></headerstyle>
			<ItemTemplate>
				<asp:Label id="IssueTypeName" runat="Server" />
			</ItemTemplate>
			<EditItemTemplate>
			  <it:picktype id="IssueType"  Runat="Server" DisplayDefault="true"></it:picktype>
			</EditItemTemplate>
		</asp:TemplateColumn>		
		<asp:TemplateColumn>
			<headerstyle horizontalalign="Right" ></headerstyle>
			<itemstyle horizontalalign="Right" width="10%"></itemstyle>
			<ItemTemplate>
				<asp:Button id="btnDelete" CommandName="delete" Text="<%$ Resources:SharedResources, Delete %>"  ToolTip="<%$ Resources:SharedResources, Delete %>" runat="Server" />
			</ItemTemplate>
		</asp:TemplateColumn>
	</Columns>
</asp:datagrid>
<br />
<div class="fieldgroup">  
	<h3>New Mailbox</h3>
	<ol>
        <li>
            <asp:Label ID="label1" runat="server" AssociatedControlID="txtMailbox" Text="Email Address:" />
            <asp:textbox id="txtMailbox" runat="server" enableviewstate="false"></asp:textbox> 
            <asp:RequiredFieldValidator id="reqVal" Display="dynamic" ControlToValidate="txtMailBox" Text=" (required)" Runat="Server" />
            <asp:RegularExpressionValidator ID="regexEmailValid" runat="server" 
                ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" 
                ControlToValidate="txtMailbox" ErrorMessage="Invalid Email Format" Text="Invalid Email Format" />
        </li>
        <li>
            <asp:Label ID="label2" runat="server" AssociatedControlID="IssueAssignedUser" Text="Assign To:" />
            <it:picksingleuser id="IssueAssignedUser"   Runat="Server" Required="true" DisplayDefault="true"></it:picksingleuser>
        </li>
        <li>
            <asp:Label ID="label3"  runat="server" AssociatedControlID="IssueAssignedType" Text="Issue Type:" />
            <it:picktype id="IssueAssignedType" Runat="Server"  Required="true" DisplayDefault="true"></it:picktype>
        </li>       
    </ol>
</div>   
<div class="submit">
    <asp:Button Text="Add Mailbox" CausesValidation="true" runat="server" id="Button1" onclick="btnAdd_Click" />
</div>

