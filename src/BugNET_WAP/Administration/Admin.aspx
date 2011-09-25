<%@ Page Language="C#" MasterPageFile="~/Shared/SingleColumn.master"  Title="<%$ Resources:Administration %>"  AutoEventWireup="true" Inherits="BugNET.Administration.Admin" Codebehind="Admin.aspx.cs" %>
<asp:Content ID="Content2" ContentPlaceHolderID="Content" Runat="Server">
    <h1 class="page-title"><asp:literal ID="AdminTitle" runat="Server" Text="<%$ Resources:Administration %>" /></h1>
    <div style="width:100%">
        <table width="400" style="margin: 0px auto -1px auto;text-align:left;" cellspacing="15">
            <tr>
                <td style="text-align:center;padding-left:45px;">
                   <asp:HyperLink ID="lnkProjects" style="text-decoration:none;" NavigateUrl="~/Administration/Projects/ProjectList.aspx" runat="server">
                        <asp:Image ID="Image1" ImageUrl="~/Images/blocks.gif" runat="server" /> 
                        <br />
                        <asp:Label ID="label2" runat="server" Text="<%$ Resources:Projects %>"/>
                    </asp:HyperLink> 
                </td>
                <td style="text-align:center;">
                    <asp:HyperLink ID="lnkUserAccounts" style="text-decoration:none;" NavigateUrl="~/Administration/Users/UserList.aspx" runat="server">
                        <asp:Image ID="Image2"  ImageUrl="~/Images/users.gif" runat="server" />
                        <br />
                        <asp:Label ID="label3" Text="<%$ Resources:UserAccounts %>" runat='server'></asp:Label>   
                    </asp:HyperLink>
                </td>
            </tr>
            <tr>
                <td style="text-align:center;padding-left:45px;width:100px;">
                    <asp:HyperLink ID="lnkConfiguration" style="text-decoration:none;" NavigateUrl="~/Administration/Host/Settings.aspx" runat="server">
                        <asp:Image ID="Image4" ImageUrl="~/Images/cog.png" runat="server" />
                        <br />
                        <asp:Label ID="label1" runat="server" Text="<%$ Resources:ApplicationConfiguration %>" />
                    </asp:HyperLink>
                </td>
                 <td style="text-align:center;">
                    <asp:HyperLink ID="lnkLogViewer" style="text-decoration:none;" runat="server" NavigateUrl="~/Administration/Host/LogViewer.aspx"> 
                        <asp:Image ID="Image5" ImageUrl="~/Images/list-error.png" runat="server" />
                        <br />
                       <asp:Label ID="label4" runat="server" Text="<%$ Resources:LogViewer %>" />
                    </asp:HyperLink>
                </td>
            </tr>
        </table>
    </div>
    
</asp:Content>

