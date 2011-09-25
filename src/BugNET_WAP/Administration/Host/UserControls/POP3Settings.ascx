<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="POP3Settings.ascx.cs" Inherits="BugNET.Administration.Host.UserControls.POP3Settings" %>
<h2><asp:literal ID="Title" runat="Server" Text="<%$ Resources:POP3Settings %>"  /></h2>
 <div class="fieldgroup noborder">
    <ol>
        <li>
            <asp:Label ID="label13" runat="server" AssociatedControlID="POP3ReaderEnabled"  Text="<%$ Resources:Enable %>" />
            <asp:checkbox id="POP3ReaderEnabled" runat="server"></asp:checkbox>
        </li> 
         <li>
            <asp:Label ID="label14" runat="server" AssociatedControlID="POP3Server" Text="<%$ Resources:Server %>" />
            <asp:TextBox id="POP3Server" Runat="Server" />
         </li>
         <li>
            <asp:Label ID="label1" runat="server" AssociatedControlID="POP3Port" Text="<%$ Resources:Port %>" />
            <asp:TextBox id="POP3Port" Width="45px" Runat="Server" />
        </li>
         <li>
            <asp:Label ID="label15" runat="server" AssociatedControlID="POP3Username" Text="<%$ Resources:SharedResources, Username %>" />
            <asp:TextBox id="POP3Username" Runat="Server" />
        </li>
         <li>
            <asp:Label ID="label16" runat="server" AssociatedControlID="POP3Password" Text="<%$ Resources:SharedResources, Password %>" />
            <asp:TextBox id="POP3Password" TextMode="Password"  Runat="Server" />
        </li>
        <li>
            <asp:Label ID="label29" runat="server" AssociatedControlID="POP3UseSSL" CssClass="col1b" Text="<%$ Resources:SSL %>" />
            <td class="input-group"><asp:CheckBox ID="POP3UseSSL" runat="server" />
        </li>
        <li>
            <asp:Label ID="label17" runat="server" AssociatedControlID="POP3Interval" Text="<%$ Resources:PollingInterval %>" />
            <asp:TextBox id="POP3Interval" Runat="Server" Width="50px" />
        </li>
         <li>
            <asp:Label ID="label18" runat="server" AssociatedControlID="POP3DeleteMessages" Text="<%$ Resources:DeleteProcessedMessages %>" />
            <td class="input-group"><asp:checkbox id="POP3DeleteMessages" runat="server"></asp:checkbox>
        </li>
         <li>
            <asp:Label ID="label19" runat="server" AssociatedControlID="POP3ProcessAttachments" Text="Process Attachments" />
            <td class="input-group"><asp:checkbox id="POP3ProcessAttachments" runat="server"></asp:checkbox>
        </li>
         <li>
            <td valign="top"><asp:Label ID="label20" runat="server" AssociatedControlID="POP3BodyTemplate" Text="<%$ Resources:BodyTemplate %>" />
            <asp:TextBox id="POP3BodyTemplate" Runat="Server" TextMode="MultiLine" Height="100px" Width="250px"/>
        </li>
         <li>
            <asp:Label ID="label21" runat="server" AssociatedControlID="POP3ReportingUsername" Text="<%$ Resources:ReportingUsername %>" />
            <asp:TextBox id="POP3ReportingUsername" Runat="Server" />
        </li>
    </ol>
</div>
