<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Message.ascx.cs" Inherits="BugNET.UserControls.Message" %>
<script type="text/javascript">
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
</script>
<asp:Panel ID="MessageContainer" runat="server">
    <asp:Image ID="CloseImage" CssClass="closeImage icon" runat="server" ImageUrl="~/images/close.png" />
    <asp:Label ID="lblMessage" EnableViewState="false" runat="server" />
</asp:Panel>
