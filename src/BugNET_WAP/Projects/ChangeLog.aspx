<%@ Page language="c#" Inherits="BugNET.Projects.ChangeLog" MasterPageFile="~/Shared/SingleColumn.master" meta:resourcekey="Page" Title="Change Log" Codebehind="ChangeLog.aspx.cs" %>
<%@ Register TagPrefix="it" TagName="TextImage" Src="~/UserControls/TextImage.ascx" %>

<asp:Content ContentPlaceHolderID="Content" ID="content1" runat="server">
    <asp:ScriptManagerProxy ID="ScriptManagerProxy1" runat="server">
        <Scripts>
            <asp:ScriptReference Path="~/js/jquery.cookie.js" />
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
	    <h1 class="page-title"> <asp:literal id="Literal1" runat="server" Text="<%$ Resources:SharedResources, ChangeLog %>"  /> - <asp:literal id="ltProject" runat="server" /> <span>(<asp:Literal ID="litProjectCode" runat="Server"></asp:Literal>)</span> </h1>
    </div>
    <div style="float:right;">
         <asp:Localize runat="server" ID="Sort" Text="Sort:" meta:resourcekey="SortLabel" /> <asp:linkbutton ID="Linkbutton7" runat="server" OnClick="SortMilestone_Click" CommandArgument="false" meta:resourcekey="MostRecent"  Text="Most Recent"></asp:linkbutton> | <asp:linkbutton ID="Linkbutton9" runat="server"  CommandArgument="true"  meta:resourcekey="FirstToLast"  OnClick="SortMilestone_Click" Text="First To Last"></asp:linkbutton>
    </div>
    <div>
       <asp:linkbutton ID="PreviousMilestones" runat="server" OnClick="SwitchViewMode_Click" CommandArgument="1" meta:resourcekey="PreviousMilestones" Text="Top 5 milestones"></asp:linkbutton> | <asp:linkbutton ID="Linkbutton5" runat="server" OnClick="SwitchViewMode_Click" CommandArgument="2" meta:resourcekey="AllMilestones" Text="All milestones"></asp:linkbutton>
    </div>
     <asp:repeater runat="server" id="ChangeLogRepeater" OnItemDataBound="ChangeLogRepeater_ItemDataBound">
        <HeaderTemplate>
            <ul class="milestoneList">
        </HeaderTemplate>
        <ItemTemplate>
            <li class="expand" id='milestone-<%#DataBinder.Eval(Container.DataItem, "Id") %>'>
                <div class="milestoneGroupHeader">
                    <div class="issueCount">
                        <asp:HyperLink ID="IssuesCount" runat="server" />
                    </div>
                    <asp:HyperLink ID="MilestoneLink" CssClass="milestoneName" runat="server" />
                    <asp:label CssClass="milestoneNotes" id="MilestoneNotes" runat="Server"></asp:label>
	                <br style="clear:both;" />
	                <span class="milestoneReleaseDate"><asp:label id="lblReleaseDate" runat="Server"></asp:label></span>
                    <span style="font-weight:normal;"><asp:HyperLink ID="ReleaseNotes" runat="server" Text="Release Notes"  meta:resourcekey="ReleaseNotes"/></span>
                </div>
                <div class="milestoneContent" style="display:none;">
                    <asp:Repeater ID="IssuesList" OnItemCreated="rptChangeLog_ItemCreated" runat="server" >
                        <HeaderTemplate>
                           <table class="grid">
			                <tr>				           
                                <td runat="server" id="tdId" class="gridHeader"><asp:LinkButton ID="LinkButton2" Runat="server" OnClick="SortIssueIdClick" Text="<%$ Resources:SharedResources, Id %>" /></td> 
				                <td runat="server" id="tdCategory" class="gridHeader"><asp:LinkButton ID="lnkCategory" Runat="server" Text="<%$ Resources:SharedResources, Category %>" OnClick="SortCategoryClick" /></td> 
				                <td runat="server" id="tdIssueType" class="gridHeader" style="text-align:center;"><asp:LinkButton ID="LinkButton1" Runat="server" OnClick="SortIssueTypeClick" Text="<%$ Resources:SharedResources, Type %>" /></td> 
				                <td runat="server" id="tdPriority" class="gridHeader" style="text-align:center;"><asp:LinkButton ID="LinkButton8" Runat="server" Text="<%$ Resources:SharedResources, Priority %>"  OnClick="SortPriorityClick" /></td>   
				                <td runat="server" id="tdTitle" class="gridHeader"><asp:LinkButton ID="LinkButton3" Runat="server" OnClick="SortTitleClick" Text="<%$ Resources:SharedResources, Title %>" /></td>
				                <td runat="server" id="tdAssigned" class="gridHeader"><asp:LinkButton ID="LinkButton4" Runat="server" OnClick="SortAssignedUserClick" Text="<%$ Resources:SharedResources, AssignedTo %>" /></td>
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
			                        <td style="text-align:center;"><it:TextImage id="ctlStatus" ImageDirectory="/Status" 
                                    Text='<%# DataBinder.Eval(Container.DataItem, "StatusName" )%>' 
                                    ImageUrl='<%# DataBinder.Eval(Container.DataItem, "StatusImageUrl" )%>' Runat="server" /></td>
		                    </tr> 
                        </ItemTemplate>
                        <AlternatingItemTemplate>
                            <tr class="gridAltRow" id="AlternateRow" runat="server">			               
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