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
    $(document).ready(function () {;
        $("ul.issue-tabs a").removeAttr('href');
    });

    //Sys.WebForms.PageRequestManager.getInstance().add_beginRequest(BeginRequestHandler);
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
        $("ul.issue-tabs a").removeAttr('href');
        //$('div.issueTabsContainer').unblock();
    }
</script>

<div>
    <asp:UpdatePanel ID="IssueTabsUpdatePanel" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="true">
        <ContentTemplate>
            <asp:Menu  
                ID="IssueTabsMenu" 
                OnMenuItemClick="IssueTabsMenu_Click" 
                runat="server" 
                IncludeStyleBlock="false" 
                ViewStateMode="Enabled"
                RenderingMode="List" 
                CssClass="content">
                <StaticMenuStyle CssClass="nav nav-tabs issue-tabs" />
                <StaticSelectedStyle CssClass="active" />
            </asp:Menu>

            <div style="margin-top:1.5em;">
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
