<%@ Page Language="c#" Inherits="BugNET._Default" Title="Home" MasterPageFile="~/Site.master"
    CodeBehind="Default.aspx.cs" meta:resourcekey="Page" %>

<%@ Import Namespace="BugNET.Entities" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="col-md-12">
        <div class="row">
            <div class="col-sm-3">
                <h3>
                    <asp:Label ID="lblApplicationTitle" runat="server">BugNET Issue Tracker</asp:Label></h3>
                <p>
                    <asp:Label ID="WelcomeMessage" runat="Server"></asp:Label>
                </p>
            </div>
            <div class="col-sm-9">
                <!-- projects -->
                <div class="jumbotron" id="BlankSlate" runat="server" visible="false">
                    <h1>Welcome to BugNET!</h1>
                    <p>There are no projects configured for BugNET. We suggest the following to get started:</p>
                    <ol>
                        <li>Create a <a href="~/Administration/Projects/AddProject.aspx" runat="server">new project</a></li>
                        <li>Configure your <a href="~/Administration/Host/Settings.aspx" runat="server">authentication settings</a></li>
                        <li>Configure your <a href="~/Administration/Host/Settings.aspx" runat="server">email settings</a></li>
                    </ol>
                    <p><a class="btn btn-primary btn-lg" href="https://bugnet.codeplex.com/documentation" role="button">Learn more</a></p>
                </div>
                <br>
                <div class="alert alert-info" id="UserMessage" runat="server" visible="False">
                    <asp:Label ID="lblMessage" runat="server"></asp:Label>
                </div>
                <asp:Repeater ID="rptProject" runat="Server">
                    <ItemTemplate>
                        <div class="row">
                            <div class="col-md-2 col-sm-3 text-center">
                                <a href="Projects/ProjectSummary.aspx?pid=<%# ((Project)Container.DataItem).Id %>">
                                    <asp:Image runat="server" AlternateText="<%# ((Project)Container.DataItem).Name %>" ID="ProjectImage" />
                                </a>
                            </div>
                            <div class="col-md-10 col-sm-9">
                                <h3 style="margin-top: 5px; margin-bottom: 3px;">
                                    <a href="Projects/ProjectSummary.aspx?pid=<%# ((Project)Container.DataItem).Id %>">
                                        <%#((Project)Container.DataItem).Name%>
                                        <span>(<%#((Project)Container.DataItem).Code%>)</span>
                                    </a>

                                    <ul id="multicol-menu" class="nav pull-right">
                                        <li class="dropdown">
                                            <button class="btn dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown">
                                                <span class="glyphicon glyphicon-list"></span>
                                                <%--<asp:Localize runat="server" ID="Filters" Text="Quick Links / Filters" meta:resourcekey="QuickLinksFilters" />--%>
                                                <span class="caret"></span>
                                            </button>
                                            <ul class="dropdown-menu dropdown-menu-right">
                                                <li>
                                                    <div class="row" style="width: 350px; padding: 10px;">
                                                        <ul class="list-unstyled col-md-6">
                                                            <li role="presentation" class="dropdown-header">
                                                               <asp:Localize runat="server" ID="QuickLinksLocalize" Text="Quick Links" meta:resourcekey="QuickLinks" />
                                                            </li>
                                                            <li>
                                                                <a href="Projects/ProjectSummary.aspx?pid=<%# ((Project)Container.DataItem).Id %>">
                                                                    <asp:Localize runat="server" ID="Localize33" Text="Project Summary" meta:resourcekey="ProjectSummary" /></a></li>
                                                            <li>
                                                                <a href="Queries/QueryList.aspx?pid=<%# ((Project)Container.DataItem).Id %>">
                                                                    <asp:Localize runat="server" ID="Localize4" Text="<%$ Resources:SharedResources, Queries %>" /></a>
                                                            </li>
                                                            <li>
                                                                <a href="Projects/ChangeLog.aspx?pid=<%# ((Project)Container.DataItem).Id %>">
                                                                    <asp:Localize runat="server" ID="Localize5" Text="<%$ Resources:SharedResources, ChangeLog %>" /></a></li>
                                                            <li>
                                                                <a href="Projects/Roadmap.aspx?pid=<%# ((Project)Container.DataItem).Id %>">
                                                                    <asp:Localize runat="server" ID="Localize6" Text="<%$ Resources:SharedResources, Roadmap %>" /></a></li>
                                                            <li id="ProjectCalendar" runat="server">
                                                                <a href="Projects/ProjectCalendar.aspx?pid=<%# ((Project)Container.DataItem).Id %>">
                                                                    <asp:Localize runat="server" ID="Localize7" Text="<%$ Resources:SharedResources, Calendar %>" /></a></li>
                                                            <li id="ReportIssue" runat="server">
                                                                <a href="Issues/CreateIssue.aspx?pid=<%# ((Project)Container.DataItem).Id %>">
                                                                    <asp:Localize runat="server" ID="Localize8" Text="<%$ Resources:SharedResources, NewIssue %>" /></a></li>
                                                            <li id="Settings" runat="server">
                                                                <a href="Administration/Projects/EditProject.aspx?pid=<%# ((Project)Container.DataItem).Id %>&amp;tid=1">
                                                                    <asp:Localize runat="server" ID="Localize9" Text="<%$ Resources:SharedResources, EditProject %>" /></a></li>
                                                        </ul>
                                                        <ul class="list-unstyled col-md-6">
                                                            <li role="presentation" class="dropdown-header">
                                                              <asp:Localize runat="server" ID="FiltersLocalize" Text="Filters" meta:resourceKey="Filters" />
                                                            </li>
                                                            <li><a href='Issues/IssueList.aspx?pid=<%# ((Project)Container.DataItem).Id %>'>
                                                                <asp:Label ID="Label1" runat="server" Text="All" meta:resourcekey="lblAll" /></a></li>
                                                            <li><a href="Issues/IssueList.aspx?pid=<%# ((Project)Container.DataItem).Id %>&amp;cr=1">
                                                                <asp:Localize runat="server" ID="Localize10" Text="Created Recently" meta:resourcekey="CreatedRecently" /></a></li>
                                                            <li><a href="Issues/IssueList.aspx?pid=<%# ((Project)Container.DataItem).Id %>&amp;ur=1">
                                                                <asp:Localize runat="server" ID="Localize11" Text="Updated Recently" meta:resourcekey="UpdatedRecently" /></a></li>
                                                            <li id="AssignedUserFilter" runat="server">
                                                                <asp:HyperLink ID="AssignedToUser" runat="server" meta:resourcekey="AssignedToUser">Assigned to me</asp:HyperLink></li>
                                                        </ul>
                                                    </div>
                                                </li>
                                            </ul>
                                        </li>
                                    </ul>
                                </h3>
                                <small style="color: #999999;">
                                    <asp:Localize runat="server" ID="Localize2" Text="Managed By" meta:resourcekey="ManagedBy" />
                                    <%#((Project)Container.DataItem).ManagerDisplayName%>
                                </small>
                                <p>
                                    <%#Server.HtmlDecode(((Project)Container.DataItem).Description)%>
                                </p>
                                <p style="color: #999999;">
                                    <small>
                                        <asp:Label ID="OpenIssues" runat="Server" />
                                        |
                                        <asp:Label ID="NextMilestoneDue" runat="Server" />
                                        |
                                        <asp:Label ID="MilestoneComplete" CssClass="progressBar" runat="Server" />
                                    </small>
                                </p>
                            </div>
                        </div>
                        <hr>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    </div>
</asp:Content>
