<%@ Control Language="c#" Inherits="BugNET.Issues.UserControls.Comments" Codebehind="Comments.ascx.cs" %>
<%@ implements interface="BugNET.UserInterfaceLayer.IIssueTab" %>
<script type="text/javascript">
//    function BindControlEvents() {
//        $('#<%=Button1.ClientID%>').click(function () {
//            $.blockUI({ css: {
//                border: 'none',
//                padding: '10px',
//                backgroundColor: '#efefef',
//                '-webkit-border-radius': '5px',
//                '-moz-border-radius': '5px',
//                opacity: .9,
//                color: '#fff'
//            }
//            });
//            setTimeout($.unblockUI, 2000);
//        });
//    }
//    $(document).ready(function () {
//        BindControlEvents();
//    });

//    var prm = Sys.WebForms.PageRequestManager.getInstance();
//    prm.add_endRequest(function () {
//        BindControlEvents();
//    });
</script>
<asp:Repeater ID="rptComments" OnItemCommand="rptComments_ItemCommand" OnItemDataBound="rptComments_ItemDataBound"  runat="server">
    <ItemTemplate>
		<div id="CommentArea" class="commentContainer" runat="server">
		         <asp:panel id="pnlComment" runat="server">
                <a id='<%#DataBinder.Eval(Container.DataItem, "Id") %>'></a>
                 <asp:Image ID="Avatar" style="float:left;padding:3px;border:1px solid #ddd;" src="" runat="server" />
                <p class="commentTitle" style="margin-left:60px;"> 
                   <span style="float:right;">
                     &nbsp; <asp:LinkButton ID="lnkDeleteComment" CausesValidation="false" runat="Server"  CommandName="Delete" CommandArgument='<%#DataBinder.Eval(Container.DataItem, "Id") %>' Text="<%$ Resources:SharedResources, Delete %>" />
                    &nbsp; <asp:LinkButton ID="lnkEditComment" CausesValidation="false" runat="Server" CommandName="Edit" CommandArgument='<%#DataBinder.Eval(Container.DataItem, "Id") %>' Text="<%$ Resources:SharedResources, Edit %>" />
                    </span>
                    <span><asp:label  CssClass="commentAuthor" ID="CreatorDisplayName" runat="server"  /> (<asp:Label id="lblDateCreated" Runat="Server" Text='' />)</span>
                    <asp:HyperLink ID="hlPermalink" ToolTip="<%$Resources:hlPermalink.Text%>" runat="server" Text="#"></asp:HyperLink>
                </p>
               <div style="margin-left:60px;margin-top:0.7em;"><asp:Literal id="ltlComment" Runat="Server" /></div>
           </asp:panel>
            <asp:panel id="pnlEditComment" style="padding:15px 15px 15px 0px;" runat="server">
	            <h3><asp:label ID="lblEditComment" runat="server" meta:resourcekey="cmdEditComment">Edit Comment</asp:label></h3>
	            <bn:HtmlEditor id="EditCommentHtmlEditor" Height="200" runat="server" />	        
	            <asp:HiddenField runat="server" id="commentNumber" value="" />
                <div style="margin-top:1.5em">
                    <asp:Button Text="Edit" CausesValidation="True" runat="server" id="Button1" meta:resourcekey="cmdEditComment" ValidationGroup="EditComment" OnClick="cmdEditComment_Click" />
                    <asp:Button Text="<%$ Resources:SharedResources, Cancel %>" CausesValidation="True" runat="server" id="Button2" ValidationGroup="EditComment" OnClick="cmdCancelEdit_Click" />
                </div>          
            </asp:panel>                              
        </div>
    </ItemTemplate>
   <AlternatingItemTemplate>
		<div id="CommentArea" class="commentContainerAlt" runat="server">
		    <asp:panel id="pnlComment" runat="server">
                <a id='<%#DataBinder.Eval(Container.DataItem, "Id") %>'></a>
                <asp:Image ID="Avatar" style="float:left;padding:3px;border:1px solid #ddd;" src="" runat="server" />
                <p class="commentTitle" style="margin-left:60px;"> 
                   <span style="float:right;">
                     &nbsp; <asp:LinkButton ID="lnkDeleteComment" CausesValidation="false" runat="Server"  CommandName="Delete" CommandArgument='<%#DataBinder.Eval(Container.DataItem, "Id") %>' Text="<%$ Resources:SharedResources, Delete %>" />
                    &nbsp; <asp:LinkButton ID="lnkEditComment" CausesValidation="false" runat="Server" CommandName="Edit" CommandArgument='<%#DataBinder.Eval(Container.DataItem, "Id") %>' Text="<%$ Resources:SharedResources, Edit %>" />
                    </span>  
                    <span><asp:label  CssClass="commentAuthor" ID="CreatorDisplayName" runat="server"  /> (<asp:Label id="lblDateCreated" Runat="Server" Text='' />)</span>
                    <asp:HyperLink ID="hlPermalink" ToolTip="<%$Resources:hlPermalink.Text%>" runat="server" Text="#"></asp:HyperLink>
                </p>
                <div style="margin-left:60px;margin-top:0.7em;"><asp:Literal id="ltlComment" Runat="Server" /></div>
           </asp:panel>
            <asp:panel id="pnlEditComment" style="padding:15px 15px 15px 0px;" runat="server">
	            <h3><asp:label ID="lblEditComment" runat="server" meta:resourcekey="cmdEditComment">Edit Comment</asp:label></h3>
	            <bn:HtmlEditor id="EditCommentHtmlEditor" Height="200" runat="server" />
	        
	            <asp:HiddenField runat="server" id="commentNumber" value="" />
	            <div style="margin-top:1.5em">
                    <asp:Button Text="Edit" CausesValidation="True" runat="server" id="Button1" meta:resourcekey="cmdEditComment" ValidationGroup="EditComment" OnClick="cmdEditComment_Click" />
                    <asp:Button Text="<%$ Resources:SharedResources, Cancel %>" CausesValidation="True" runat="server" id="Button2" ValidationGroup="EditComment" OnClick="cmdCancelEdit_Click" />
                </div>   
            </asp:panel>                              
        </div>
    </AlternatingItemTemplate>
</asp:Repeater>    
<asp:label id="lblComments"  Font-Italic="true" runat="server"></asp:label>
 
    <asp:panel id="pnlAddComment"  CssClass="fieldgroup" runat="server">
        <h3><asp:Literal ID="Literal1" runat="server" meta:resourcekey="LeaveComment" /></h3> 
        <bn:HtmlEditor id="CommentHtmlEditor" runat="server" />
        <div style="margin-top:1.5em">
            <asp:Button Text="Add Comment" CausesValidation="false" runat="server" id="Button1" meta:resourcekey="cmdAddComment" ValidationGroup="AddComment" OnClick="cmdAddComment_Click" />
        </div>       
    </asp:panel>
    
  