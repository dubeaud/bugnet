<%@ Page Language="C#" MasterPageFile="~/Shared/SingleColumn.master"  Title="Road Map" AutoEventWireup="true" meta:resourcekey="Page" Inherits="BugNET.Projects.Roadmap" Codebehind="RoadMap.aspx.cs" %>
<%@ Register TagPrefix="it" TagName="TextImage" Src="~/UserControls/TextImage.ascx" %>

<asp:Content ID="Content2" ContentPlaceHolderID="Content" Runat="Server">
 <asp:ScriptManagerProxy ID="ScriptManagerProxy1" runat="server">
        <Scripts>
            <asp:ScriptReference Path="~/Scripts/jquery.cookie.js" />
        </Scripts>
    </asp:ScriptManagerProxy>
    <script type="text/javascript">
        $(document).ready(function () {
            $('.milestoneGroupHeader').click(function () {
                var li = $(this).parent();
                if (li.hasClass('active')) {
                    li.removeClass('active');
                    li.children('.milestoneContent').slideUp();
                    $.cookie(li.attr('id'), null);
                }
                else {
                    li.addClass('active');
                    li.children('.milestoneContent').slideDown();
                    $.cookie(li.attr('id'), 'expanded');
                }

            });
            $("li.expand").each(function () {
                var isExpanded = $.cookie($(this).attr('id'));
                if (isExpanded == 'expanded') {
                    $(this).addClass('active');
                    $(this).children('.milestoneContent').show();
                }
            });
        });
    </script>
    <div class="centered-content">
	    <h1 class="page-title"><asp:literal id="Literal1" runat="server"  meta:resourcekey="TitleLabel" /> - <asp:literal id="ltProject" runat="server" /> <span>(<asp:Literal ID="litProjectCode" runat="Server"></asp:Literal>)</span> </h1>
    </div>
    <asp:repeater runat="server" id="RoadmapRepeater" OnItemDataBound="RoadmapRepeater_ItemDataBound">
        <HeaderTemplate>
            <ul class="milestoneList">
        </HeaderTemplate>
        <ItemTemplate>
            <li class="expand" id='milestoneRoadmap-<%#DataBinder.Eval(Container.DataItem, "Id") %>'>
                <div class="milestoneGroupHeader" >
                    <div class="milestoneProgress">
                        &nbsp;<asp:label id="PercentLabel" runat="Server" style="float:right;padding-left:10px;width:30px;text-align:right;"></asp:label>
                        <div  class="roadMapProgress" style="float:right;vertical-align:top;background-color:#FA0000;font-size:8px;width:135px;height:15px;margin:0px;text-align:center;">
                                <div  id="ProgressBar" runat='server' style="display: block;height:15px; background: #6FB423 url('../images/fade.png') repeat-x 0% -3px;">&nbsp;</div>
				
                        </div>
                        <br />
                        <asp:label style="float:left;" id="lblProgress" runat="Server"></asp:label>
                    </div>
                    <asp:HyperLink ID="MilestoneLink" CssClass="milestoneName" runat="server" />
                    <asp:label CssClass="milestoneNotes" id="MilestoneNotes" runat="Server"></asp:label>
	                <br style="clear:both;" />
	                <span class="milestoneReleaseDate"><asp:label id="lblDueDate" runat="Server"></asp:label></span>                   
                </div>
                <div class="milestoneContent" style="display:none;">
                    <asp:Repeater ID="IssuesList" OnItemCreated="rptRoadMap_ItemCreated" runat="server" >
                        <HeaderTemplate>
                           <table class="grid">
			                <tr>
                                <td runat="server" id="tdId" class="gridHeader"><asp:LinkButton ID="LinkButton2" Runat="server" OnClick="SortIssueIdClick" Text="<%$ Resources:SharedResources, Id %>" /></td> 
				                <td runat="server" id="tdCategory" class="gridHeader"><asp:LinkButton ID="lnkCategory" Runat="server" Text="<%$ Resources:SharedResources, Category %>" OnClick="SortCategoryClick" /></td> 
				                <td runat="server" id="tdIssueType" class="gridHeader" style="text-align:center;"><asp:LinkButton ID="LinkButton1" Runat="server" OnClick="SortIssueTypeClick" Text="<%$ Resources:SharedResources, Type %>" /></td> 
				                <td runat="server" id="tdPriority" class="gridHeader" style="text-align:center;"><asp:LinkButton ID="LinkButton8" Runat="server" Text="<%$ Resources:SharedResources, Priority %>"  OnClick="SortPriorityClick" /></td>   
				                <td runat="server" id="tdTitle" class="gridHeader"><asp:LinkButton ID="LinkButton3" Runat="server" OnClick="SortTitleClick" Text="<%$ Resources:SharedResources, Title %>" /></td>
				                <td runat="server" id="tdAssigned" class="gridHeader"><asp:LinkButton ID="LinkButton4" Runat="server" OnClick="SortAssignedUserClick" Text="<%$ Resources:SharedResources, AssignedTo %>" /></td>
                                <td runat="server" id="tdDueDate" class="gridHeader"><asp:LinkButton ID="LinkButton5" Runat="server" OnClick="SortDueDateClick" Text="<%$ Resources:SharedResources, DueDate %>" /></td>
				                <td runat="server" id="tdStatus" class="gridHeader" style="text-align:center;"><asp:LinkButton ID="LinkButton6" Runat="server" OnClick="SortStatusClick" Text="<%$ Resources:SharedResources, Status %>" /></td>  
			                </tr> 
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr id="Row" runat="server"> 
                                <td><a href='../Issues/IssueDetail.aspx?id=<%#DataBinder.Eval(Container.DataItem, "Id") %>'><%#DataBinder.Eval(Container.DataItem, "FullId") %></a></td>			    
			                    <td><asp:label id="lblComponent" Text='<%# DataBinder.Eval(Container.DataItem, "CategoryName" )%>' runat="Server"></asp:label></td>
			                    <td style="text-align:center;"><it:TextImage id="ctlType" ImageDirectory="/IssueType" 
                                    Text='<%# DataBinder.Eval(Container.DataItem, "IssueTypeName" )%>' 
                                    ImageUrl='<%# DataBinder.Eval(Container.DataItem, "IssueTypeImageUrl" )%>' Runat="server" /></td>
                                <td style="text-align:center;"><it:TextImage id="ctlPriority" ImageDirectory="/Priority" 
                                    Text='<%# DataBinder.Eval(Container.DataItem, "PriorityName" )%>' 
                                    ImageUrl='<%# DataBinder.Eval(Container.DataItem, "PriorityImageUrl" )%>' 
                                    Runat="server" /></td>
			                
			                    <td><a href='../Issues/IssueDetail.aspx?id=<%#DataBinder.Eval(Container.DataItem, "Id") %>'><asp:label id="lblSummary"  Text='<%# DataBinder.Eval(Container.DataItem, "Title" )%>' runat="Server"></asp:label></a></td>
			                    <td><asp:label id="lblAssignedTo" Text='<%# DataBinder.Eval(Container.DataItem, "AssignedDisplayName" )%>'  runat="Server"></asp:label></td>
			                    <td>  <%#(DateTime)Eval("DueDate") == DateTime.MinValue ? "none" : Eval("DueDate", "{0:d}") %></td>
                                <td style="text-align:center;"><it:TextImage id="ctlStatus" ImageDirectory="/Status" 
                                    Text='<%# DataBinder.Eval(Container.DataItem, "StatusName" )%>' 
                                    ImageUrl='<%# DataBinder.Eval(Container.DataItem, "StatusImageUrl" )%>' Runat="server" /></td>
		                    </tr> 
                        </ItemTemplate>
                        <AlternatingItemTemplate>
                            <tr id="AlternateRow" runat="server"  class="gridAltRow"> 
                                <td><a href='../Issues/IssueDetail.aspx?id=<%#DataBinder.Eval(Container.DataItem, "Id") %>'><%#DataBinder.Eval(Container.DataItem, "FullId") %></a></td>			    
			                    <td><asp:label id="lblComponent" Text='<%# DataBinder.Eval(Container.DataItem, "CategoryName" )%>' runat="Server"></asp:label></td>
			                    <td style="text-align:center;"><it:TextImage id="ctlType" ImageDirectory="/IssueType" 
                                    Text='<%# DataBinder.Eval(Container.DataItem, "IssueTypeName" )%>' 
                                    ImageUrl='<%# DataBinder.Eval(Container.DataItem, "IssueTypeImageUrl" )%>' Runat="server" /></td>
                                <td style="text-align:center;"><it:TextImage id="ctlPriority" ImageDirectory="/Priority" 
                                    Text='<%# DataBinder.Eval(Container.DataItem, "PriorityName" )%>' 
                                    ImageUrl='<%# DataBinder.Eval(Container.DataItem, "PriorityImageUrl" )%>' 
                                    Runat="server" /></td>
			                
			                    <td><a href='../Issues/IssueDetail.aspx?id=<%#DataBinder.Eval(Container.DataItem, "Id") %>'><asp:label id="lblSummary"  Text='<%# DataBinder.Eval(Container.DataItem, "Title" )%>' runat="Server"></asp:label></a></td>
			                    <td><asp:label id="lblAssignedTo" Text='<%# DataBinder.Eval(Container.DataItem, "AssignedDisplayName" )%>'  runat="Server"></asp:label></td>
			                    <td>  <%#(DateTime)Eval("DueDate") == DateTime.MinValue ? "none" : Eval("DueDate", "{0:d}") %></td>
                                <td style="text-align:center;"><it:TextImage id="ctlStatus" ImageDirectory="/Status" 
                                    Text='<%# DataBinder.Eval(Container.DataItem, "StatusName" )%>' 
                                    ImageUrl='<%# DataBinder.Eval(Container.DataItem, "StatusImageUrl" )%>' Runat="server" /></td>
		                    </tr> 
                        </AlternatingItemTemplate>
                        <FooterTemplate>
                           </table>
                        </FooterTemplate>
                    </asp:Repeater>
                </div>
            </li>
        </ItemTemplate>
        <FooterTemplate>
            </ul>
        </FooterTemplate>
    </asp:repeater>
</asp:Content>


