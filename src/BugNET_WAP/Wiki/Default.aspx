<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="BugNET.Wiki.Default" MasterPageFile="~\Site.Master" %>

<asp:Content ID="indexContent" ContentPlaceHolderID="MainContent" runat="server">
    <div>
        <div id="sub-menu" class="row">
            <div id="editWiki" class="pull-right" runat="server">

                <asp:HyperLink ID="NewPage" meta:resourceKey="NewPage" CssClass="btn btn-link" Text="New Page" runat="server" />

                <asp:LinkButton ID="Delete" Text="Delete" meta:resourceKey="Delete" OnClick="Delete_Click" runat="server" />
                <a id="editWikiContent" class="btn btn-link" href="#">
                    <asp:Literal ID="EditContent" runat="server" meta:resourceKey="EditContent" /></a>
            </div>

            <asp:HyperLink ID="PageInfo" Text="Page Info" CssClass="btn btn-link" meta:resourceKey="PageInfo" runat="server" />
        </div>
    </div>
    <div id="wikiContainer">
        <div id="wikiHistory" class="pull-right well">
            <h3>
                <asp:Literal ID="litPageHistory" runat="server" meta:resourceKey="PageHistory" />
            </h3>
            <ul class="list-unstyled">
                <asp:Repeater ID="pageHistory" runat="server" OnItemDataBound="BindPageHistoryItem">
                    <ItemTemplate>
                        <li>
                            <asp:Literal ID="date" runat="server" />
                            <asp:HyperLink ID="versionLink" runat="server" />
                        </li>
                    </ItemTemplate>
                </asp:Repeater>
            </ul>
        </div>

        <div id="wikiContent">
            <div id="originalWikiContent">
                <asp:Literal ID="renderedSource" runat="server" />
            </div>
            <div id="previewWikiContent" style="display: none;"></div>
        </div>

        <div class="clear"></div>

        <div id="editWikiForm" class="editWikiForm" runat="server">
            <asp:HiddenField ID="Name" runat="server" />
            <fieldset>
                <legend>
                    <asp:Literal ID="Literal2" runat="server" meta:resourceKey="EditLiteral" />
                </legend>
                <asp:Label AssociatedControlID="Source" ID="SourceLabel" runat="server" meta:resourceKey="SourceLabel" />
                <asp:PlaceHolder ID="NotLatestPlaceHolder" runat="server">
                    <span id="editWikiNotLatest">
                        <asp:Literal ID="Literal1" runat="server" meta:resourceKey="NotLatestVersion" />
                    </span>
                </asp:PlaceHolder>
                <asp:TextBox ID="Source" TextMode="MultiLine" CssClass="form-control" runat="server" />
                <asp:Button ID="SaveButton" Text="<%$ Resources:SharedResources, Save %>" OnClick="SaveWikiContent" CssClass="btn btn-success" runat="server" />
                <input id="cancelEdit" type="button" class="btn btn-default" value="Cancel" />
            </fieldset>

        </div>
    </div>

    <script type="text/javascript">
        var timeout = null;
        $(function() {
            var dlg = $('#<%= editWikiForm.ClientID %>');
            var cnt = $('#editWikiContent');
            var pos = $(cnt).offset();

            dlg.dialog({ autoOpen: false,
                width: 450,
                position: [pos.left - 360, pos.top + 35],
                show: 'blind',
                beforeclose: function() { $('#originalWikiContent').show(); $('#previewWikiContent').hide(); }
            });
            dlg.parent().appendTo($("form:first"));
            cnt.click(function() {
                if (!dlg.dialog('isOpen')) {
                    $.ajax({
                        type: 'POST',
                        contentType: 'application/json; charset=utf-8',
                        url: '<%=ResolveUrl("~/WebServices/BugNetServices.asmx/GetWikiSource")%>',
                    data: "{id: '<asp:Literal id="sourceId" runat="server" />', slug: '<asp:Literal id="sourceSlug" runat="server" />', version: '<asp:Literal id="sourceVersion" runat="server" />'}",
                    dataType: 'json',
                success: function(data) {
                    $('#<%= Source.ClientID %>').val(data.d);
                    var original = $('#originalWikiContent');
                    original.hide();
                    $('#previewWikiContent').html(original.html()).show();
                    dlg.dialog('open');
                }
                });
        } else {
                dlg.dialog('close');
        }
        });

        $('#<%= Source.ClientID %>').keyup(function(e) {
            if (timeout != null) {
                clearTimeout(timeout);
                timeout = null;
            }

            var self = $(this);
            timeout = setTimeout(function() {
                $.ajax({
                    type: 'POST',
                    contentType: 'application/json; charset=utf-8',
                    url: '<%=ResolveUrl("~/WebServices/BugNetServices.asmx/GetWikiPreview")%>',
                    data: "{projectId:'<asp:Literal id="projectId" runat="server" />', id: '<asp:Literal id="previewId" runat="server" />', slug: '<asp:Literal id="previewSlug" runat="server" />', source: '" + self.val()  + "'}",
                    dataType: 'json',
                success: function(data) { $('#previewWikiContent').html(data.d); }
            });
            }, 250);
        });

        $('#cancelEdit').click(function() {
            $('#<%= editWikiForm.ClientID %>').dialog('close');
        });
        });
    </script>
</asp:Content>
