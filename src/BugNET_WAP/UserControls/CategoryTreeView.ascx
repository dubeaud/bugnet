<%@ Control Language="C#" AutoEventWireup="true" Inherits="BugNET.UserControls.CategoryTreeView" Codebehind="CategoryTreeView.ascx.cs" %>
<asp:TreeView  ShowLines="true" ID="tvCategory"  
    Width="98%" 
    NodeIndent="13"   
    ShowExpandCollapse="false"
    CssClass="tree"
    OnTreeNodePopulate="tvCategory_TreeNodePopulate" 
    runat="server">
    <SelectedNodeStyle CssClass="selected-node" />
    <NodeStyle CssClass="node" ImageUrl="~/images/plugin.gif" />
</asp:TreeView>