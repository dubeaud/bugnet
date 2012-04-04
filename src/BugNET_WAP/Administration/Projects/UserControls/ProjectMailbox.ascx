<%@ Register TagPrefix="it" TagName="PickType" Src="~/UserControls/PickType.ascx" %>
<%@ Register TagPrefix="it" TagName="PickSingleUser" Src="~/UserControls/PickSingleUser.ascx" %>
<%@ Control Language="c#" Inherits="BugNET.Administration.Projects.UserControls.Mailboxes" CodeBehind="ProjectMailbox.ascx.cs" %>
<div>
    <h2><asp:Literal ID="MailboxesTitle" runat="Server" meta:resourcekey="MailboxesTitle" /></h2>
    <p>
        <asp:Label ID="DescriptionLabel" runat="server" meta:resourcekey="DescriptionLabel" />
    </p>
    <br/>
    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>
            <bn:Message ID="ActionMessage" runat="server" Visible="False" />
            <asp:DataGrid ID="grdMailboxes" runat="server" SkinID="DataGrid" Width="100%" OnUpdateCommand="dtgMailboxes_Update" OnEditCommand="dtgMailboxes_Edit"
                OnCancelCommand="dtgMailboxes_Cancel" OnDeleteCommand="dtgMailboxes_Delete" OnItemDataBound="dtgMailboxes_ItemDataBound"
                CellPadding="3" GridLines="None" BorderWidth="0" AutoGenerateColumns="False">
                <Columns>
                    <asp:TemplateColumn>
                        <HeaderStyle HorizontalAlign="Right" Width="45" />
                        <ItemStyle HorizontalAlign="Right" Width="45" Wrap="false" />
                        <ItemTemplate>
                            <asp:ImageButton ID="cmdEdit" ToolTip="<%$ Resources:SharedResources, Edit %>" AlternateText="<%$ Resources:SharedResources, Edit %>"
                                CssClass="icon" ImageUrl="~/images/pencil.gif" BorderWidth="0px" CommandName="Edit" CausesValidation="false" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "Id") %>'
                                runat="server" />
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:ImageButton ID="cmdUpdate" ToolTip="<%$ Resources:SharedResources, Update %>" AlternateText="<%$ Resources:SharedResources, Update %>"
                                CssClass="icon" ImageUrl="~/images/disk.gif" BorderWidth="0px" ValidationGroup="Update" CommandName="Update" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "Id") %>'
                                runat="server" />&nbsp;
                            <asp:ImageButton ID="cmdCancel" ToolTip="<%$ Resources:SharedResources, Cancel %>" AlternateText="<%$ Resources:SharedResources, Cancel %>"
                                CssClass="icon" ImageUrl="~/images/cancel.gif" BorderWidth="0px" CommandName="Cancel" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "Id") %>'
                                runat="server" />
                        </EditItemTemplate>
                    </asp:TemplateColumn>
                    <asp:TemplateColumn HeaderText="Email Address">
                        <HeaderStyle HorizontalAlign="Left" />
                        <ItemStyle HorizontalAlign="Left" />
                        <ItemTemplate>
                            <asp:Label ID="EmailAddressLabel" runat="Server" />
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox runat="server" ID="txtEmailAddress" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ValidationGroup="Update" runat="server" Display="Dynamic" ControlToValidate="txtEmailAddress"
                                ErrorMessage="Email address is required." SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </EditItemTemplate>
                    </asp:TemplateColumn>
                    <asp:TemplateColumn HeaderText="Assign To">
                        <HeaderStyle HorizontalAlign="Left" />
                        <ItemStyle HorizontalAlign="Left" />
                        <ItemTemplate>
                            <asp:Label ID="AssignToLabel" runat="Server" />
                        </ItemTemplate>
                        <EditItemTemplate>
                            <it:PickSingleUser ID="IssueAssignedUser" runat="Server" DisplayDefault="true"></it:PickSingleUser>
                        </EditItemTemplate>
                    </asp:TemplateColumn>
                    <asp:TemplateColumn HeaderText="Issue Type">
                        <HeaderStyle HorizontalAlign="Left" />
                        <ItemStyle HorizontalAlign="Left" />
                        <ItemTemplate>
                            <asp:Label ID="IssueTypeName" runat="Server" />
                        </ItemTemplate>
                        <EditItemTemplate>
                            <it:PickType ID="IssueType" runat="Server" DisplayDefault="true"></it:PickType>
                        </EditItemTemplate>
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
                    <asp:Literal ID="NewMailboxText" runat="server" Text="New Mailbox" meta:resourcekey="NewMailboxText" /></h3>
                <ol>
                    <li>
                        <asp:Label ID="EmailAddressLabel" runat="server" AssociatedControlID="txtMailbox" Text="Email Address:" meta:resourcekey="EmailAddressLabel" />
                        <asp:TextBox ID="txtMailbox" runat="server" EnableViewState="false"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="reqVal" Display="dynamic" ControlToValidate="txtMailBox" CssClass="req"  Text=" (required)" runat="Server" />
                        <asp:RegularExpressionValidator ID="regexEmailValid" runat="server" ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                            ControlToValidate="txtMailbox" ErrorMessage="Invalid Email Format"  CssClass="req"  Text="Invalid Email Format" />
                    </li>
                    <li>
                        <asp:Label ID="IssueAssignedUserLabel" runat="server" AssociatedControlID="IssueAssignedUser" Text="Assign To:" meta:resourcekey="IssueAssignedUserLabel" />
                        <it:PickSingleUser ID="IssueAssignedUser" runat="Server" Required="true" DisplayDefault="true"></it:PickSingleUser>
                    </li>
                    <li>
                        <asp:Label ID="IssueTypeLabel" runat="server" AssociatedControlID="IssueAssignedType" Text="Issue Type:" meta:resourcekey="IssueTypeLabel" />
                        <it:PickType ID="IssueAssignedType" runat="Server" Required="true" DisplayDefault="true"></it:PickType>
                    </li>
                </ol>
            </div>
            <div class="submit">
                <asp:Button Text="Add Mailbox" CausesValidation="true" runat="server" ID="btnAddMailbox" OnClick="btnAdd_Click" meta:resourcekey="btnAddMailbox" />
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</div>
