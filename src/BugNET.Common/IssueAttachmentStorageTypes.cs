
using System.Xml.Serialization;

namespace BugNET.Common
{
   
    /// <summary>
    /// Enumeration for the storage type of attachments
    /// </summary>
    public enum IssueAttachmentStorageTypes
    {
        /// <summary>
        /// File System
        /// </summary>
        [XmlEnum(Name = "None")]
        None = 0,

        /// <summary>
        /// File System
        /// </summary>
        [XmlEnum(Name = "FileSystem")]
        FileSystem = 1,

        /// <summary>
        /// Database
        /// </summary>
        [XmlEnum(Name = "Database")]
        Database = 2
    }
}
