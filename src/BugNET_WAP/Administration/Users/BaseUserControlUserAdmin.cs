using System;
using System.Web.Security;
using BugNET.BLL;
using BugNET.Common;

namespace BugNET.Administration.Users
{
    public abstract class BaseUserControlUserAdmin : System.Web.UI.UserControl
    {
        public event ActionEventHandler Action;

        protected virtual void OnAction(ActionEventArgs args)
        {
            if (Action != null)
                Action(this, args);
        }

        protected MembershipUser MembershipData { get; set; }

        protected void BindUserData(Guid userId)
        {
            MembershipData = UserManager.GetUser(userId);
        }
    }
}