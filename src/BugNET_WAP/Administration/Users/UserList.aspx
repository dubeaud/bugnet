<%@ Page language="c#" Inherits="BugNET.Administration.Users.UserList" MasterPageFile="~/Shared/SingleColumn.master" Title="User List" Codebehind="UserList.aspx.cs" %>
<%@ Register Assembly="BugNET" Namespace="BugNET.UserInterfaceLayer.WebControls" TagPrefix="BNWC" %>

<asp:Content ContentPlaceHolderID="content" ID="Content1" runat="server">	
    <h1 class="page-title"><asp:literal ID="Title1" runat="Server" Text="<%$ Resources:ManageUserAccounts %>" /></h1>  
    <asp:Panel ID="pnlSearch" Runat="server" HorizontalAlign="Center">
        <asp:Label ID="Label1" runat="server" Text="<%$ Resources:SharedResources, Search %>"></asp:Label>
        &nbsp;<asp:TextBox ID="txtSearch" runat="server"></asp:TextBox> 
        <asp:DropDownList ID="SearchField" runat="server">
            <asp:ListItem Text="<%$ Resources:SharedResources, Email %>" Value="Email"></asp:ListItem>
            <asp:ListItem Text="<%$ Resources:SharedResources, Username %>" Value="Username" Selected="true"></asp:ListItem>
        </asp:DropDownList>
        <asp:ImageButton ID="ibSearch" ImageUrl="~/Images/magnifier.gif" OnClick="IbSearchClick"  runat="server" />
        <br />
        <br />
    </asp:Panel> 
    <asp:Panel ID="plLetterSearch" Runat="server" HorizontalAlign="Center">
        <asp:Repeater ID="LetterSearch" runat="server">
            <ItemTemplate>    
		        <asp:linkbutton ID="FilterButton" OnClick="FilterButtonClick" runat="server" CssClass="CommandButton"  CommandArgument="<%# Container.DataItem %>" CommandName="Filter" Text='<%# Container.DataItem %>'>
		        </asp:linkbutton>&nbsp;&nbsp;
	        </ItemTemplate>
        </asp:Repeater>
    </asp:Panel>
    <br />
    <BNWC:GridView ID="gvUsers" runat="server" Width="100%" SkinID="GridView"
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
                <ItemTemplate >
                    <asp:ImageButton ID="Edit" runat="server" CommandName="Edit" CommandArgument='<%#DataBinder.Eval(Container.DataItem, "ProviderUserKey") %>' AlternateText="<%$ Resources:SharedResources, Edit %>" ImageUrl="~/images/pencil.gif" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <HeaderStyle HorizontalAlign="Center" />
                <ItemStyle HorizontalAlign="Center" Width="16px" />
                <ItemTemplate >
                    <asp:ImageButton ID="Delete" runat="server" CommandName="Delete" CommandArgument='<%#DataBinder.Eval(Container.DataItem, "ProviderUserKey") %>' AlternateText="<%$ Resources:SharedResources, Delete %>" ImageUrl="~/images/cross.gif" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <HeaderStyle HorizontalAlign="Center" />
                <ItemStyle HorizontalAlign="Center" Width="16px" />
                <ItemTemplate >
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
            <div style="width:100%;text-align:center;">
                <asp:Label ID="NoResultsLabel" runat="server" Text="<%$ Resources:NoUsersFound %>"></asp:Label>
            </div>
        </EmptyDataTemplate>
    </BNWC:GridView>	
    <div class="pager">
        <asp:DataPager ID="pager" runat="server" PageSize="10" PagedControlID="gvUsers">
            <Fields>                  
                <BNWC:BugNetPagerField   
                    NextPageImageUrl="~/App_Themes/Default/Images/resultset_next.gif" 
                    PreviousPageImageUrl="~/App_Themes/Default/Images/resultset_previous.gif" 
                    LastPageImageUrl="~/App_Themes/Default/Images/resultset_last.gif"   
                    FirstPageImageUrl="~/App_Themes/Default/Images/resultset_first.gif" />                         
            </Fields>                            
        </asp:DataPager>
    </div> 
    <div style="padding:15px 0 10px 0;">
        <span >
            <asp:ImageButton runat="server" OnClick="AddUserClick" ImageUrl="~/Images/user_add.gif" CssClass="icon"  AlternateText="<%$ Resources:CreateNewUser %>" ID="add" />
            <asp:LinkButton ID="AddUser" OnClick="AddUserClick" runat="server" Text="<%$ Resources:CreateNewUser %>" />
        </span>
    </div>
</asp:Content>

