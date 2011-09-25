using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;

namespace BugNET.BusinessLogicLayer
{
   
    /// <summary>
    /// Enumeration for the storage type of attachments
    /// </summary>
    public enum IssueAttachmentStorageType
    {
        /// <summary>
        /// File System
        /// </summary>
        FileSystem = 1,
        /// <summary>
        /// Database
        /// </summary>
        Database = 2
    }
}
