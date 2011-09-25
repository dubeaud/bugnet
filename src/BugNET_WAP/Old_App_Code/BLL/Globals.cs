using System;
using System.Configuration;
using log4net;
using System.Data.SqlTypes;

namespace BugNET.BusinessLogicLayer
{
	/// <summary>
	/// Global constants, enumerations and properties
	/// </summary>
	public class Globals
	{

		#region Public Constants
		    //Cookie Constants
		    public const string UserCookie = "BugNETUser";
            public const string IssueColumns = "issuecolumns";

            public const string ConfigFolder  = "\\Config\\";
            public const string UploadFolder = "\\Uploads\\";
            public const string UPLOAD_TOKEN = "UploadToken"; 
            
		    /// <summary>
		    /// Constant assigned to value for new bugs
		    /// </summary>
		    public const int NewBugAssignedTo = 0;
		    public const int NewIssueStatusId = 1;
		    public const int NewIssueResolutionId = 1;
            public const string SkipProjectIntro = "skipprojectintro";
		    public const string UnassignedDisplayText = "none";
		    public const int NewId = 0;
            public const int DefaultId = -1;

            public static string SuperUserRole = "Super Users";
            public static string[] DefaultRoles = {"Project Administrators", "Read Only", "Reporter", "Developer", "Quality Assurance" };
            public static string ProjectAdminRole = DefaultRoles[0];

            public static DateTime GetDateTimeMinValue()
            {
                DateTime MinValue = (DateTime)SqlDateTime.MinValue;
                MinValue.AddYears(1);
                return (MinValue);
            }

            /// <summary>
            /// Upgrade Status Enumeration
            /// </summary>
            public enum UpgradeStatus: int{
                Upgrade = 0,
                Install = 1,
                None = 2,
                Authenticated = 3,
                WindowsSAM =4,
                ActiveDirectory = 5
            }
        
            /// <summary>
            /// Default read only role permissions
            /// </summary>
            public static int[] ReadOnlyPermissions = { 
                (int)Permission.SUBSCRIBE_ISSUE,
                (int)Permission.VIEW_PROJECT_CALENDAR
            };

            /// <summary>
            /// Default reporter role permissions
            /// </summary>
            public static int[] ReporterPermissions = { 
                (int)Permission.ADD_ISSUE, 
                (int)Permission.ADD_COMMENT, 
                (int)Permission.OWNER_EDIT_COMMENT, 
                (int)Permission.SUBSCRIBE_ISSUE, 
                (int)Permission.ADD_ATTACHMENT, 
                (int)Permission.ADD_RELATED,
                (int)Permission.ADD_PARENT_ISSUE,
                (int)Permission.ADD_SUB_ISSUE,
                (int)Permission.VIEW_PROJECT_CALENDAR
            };

            /// <summary>
            /// Default developer role permissions
            /// </summary>
            public static int[] DeveloperPermissions = { 
                (int)Permission.ADD_ISSUE, 
                (int)Permission.ADD_COMMENT,
                (int)Permission.ADD_ATTACHMENT,
                (int)Permission.ADD_RELATED,
                (int)Permission.ADD_TIME_ENTRY,
                (int)Permission.ADD_PARENT_ISSUE,
                (int)Permission.ADD_SUB_ISSUE,
                (int)Permission.ADD_QUERY,
                (int)Permission.OWNER_EDIT_COMMENT, 
                (int)Permission.SUBSCRIBE_ISSUE,
                (int)Permission.EDIT_ISSUE,
                (int)Permission.ASSIGN_ISSUE,
                (int)Permission.CHANGE_ISSUE_STATUS,
                (int)Permission.VIEW_PROJECT_CALENDAR
            };

            /// <summary>
            /// Default QA role permissions
            /// </summary>
            public static int[] QualityAssurancePermissions = { 
                (int)Permission.ADD_ISSUE, 
                (int)Permission.ADD_COMMENT,
                (int)Permission.ADD_ATTACHMENT,
                (int)Permission.ADD_RELATED,
                (int)Permission.ADD_TIME_ENTRY,
                (int)Permission.ADD_PARENT_ISSUE,
                (int)Permission.ADD_SUB_ISSUE,
                (int)Permission.ADD_QUERY,
                (int)Permission.OWNER_EDIT_COMMENT, 
                (int)Permission.SUBSCRIBE_ISSUE,
                (int)Permission.EDIT_ISSUE,
                (int)Permission.EDIT_ISSUE_TITLE,
                (int)Permission.ASSIGN_ISSUE,
                (int)Permission.CLOSE_ISSUE,
                (int)Permission.DELETE_ISSUE,
                (int)Permission.CHANGE_ISSUE_STATUS,
                (int)Permission.VIEW_PROJECT_CALENDAR
            };

            /// <summary>
            /// Default project administrator role permissions
            /// </summary>
            public static int[] AdministratorPermissions = { 
                (int)Permission.ADD_ISSUE, 
                (int)Permission.ADD_COMMENT,
                (int)Permission.ADD_ATTACHMENT,
                (int)Permission.ADD_RELATED,
                (int)Permission.ADD_TIME_ENTRY,
                (int)Permission.ADD_PARENT_ISSUE,
                (int)Permission.ADD_SUB_ISSUE,
                (int)Permission.ADD_QUERY,
                (int)Permission.OWNER_EDIT_COMMENT, 
                (int)Permission.SUBSCRIBE_ISSUE,
                (int)Permission.EDIT_ISSUE,
                (int)Permission.EDIT_COMMENT,
                (int)Permission.EDIT_ISSUE_DESCRIPTION,
                (int)Permission.EDIT_ISSUE_TITLE,
                (int)Permission.DELETE_QUERY,
                (int)Permission.DELETE_ATTACHMENT,
                (int)Permission.DELETE_COMMENT,
                (int)Permission.DELETE_ISSUE,
                (int)Permission.DELETE_RELATED,
                (int)Permission.DELETE_TIME_ENTRY,
                (int)Permission.DELETE_QUERY,
                (int)Permission.DELETE_SUB_ISSUE,
                (int)Permission.DELETE_PARENT_ISSUE,
                (int)Permission.ASSIGN_ISSUE,
                (int)Permission.CLOSE_ISSUE,
                (int)Permission.ADMIN_EDIT_PROJECT,
                (int)Permission.CHANGE_ISSUE_STATUS,
                (int)Permission.VIEW_PROJECT_CALENDAR
            };

		#endregion

		#region Public Enumerations
        public enum UserRegistration : int
        {
            None = 0,
            Public = 1,
            Verified = 2
        }

		public enum ProjectAccessType : int 
		{
			None = 0,
			Public = 1,
			Private = 2
		}

        public enum IssueVisibility : int
        {
            Public = 0,
            Private = 1
        }

      
        /// <summary>
        /// Permissions Enumeration
        /// </summary>
        public enum Permission : int
        {
            None = 0,
            CLOSE_ISSUE = 1,
            ADD_ISSUE = 2,
            ASSIGN_ISSUE = 3,
            EDIT_ISSUE = 4,
            SUBSCRIBE_ISSUE = 5,
            DELETE_ISSUE = 6,
            ADD_COMMENT = 7,
            EDIT_COMMENT = 8,
            DELETE_COMMENT = 9,
            ADD_ATTACHMENT = 10,
            DELETE_ATTACHMENT = 11,
            ADD_RELATED = 12,
            DELETE_RELATED = 13,
            REOPEN_ISSUE = 14,  
            OWNER_EDIT_COMMENT = 15,
            EDIT_ISSUE_DESCRIPTION = 16,
            EDIT_ISSUE_TITLE = 17,
            ADMIN_EDIT_PROJECT = 18,
            ADD_TIME_ENTRY = 19,
            DELETE_TIME_ENTRY = 20,
            ADMIN_CREATE_PROJECT = 21,
            ADD_QUERY = 22,
            DELETE_QUERY = 23,
            ADMIN_CLONE_PROJECT = 24,
            ADD_SUB_ISSUE = 25,
            DELETE_SUB_ISSUE = 26,
            ADD_PARENT_ISSUE = 27,
            DELETE_PARENT_ISSUE = 28,
            ADMIN_DELETE_PROJECT = 29,
            VIEW_PROJECT_CALENDAR = 30,
            CHANGE_ISSUE_STATUS = 31,
            EDIT_QUERY = 32
        }
		#endregion

		#region Public Properties
        /// <summary>
        /// Gets the SMTP server.
        /// </summary>
        /// <value>The SMTP server.</value>
		public static string SmtpServer 
		{
			get 
			{
				string str = HostSetting.GetHostSetting("SMTPServer");
				if (String.IsNullOrEmpty(str))
					throw (new ApplicationException("SmtpServer configuration is missing or not set, check the host settings"));
				else
					return (str);
			}
		}

        /// <summary>
        /// Gets the host email address.
        /// </summary>
        /// <value>The host email address.</value>
		public static string HostEmailAddress 
		{
			get 
			{
				
				string str = HostSetting.GetHostSetting("HostEmailAddress");
				if (String.IsNullOrEmpty(str))
					throw (new ApplicationException("Host email address is not set, check the host settings."));
				else
					return (str);
			}
		}

        /// <summary>
        /// Gets the user account source.
        /// </summary>
        /// <value>The user account source.</value>
		public static string UserAccountSource 
		{
			get 
			{
				string str = HostSetting.GetHostSetting("UserAccountSource");
				if (String.IsNullOrEmpty(str))
					throw (new ApplicationException("UserAccountSource configuration is not set properly, check the host settings."));
				else
					return (str);
			}
		}

        /// <summary>
        /// Gets the default URL.
        /// </summary>
        /// <value>The default URL.</value>
		public static string DefaultUrl 
		{
			get 
			{
				string str = HostSetting.GetHostSetting("DefaultUrl");
                if (String.IsNullOrEmpty(str))
                {
                    throw (new ApplicationException("DefaultUrl configuration is not set, check the host settings."));
                }
                else
                {
                    if (str.EndsWith("/"))
                    {
                        return (str);
                    }
                    else
                    {
                        return (str.Insert(str.Length, "/"));
                    }
                }
			}
		}
        /// <summary>
        /// Parses the full bug id.
        /// </summary>
        /// <param name="fullId">The full id.</param>
        /// <returns></returns>
		public static int ParseFullIssueId(string fullId)
		{
			string[] split = fullId.Split('-');

			if(split.Length > 1)
				return  Convert.ToInt32(split[1]);

            try
            {
                return Convert.ToInt32(split[0]);
            }
            catch
            {
                return -1;
            }
		}
		#endregion

	}
}
