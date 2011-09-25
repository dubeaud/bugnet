using System;
using System.Data;
using System.Collections.Generic;
using BugNET.DataAccessLayer;
using System.IO;
using log4net;
using log4net.Config;
using System.Web;

namespace BugNET.BusinessLogicLayer
{
    /// <summary>
    /// Summary description for IssueAttachment.
    /// </summary>
    public class IssueAttachment
    {
        #region Private Variables
        private int _Id;
        private int _IssueId;
        private string _CreatorUserName;
        private string _CreatorDisplayName;
        private DateTime _DateCreated;
        private string _FileName;
        private string _ContentType;
        private string _Description;
        private int _Size;
        private Byte[] _Attachment;
        private static readonly ILog Log = LogManager.GetLogger(typeof(IssueAttachment));
        #endregion

        #region Constructors

        /// <summary>
        /// Initializes a new instance of the <see cref="IssueAttachment"/> class.
        /// </summary>
        /// <param name="fileName">Name of the file.</param>
        /// <param name="contentType">Type of the content.</param>
        /// <param name="attachment">The attachment.</param>
        public IssueAttachment(string fileName, string contentType, byte[] attachment)
            : this(Globals.NewId, Globals.NewId, String.Empty, String.Empty, Globals.GetDateTimeMinValue(), fileName, contentType, attachment, 0, string.Empty)
        { }


        /// <summary>
        /// Initializes a new instance of the <see cref="IssueAttachment"/> class.
        /// </summary>
        /// <param name="issueId">The issue id.</param>
        /// <param name="creatorUserName">Name of the creator user.</param>
        /// <param name="fileName">Name of the file.</param>
        /// <param name="contentType">Type of the content.</param>
        /// <param name="attachment">The attachment.</param>
        public IssueAttachment(int issueId, string creatorUserName, string fileName, string contentType, byte[] attachment, int size, string description)
            : this(Globals.NewId, issueId, creatorUserName, String.Empty, Globals.GetDateTimeMinValue(), fileName, contentType, attachment, size, description)
        { }


        /// <summary>
        /// Initializes a new instance of the <see cref="IssueAttachment"/> class.
        /// </summary>
        /// <param name="attachmentId">The attachment id.</param>
        /// <param name="issueId">The issue id.</param>
        /// <param name="creatorUserName">Name of the creator user.</param>
        /// <param name="creatorDisplayName">Display name of the creator.</param>
        /// <param name="created">The created.</param>
        /// <param name="fileName">Name of the file.</param>
        public IssueAttachment(int attachmentId, int issueId, string creatorUserName, string creatorDisplayName, DateTime created, string fileName, int size, string description)
            : this(attachmentId, issueId, creatorUserName, creatorDisplayName, created, fileName, String.Empty, null, size, description)
        { }

        /// <summary>
        /// Initializes a new instance of the <see cref="IssueAttachment"/> class.
        /// </summary>
        /// <param name="attachmentId">The attachment id.</param>
        /// <param name="issueId">The issue id.</param>
        /// <param name="creatorUserName">Name of the creator user.</param>
        /// <param name="creatorDisplayName">Display name of the creator.</param>
        /// <param name="created">The created.</param>
        /// <param name="fileName">Name of the file.</param>
        /// <param name="contentType">Type of the content.</param>
        /// <param name="attachment">The attachment.</param>
        public IssueAttachment(int attachmentId, int issueId, string creatorUserName, string creatorDisplayName, DateTime created, string fileName, string contentType, byte[] attachment, int size, string description)
        {
            _Id = attachmentId;
            _IssueId = issueId;
            _CreatorUserName = creatorUserName;
            _CreatorDisplayName = creatorDisplayName;
            _DateCreated = created;
            _FileName = fileName;
            _ContentType = contentType;
            _Attachment = attachment;
            _Size = size;
            _Description = description;
        }
        #endregion

        #region Properties
        /// <summary>
        /// Gets the id.
        /// </summary>
        /// <value>The id.</value>
        public int Id
        {
            get { return _Id; }
        }


        /// <summary>
        /// Gets or sets the issue id.
        /// </summary>
        /// <value>The issue id.</value>
        public int IssueId
        {
            get { return _IssueId; }
            set
            {
                if (value <= Globals.NewId)
                    throw (new ArgumentOutOfRangeException("value"));
                _IssueId = value;
            }
        }


        /// <summary>
        /// Gets the creator username.
        /// </summary>
        /// <value>The creator username.</value>
        public string CreatorUserName
        {
            get
            {
                if (_CreatorUserName == null || _CreatorUserName.Length == 0)
                    return string.Empty;
                else
                    return _CreatorUserName;
            }
        }


        /// <summary>
        /// Gets the display name of the creator.
        /// </summary>
        /// <value>The display name of the creator.</value>
        public string CreatorDisplayName
        {
            get
            {
                if (_CreatorDisplayName == null || _CreatorDisplayName.Length == 0)
                    return string.Empty;
                else
                    return _CreatorDisplayName;
            }
        }

        /// <summary>
        /// Gets the date created.
        /// </summary>
        /// <value>The date created.</value>
        public DateTime DateCreated
        {
            get { return _DateCreated; }
        }


        /// <summary>
        /// Gets the name of the file.
        /// </summary>
        /// <value>The name of the file.</value>
        public string FileName
        {
            get
            {
                if (_FileName == null || _FileName.Length == 0)
                    return string.Empty;
                else
                    return _FileName;
            }
        }



        /// <summary>
        /// Gets the type of the content.
        /// </summary>
        /// <value>The type of the content.</value>
        public string ContentType
        {
            get
            {
                if (_ContentType == null || _ContentType.Length == 0)
                    return string.Empty;
                else
                    return _ContentType;
            }
        }


        /// <summary>
        /// Gets the attachment.
        /// </summary>
        /// <value>The attachment.</value>
        public Byte[] Attachment
        {
            get { return _Attachment; }
        }


        ///<summary>
        /// Gets the size.
        /// </summary>
        /// <value>The size.</value>
        public int Size
        {
            get { return _Size; }
        }
        /// <summary>
        /// Gets the description.
        /// </summary>
        /// <value>The description.</value>
        public string Description
        {
            get { return _Description; }
        }



        #endregion

        #region Instance Methods
        /// <summary>
        /// Saves this instance.
        /// </summary>
        /// <returns></returns>
        public bool Save()
        {

            if (Id <= Globals.NewId)
            {
                //Start new save attachment code
                if (this._Attachment.Length > 0)
                {
                    bool isFileOk = false;
                    string[] AllowedFileTypes = HostSetting.GetHostSetting("AllowedFileExtensions").Split(';');
                    string fileExt = System.IO.Path.GetExtension(this._FileName);
                    string uploadedFileName = string.Empty;

                    uploadedFileName = Path.GetFileName(this._FileName);

                    //check if file type is allowed
                    if (AllowedFileTypes.Length > 0 && AllowedFileTypes[0].CompareTo("*.*") == 0)
                    {
                        isFileOk = true;
                    }
                    else
                    {
                        foreach (string fileType in AllowedFileTypes)
                        {
                            string newfileType = fileType.Substring(fileType.LastIndexOf("."));
                            if (newfileType.CompareTo(fileExt) == 0)
                            {
                                isFileOk = true;
                                break;
                            }
                        }
                    }

                    //file type is not valid
                    if (!isFileOk)
                    {
                        if (Log.IsErrorEnabled) Log.Error(string.Format(Logging.GetErrorMessageResource("InvalidFileType"), uploadedFileName));
                        return false;
                    }

                    //check for illegal filename characters
                    if (uploadedFileName.IndexOfAny(System.IO.Path.GetInvalidFileNameChars()) != -1)
                    {
                        if (Log.IsErrorEnabled) Log.Error(string.Format(Logging.GetErrorMessageResource("InvalidFileName"), uploadedFileName));
                        return false;
                    }

                    //if the file is ok save it.
                    if (isFileOk)
                    {
                        // save the file to the upload directory
                        int projectId = Issue.GetIssueById(this._IssueId).ProjectId;
                        Project p = Project.GetProjectById(projectId);

                        if (p.AllowAttachments)
                        {
                            this._ContentType = this._ContentType.Replace("/x-png", "/png");
                            if (this._ContentType == "image/bmp")
                            {
                                System.Drawing.Image img;

                                using (MemoryStream ms = new MemoryStream(this._Attachment, 0, this._Attachment.Length))
                                {
                                    ms.Write(this._Attachment, 0, this._Attachment.Length);
                                    img = System.Drawing.Image.FromStream(ms);
                                    img.Save(ms, System.Drawing.Imaging.ImageFormat.Png);
                                    ms.Seek(0, SeekOrigin.Begin);
                                    this._Attachment = ms.ToArray();

                                }
                                this._ContentType = "image/png";
                                this._FileName = Path.ChangeExtension(this._FileName, "png");
                            }
                            this._Size = this._Attachment.Length;

                            if (p.AttachmentStorageType == IssueAttachmentStorageType.Database)
                            {
                                //save the attachment record to the database.
                                int TempId = DataProviderManager.Provider.CreateNewIssueAttachment(this);
                                if (TempId > 0)
                                {
                                    _Id = TempId;
                                    return true;
                                }
                                else
                                    return false;
                            }
                            else
                            {
                                string ProjectPath = p.UploadPath;

                                try
                                {
                                    if (ProjectPath.Length == 0)
                                        throw new ApplicationException(string.Format(Logging.GetErrorMessageResource("UploadPathNotDefined"), p.Name));

                                    Guid attachmentGuid = Guid.NewGuid();
                                    byte[] AttachmentBytes = this._Attachment;
                                    this._Attachment = null;    //set attachment to null    
                                    this._FileName = String.Format("{0}.{1}{2}", System.IO.Path.GetFileNameWithoutExtension(_FileName), attachmentGuid.ToString(), System.IO.Path.GetExtension(_FileName));
                                    string UploadedFilePath = HttpContext.Current.Server.MapPath("~" + Globals.UploadFolder + ProjectPath) + "\\" + this._FileName;


                                    //save the attachment record to the database.
                                    int TempId = DataProviderManager.Provider.CreateNewIssueAttachment(this);
                                    if (TempId > 0)
                                    {
                                        _Id = TempId;
                                        //save file to file system
                                        FileStream fs = File.Create(UploadedFilePath);
                                        fs.Write(AttachmentBytes, 0, this._Size);
                                        fs.Close();
                                        return true;
                                    }
                                    else
                                        return false;
                                }
                                catch (DirectoryNotFoundException ex)
                                {
                                    if (Log.IsErrorEnabled) Log.Error(string.Format(Logging.GetErrorMessageResource("UploadPathNotFound"), ProjectPath), ex);
                                    throw;
                                }
                                catch (Exception ex)
                                {
                                    if (Log.IsErrorEnabled) Log.Error(ex.Message, ex);
                                    throw;
                                }
                            }

                        }

                    }
                }
            }
            return false;
        }
        #endregion

        #region Static Methods
        /// <summary>
        /// Gets all IssueAttachments for a bug
        /// </summary>
        /// <param name="bugId"></param>
        /// <returns></returns>
        public static List<IssueAttachment> GetIssueAttachmentsByIssueId(int issueId)
        {
            // validate input
            if (issueId <= Globals.NewId)
                throw (new ArgumentOutOfRangeException("issueId"));

            return DataProviderManager.Provider.GetIssueAttachmentsByIssueId(issueId);
        }

        /// <summary>
        /// Gets an IssueAttachment by id
        /// </summary>
        /// <param name="IssueAttachmentId">The IssueAttachment id.</param>
        /// <returns></returns>
        public static IssueAttachment GetIssueAttachmentById(int attachmentId)
        {
            // validate input
            if (attachmentId <= Globals.NewId)
                throw (new ArgumentOutOfRangeException("attachmentId"));

            return DataProviderManager.Provider.GetIssueAttachmentById(attachmentId);
        }

        /// <summary>
        /// Deletes the IssueAttachment.
        /// </summary>
        /// <param name="issueAttachmentId">The issue attachment id.</param>
        /// <returns></returns>
        public static bool DeleteIssueAttachment(int issueAttachmentId)
        {
            IssueAttachment att = IssueAttachment.GetIssueAttachmentById(issueAttachmentId);
            Issue b = Issue.GetIssueById(att.IssueId);
            Project p = Project.GetProjectById(b.ProjectId);

            if (DataProviderManager.Provider.DeleteIssueAttachment(issueAttachmentId))
            {
                if (p.AttachmentStorageType == IssueAttachmentStorageType.FileSystem)
                {
                    //delete IssueAttachment from file system.
                    try
                    {
                        File.Delete(System.Web.HttpContext.Current.Server.MapPath(string.Format("~{2}{0}\\{1}", p.UploadPath, att.FileName, Globals.UploadFolder)));
                    }
                    catch (Exception ex)
                    {
                        //set user to log4net context, so we can use %X{user} in the appenders
                        if (System.Web.HttpContext.Current.User != null && System.Web.HttpContext.Current.User.Identity.IsAuthenticated)
                            MDC.Set("user", System.Web.HttpContext.Current.User.Identity.Name);

                        if (Log.IsErrorEnabled)
                            Log.Error(String.Format("Error Deleting IssueAttachment - {0}", string.Format("{0}\\{1}", p.UploadPath, att.FileName)), ex);

                        throw new ApplicationException(Logging.GetErrorMessageResource("AttachmentDeleteError"), ex);
                    }
                }
            }
            return true;

        }

        /// <summary>
        /// Stewart Moss
        /// Apr 14 2010 
        /// 
        /// Performs a query containing any number of query clauses on a certain IssueID
        /// </summary>
        /// <param name="issueId"></param>
        /// <param name="QueryClauses"></param>
        /// <returns></returns>
        public static List<IssueAttachment> PerformQuery(int issueId, List<QueryClause> QueryClauses)
        {
            if (issueId < 0)
                throw new ArgumentOutOfRangeException("issueId must be bigger than 0");
            QueryClauses.Add(new QueryClause("AND", "IssueId", "=", issueId.ToString(), System.Data.SqlDbType.Int, false));

            return PerformQuery(QueryClauses);
        }

        /// <summary>
        /// Stewart Moss
        /// Apr 14 2010 8:30 pm
        /// 
        /// Performs any query containing any number of query clauses
        /// WARNING! Will expose the entire IssueAttachment table, regardless of 
        /// project level privileges. (that's why its private for now)
        /// </summary>        
        /// <param name="QueryClauses"></param>
        /// <returns></returns>
        private static List<IssueAttachment> PerformQuery(List<QueryClause> QueryClauses)
        {
            if (QueryClauses == null)
                throw new ArgumentNullException("QueryClauses");

            List<IssueAttachment> lst = new List<IssueAttachment>();
            DataProviderManager.Provider.PerformGenericQuery<IssueAttachment>(ref lst, QueryClauses, @"SELECT a.*, b.UserName as CreatorUserName, a.Userid as CreatorUserID, b.Username as CreatorDisplayName from BugNet_IssueAttachment as a, aspnet_Users as b  WHERE a.UserId=b.UserID ", @" ORDER BY IssueAttachmentId DESC");

            return lst;
        }

        /// <summary>
        /// Validates the name of the file.
        /// </summary>
        /// <param name="fileName">Name of the file.</param>
        /// <returns></returns>
        public static string ValidateFileName(string fileName)
        {
            if (string.IsNullOrEmpty(fileName))
                return string.Format(Logging.GetErrorMessageResource("InvalidFileName"), fileName);

            bool isFileOk = false;
            string[] AllowedFileTypes = HostSetting.GetHostSetting("AllowedFileExtensions").Split(';');
            string fileExt = System.IO.Path.GetExtension(fileName);

            if (AllowedFileTypes.Length > 0 && AllowedFileTypes[0].CompareTo("*.*") == 0)
            {
                isFileOk = true;
            }
            else
            {

                foreach (string fileType in AllowedFileTypes)
                {
                    string newfileType = fileType.Substring(fileType.LastIndexOf("."));
                    if (newfileType.CompareTo(fileExt) == 0)
                    {
                        isFileOk = true;
                        break;
                    }
                }
            }

            //file type is not valid
            if (!isFileOk)
            {
                return string.Format(Logging.GetErrorMessageResource("InvalidFileType"), fileName);
            }

            //check for illegal filename characters
            if (fileName.IndexOfAny(System.IO.Path.GetInvalidFileNameChars()) != -1)
            {
                return string.Format(Logging.GetErrorMessageResource("InvalidFileName"), fileName);
            }

            return string.Empty;
        }

        /// <summary>
        /// Uploads the file.
        /// </summary>
        /// <param name="issueId">The issue id.</param>
        /// <param name="uploadFile">The upload file.</param>
        /// <param name="context">The context.</param>
        /// <returns></returns>
        [Obsolete("This method is obsolete; use the save method of the issue attachment instead")]
        public static void UploadFile(int issueId, HttpPostedFile uploadFile, HttpContext context, string description)
        {
            if (issueId <= 0)
                throw new ArgumentOutOfRangeException("issueId");
            if (uploadFile == null)
                throw new ArgumentNullException("uploadFile");
            if (uploadFile.ContentLength == 0)
                throw new ArgumentOutOfRangeException("uploadFile");
            if (context == null)
                throw new ArgumentNullException("context");


            // get the current file
            //HttpPostedFile uploadFile = this.AspUploadFile.PostedFile;
            //HttpContext context = HttpContext.Current;

            // if there was a file uploaded
            if (uploadFile.ContentLength > 0)
            {
                bool isFileOk = false;
                string[] AllowedFileTypes = HostSetting.GetHostSetting("AllowedFileExtensions").Split(new char[';']);
                string fileExt = System.IO.Path.GetExtension(uploadFile.FileName);
                string uploadedFileName = string.Empty;

                uploadedFileName = Path.GetFileName(uploadFile.FileName);

                if (AllowedFileTypes.Length > 0 && AllowedFileTypes[0].CompareTo("*.*") == 0)
                {
                    isFileOk = true;
                }
                else
                {

                    foreach (string fileType in AllowedFileTypes)
                    {
                        string newfileType = fileType.Substring(fileType.LastIndexOf("."));
                        if (newfileType.CompareTo(fileExt) == 0)
                            isFileOk = true;

                    }
                }

                //file type is not valid
                if (!isFileOk)
                {
                    if (Log.IsErrorEnabled) Log.Error(string.Format(Logging.GetErrorMessageResource("InvalidFileType"), uploadedFileName));
                    return;
                }

                //check for illegal filename characters
                if (uploadedFileName.IndexOfAny(System.IO.Path.GetInvalidFileNameChars()) != -1)
                {
                    if (Log.IsErrorEnabled) Log.Error(string.Format(Logging.GetErrorMessageResource("InvalidFileName"), uploadedFileName));
                    return;
                }

                //if the file is ok save it.
                if (isFileOk)
                {
                    // save the file to the upload directory
                    int projectId = Issue.GetIssueById(issueId).ProjectId;
                    Project p = Project.GetProjectById(projectId);

                    if (p.AllowAttachments)
                    {
                        IssueAttachment attachment;

                        Stream input = uploadFile.InputStream;
                        int fileSize = uploadFile.ContentLength;
                        string ctype = uploadFile.ContentType.Replace("/x-png", "/png");
                        if (uploadFile.ContentType == "image/bmp")
                        {
                            MemoryStream memstr = new MemoryStream();
                            System.Drawing.Image img = System.Drawing.Image.FromStream(uploadFile.InputStream);
                            img.Save(memstr, System.Drawing.Imaging.ImageFormat.Png);
                            memstr.Seek(0, SeekOrigin.Begin);
                            input = memstr;
                            fileSize = (int)memstr.Length;
                            ctype = "image/png";
                            uploadedFileName = Path.ChangeExtension(uploadedFileName, "png");
                        }
                        byte[] fileBytes = new byte[fileSize];
                        input.Read(fileBytes, 0, fileSize);

                        if (p.AttachmentStorageType == IssueAttachmentStorageType.Database)
                        {

                            attachment = new IssueAttachment(
                                issueId,
                                HttpContext.Current.User.Identity.Name,
                                uploadedFileName,
                                ctype,
                                fileBytes,
                                fileSize,
                                description);

                            attachment.Save();
                        }
                        else
                        {
                            string ProjectPath = p.UploadPath;

                            try
                            {
                                if (ProjectPath.Length == 0)
                                    throw new ApplicationException(string.Format(Logging.GetErrorMessageResource("UploadPathNotDefined"), p.Name));

                                string UploadedFileName = String.Format("{0:0000}_", issueId) + System.IO.Path.GetFileName(uploadedFileName);
                                string UploadedFilePath = context.Server.MapPath("~" + Globals.UploadFolder + ProjectPath) + "\\" + UploadedFileName;
                                attachment = new IssueAttachment(issueId, context.User.Identity.Name, UploadedFileName, ctype, null, fileSize, description);
                                if (attachment.Save())
                                {
                                    FileStream fs = File.Create(UploadedFilePath);
                                    fs.Write(fileBytes, 0, fileSize);
                                    fs.Close();
                                    return;
                                }
                            }
                            catch (DirectoryNotFoundException ex)
                            {
                                if (Log.IsErrorEnabled) Log.Error(string.Format(Logging.GetErrorMessageResource("UploadPathNotFound"), ProjectPath), ex);
                                throw;
                            }
                            catch (Exception ex)
                            {
                                if (Log.IsErrorEnabled) Log.Error(ex.Message, ex);
                                throw;
                            }
                        }

                    }

                }
            }
        }


        #endregion

    }
}
