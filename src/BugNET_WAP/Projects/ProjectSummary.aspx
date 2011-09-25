<%@ Page language="c#" Inherits="BugNET.Projects.ProjectSummary"  MasterPageFile="~/Shared/FourColumn.master" meta:resourcekey="Page" Title="Project Summary" MaintainScrollPositionOnPostback="true" Codebehind="ProjectSummary.aspx.cs" %>
<%@ Register Src="~/UserControls/CategoryTreeView.ascx" TagName="CategoryTreeView" TagPrefix="uc1" %>
  
    <asp:Content ContentPlaceHolderID="PageTitle" runat="server" ID="content5">
             
	         <div>
                    <asp:Panel style="float:left;margin-top:10px;margin-left:15px;text-align:left;height:20px;" ID="Panel9" runat="server">
                        <asp:image AlternateText="RSS Feeds" CssClass="icon" runat="server" ImageUrl="~/images/xml_small.gif" ID="Image3" /> <asp:image AlternateText="RSS Feeds" CssClass="icon" runat="server" ImageUrl="~/images/arrow_down.gif" ID="Image2" /> 
                    </asp:Panel>
                    <ajaxToolkit:HoverMenuExtender ID="hme2" runat="Server"
                        TargetControlID="Panel9"
                        PopupControlID="PopupMenu"
                        HoverCssClass="popupHover"                   
                        PopupPosition="Bottom"
                        OffsetX="0"
                        OffsetY="0" 
                        PopDelay="100" />
                    
                    <asp:Panel CssClass="popupMenu" ID="PopupMenu" runat="server">
                        <ul>
                            <li><asp:HyperLink ID="lnkRSSIssuesByCategory" runat="server" meta:resourcekey="IssuesByCategory">Issues by category</asp:HyperLink></li>
                            <li><asp:HyperLink ID="lnkRSSIssuesByAssignee" runat="server" meta:resourcekey="IssuesByAssignee">Issues by assignee</asp:HyperLink></li>
                            <li><asp:HyperLink ID="lnkRSSIssuesByStatus" runat="server" meta:resourcekey="IssuesByStatus">Issues by status</asp:HyperLink></li>
                            <li><asp:HyperLink ID="lnkRSSIssuesByMilestone" runat="server" meta:resourcekey="IssuesByMilestone">Issues by milestone</asp:HyperLink></li>
                            <li><asp:HyperLink ID="lnkRSSIssuesByPriority" runat="server" meta:resourcekey="IssuesByPriority">Issues by priority</asp:HyperLink></li>
                            <li><asp:HyperLink ID="lnkRSSIssuesByType" runat="server" meta:resourcekey="IssuesByType">Issues by type</asp:HyperLink></li>
                        </ul>
                    </asp:Panel>
             
	            <div class="centered-content">
	                <h1 class="page-title"><asp:literal enableviewstate="true" id="litProject" runat="server" /> <span>(<asp:Literal ID="litProjectCode" runat="Server"></asp:Literal>)</span> </h1>
	            </div>
	         
            </div>
    </asp:Content>
    
	<asp:Content ContentPlaceHolderID="leftcontent" runat="server" ID="content1">
        <asp:repeater runat="server" id="rptVersions">
            <HeaderTemplate>
                <table class="summary" cellspacing="3">
                    <tr>
                        <th colspan="4">
                            <div class="roundedBox">
                                <asp:Literal ID="Literal3" runat="server" Text="<%$ Resources:SharedResources, Milestone %>"/> <span class="small"><asp:Literal ID="Literal2" runat="server" meta:resourcekey="OpenIssues"/> </span>
                            </div>
                           
                        </th> 
                    </tr> 
            </HeaderTemplate> 
            <ItemTemplate>
                <tr>
                    <td class="image-column">
                        <bn:TextImage ID="MilestoneImage" runat="server" ImageUrl="package.gif" ImageDirectory="/Milestone" /> 
                    </td>
                    <td class="item-column"><asp:HyperLink id="HyperLink1" Text='<%# DataBinder.Eval(Container.DataItem, "Name") %>' NavigateUrl='<%# "~/Issues/IssueList.aspx?pid=" + HttpUtility.UrlEncode(ProjectId.ToString()) + "&m=" + HttpUtility.UrlEncode(DataBinder.Eval(Container.DataItem,"Id").ToString()) %>' runat="server" /></td>
                    <td class="count-column"><asp:label id="lblVersionCount" runat="Server"></asp:label></td>  
                    <td class="count-column"><asp:label id="lblPercent" runat="Server"></asp:label></td>  
                </tr> 
            </ItemTemplate> 
            <FooterTemplate>
                    <tr>
                        <td class="image-column"><asp:image ID="MilestoneImage" runat="server" ImageUrl="~/images/package.gif"  /> </td>
                        <td class="item-column"><asp:HyperLink id="HyperLink1" meta:resourceKey="Unscheduled" Text="Unscheduled" NavigateUrl='<%# "~/Issues/IssueList.aspx?pid=" + HttpUtility.UrlEncode(ProjectId.ToString()) + "&m=0" %>' runat="server" /></td>
                        <td class="count-column"><asp:label id="lblUnscheduledCount" runat="server"></asp:label></td>  
                        <td class="count-column"><asp:label id="lblPercent" runat="Server"></asp:label></td>  
                    </tr>   
                </table>
            </FooterTemplate> 
        </asp:repeater>                
</asp:Content>
<asp:Content ContentPlaceHolderID="centerleftcontent" runat="server" ID="content2">
    <table class="summary">
        <tr>
            <th>
                <div class="roundedBox">
                   <asp:Literal ID="Literal3" runat="server" Text="<%$ Resources:SharedResources, Category %>"/>  <span class="small"><asp:Literal ID="Literal2" runat="server" meta:resourcekey="OpenIssues"/></span>
                </div>
            </th> 
        </tr>
        <tr>
            <td>
                <uc1:CategoryTreeView ID="CategoryTreeView1" runat="server" />
            </td>
        </tr>
    </table> 
</asp:Content>
	
<asp:Content ContentPlaceHolderID="centerrightcontent" runat="server" ID="content3">
    <asp:repeater runat="server" id="rptAssignee">
        <HeaderTemplate>
            <table class="summary" cellspacing="3">
                <tr>
                    <th colspan="2">
                         <div class="roundedBox">
		                       <asp:Literal ID="Literal3" runat="server" meta:resourcekey="ByAssignee"/> <span class="small"><asp:Literal ID="Literal2" runat="server" meta:resourcekey="OpenIssues"/></span>
                        </div>
                    </th> 
                </tr> 
        </HeaderTemplate> 
        <ItemTemplate>
            <tr>
                <td class="item-column"><asp:HyperLink id="HyperLink1" Text='<%# DataBinder.Eval(Container.DataItem, "Name") %>' NavigateUrl='<%# "~/Issues/IssueList.aspx?pid=" + HttpUtility.UrlEncode(ProjectId.ToString()) + "&u=" + HttpUtility.UrlEncode(DataBinder.Eval(Container.DataItem,"Id").ToString()) %>' runat="server" /></td>
                <td class="count-column"><asp:label id="lblCount" runat="Server"></asp:label></td>  
            </tr> 
        </ItemTemplate> 
        <FooterTemplate>
                <tr>
                    <td class="item-column">
                        <asp:HyperLink Runat="server" ID="HyperLink2" NavigateUrl='<%# "~/Issues/IssueList.aspx?pid=" + HttpUtility.UrlEncode(ProjectId.ToString()) + "&u=0" %>' meta:resourceKey="Unassigned" >Unassigned</asp:HyperLink></td>
                    <td class="count-column"><asp:label id="lblUnassignedCount" runat="server"></asp:label></td>  
                </tr>              
            </table>
        </FooterTemplate> 
    </asp:repeater>
</asp:Content>

<asp:Content ContentPlaceHolderID="rightcontent" runat="server" ID="content4">
 <asp:repeater runat="server" id="rptSummary">
            <HeaderTemplate>
                <table class="summary" cellspacing="3">
                    <tr>
	                    <th colspan="4">
		                      <div class="roundedBox">
				                  <asp:Literal ID="Literal3" runat="server" Text="<%$ Resources:SharedResources, Status %>"/>
		                    </div>
	                    </th> 
                    </tr> 
            </HeaderTemplate> 
            <ItemTemplate>
                <tr>
                    <td class="image-column"><bn:TextImage ID="StatusImage" runat="server" ImageDirectory="/Status" /> </td>
                    <td class="item-column">
                        <asp:HyperLink id="HyperLink1" Text='<%# DataBinder.Eval(Container.DataItem, "Name") %>' NavigateUrl='<%# "~/Issues/IssueList.aspx?pid=" + HttpUtility.UrlEncode(ProjectId.ToString()) + "&s=" + HttpUtility.UrlEncode(DataBinder.Eval(Container.DataItem,"Id").ToString()) %>' runat="server" />
                     </td>
                    <td class="count-column"><asp:label id="lblCount" runat="Server"></asp:label></td>  
                    <td class="count-column"><asp:label id="lblPercent" runat="Server"></asp:label></td>  
                </tr> 
            </ItemTemplate> 
            <FooterTemplate>
                </table>
            </FooterTemplate> 
        </asp:repeater>
        <asp:repeater runat="server" id="rptOpenIssues">
            <HeaderTemplate>
                <table class="summary" cellspacing="3">
                    <tr>
	                    <th colspan="3">
		                   <div class="roundedBox">
				                 <asp:Literal ID="Literal3" runat="server" Text="<%$ Resources:SharedResources, Priority %>"/>
		                    </div>
	                    </th> 
                    </tr> 
            </HeaderTemplate> 
            <ItemTemplate>
                <tr>
                    <td class="image-column"><bn:TextImage ID="PriorityImage" runat="server" ImageDirectory="/Priority" /> </td>
                    <td class="item-column">
                        <asp:HyperLink id="HyperLink1" Text='<%# DataBinder.Eval(Container.DataItem, "Name") %>' NavigateUrl='<%# "~/Issues/IssueList.aspx?pid=" + HttpUtility.UrlEncode(ProjectId.ToString()) + "&p=" + HttpUtility.UrlEncode(DataBinder.Eval(Container.DataItem,"Id").ToString()) %>' runat="server" />
                    </td>
                    <td class="count-column"><asp:label id="lblCount" runat="Server"></asp:label></td>  
                </tr> 
            </ItemTemplate> 
            <FooterTemplate>
                </table>
            </FooterTemplate> 
        </asp:repeater>	
        <asp:repeater runat="server" id="rptType">
            <HeaderTemplate>
                <table class="summary" cellspacing="3">
                    <tr>
	                    <th colspan="3">
		                    <div class="roundedBox">
				                <asp:Literal ID="Literal3" runat="server" Text="<%$ Resources:SharedResources, Type %>" />
		                    </div>
	                    </th> 
                    </tr> 
            </HeaderTemplate> 
            <ItemTemplate>
                <tr>
                    <td class="image-column"><bn:TextImage ID="IssueTypeImage" runat="server" ImageDirectory="/IssueType" /></td>
                    <td class="item-column">
                        <asp:HyperLink id="HyperLink1" Text='<%# DataBinder.Eval(Container.DataItem, "Name") %>' NavigateUrl='<%# "~/Issues/IssueList.aspx?pid=" + HttpUtility.UrlEncode(ProjectId.ToString()) + "&t=" + HttpUtility.UrlEncode(DataBinder.Eval(Container.DataItem,"Id").ToString()) %>' runat="server" />
                    </td>
                    <td class="count-column"><asp:label id="lblCount" runat="Server"></asp:label></td>  
                </tr> 
            </ItemTemplate> 
            <FooterTemplate>
                </table>
            </FooterTemplate> 
        </asp:repeater>	
        
        
        
</asp:Content> 
