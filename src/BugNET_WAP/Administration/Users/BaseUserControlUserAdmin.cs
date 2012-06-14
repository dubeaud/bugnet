using System;
using System.Web.Security;
using BugNET.BLL;

namespace BugNET.Administration.Users
{
    public abstract class BaseUserControlUserAdmin : System.Web.UI.UserControl
    {
        protected MembershipUser MembershipData { get; set; }

        protected void GetMembershipData(Guid userId)
        {
            MembershipData = UserManager.GetUser(userId);
        }
    }
}