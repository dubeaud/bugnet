using System;
using BugNET.BLL;
using BugNET.Models;

namespace BugNET.Administration.Users
{
    public abstract class BaseUserControlUserAdmin : System.Web.UI.UserControl
    {
        protected ApplicationUser MembershipData { get; set; }

        protected void GetMembershipData(Guid userId)
        {
            MembershipData = UserManager.GetUser(userId);
        }
    }
}