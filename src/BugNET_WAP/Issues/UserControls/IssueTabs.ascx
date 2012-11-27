<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="IssueTabs.ascx.cs" Inherits="BugNET.Issues.UserControls.IssueTabs" %>

<%@ Register Src="Comments.ascx" TagName="Comments" TagPrefix="IssueTab" %>
<%@ Register Src="Attachments.ascx" TagName="Attachments" TagPrefix="IssueTab" %>
<%@ Register Src="History.ascx" TagName="History" TagPrefix="IssueTab" %>
<%@ Register Src="Notifications.ascx" TagName="Notifications" TagPrefix="IssueTab" %>
<%@ Register Src="ParentIssues.ascx" TagName="ParentIssues" TagPrefix="IssueTab" %>
<%@ Register Src="RelatedIssues.ascx" TagName="RelatedIssues" TagPrefix="IssueTab" %>
<%@ Register Src="Revisions.ascx" TagName="Revisions" TagPrefix="IssueTab" %>
<%@ Register Src="SubIssues.ascx" TagName="SubIssues" TagPrefix="IssueTab" %>
<%@ Register Src="TimeTracking.ascx" TagName="TimeTracking" TagPrefix="IssueTab" %>

<script type="text/javascript">
    var pleaseWaitMessage = '<%= GetLocalResourceObject("PleaseWaitMessage") %>';
    $(document).ready(function () {
        var shift = 130;
        $('.scrollButtons .left').click(function () {
            var content = $(".issueTabs")
            var pos = content.position().left + shift;
            if (pos > 0) pos = 0;
            content.animate({ left: pos }, 200);
        });
        $('.scrollButtons .right').click(function () {
            var content = $(".issueTabs")
            var pos = content.position().left - shift;
            if (content.width() + pos < 400) {
                var newPos = $(".scrollable").width() - $(".issueTabs").width();
            }
            content.animate({ left: pos }, 200);
        });
        $("ul.issueTabs a").removeAttr('href');
    });

    Sys.WebForms.PageRequestManager.getInstance().add_beginRequest(BeginRequestHandler);
    Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);
    
    function BeginRequestHandler(sender, args) {
        $('div.issueTabsContainer').block({ message: pleaseWaitMessage, css: {
            border: 'none',
            padding: '10px',
            backgroundColor: '#efefef',
            '-webkit-border-radius': '5px',
            '-moz-border-radius': '5px',
            opacity: .9,
            color: '#fff'
        }
        });
    }
    function EndRequestHandler(sender, args) {
        $("ul.issueTabs a").removeAttr('href');
        $('div.issueTabsContainer').unblock();
    }
</script>

<div class="issueTabsContainer">
    <asp:UpdatePanel ID="IssueTabsUpdatePanel" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="true">
        <ContentTemplate>
            <div>
                <div class="scrollable">
                    <div class="content">
                        <asp:Menu  
                            ID="IssueTabsMenu" 
                            OnMenuItemClick="IssueTabsMenu_Click" 
                            runat="server" 
                            IncludeStyleBlock="false" 
                            ViewStateMode="Enabled"
                            RenderingMode="List" 
                            CssClass="content">
                            <StaticMenuStyle CssClass="issueTabs" />
                            <StaticMenuItemStyle CssClass="issueTab" />
                            <StaticSelectedStyle CssClass="issueTabSelected" />
                        </asp:Menu>
                    </div>
                </div>
                <div class="scrollButtons">
                    <a class="right" style=""></a><a class="left" style=""></a>
                </div>
                <div style="padding: 2em; border: 1px solid #D5D291; background-color: White; top: -1px; position: relative; display: block;">
                    <IssueTab:Notifications ID="TabNotifications" runat="server" Visible="false" />
                    <IssueTab:History ID="TabHistory" runat="server" Visible="false" />
                    <IssueTab:Attachments ID="TabAttachments" runat="server" Visible="false" />
                    <IssueTab:Comments ID="TabComments" runat="server" Visible="false" />
                    <IssueTab:ParentIssues ID="TabParentIssues" runat="server" Visible="false" />
                    <IssueTab:RelatedIssues ID="TabRelatedIssues" runat="server" Visible="false" />
                    <IssueTab:Revisions ID="TabRevisions" runat="server" Visible="false" />
                    <IssueTab:SubIssues ID="TabSubIssues" runat="server" Visible="false" />
                    <IssueTab:TimeTracking ID="TabTimeTracking" runat="server" Visible="false" />
                </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</div>
