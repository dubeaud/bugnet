<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="TimeTracking.ascx.cs" Inherits="BugNET.Issues.UserControls.TimeTracking" %>

<asp:Label ID="TimeEntryLabel" Font-Italic="true" runat="server"></asp:Label>
<asp:DataGrid ID="TimeEntriesDataGrid" runat="server" CssClass="table table-striped" AutoGenerateColumns="false" UseAccessibleHeader="true"
    GridLines="None"
    OnItemCommand="TimeEntriesDataGrid_ItemCommand"
    OnItemDataBound="TimeEntriesDataGridItemDataBound"
    ShowFooter="True">
    <Columns>
        <asp:BoundColumn DataField="WorkDate" HeaderText="Date" DataFormatString="{0:d}"></asp:BoundColumn>
        <asp:BoundColumn DataField="Duration" HeaderText="Hours" DataFormatString="{0:0.00}"></asp:BoundColumn>
        <asp:BoundColumn DataField="CreatorDisplayName" HeaderText="User"></asp:BoundColumn>
        <asp:BoundColumn DataField="CommentText" HeaderText="Comment"></asp:BoundColumn>
        <asp:TemplateColumn>
            <ItemStyle Width="16px" />
            <ItemTemplate>
                <asp:ImageButton ToolTip="<%$ Resources:SharedResources, Remove %>" AlternateText="<%$ Resources:SharedResources, Remove %>" CssClass="icon" ID="cmdDelete" ImageUrl="~/images/cross.gif"
                    BorderWidth="0px" CommandName="Delete" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "Id") %>' runat="server" />
            </ItemTemplate>
        </asp:TemplateColumn>
    </Columns>
</asp:DataGrid>

<asp:Panel ID="AddTimeEntryPanel" CssClass="form-horizontal" runat="server">
    <h3>
        <asp:Literal ID="Literal1" runat="server" meta:resourcekey="AddTimeEntry" /></h3>
    <div class="form-group">
        <asp:Label runat="server" CssClass="col-md-2 control-label" AssociatedControlID="TimeEntryDate:DateTextBox" ID="Label3" meta:resourcekey="DateLabel" Text="Date:"></asp:Label>
        <div class="col-md-10">
            <bn:PickDate ID="TimeEntryDate" runat="server" />
            <asp:RequiredFieldValidator SetFocusOnError="True" ID="RequiredFieldValidator5" Display="Dynamic" ControlToValidate="TimeEntryDate:DateTextBox" ValidationGroup="AddTimeEntry" runat="server" ErrorMessage=" *"></asp:RequiredFieldValidator>
            <asp:CompareValidator ID="cpTimeEntry" runat="server" ValidationGroup="AddTimeEntry" meta:resourcekey="cpTimeEntry"
                ControlToValidate="TimeEntryDate:DateTextBox" ErrorMessage="Date cannot be in the future."
                Display="dynamic" Type="Date" Operator="LessThanEqual"></asp:CompareValidator>
        </div>
    </div>
    <div class="form-group">
        <asp:Label runat="server" CssClass="col-md-2 control-label" meta:resourcekey="lblDuration" AssociatedControlID="DurationTextBox" ID="lblDuration" Text="Duration:" />
        <div class="col-md-10">

            <asp:TextBox ID="DurationTextBox" runat="server" CssClass="form-control" MaxLength="5"></asp:TextBox>&nbsp;<asp:Literal ID="hrsLiteral" runat="server" Text="hrs" meta:resourcekey="hrsLiteral" />
            <asp:RequiredFieldValidator SetFocusOnError="True" ID="RequiredFieldValidator4" ControlToValidate="DurationTextBox" ValidationGroup="AddTimeEntry" runat="server" ErrorMessage=" *" CssClass="text-danger"></asp:RequiredFieldValidator>
            <asp:RangeValidator ID="RangeValidator1" Display="Dynamic" runat="server" meta:resourcekey="RangeValidator1" ErrorMessage="Duration is out of range." Type="Double"
                MaximumValue="24" MinimumValue="0.01" CssClass="text-danger" ControlToValidate="DurationTextBox"></asp:RangeValidator>

        </div>
    </div>

    <div class="form-group">
        <label for="CommentHtmlEditor" class="col-md-2 control-label">
            <asp:Literal ID="Literal2" runat="server" meta:resourcekey="Comments" />
            <span style="font-size: 90%; color: #999999">
                <asp:Literal ID="CommentOptional" runat="server" meta:resourcekey="CommentOptional" /></span></label>
        <div class="col-md-10">
            <bn:HtmlEditor ID="CommentHtmlEditor" Height="200" runat="server" />
        </div>
    </div>

    <div class="form-group">
        <div class="col-md-offset-2 col-md-7">
            <asp:Button ID="AddTimeEntryButton" CssClass="btn btn-primary" runat="server" CausesValidation="true" ValidationGroup="AddTimeEntry" OnClick="AddTimeEntry_Click" meta:resourcekey="cmdAddTimeEntry" Text="Add Time Entry" />
        </div>
    </div>
</asp:Panel>
