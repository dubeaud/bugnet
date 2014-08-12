<%@ Page Language="c#" Inherits="BugNET.Administration.Users.UserList" MasterPageFile="~/Site.master" Title="<%$ Resources:ManageUserAccounts %>" CodeBehind="UserList.aspx.cs" %>

<%@ Register Assembly="BugNET" Namespace="BugNET.UserInterfaceLayer.WebControls" TagPrefix="BNWC" %>

<asp:Content ContentPlaceHolderID="MainContent" ID="Content1" runat="server">
    <div class="page-header">
        <h1 class="page-title">
            <asp:Literal ID="Title1" runat="Server" Text="<%$ Resources:ManageUserAccounts %>" />
        </h1>
    </div>
    <asp:Panel ID="pnlSearch" runat="server" HorizontalAlign="Center" CssClass="form-inline">
        <div class="form-group">
            <asp:Label ID="Label1" CssClass="sr-only" runat="server" AssociatedControlID="txtSearch" Text="<%$ Resources:SharedResources, Search %>"></asp:Label>
            <asp:TextBox ID="txtSearch" CssClass="form-control" runat="server" placeholder="<%$ Resources:SharedResources, Search %>"></asp:TextBox>
        </div>
        <div class="form-group">
            <asp:DropDownList ID="SearchField" CssClass="form-control" runat="server">
                <asp:ListItem Text="<%$ Resources:SharedResources, Email %>" Value="Email"></asp:ListItem>
                <asp:ListItem Text="<%$ Resources:SharedResources, Username %>" Value="Username" Selected="true"></asp:ListItem>
            </asp:DropDownList>
        </div>
        <div class="form-group">
            <asp:ImageButton ID="ibSearch" ImageUrl="~/Images/magnifier.gif" OnClick="IbSearchClick" runat="server" />
        </div>
        <br />
        <br />
    </asp:Panel>
    <asp:Panel ID="plLetterSearch" runat="server" HorizontalAlign="Center">
        <asp:Repeater ID="LetterSearch" runat="server">
            <ItemTemplate>
                <asp:LinkButton ID="FilterButton" OnClick="FilterButtonClick" runat="server" CssClass="CommandButton" CommandArgument="<%# Container.DataItem %>" CommandName="Filter" Text='<%# GetLocalizedText(Container.DataItem) %>'>
                </asp:LinkButton>&nbsp;&nbsp;
            </ItemTemplate>
        </asp:Repeater>
    </asp:Panel>

    <div style="padding: 0px 0 10px 0;">
        <span style="padding-right: 5px;" id="CreateNewUserAction" runat="server">
            <asp:LinkButton ID="AddUser" CssClass="btn btn-primary" OnClick="AddUserClick" runat="server" Text="<%$ Resources:CreateNewUser %>" />
        </span>
    </div>

    <BNWC:GridView ID="gvUsers" runat="server" GridLines="None" UseAccessibleHeader="true" CssClass="table table-striped table-hover"
        OnRowCommand="GvUsersRowCommand"
        AutoGenerateColumns="False"
        AllowPaging="True"
        AllowSorting="true"
        OnSorting="GvUsersSorting"
        OnRowCreated="GvUsersRowCreated"
        OnPageIndexChanging="GvUsersPageIndexChanging"
        PageSize="25"
        PagerStyle-HorizontalAlign="right">
        <Columns>
            <asp:TemplateField>
                <HeaderStyle HorizontalAlign="Center" />
                <ItemStyle HorizontalAlign="Center" Width="16px" />
                <ItemTemplate>
                    <asp:ImageButton ID="Edit" runat="server" CommandName="Edit" CommandArgument='<%#DataBinder.Eval(Container.DataItem, "ProviderUserKey") %>' AlternateText="<%$ Resources:SharedResources, Edit %>" ImageUrl="~/images/pencil.gif" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <HeaderStyle HorizontalAlign="Center" />
                <ItemStyle HorizontalAlign="Center" Width="16px" />
                <ItemTemplate>
                    <asp:ImageButton ID="Delete" runat="server" CommandName="Delete" CommandArgument='<%#DataBinder.Eval(Container.DataItem, "ProviderUserKey") %>' AlternateText="<%$ Resources:SharedResources, Delete %>" ImageUrl="~/images/cross.gif" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <HeaderStyle HorizontalAlign="Center" />
                <ItemStyle HorizontalAlign="Center" Width="16px" />
                <ItemTemplate>
                    <asp:ImageButton ID="ManageRoles" runat="server" CommandName="ManageRoles" CommandArgument='<%#DataBinder.Eval(Container.DataItem, "ProviderUserKey") %>' AlternateText="<%$ Resources:ManageRoles %>" ImageUrl="~/images/shield.gif" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="UserName" HeaderText="<%$ Resources:SharedResources, Username %>" ReadOnly="True" SortExpression="UserName">
                <HeaderStyle HorizontalAlign="Left" />
                <ItemStyle HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:BoundField DataField="DisplayName" HeaderText="<%$ Resources:SharedResources, Name %>" ReadOnly="True" SortExpression="DisplayName">
                <HeaderStyle HorizontalAlign="Left" />
                <ItemStyle HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:BoundField DataField="Email" HeaderText="<%$ Resources:SharedResources, Email %>" SortExpression="Email">
                <HeaderStyle HorizontalAlign="Left" />
                <ItemStyle HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:BoundField DataField="CreationDate" HeaderText="<%$ Resources:SharedResources, Created %>" SortExpression="CreationDate" DataFormatString="{0:g}">
                <HeaderStyle HorizontalAlign="Left" />
                <ItemStyle HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:CheckBoxField DataField="IsApproved" HeaderText="<%$ Resources:Authorized %>" SortExpression="IsApproved">
                <HeaderStyle HorizontalAlign="Center" />
                <ItemStyle HorizontalAlign="Center" />
            </asp:CheckBoxField>
        </Columns>
        <EmptyDataTemplate>
            <div style="width: 100%; text-align: center;">
                <asp:Label ID="NoResultsLabel" runat="server" Text="<%$ Resources:NoUsersFound %>"></asp:Label>
            </div>
        </EmptyDataTemplate>
    </BNWC:GridView>
    <div class="pager">
        <asp:DataPager ID="pager" runat="server" PageSize="10" PagedControlID="gvUsers">
            <Fields>
                <BNWC:BugNetPagerField />
            </Fields>
        </asp:DataPager>
    </div>
</asp:Content>

