<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserProfile.aspx.cs" MasterPageFile="~/Site.master"
    Title="User Profile" Inherits="BugNET.Account.UserProfile" meta:resourcekey="Page" %>

<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="MainContent">
    <div class="page-header">
        <h1>
            <asp:Literal ID="litUserProfile" runat="server" />
            <small>
                <asp:Literal ID="litUserName" runat="Server" />
            </small>
        </h1>
    </div>
    <div class="row">
        <div class="col-md-3">
            <asp:BulletedList ID="BulletedList4" DisplayMode="LinkButton" CssClass="nav nav-pills nav-stacked"
                runat="server" OnClick="BulletedList4_Click1">
                <asp:ListItem meta:resourceKey="UserDetails">User Details</asp:ListItem>
                <asp:ListItem meta:resourceKey="Preferences">Preferences</asp:ListItem>
                <asp:ListItem meta:resourceKey="Notifications">Notifications</asp:ListItem>
            </asp:BulletedList>
        </div>
        <div class="col-md-9">
            <asp:MultiView ID="ProfileView" ActiveViewIndex="0" runat="server">
                <asp:View ID="UserDetails" runat="server">
                    <bn:Message ID="Message1" runat="server" Width="650px" Visible="False" />


                    <div class="form-horizontal">
                        <h2>
                            <asp:Literal ID="Literal3" runat="server" Text="[Resource Needed]" meta:resourceKey="UserDetails" /></h2>
                        <div class="form-group">

                            <asp:Label ID="Label2" CssClass="control-label col-md-2" AssociatedControlID="UserName" runat="server" Text="<%$ Resources:SharedResources, Username %>" />
                            <div class="col-md-6">
                                <asp:TextBox ID="UserName" CssClass="form-control" ReadOnly="True" Enabled="false" runat="server" />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" Display="Dynamic"
                                    Text="<%$ Resources:SharedResources, Required %>" ControlToValidate="UserName" />
                            </div>
                        </div>

                        <div class="form-group">
                            <asp:Label ID="Label1" CssClass="control-label col-md-2" AssociatedControlID="FirstName" runat="server" Text="<%$ Resources:SharedResources, FirstName %>" />
                            <div class="col-md-6">
                                <asp:TextBox CssClass="form-control" ID="FirstName" runat="server" />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" Display="Dynamic"
                                    Text="<%$ Resources:SharedResources, Required %>" ControlToValidate="FirstName" />
                            </div>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="Label3" CssClass="control-label col-md-2" AssociatedControlID="LastName" runat="server" Text="<%$ Resources:SharedResources, LastName %>" />
                            <div class="col-md-6">
                                <asp:TextBox ID="LastName" CssClass="form-control" runat="server" />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" Display="Dynamic"
                                    Text="<%$ Resources:SharedResources, Required %>" ControlToValidate="LastName"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="Label5" CssClass="control-label col-md-2" AssociatedControlID="FullName" runat="server" Text="<%$ Resources:SharedResources, DisplayName %>" />
                            <div class="col-md-6">
                                <asp:TextBox ID="FullName" CssClass="form-control" runat="server" />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" Display="Dynamic"
                                    Text="<%$ Resources:SharedResources, Required %>" ControlToValidate="FullName"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="Label4" CssClass="control-label col-md-2" AssociatedControlID="Email" runat="server" Text="<%$ Resources:SharedResources, Email %>" />
                            <div class="col-md-6">
                                <asp:TextBox ID="Email" CssClass="form-control" runat="server" />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" Display="Dynamic"
                                    Text="<%$ Resources:SharedResources, Required %>" ControlToValidate="Email" />
                                <asp:RegularExpressionValidator ID="regexEmailValid" runat="server" ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                    ControlToValidate="Email" ErrorMessage="Invalid Email Format" Text="Invalid Email Format" />
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-md-offset-2 col-md-4">
                                <asp:LinkButton ID="SaveButton" runat="server" CssClass="btn btn-primary" OnClick="SaveButton_Click"
                                    Text="<%$ Resources:SharedResources, Save %>" />
                                <asp:LinkButton ID="BackButton" runat="server" CssClass="btn btn-default" CausesValidation="false"
                                    OnClick="BackButton_Click" Text="<%$ Resources:SharedResources, Return %>" />
                            </div>
                        </div>
                    </div>
                </asp:View>
                <asp:View ID="Customize" runat="server">
                    <bn:Message ID="Message3" runat="server" Width="650px" Visible="False" />
                    <h2>
                        <asp:Literal ID="Literal2" runat="server" Text="[Resource Needed]" meta:resourceKey="Preferences" /></h2>
                    <div class="form-horizontal">
                        <div class="form-group">
                            <asp:Label ID="Label8" CssClass="control-label col-md-2" AssociatedControlID="IssueListItems" runat="server" Text="Issue Page Size:"
                                meta:resourcekey="lblItemPageSize" />
                            <div class="col-md-6">
                                <asp:DropDownList ID="IssueListItems" CssClass="form-control" runat="server">
                                    <asp:ListItem Text="5" Value="5" />
                                    <asp:ListItem Text="10" Value="10" />
                                    <asp:ListItem Text="15" Value="15" />
                                    <asp:ListItem Text="25" Value="25" />
                                    <asp:ListItem Text="50" Value="50" />
                                    <asp:ListItem Text="75" Value="75" />
                                    <asp:ListItem Text="100" Value="100" />
                                    <asp:ListItem Text="250" Value="250" />
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="Label6" CssClass="col-md-2" AssociatedControlID="ddlPreferredLocale" runat="server" Text="Preferred Locale:" meta:resourcekey="PreferredLocale" />
                            <div class="col-md-6">
                                <asp:DropDownList CssClass="form-control" ID="ddlPreferredLocale" DataTextField="Text" DataValueField="Value"
                                    runat="server">
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-md-4 col-md-offset-2">
                                <asp:LinkButton ID="SaveCustomSettings" CssClass="btn btn-primary" OnClick="SaveCustomSettings_Click" runat="server"
                                    Text="<%$ Resources:SharedResources, Save %>" />
                                <asp:LinkButton ID="Linkbutton1" runat="server" CssClass="btn btn-default" OnClick="BackButton_Click"
                                    Text="<%$ Resources:SharedResources, Return %>" />
                            </div>
                        </div>
                    </div>
                </asp:View>
                <asp:View ID="Notifications" runat="server">
                    <bn:Message ID="Message4" runat="server" Width="650px" Visible="False" />
                    <h2>
                        <asp:Literal ID="Label13" runat="server" meta:resourcekey="Notifications" Text="[Resource Needed]" /></h2>
                    <div class="form-horizontal">
                        <div class="form-group">
                            <asp:Label CssClass="control-label col-md-2" runat="server" Text="[Resource Needed]" meta:resourceKey="AllowNotifications" AssociatedControlID="AllowNotifications" />
                            <div class="col-md-6">
                                <div class="checkbox">
                                    <asp:CheckBox ID="AllowNotifications" runat="server" Text="" />
                                </div>
                            </div>
                        </div>

                        <asp:Literal ID="Literal4" runat="server" Text="[Resource Needed]" meta:resourceKey="ReceiveProjectNotifications" />
                        <br />
                        <br />
                        <div class="row">
                            <div class="col-md-5">
                                <strong><asp:Literal ID="Literal5" runat="server" Text="[Resource Needed]" meta:resourceKey="AllProjects" /></strong>
                                <asp:ListBox ID="lstAllProjects" SelectionMode="Multiple" runat="Server" CssClass="form-control"
                                    Height="150px" />
                            </div>

                            <div class="col-md-2 text-center" style="padding-top: 50px;">
                                <asp:Button Text="->" CssClass="btn btn-primary" runat="server"
                                    ID="Button1" OnClick="AddProjectNotification" />
                                <br />
                                <asp:Button Text="<-" CssClass="btn btn-primary"
                                    runat="server" ID="Button2" OnClick="RemoveProjectNotification" />
                            </div>

                            <div class="col-md-5">
                               <strong><asp:Literal ID="Literal6" runat="server" Text="[Resource Needed]" meta:resourceKey="SelectedProjects" /></strong>
                                <asp:ListBox ID="lstSelectedProjects" SelectionMode="Multiple" runat="Server" CssClass="form-control"
                                    Height="150px" />
                           </div>
                        </div>
                        <div class="form-group">
                            <div class="col-md-6">
                                <asp:LinkButton CssClass="btn btn-primary" ID="LinkButton2" OnClick="SaveCustomSettings_Click" runat="server"
                                    Text="<%$ Resources:SharedResources, Save %>" />
                                <asp:LinkButton ID="Linkbutton6" runat="server" CssClass="btn btn-default" OnClick="BackButton_Click"
                                    Text="<%$ Resources:SharedResources, Return %>" />
                            </div>
                        </div>
                    </div>
                </asp:View>
            </asp:MultiView>
        </div>
    </div>
</asp:Content>

