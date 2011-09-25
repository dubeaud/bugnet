<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="DeleteUser.ascx.cs" Inherits="BugNET.Administration.Users.UserControls.DeleteUser" %>
<asp:Label ID="lblError" runat="server"  ForeColor="Red" />
<div class="fieldgroup">
    <h3>Delete User</h3>
    <p class="desc"  align="left">It is higly recommended that you unauthorize the users account instead of deleting to maintain 
        the integrity of the BugNET database.
    </p>
    <br />
    <p class="desc" align="left">
        Unauthorizing the account will keep the user information intact but will not allow the user to log into the application. You can re-authorize the account
        at anytime if necessary from the user details page.
    </p>
   
</div>
<p align="center" style="margin-top:15px;">
    <asp:ImageButton runat="server" id="Image4" OnClick="cmdUnauthorizeAccount_Click" CssClass="icon" ImageUrl="~/Images/key_delete.gif" />
    <asp:LinkButton ID="cmdUnauthorizeAccount" OnClick="cmdUnauthorizeAccount_Click" runat="server" Text="Unauthorize this Account" />
    &nbsp;
    <asp:ImageButton runat="server" id="Image6" OnClientClick="return confirm('Are you sure?')" OnClick="cmdDeleteUser_Click" CssClass="icon" ImageUrl="~/Images/user_delete.gif" />
    <asp:LinkButton ID="cmdDeleteUser" OnClientClick="return confirm('Are you sure?')" OnClick="cmdDeleteUser_Click" runat="server" Text="Delete this User" />
</p>