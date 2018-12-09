<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UserCustomFieldsSettings.ascx.cs"
    Inherits="BugNET.Administration.Host.UserControls.UserCustomFieldsSettings" %>

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
<h2>
    <asp:Literal ID="LogViewerTitle" runat="Server" Text="<%$ Resources:UserCustomFields %>" /></h2>
<asp:Label ID="lblError" ForeColor="red" EnableViewState="false" runat="Server" />
<asp:UpdatePanel ID="UpdatePanel2" runat="server">
    <ContentTemplate>
        <asp:DataGrid ID="grdCustomFields" OnUpdateCommand="grdCustomFields_Update"
            AutoGenerateColumns="false" GridLines="None" CssClass="table table-striped"
            UseAccessibleHeader="true"
            OnEditCommand="grdCustomFields_Edit" OnCancelCommand="grdCustomFields_Cancel"
            runat="Server" OnItemDataBound="grdCustomFields_ItemDataBound">
            <Columns>
                <asp:BoundColumn Visible="False" DataField="Id" HeaderText="<%$ Resources: SharedResources, Id %>" />
                <asp:TemplateColumn>
                    <ItemTemplate>
                        <img alt="expand / collapse" id="image_" runat="server" width="9" src="~/images/minus.gif" height="9" visible="False" />
                    </ItemTemplate>
                </asp:TemplateColumn>

                <asp:TemplateColumn>
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
                    <ItemTemplate>
                        <asp:Label ID="lblName" runat="Server" />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox runat="server" CssClass="form-control" ID="txtCustomFieldName" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Text="<%$ Resources:SharedResources, Required %>"
                            ControlToValidate="txtCustomFieldName" ValidationGroup="AddSelection" Display="Dynamic" CssClass="text-danger validation-error"></asp:RequiredFieldValidator>
                    </EditItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn HeaderText="<%$ Resources:FieldType %>">
                    <ItemTemplate>
                        <asp:Label ID="lblFieldType" runat="Server"></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:DropDownList ID="dropCustomFieldType" CssClass="form-control" AutoPostBack="True" OnSelectedIndexChanged="DropFieldType_SelectedIndexChanged"
                            runat="Server">
                            <asp:ListItem Text="Text" Selected="True" Value="1" meta:resourcekey="TextType" />
                            <asp:ListItem Text="Drop Down List" Value="2" meta:resourcekey="DropDownListType" />
                            <asp:ListItem Text="Date" Value="3" meta:resourcekey="DateType" />
                            <asp:ListItem Text="Rich Text" Value="4" meta:resourcekey="RichTextType"/>
                            <asp:ListItem Text="Yes / No" Value="5" meta:resourcekey="YesNoType"/>
                            <asp:ListItem Text="User List" Value="6" meta:resourcekey="UserListType"/>
                        </asp:DropDownList>
                    </EditItemTemplate>
                </asp:TemplateColumn>


                <asp:TemplateColumn HeaderText="<%$ Resources:DataType %>">
                    <ItemTemplate>
                        <asp:Label ID="lblDataType" runat="Server" />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:DropDownList ID="dropEditDataType" CssClass="form-control" runat="Server" />
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
                            OnClick="btnDeleteCustomField_Click" />
                    </ItemTemplate>
                </asp:TemplateColumn>

                <asp:TemplateColumn>
                    <ItemTemplate>
                        </td> </tr>
                        <tr>
                            <td colspan="6" style="padding-left: 60px;">
                                <table id="tblSelectionValues" border="0" cellpadding="3" cellspacing="3" runat="server" visible="False">
                                    <tr>
                                        <td>
                                            <div id="divSelectionValues" runat="server" style="display: inline;">
                                                <div style="font-size: 12px; font-weight: bold; padding: 5px 0 5px 0;">
                                                    <h4>
                                                        <asp:Label ID="SelectionValuesLabel" runat="server" meta:resourcekey="SelectionValuesLabel" /></h4>
                                                </div>
                                                <asp:DataGrid ID="grdSelectionValues" runat="server"
                                                    CssClass="table table-striped" UseAccessibleHeader="true"
                                                    GridLines="none"
                                                    ShowFooter="true" AutoGenerateColumns="False" Visible="true"
                                                    OnCancelCommand="grdSelectionValues_CancelCommand" OnEditCommand="grdSelectionValues_Edit"
                                                    OnItemCommand="grdSelectionValues_ItemCommand" OnItemDataBound="grdSelectionValues_ItemDataBound" OnUpdateCommand="grdSelectionValues_Update">
                                                    <Columns>
                                                        <asp:BoundColumn Visible="False" DataField="Id" HeaderText="ID" />
                                                        <asp:TemplateColumn>
                                                            <ItemTemplate>
                                                                <asp:ImageButton ID="ImageButton1" ToolTip="<%$ Resources:SharedResources, Edit %>" AlternateText="<%$ Resources:SharedResources, Edit %>"
                                                                    CssClass="icon" ImageUrl="~/images/pencil.gif" BorderWidth="0px" CommandName="Edit" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "Id") %>'
                                                                    runat="server" />
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <asp:ImageButton ID="ImageButton2" ToolTip="<%$ Resources:SharedResources, Update %>" AlternateText="<%$ Resources:SharedResources, Update %>"
                                                                    CssClass="icon" ImageUrl="~/images/disk.gif" BorderWidth="0px" CommandName="Update" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "Id") %>'
                                                                    runat="server" />&nbsp;
                                                                <asp:ImageButton ID="ImageButton3" ToolTip="<%$ Resources:SharedResources, Cancel %>" AlternateText="<%$ Resources:SharedResources, Cancel %>"
                                                                    CssClass="icon" ImageUrl="~/images/cancel.gif" BorderWidth="0px" CommandName="Cancel" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "Id") %>'
                                                                    runat="server" />
                                                            </EditItemTemplate>
                                                            <FooterTemplate>
                                                                <div class="align-right">
                                                                    <asp:ImageButton ID="btnAddSelectionValue" ImageUrl="~/Images/add.gif" ValidationGroup="AddSelection" CommandName="add" ToolTip="<%$ Resources:SharedResources, Add %>" runat="server" /></div>
                                                            </FooterTemplate>
                                                        </asp:TemplateColumn>

                                                        <asp:TemplateColumn HeaderText="<%$ Resources: Name %>">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblSelectionName" runat="server" Text='<%# Server.HtmlEncode(DataBinder.Eval(Container.DataItem, "Name").ToString()) %>' />
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <asp:TextBox ID="txtEditSelectionName" CssClass="form-control" MaxLength="255" Text='<%# DataBinder.Eval(Container.DataItem, "Name") %>' runat="server" />
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" Text="<%$ Resources:SharedResources, Required %>"
                                                                    ControlToValidate="txtEditSelectionName" ValidationGroup="UpdateSelection" Display="Dynamic" CssClass="text-danger validation-error"></asp:RequiredFieldValidator>
                                                            </EditItemTemplate>
                                                            <FooterTemplate>
                                                                <asp:TextBox ID="txtAddSelectionName" MaxLength="255" CssClass="form-control" runat="server" />
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" Text="<%$ Resources:SharedResources, Required %>"
                                                                    ControlToValidate="txtAddSelectionName" ValidationGroup="AddSelection" Display="Dynamic" CssClass="text-danger validation-error"></asp:RequiredFieldValidator>
                                                            </FooterTemplate>
                                                        </asp:TemplateColumn>

                                                        <asp:TemplateColumn HeaderText="<%$ Resources: Value %>">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblSelectionValue" runat="server" Text='<%# Server.HtmlEncode(DataBinder.Eval(Container.DataItem, "Value").ToString()) %>' />
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <asp:TextBox ID="txtEditSelectionValue" CssClass="form-control" Text='<%# DataBinder.Eval(Container.DataItem, "Value") %>' runat="server" MaxLength="255" />
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" Text="<%$ Resources:SharedResources, Required %>"
                                                                    ControlToValidate="txtEditSelectionValue" ValidationGroup="UpdateSelection" Display="Dynamic" CssClass="text-danger validation-error"></asp:RequiredFieldValidator>
                                                            </EditItemTemplate>
                                                            <FooterTemplate>
                                                                <asp:TextBox ID="txtAddSelectionValue" CssClass="form-control" MaxLength="255" runat="server" />
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" Text="<%$ Resources:SharedResources, Required %>"
                                                                    ControlToValidate="txtAddSelectionValue" ValidationGroup="AddSelection" Display="Dynamic" CssClass="text-danger validation-error"></asp:RequiredFieldValidator>
                                                            </FooterTemplate>
                                                        </asp:TemplateColumn>

                                                        <asp:TemplateColumn HeaderText="<%$ Resources:SharedResources, Order %>">
                                                            <ItemTemplate>
                                                                <asp:ImageButton ID="MoveUp" ImageUrl="~/Images/up.gif" CommandName="up" runat="server" />
                                                                <asp:ImageButton ID="MoveDown" ImageUrl="~/Images/down.gif" CommandName="down" runat="server" />
                                                            </ItemTemplate>
                                                        </asp:TemplateColumn>

                                                        <asp:TemplateColumn>
                                                            <ItemTemplate>
                                                                <asp:ImageButton ID="btnDeleteSelectionValue" ImageUrl="~/images/cross.gif"
                                                                    AlternateText="<%$ Resources:SharedResources, Delete %>" CausesValidation="false"
                                                                    CommandName="Delete" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "Id") %>' runat="server"
                                                                    OnClick="btnDeleteSelectionValue_Click" />
                                                            </ItemTemplate>
                                                        </asp:TemplateColumn>
                                                        <asp:TemplateColumn Visible="false">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblCustomFieldId" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "CustomFieldId") %>'>
                                                                </asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateColumn>
                                                    </Columns>
                                                </asp:DataGrid>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                    </ItemTemplate>
                </asp:TemplateColumn>
            </Columns>
        </asp:DataGrid>
        <div class="form-horizontal">
            <h3>
                <asp:Literal ID="DetailsTitle" runat="Server" meta:resourcekey="NewCustomFieldTitle" /></h3>
            <div class="form-group">
                <asp:Label ID="label1" CssClass="control-label col-md-2" runat="server" AssociatedControlID="txtName" Text="<%$ Resources:FieldName %>" />
                <div class="col-md-10">
                    <asp:TextBox ID="txtName" CssClass="form-control" MaxLength="255" runat="Server" />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" Display="Dynamic" ControlToValidate="txtName" ValidationGroup="AddCustomField"
                        ErrorMessage="A name is required." SetFocusOnError="True" CssClass="text-danger validation-error"></asp:RequiredFieldValidator>
                </div>
            </div>
            <div class="form-group">
                <asp:Label ID="label2" CssClass="col-md-2 control-label" runat="server" AssociatedControlID="rblCustomFieldType" Text="<%$ Resources:FieldType %>" />
                <div class="col-md-10">
                    <asp:RadioButtonList AutoPostBack="True" CssClass="radio" OnSelectedIndexChanged="rblCustomFieldType_SelectedIndexChanged" ID="rblCustomFieldType"
                        runat="server">
                        <asp:ListItem Text="Text" Selected="True" Value="1" meta:resourcekey="TextType" />
                        <asp:ListItem Text="Drop Down List" Value="2" meta:resourcekey="DropDownListType" />
                        <asp:ListItem Text="Date" Value="3" meta:resourcekey="DateType" />
                        <asp:ListItem Text="Rich Text" Value="4" meta:resourcekey="RichTextType" />
                        <asp:ListItem Text="Yes / No" Value="5" meta:resourcekey="YesNoType" />
                        <asp:ListItem Text="User List" Value="6" meta:resourcekey="UserListType" />
                    </asp:RadioButtonList>
                </div>
            </div>
            <div class="form-group">
                <asp:Label ID="label3" CssClass="control-label col-md-2" runat="server" AssociatedControlID="dropDataType" Text="<%$ Resources:DataType %>" />
                <div class="col-md-10">
                    <asp:DropDownList ID="dropDataType" CssClass="form-control" runat="Server" />
                </div>
            </div>
            <div class="form-group">
                <asp:Label ID="label4" CssClass="control-label col-md-2" runat="server" AssociatedControlID="chkRequired" Text="<%$ Resources:Required %>" />
                <div class="col-md-10">
                    <div class="checkbox">
                        <asp:CheckBox ID="chkRequired" runat="Server" />
                    </div>
                </div>
            </div>
            <div class="form-group">
                <div class="col-md-offset-2 col-md-10">
                    <asp:Button Text="<%$ Resources:AddNew %>" CssClass="btn btn-primary" ValidationGroup="AddCustomField" runat="server" ID="Button1" OnClick="lnkAddCustomField_Click" />
                </div>
            </div>
        </div>
    </ContentTemplate>
</asp:UpdatePanel>