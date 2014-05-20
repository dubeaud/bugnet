<%@ Control Language="c#" Inherits="BugNET.Administration.Projects.UserControls.ProjectCategories" CodeBehind="ProjectCategories.ascx.cs"
    AutoEventWireup="True" %>
<%@ Register TagPrefix="it" TagName="PickCategory" Src="~/UserControls/PickCategory.ascx" %>
<asp:ScriptManagerProxy ID="ScriptManagerProxy1" runat="server">
    <Scripts>
        <asp:ScriptReference Path="~/Scripts/jquery.jstree.js" />
        <asp:ScriptReference Path="~/Scripts/jquery.cookie.js" />
    </Scripts>
</asp:ScriptManagerProxy>

<script type="text/javascript">
    
    $(document).ready(function(){
        
        var projectId = { 'projectId': '<%=ProjectId%>' };
        var jsTree = $("#divJsTree");
        
        if(jsTree) {
            jsTree
                .bind("dblclick.jstree", function (e, data) { 
                    
                    $("#divJsTree").jstree("rename");
                    
                }).bind("move_node.jstree",function (e, data) {
                        
                    //listkeys(data.rslt); 
                    if(data.rslt.np != undefined && data.rslt.o != undefined)
                    {
                        var currentNodeId = data.rslt.o.attr('id');
                    
                        var newParentNodeId = data.rslt.np.attr('id') == 'divJsTree' ? 0 : data.rslt.np.attr('id');
                   
                        window.BugNET.Webservices.BugNetServices.MoveCategory(currentNodeId,0,newParentNodeId, SucceededCallback, OnError);
                    }
                }).bind("rename_node.jstree",function (e, data) {
                        
                    //listkeys(data.rslt.obj);
                    var currentNodeId = data.rslt.obj.attr('id');
                    
                    // seems the rename node event gets called when we create a new node as well this to stop
                    if(currentNodeId == undefined) return;
                    
                    var name = data.rslt.name;
                    window.BugNET.Webservices.BugNetServices.RenameCategory(currentNodeId,name, SucceededCallback, OnError);
                        
                }).bind("reselect.jstree", function (event, data) {
                        
                    jsTree.jstree("open_all");
                        
                }).bind("create.jstree", function (e, data) {
                        
                    //listkeys(data.rslt);
                    var pid = <%= ProjectId %>;
                    var node = data.rslt;              
                    var name = node.name;
                    var parentNode = data.inst._get_parent(data.rslt.obj);
			    
                    if (parentNode) {
                    
                        var parentNodeId = parentNode == -1 ? 0 : parentNode.attr("id");
			        
                        //add the new node
                        window.BugNET.Webservices.BugNetServices.AddCategory(pid, name ,parentNodeId, function(result){
                            data.rslt.obj.attr("id", result); //set the new id to the new node
                        }, OnError);   
                    }
                        
                }).bind("select_node.jstree", function (e, data) {
                    
                    $('#HiddenField1').val(data.rslt.obj.attr('id'));
                    //alert(data.rslt.obj.attr('id')); 
                    //alert($('#HiddenField1').val());
                    
                }).jstree({
                    "plugins": ["themes", "json_data", "dnd", "crrm", "ui"],
                    "json_data": {
                        "ajax": {
                            "type": "POST",
                            "data": JSON.stringify(projectId),
                            "contentType": "application/json; charset=utf-8",
                            "dataType": "json",
                            "url": '<%=ResolveUrl("~/WebServices/BugNetServices.asmx/GetCategories")%>',
                        "success": function (retval) {
                            if (retval.hasOwnProperty('d')) {
                                return (eval(retval.d));
                            }
                            return retval;
                        }
                    }
                }
            });
        }
        
        $('[data-selector="AddCategory"]').each(function() {
            $(this).click(function() {
                $("#divJsTree").jstree("create");
            });   
        });

        $('[data-selector="DeleteCategory"]').each(function() {
            $(this).click(function () {
            
                var node = $("#divJsTree").jstree('get_selected');
                if(node.find("> ul > li").length > 0)
                {
                    return alert('<asp:Literal runat="server" Text="<%$ Resources:DeleteCategoriesMessage%>" />');
                }

                $('#deleteCategoryModal').modal().show();
                return false;
            });
        });
    });

    // This is the callback function that
    // processes the Web Service return value.
    function SucceededCallback(result){
        return;
    }
    
    function OnError(result){
        alert("Error: " + result.get_message());
    }  
    
    function onOk(sender,e){
        try 
        {
            if(tree) {
                var selectedNode = tree.getSelectionModel().getSelectedNode();       
                document.getElementById('<%=HiddenField1.ClientID %>').value = selectedNode.id;            
            }
        } catch(e) { } 

        $("#divJsTree").jstree('refresh', -1);
    }
</script>

<div>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" DisplayMode="BulletList" HeaderText="<%$ Resources:SharedResources, ValidationSummaryHeaderText %>"
        CssClass="validationSummary" />
    <h2>
        <asp:Literal ID="CategoriesTitle" runat="Server" meta:resourcekey="CategoriesTitle" /></h2>
    <br />
    <asp:CustomValidator Display="dynamic" meta:resourcekey="CategoryValidator" runat="server" OnServerValidate="CategoryValidation_Validate"
        ID="ComponentValidation" />
    <p>
        <asp:Label ID="DescriptionLabel" runat="server" meta:resourcekey="DescriptionLabel" />
    </p>
    <bn:Message ID="Message1" runat="server" />
    <br />
    <img id="imgAddCategory" data-selector="AddCategory" alt="Add Category" src="~/images/plugin_add.gif" class="icon cursor-hand" runat="server" />
    <a href="#" id="linkAddCategory" data-selector="AddCategory">
        <asp:Literal ID="Literal2" runat="Server" meta:resourcekey="AddCategory" /></a>
    <img id="imgDeleteCategory" data-selector="DeleteCategory" alt="Delete Category" src="~/images/plugin_delete.gif" class="icon cursor-hand" runat="server" />
    <a href="#" id="linkDeleteCategory" data-selector="DeleteCategory">
        <asp:Literal ID="Literal1" runat="Server" meta:resourcekey="DeleteCategory" /></a>
    <br />
    <br />
    <div id="divJsTree">
    </div>
    <asp:HiddenField ID="HiddenField1" ClientIDMode="Static" runat="server" />
    <asp:LinkButton ID="lbDeleteCategory" runat="server" Text="nil" Style="display: none" />
</div>
<!-- Modal -->
<div class="modal fade" id="deleteCategoryModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">
                    <asp:Literal runat="server" meta:resourcekey="DeleteCategory" /></h4>
            </div>
            <div class="modal-body">
                <p>
                    <asp:Literal ID="SelectOption" runat="Server" meta:resourcekey="SelectOption" /></p>
                <div class="form-horizontal">
                    <div class="form-group">
                        <asp:RadioButton ID="RadioButton1" GroupName="DeleteCategory" CssClass="radio" runat="server" Checked="true" Height="30px" Text="&nbsp;&nbsp;Delete this category and all assigned issues." meta:resourcekey="DeleteCategoryRadioButton" />
                    </div>
                    <div class="form-group">
                        <asp:RadioButton ID="RadioButton2" GroupName="DeleteCategory" CssClass="radio" runat="server" Height="30px" Text="&nbsp;&nbsp;Assign all issues to an existing category." meta:resourcekey="DeleteCategoryRadioButton1" />
                        <div class="col-sm-offset-1">
                            <it:PickCategory ID="DropCategory" DisplayDefault="true" Required="false" runat="Server" />
                        </div>

                    </div>
                    <div class="form-group">
                        <asp:RadioButton ID="RadioButton3" GroupName="DeleteCategory" CssClass="radio" runat="server" Height="30px" Text="&nbsp;&nbsp;Assign all issues to a new category." meta:resourcekey="DeleteCategoryRadioButton2" />
                        <div class="col-sm-offset-1">
                            <asp:TextBox ID="NewCategoryTextBox" CssClass="form-control" runat="server" placeholder="Enter a new category"></asp:TextBox>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <asp:Button ID="CancelButton" runat="server" Text="Cancel" CssClass="btn btn-default" data-dismiss="modal" meta:resourcekey="CancelButton" />
                <asp:Button ID="OkButton" runat="server" OnClick="OkButton_Click" OnClientClick="onOk();" CssClass="btn btn-primary" Text="Save changes" meta:resourcekey="OkButton" />
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!-- /.modal -->

<ajaxToolkit:TextBoxWatermarkExtender ID="TBWE2" runat="server" TargetControlID="NewCategoryTextBox" WatermarkText="Enter a new category"
    meta:resourcekey="NewCategoryWatermark" WatermarkCssClass="watermarked" />
