<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Edit.aspx.cs" Inherits="BugNET.Wiki.Edit" MasterPageFile="~\Site.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div id="wikiContainer">
        <h2>
            <asp:Literal ID="Literal1" runat="server" /></h2>
        <asp:ValidationSummary ID="ValidationSummary1" runat="server" DisplayMode="BulletList"
            HeaderText="<%$ Resources:SharedResources, ValidationSummaryHeaderText %>" CssClass="validationSummary" />
        <div class="form-horizontal">
            <div class="row">
                <div class="col-md-12">
                    <div class="form-group">
                        <asp:Label AssociatedControlID="Name" CssClass="control-label col-sm-2" ID="NameLabel" runat="server" meta:resourceKey="NameLabel" />
                        <div class="col-sm-10">
                            <asp:TextBox ID="Name" CssClass="form-control" runat="server" />
                            <asp:RequiredFieldValidator Text="<%$ Resources:SharedResources, Required %>" CssClass="req"
                                SetFocusOnError="True" ErrorMessage="Title is required" meta:resourcekey="TitleRequiredFieldValidator"
                                ControlToValidate="Name" runat="server" ID="TitleRequiredFieldValidator" />
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <div class="form-group">
                        <asp:Label AssociatedControlID="Source" CssClass="control-label col-sm-2" ID="Label1" runat="server" meta:resourceKey="SourceLabel" />
                        <div class="col-sm-10">
                            <asp:TextBox ID="Source" Height="300px" CssClass="form-control" TextMode="MultiLine" runat="server" />
                            <asp:RequiredFieldValidator Text="<%$ Resources:SharedResources, Required %>" CssClass="req"
                                SetFocusOnError="True" ErrorMessage="Source is required" meta:resourcekey="SourceRequiredFieldValidator"
                                ControlToValidate="Source" runat="server" ID="RequiredFieldValidator1" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                        <asp:Button ID="Save" Text="<%$ Resources:SharedResources, Save %>" CssClass="btn btn-primary" OnClick="SaveSource" runat="server" />
                        <asp:PlaceHolder ID="CancelPlaceHolder" Visible="false" runat="server">
                            <asp:Button ID="Cancel" UseSubmitBehavior="false" CssClass="btn btn-default" Text="<%$ Resources:SharedResources, Cancel %>" runat="server" />
                        </asp:PlaceHolder>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
