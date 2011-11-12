<%@ Control Language="c#" Inherits="BugNET.Issues.UserControls.Comments" CodeBehind="Comments.ascx.cs" %>
<%@ Implements Interface="BugNET.UserInterfaceLayer.IIssueTab" %>

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

<asp:Repeater ID="rptComments" OnItemCommand="RptCommentsItemCommand" OnItemDataBound="rptComments_ItemDataBound" runat="server">
    <ItemTemplate>
        <div id="CommentArea" class="commentContainer" runat="server">
            <asp:Panel ID="pnlComment" runat="server">
                <a id='<%#DataBinder.Eval(Container.DataItem, "Id") %>'></a>
                <asp:Image ID="Avatar" Style="float: left; padding: 3px; border: 1px solid #ddd;" src="" runat="server" />
                <p class="commentTitle" style="margin-left: 60px;">
                    <span style="float: right;">&nbsp;
                        <asp:ImageButton ID="cmdEditComment" ToolTip="<%$ Resources:SharedResources, Edit %>" AlternateText="<%$ Resources:SharedResources, Edit %>" CssClass="icon" ImageUrl="~/images/pencil.gif"
                            BorderWidth="0px" CommandName="Edit" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "Id") %>' runat="server" />
                        &nbsp;
                        <asp:ImageButton ID="cmdDeleteComment" ToolTip="<%$ Resources:SharedResources, Delete %>" AlternateText="<%$ Resources:SharedResources, Delete %>" CssClass="icon" ImageUrl="~/images/cross.gif"
                            BorderWidth="0px" CommandName="Delete" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "Id") %>' runat="server" />
                    </span>
                    <span>
                        <asp:Label CssClass="commentAuthor" ID="CreatorDisplayName" runat="server" />
                        (<asp:Label ID="lblDateCreated" runat="Server" Text='' />)
                    </span>
                    <asp:HyperLink ID="hlPermalink" ToolTip="<%$Resources:hlPermalink.Text%>" runat="server" Text="#"></asp:HyperLink>
                </p>
                <div style="margin-left: 60px; margin-top: 0.7em;">
                    <asp:Literal ID="ltlComment" runat="Server" /></div>
            </asp:Panel>
            <asp:Panel ID="pnlEditComment" Style="padding: 15px 15px 15px 0px;" runat="server">
                <h3><asp:Label ID="lblEditComment" runat="server" meta:resourcekey="cmdEditComment">Edit Comment</asp:Label></h3>
                <bn:HtmlEditor ID="EditCommentHtmlEditor" Height="200" runat="server" />
                <asp:HiddenField runat="server" ID="commentNumber" Value="" />
                <div style="margin-top: 1.5em">
                    <asp:Button ID="cmdUpdateComment" Text="<%$ Resources:SharedResources, Update %>" runat="server" CausesValidation="True" ValidationGroup="EditComment"
                        UseSubmitBehavior="false" CommandName="Save" />
                    <asp:Button ID="cmdCancelEdit" Text="<%$ Resources:SharedResources, Cancel %>" runat="server" CausesValidation="False" ValidationGroup="EditComment"
                        UseSubmitBehavior="false" CommandName="Cancel" />
                </div>
            </asp:Panel>
        </div>
    </ItemTemplate>
    <AlternatingItemTemplate>
        <div id="CommentArea" class="commentContainerAlt" runat="server">
            <asp:Panel ID="pnlComment" runat="server">
                <a id='<%#DataBinder.Eval(Container.DataItem, "Id") %>'></a>
                <asp:Image ID="Avatar" Style="float: left; padding: 3px; border: 1px solid #ddd;" src="" runat="server" />
                <p class="commentTitle" style="margin-left: 60px;">
                    <span style="float: right;">&nbsp;
                        <asp:ImageButton ID="cmdEditComment" ToolTip="<%$ Resources:SharedResources, Edit %>" AlternateText="<%$ Resources:SharedResources, Edit %>" CssClass="icon" ImageUrl="~/images/pencil.gif"
                            BorderWidth="0px" CommandName="Edit" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "Id") %>' runat="server" />
                        &nbsp;
                        <asp:ImageButton ID="cmdDeleteComment" ToolTip="<%$ Resources:SharedResources, Delete %>" AlternateText="<%$ Resources:SharedResources, Delete %>" CssClass="icon" ImageUrl="~/images/cross.gif"
                            BorderWidth="0px" CommandName="Delete" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "Id") %>' runat="server" />
                    </span>
                    <span>
                        <asp:Label CssClass="commentAuthor" ID="CreatorDisplayName" runat="server" />
                        (<asp:Label ID="lblDateCreated" runat="Server" Text='' />)
                    </span>
                    <asp:HyperLink ID="hlPermalink" ToolTip="<%$Resources:hlPermalink.Text%>" runat="server" Text="#"></asp:HyperLink>
                </p>
                <div style="margin-left: 60px; margin-top: 0.7em;">
                    <asp:Literal ID="ltlComment" runat="Server" /></div>
            </asp:Panel>
            <asp:Panel ID="pnlEditComment" Style="padding: 15px 15px 15px 0px;" runat="server">
                <h3><asp:Label ID="lblEditComment" runat="server" meta:resourcekey="cmdEditComment">Edit Comment</asp:Label></h3>
                <bn:HtmlEditor ID="EditCommentHtmlEditor" Height="200" runat="server" />
                <asp:HiddenField runat="server" ID="commentNumber" Value="" />
                <div style="margin-top: 1.5em">
                    <asp:Button ID="cmdUpdateComment" Text="<%$ Resources:SharedResources, Update %>" runat="server" CausesValidation="True" ValidationGroup="EditComment"
                        UseSubmitBehavior="false" CommandName="Save" />
                    <asp:Button ID="cmdCancelEdit" Text="<%$ Resources:SharedResources, Cancel %>" runat="server" CausesValidation="False" ValidationGroup="EditComment"
                        UseSubmitBehavior="false" CommandName="Cancel" />
                </div>
            </asp:Panel>
        </div>
    </AlternatingItemTemplate>
</asp:Repeater>
<asp:Label ID="lblComments" Font-Italic="true" runat="server"></asp:Label>
<asp:Panel ID="pnlAddComment" CssClass="fieldgroup" runat="server">
    <h3><asp:Literal ID="Literal1" runat="server" meta:resourcekey="LeaveComment" /></h3>
    <bn:HtmlEditor ID="CommentHtmlEditor" runat="server" />
    <div style="margin-top: 1.5em">
        <asp:Button Text="Add Comment" CausesValidation="false" runat="server" ID="Button1" meta:resourcekey="cmdAddComment" ValidationGroup="AddComment"
            OnClick="CmdAddCommentClick" />
    </div>
</asp:Panel>
