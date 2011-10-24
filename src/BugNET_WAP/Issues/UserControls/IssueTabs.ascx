<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="IssueTabs.ascx.cs" Inherits="BugNET.Issues.UserControls.IssueTabs" %>

<script type="text/javascript">
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
                newPos = $(".scrollable").width() - $(".issueTabs").width();
            }
            content.animate({ left: pos }, 200);

        });


    });

    Sys.WebForms.PageRequestManager.getInstance().add_beginRequest(BeginRequestHandler);
    Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);
    function BeginRequestHandler(sender, args) {
        $('div.issueTabsContainer').block({ css: {
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

        $('div.issueTabsContainer').unblock();
    }
</script>
<div class="issueTabsContainer">
<asp:UpdatePanel ID="IssueTabsUpdatePanel" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="true">
	<ContentTemplate>
		<div> 
		<div class="scrollable">
				<div class="content">  
			        <asp:Menu ID="IssueTabsMenu" OnMenuItemClick="IssueTabsMenu_Click" runat="server" IncludeStyleBlock="false"  ViewStateMode="Enabled" RenderingMode="List" CssClass="content" >
				        <StaticMenuStyle CssClass="issueTabs" />
				        <StaticMenuItemStyle CssClass="issueTab"  />
				        <StaticSelectedStyle CssClass="issueTabSelected" />
			        </asp:Menu> 	
				</div>
			</div>
			<div class="scrollButtons">
				<a  class="right" style=""></a>
				<a  class="left" style=""></a>
			</div>
			
			<div style="padding:2em;border:1px solid #D5D291;background-color:White;top:-1px;position:relative;display:block;min-height:150px;">    
				<asp:PlaceHolder id="plhContent" Runat="Server" />			
			</div>
			
		</div>   

</ContentTemplate>
</asp:UpdatePanel>
</div>