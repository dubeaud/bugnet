<%@ Page Language="C#" MasterPageFile="~/Shared/SingleColumn.master" AutoEventWireup="true" Inherits="BugNET.Administration.Host.LogViewer" Title="<%$ Resources:LogViewer %>" Codebehind="LogViewer.aspx.cs" %>
<%@ Register Assembly="BugNET" Namespace="BugNET.UserInterfaceLayer.WebControls" TagPrefix="BNWC" %>

<asp:Content ID="Content2" ContentPlaceHolderID="Content" Runat="Server">
    <h1 class="page-title"><asp:literal ID="LogViewerTitle" runat="Server" Text="<%$ Resources:LogViewer %>"  /></h1>
    <script type="text/javascript">
        function ExpandDetails(eid)
        {
            var el = document.getElementById(eid);
            var row = el.parentNode.parentNode.previousSibling.previousSibling;
            if(el.style.display=='none')
            {
               el.style.display = 'block';
               row.style.backgroundColor = '#ddd';
               row.style.fontWeight = 'bold';
            }
            else
            {
                el.style.display='none';
                row.style.backgroundColor = '';
                row.style.fontWeight = 'normal';
            }
        }  
    </script>

    <asp:Label ID="Label1" runat="server" Text="<%$ Resources:FilterBy %>"></asp:Label> <asp:DropDownList
        ID="FilterDropDown" runat="server" OnSelectedIndexChanged="FilterDropDown_SelectedIndexChanged" AutoPostBack="true">
        <asp:ListItem Text="<%$ Resources:SelectLevel %>" Value="" />
        <asp:ListItem Text="<%$ Resources:Error %>" Value="ERROR" />
        <asp:ListItem Text="<%$ Resources:Warning %>" Value="WARN" />
        <asp:ListItem Text="<%$ Resources:Info %>" Value="INFO" />
		<asp:ListItem Text="<%$ Resources:Debug %>" Value="DEBUG" />
    </asp:DropDownList>
    <br />
    <br />
    <asp:UpdatePanel ID="UpdatePanel2" RenderMode="inline" runat="Server">
   	    <ContentTemplate>             			
            <BNWC:GridView 
                ID="gvLog" 
                runat="server" 
                SkinID="GridView"
                AllowPaging="True" 
                AllowSorting="True"
                ClientIDMode="Predictable"
                PagerSettings-Mode="NumericFirstLast"
                PagerStyle-HorizontalAlign="right"
                BorderWidth="1px"
                BorderStyle="Solid" 
                GridLines="None"  
                AutoGenerateColumns="False"
                UseAccessibleHeader="true" 
                SortAscImageUrl="~/images/bullet_arrow_up.png" 
                SortDescImageUrl="~/images/bullet_arrow_down.png"
                OnPageIndexChanging="gvLog_PageIndexChanging"
                OnSorting="gvLog_Sorting"
                OnRowDataBound="gvLog_RowDataBound">
                <Columns>
                    <asp:BoundField DataField="Id" HeaderText="<%$ Resources:SharedResources, Id %>" SortExpression="Id">
                        <ItemStyle HorizontalAlign="Left" Width="60px" />
                        <HeaderStyle HorizontalAlign="Left" Width="60px" />
                    </asp:BoundField>

                     <asp:BoundField DataField="Date" HeaderText="<%$ Resources:SharedResources, Date %>" SortExpression="Date" DataFormatString="{0:d}  {0:HH\:mm\:ss}">
                        <ItemStyle HorizontalAlign="Left" Width="100px" />
                        <HeaderStyle HorizontalAlign="Left" Width="100px" />                         
                     </asp:BoundField>

                    <asp:TemplateField HeaderText="<%$ Resources:Level %>" SortExpression="Level">
                        <ItemStyle HorizontalAlign="Left" Width="75px" />
                        <HeaderStyle HorizontalAlign="Left" Width="75px" /> 
                        <ItemTemplate>
                            <asp:image id="imgLevel" runat="server" CssClass="icon" ImageUrl=""></asp:image>&nbsp;<asp:Label ID="LevelLabel" runat="server"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    
                    <asp:BoundField DataField="User" HeaderText="<%$ Resources:User %>" SortExpression="User">
                        <ItemStyle HorizontalAlign="Left" Width="150px" />
                        <HeaderStyle HorizontalAlign="Left" Width="150px" /> 
                    </asp:BoundField>

                    <asp:TemplateField HeaderText="<%$ Resources:Logger %>" SortExpression="Logger">
                        <ItemStyle HorizontalAlign="Left" Width="300px" />
                        <HeaderStyle HorizontalAlign="Left" Width="300px" />                         
                        <ItemTemplate>
                            <asp:Label ID="LoggerLabel" runat="server"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>                
                    <asp:TemplateField HeaderText="<%$ Resources:Message %>" SortExpression="Message">
                        <ItemStyle HorizontalAlign="Left" Width="300px" />
                        <HeaderStyle HorizontalAlign="Left" Width="300px" />                           
                        <ItemTemplate>
                                <asp:Label ID="MessageLabel" runat="server"></asp:Label>
                            </td>
                            </tr> 
				            <tr>
					            <td colspan="6" style="width: 100%; padding: 0px;">
					                <div style="display:none;background-color:#efefef;padding:10px;overflow-x:scroll;overflow-y: hidden; " id='Exception_<%#Eval("Id")%>'>
					                    <table style="table-layout:fixed;width:100%;">
					                        <tr>
					                            <td><pre><asp:Label ID="ExceptionLabel"  runat="server" Width="100%"></asp:Label></pre></td>
					                        </tr>
					                    </table>     		                                                       
                                    </div>                                                                     
                        </ItemTemplate>
                    </asp:TemplateField> 
                </Columns>
                <EmptyDataTemplate>
                    <p style="font-style:italic;"> <asp:literal ID="NoEntries" runat="Server" Text="<%$ Resources:NoEntries %>"  /></p>
                </EmptyDataTemplate>               
            </BNWC:GridView>
            <div class="pager">
                <asp:DataPager ID="pager" runat="server" PageSize="10" PagedControlID="gvLog">
                    <Fields>
                        <BNWC:BugNetPagerField   
                            NextPageImageUrl="~/App_Themes/Default/Images/resultset_next.gif" 
                            PreviousPageImageUrl="~/App_Themes/Default/Images/resultset_previous.gif" 
                            LastPageImageUrl="~/App_Themes/Default/Images/resultset_last.gif"   
                            FirstPageImageUrl="~/App_Themes/Default/Images/resultset_first.gif" />                         
                    </Fields>                            
                </asp:DataPager>
            </div>    
     </ContentTemplate>
    </asp:UpdatePanel>
    <div style="padding:10px 0 10px 0;">
        <asp:imagebutton runat="server" id="save" CssClass="icon" OnClick="cmdClearLog_Click"  ImageUrl="~/Images/page_white_delete.gif" />
        <asp:LinkButton ID="cmdClearLog" OnClick="cmdClearLog_Click" runat="server" Text="[Clear Log]" meta:resourcekey="cmdClearLog" />
    </div>
</asp:Content>


