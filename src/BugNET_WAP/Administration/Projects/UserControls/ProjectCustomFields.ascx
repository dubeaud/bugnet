<%@ Control Language="C#" AutoEventWireup="true" Inherits="BugNET.Administration.Projects.UserControls.ProjectCustomFields"
    CodeBehind="ProjectCustomFields.ascx.cs" %>
<div>
    <h2>
        <asp:Literal ID="CustomFieldsTitle" runat="Server" meta:resourcekey="CustomFieldsTitle" /></h2>
    <p>
        <asp:Label ID="DescriptionLabel" runat="server" meta:resourcekey="DescriptionLabel" />
    </p>
    <p>
        <asp:Label ID="lblError" ForeColor="red" EnableViewState="false" runat="Server" />
    </p>

    <script type="text/javascript">
        function Toggle(commId, imageId) {

            var div = document.getElementById(commId);
            var img = document.getElementById(imageId);
            if (div.style.display == 'none') {
                div.style.display = 'inline';
                img.src = '../../images/minus.gif';
            } else {
                div.style.display = 'none';
                img.src = '../../images/plus.gif';
            }
        }
    </script>

    <br />
    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>
            <asp:DataGrid ID="grdCustomFields" SkinID="DataGrid" OnUpdateCommand="grdCustomFields_Update"
                AutoGenerateColumns="false" BorderStyle="None" OnEditCommand="grdCustomFields_Edit" OnCancelCommand="grdCustomFields_Cancel"
                runat="Server" OnItemDataBound="grdCustomFields_ItemDataBound">
                <Columns>
                    <asp:BoundColumn Visible="False" DataField="Id" HeaderText="<%$ Resources: SharedResources, Id %>" />

                    <asp:TemplateColumn>
                        <HeaderStyle HorizontalAlign="Center" Width="10"></HeaderStyle>
                        <ItemStyle HorizontalAlign="Center" Width="10"></ItemStyle>                        
                        <ItemTemplate>
                            <img alt="expand / collapse" id="image_" runat="server" width="9" src="~/images/minus.gif" height="9" Visible="False" />
                        </ItemTemplate>
                    </asp:TemplateColumn>

                    <asp:TemplateColumn>
                        <HeaderStyle HorizontalAlign="Right" Width="45" />
                        <ItemStyle HorizontalAlign="Right" Width="45" Wrap="false" />
                        <ItemTemplate>
                            <asp:ImageButton ID="cmdEdit" ToolTip="<%$ Resources:SharedResources, Edit %>" AlternateText="<%$ Resources:SharedResources, Edit %>"
                                CssClass="icon" ImageUrl="~/images/pencil.gif" BorderWidth="0px" CommandName="Edit" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "Id") %>'
                                runat="server" />
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:ImageButton ID="cmdUpdate" ToolTip="<%$ Resources:SharedResources, Update %>" AlternateText="<%$ Resources:SharedResources, Update %>"
                                CssClass="icon" ImageUrl="~/images/disk.gif" BorderWidth="0px" CommandName="Update" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "Id") %>'
                                runat="server" />&nbsp;
                            <asp:ImageButton ID="cmdCancel" ToolTip="<%$ Resources:SharedResources, Cancel %>" AlternateText="<%$ Resources:SharedResources, Cancel %>"
                                CssClass="icon" ImageUrl="~/images/cancel.gif" BorderWidth="0px" CommandName="Cancel" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "Id") %>'
                                runat="server" />
                        </EditItemTemplate>
                    </asp:TemplateColumn>

                    <asp:TemplateColumn HeaderText="<%$ Resources:Field %>">
                        <HeaderStyle HorizontalAlign="Left" Width="400"></HeaderStyle>
                        <ItemStyle HorizontalAlign="Left" Width="400"></ItemStyle>
                        <ItemTemplate>
                            <asp:Label ID="lblName" runat="Server" />
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox runat="server" ID="txtCustomFieldName" />
                        </EditItemTemplate>
                    </asp:TemplateColumn>
                    

                    <asp:TemplateColumn HeaderText="<%$ Resources:FieldType %>">
                        <HeaderStyle HorizontalAlign="Left" Width="150"></HeaderStyle>
                        <ItemStyle HorizontalAlign="Left" Width="150"></ItemStyle>
                        <ItemTemplate>
                            <asp:Label ID="lblFieldType" runat="Server"></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:DropDownList ID="dropCustomFieldType" AutoPostBack="True" OnSelectedIndexChanged="DropFieldType_SelectedIndexChanged"
                                runat="Server">
                                <asp:ListItem Text="Text" Selected="True" Value="1" />
                                <asp:ListItem Text="Drop Down List" Value="2" />
                                <asp:ListItem Text="Date" Value="3" />
                                <asp:ListItem Text="Rich Text" Value="4" />
                                <asp:ListItem Text="Yes / No" Value="5" />
                                <asp:ListItem Text="User List" Value="6" />
                            </asp:DropDownList>
                        </EditItemTemplate>
                    </asp:TemplateColumn>
                    

                    <asp:TemplateColumn HeaderText="<%$ Resources:DataType %>">
                        <HeaderStyle HorizontalAlign="Left" Width="150"></HeaderStyle>
                        <ItemStyle HorizontalAlign="Left" Width="150"></ItemStyle>
                        <ItemTemplate>
                            <asp:Label ID="lblDataType" runat="Server" />
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:DropDownList ID="dropEditDataType" runat="Server" />
                        </EditItemTemplate>
                    </asp:TemplateColumn>
                    

                    <asp:TemplateColumn HeaderText="<%$ Resources:Required %>">
                        <HeaderStyle HorizontalAlign="Center" Width="100"></HeaderStyle>
                        <ItemStyle HorizontalAlign="Center" Width="100"></ItemStyle>
                        <ItemTemplate>
                            <asp:Label ID="lblRequired" runat="Server" />
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:CheckBox ID="chkEditRequired" runat="Server" />
                        </EditItemTemplate>
                    </asp:TemplateColumn>

                    <asp:TemplateColumn>
                        <HeaderStyle HorizontalAlign="Center" Width="16"></HeaderStyle>
                        <ItemStyle HorizontalAlign="Center" Width="16"></ItemStyle>
                        <ItemTemplate>
                            <asp:ImageButton ID="btnDeleteCustomField" ImageUrl="~/images/cross.gif" 
                                AlternateText="<%$ Resources:SharedResources, Delete %>" CausesValidation="false"
                                CommandName="Delete" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "Id") %>' runat="server" 
                                onclick="btnDeleteCustomField_Click" />
                        </ItemTemplate>
                    </asp:TemplateColumn>

                    <asp:TemplateColumn>
                        <ItemTemplate>
                            </td> </tr>
                            <tr>
                                <td colspan="6" style="padding-left: 60px;">
                                    <table id="tblSelectionValues" border="0" cellpadding="3" cellspacing="3" runat="server" Visible="False">
                                        <tr>
                                            <td>
                                                <div id="divSelectionValues" runat="server" style="display: inline;">
                                                    <div style="font-size: 12px; font-weight: bold; padding: 5px 0 5px 0;">
                                                        <asp:Label ID="SelectionValuesLabel" runat="server" meta:resourcekey="SelectionValuesLabel" /></div>
                                                    <asp:DataGrid ID="grdSelectionValues" runat="server" ShowFooter="true" AutoGenerateColumns="False" Visible="true" SkinID="DataGrid"
                                                        FooterStyle-BackColor="#F2F7FC" Width="100%" OnCancelCommand="grdSelectionValues_CancelCommand" OnEditCommand="grdSelectionValues_Edit"
                                                        OnItemCommand="grdSelectionValues_ItemCommand" OnItemDataBound="grdSelectionValues_ItemDataBound" OnUpdateCommand="grdSelectionValues_Update">
                                                        <Columns>
                                                            <asp:BoundColumn Visible="False" DataField="Id" HeaderText="ID" />

                                                            <asp:TemplateColumn>
                                                                <HeaderStyle HorizontalAlign="Right" Width="45" />
                                                                <ItemStyle HorizontalAlign="Right" Width="45" />
                                                                <ItemTemplate>
                                                                    <asp:ImageButton ID="cmdEdit" ToolTip="<%$ Resources:SharedResources, Edit %>" AlternateText="<%$ Resources:SharedResources, Edit %>"
                                                                        CssClass="icon" ImageUrl="~/images/pencil.gif" BorderWidth="0px" CommandName="Edit" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "Id") %>'
                                                                        runat="server" />
                                                                </ItemTemplate>
                                                                <EditItemTemplate>
                                                                    <asp:ImageButton ID="cmdUpdate" ToolTip="<%$ Resources:SharedResources, Update %>" AlternateText="<%$ Resources:SharedResources, Update %>"
                                                                        CssClass="icon" ImageUrl="~/images/disk.gif" BorderWidth="0px" CommandName="Update" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "Id") %>'
                                                                        runat="server" />&nbsp;
                                                                    <asp:ImageButton ID="cmdCancel" ToolTip="<%$ Resources:SharedResources, Cancel %>" AlternateText="<%$ Resources:SharedResources, Cancel %>"
                                                                        CssClass="icon" ImageUrl="~/images/cancel.gif" BorderWidth="0px" CommandName="Cancel" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "Id") %>'
                                                                        runat="server" />
                                                                </EditItemTemplate>
                                                                <FooterTemplate>
                                                                    <div class="align-right"><asp:ImageButton ID="btnAddSelectionValue" ImageUrl="~/Images/add.gif" ValidationGroup="AddSelection" CommandName="add" ToolTip="<%$ Resources:SharedResources, Add %>" runat="server" /></div>
                                                                </FooterTemplate>
                                                            </asp:TemplateColumn>

                                                            <asp:TemplateColumn HeaderText="<%$ Resources: Name %>">
                                                                <HeaderStyle HorizontalAlign="Left" Width="325" />
                                                                <ItemStyle HorizontalAlign="Left" Width="325" />                                                              
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblSelectionName" runat="server" Text='<%# Server.HtmlEncode(DataBinder.Eval(Container.DataItem, "Name").ToString()) %>' />
                                                                </ItemTemplate>
                                                                <EditItemTemplate>
                                                                    <asp:TextBox ID="txtEditSelectionName" MaxLength="255" Text='<%# DataBinder.Eval(Container.DataItem, "Name") %>' runat="server" />
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" Text="<%$ Resources:SharedResources, Required %>"
                                                                        ControlToValidate="txtEditSelectionName" ValidationGroup="UpdateSelection"></asp:RequiredFieldValidator>
                                                                </EditItemTemplate>
                                                                <FooterTemplate>
                                                                    <asp:TextBox ID="txtAddSelectionName" MaxLength="255" runat="server" />
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Text="<%$ Resources:SharedResources, Required %>"
                                                                        ControlToValidate="txtAddSelectionName" ValidationGroup="AddSelection"></asp:RequiredFieldValidator>
                                                                </FooterTemplate>
                                                            </asp:TemplateColumn>
                                                            
                                                            <asp:TemplateColumn HeaderText="<%$ Resources: Value %>">
                                                                <HeaderStyle HorizontalAlign="Left" Width="325" />
                                                                <ItemStyle HorizontalAlign="Left" Width="325" />                                                             
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblSelectionValue" runat="server" Text='<%# Server.HtmlEncode(DataBinder.Eval(Container.DataItem, "Value").ToString()) %>' />
                                                                </ItemTemplate>
                                                                <EditItemTemplate>
                                                                    <asp:TextBox ID="txtEditSelectionValue" Text='<%# DataBinder.Eval(Container.DataItem, "Value") %>' runat="server" MaxLength="255" />
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" Text="<%$ Resources:SharedResources, Required %>"
                                                                        ControlToValidate="txtEditSelectionValue" ValidationGroup="UpdateSelection"></asp:RequiredFieldValidator>
                                                                </EditItemTemplate>
                                                                <FooterTemplate>
                                                                    <asp:TextBox ID="txtAddSelectionValue" MaxLength="255" runat="server" />
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" Text="<%$ Resources:SharedResources, Required %>"
                                                                        ControlToValidate="txtAddSelectionValue" ValidationGroup="AddSelection"></asp:RequiredFieldValidator>
                                                                </FooterTemplate>
                                                            </asp:TemplateColumn>

                                                            <asp:TemplateColumn HeaderText="<%$ Resources:SharedResources, Order %>">
                                                                <HeaderStyle HorizontalAlign="Center" Width="50"></HeaderStyle>
                                                                <ItemStyle HorizontalAlign="Center" Width="50"></ItemStyle>
                                                                <ItemTemplate>
                                                                    <asp:ImageButton ID="MoveUp" ImageUrl="~/Images/up.gif" CommandName="up" runat="server" />
                                                                    <asp:ImageButton ID="MoveDown" ImageUrl="~/Images/down.gif" CommandName="down" runat="server" />
                                                                </ItemTemplate>
                                                            </asp:TemplateColumn>

                                                            <asp:TemplateColumn>
                                                                <HeaderStyle HorizontalAlign="Right" Width="16"></HeaderStyle>
                                                                <ItemStyle HorizontalAlign="Right" Width="16"></ItemStyle>
                                                                <ItemTemplate>
                                                                    <asp:ImageButton ID="btnDeleteSelectionValue" ImageUrl="~/images/cross.gif" 
                                                                        AlternateText="<%$ Resources:SharedResources, Delete %>" CausesValidation="false"
                                                                        CommandName="Delete" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "Id") %>' runat="server" 
                                                                        onclick="btnDeleteSelectionValue_Click" />                                                                    
                                                                </ItemTemplate>
                                                            </asp:TemplateColumn>
                                                            <asp:TemplateColumn Visible="false">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblCustomFieldId" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "CustomFieldId") %>'>
                                                                    </asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateColumn>
                                                        </Columns>
                                                        <FooterStyle BackColor="#F2F7FC" />
                                                    </asp:DataGrid>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                        </ItemTemplate>
                    </asp:TemplateColumn>
                </Columns>
            </asp:DataGrid>
            <div class="fieldgroup">
                <h3>
                    <asp:Literal ID="DetailsTitle" runat="Server" meta:resourcekey="NewCustomFieldTitle" /></h3>
                <ol>
                    <li>
                        <asp:Label ID="label1" runat="server" AssociatedControlID="txtName" Text="<%$ Resources:FieldName %>" />
                        <asp:TextBox ID="txtName" MaxLength="255" runat="Server" />
                    </li>
                    <li>
                        <asp:Label ID="label2" runat="server" AssociatedControlID="rblCustomFieldType" Text="<%$ Resources:FieldType %>" />
                        <asp:RadioButtonList AutoPostBack="True" OnSelectedIndexChanged="rblCustomFieldType_SelectedIndexChanged" ID="rblCustomFieldType"
                            runat="server">
                            <asp:ListItem Text="Text" Selected="True" Value="1" meta:resourcekey="TextType" />
                            <asp:ListItem Text="Drop Down List" Value="2" meta:resourcekey="DropDownListType" />
                            <asp:ListItem Text="Date" Value="3" meta:resourcekey="DateType" />
                            <asp:ListItem Text="Rich Text" Value="4" meta:resourcekey="RichTextType" />
                            <asp:ListItem Text="Yes / No" Value="5" meta:resourcekey="YesNoType" />
                            <asp:ListItem Text="User List" Value="6" meta:resourcekey="UserListType" />
                        </asp:RadioButtonList>
                    </li>
                    <li>
                        <asp:Label ID="label3" runat="server" AssociatedControlID="dropDataType" Text="<%$ Resources:DataType %>" />
                        <asp:DropDownList ID="dropDataType" runat="Server" />
                    </li>
                    <li>
                        <asp:Label ID="label4" runat="server" AssociatedControlID="chkRequired" Text="<%$ Resources:Required %>" />
                        <asp:CheckBox ID="chkRequired" runat="Server" />
                    </li>
                </ol>
            </div>
            <div class="submit">
                <asp:Button Text="<%$ Resources:AddNew %>" CausesValidation="false" runat="server" ID="Button1" OnClick="lnkAddCustomField_Click" />
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</div>
