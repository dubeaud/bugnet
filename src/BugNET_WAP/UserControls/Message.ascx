<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Message.ascx.cs" Inherits="BugNET.UserControls.Message" %>
<%--<script type="text/javascript">
    $(document).ready(function () {
        
        <%if(!ShowStatic) { %>
            setTimeout(function () {
                $("#<%= MessageContainer.ClientID %>").fadeOut("slow", function () {
                    $("#<%= MessageContainer.ClientID %>").remove();
                });
            }, 4000);        
        <% } %>
        
        $('.closeImage').click(function () {
            $(this).parent().hide();
        });
    });
</script>--%>
<asp:Panel ID="MessageContainer" runat="server">
    <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
    <asp:Label ID="lblMessage" EnableViewState="false" runat="server" />
</asp:Panel>
