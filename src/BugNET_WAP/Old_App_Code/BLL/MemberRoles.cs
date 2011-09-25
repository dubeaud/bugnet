using System;
using System.Collections;

namespace BugNET.BusinessLogicLayer
{
    public class MemberRoles
    {
        private string _Member;
        private  ArrayList _Roles;

        public MemberRoles(string member, string role)
        {
            _Member = member;
            _Roles = new ArrayList();
            _Roles.Add(role);
            _Roles.TrimToSize();
        }

        public void AddRole(string role) 
        {
            if (!_Roles.Contains(role))
            {
                _Roles.Add(role);
            }
        }

        public bool HasRole(string role)
        {
            return _Roles.Contains(role);
        }

        public string Username
        {
            get {return _Member;}
        }

        public string RoleString
        {
            get
            {
                string tmpstr= "";
                foreach (string rs in _Roles)
                {
                    tmpstr += rs + ", ";
                }
                return tmpstr.Remove(tmpstr.Length - 2, 2);
            }
        }

        public IList Roles
        {
            get { return _Roles; }
        }
    }
}
