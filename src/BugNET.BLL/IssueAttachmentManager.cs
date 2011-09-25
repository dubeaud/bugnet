using System;
using System.Collections.Generic;
using System.IO;
using System.Web;
using BugNET.Common;
using BugNET.DAL;
using BugNET.Entities;
using log4net;

namespace BugNET.BLL
{
    public class IssueAttachmentManager
    {
        private static readonly ILog Log = LogManager.GetLogger(typeof(IssueAttachmentManager));

        #region Instance Methods
        /// <summary>
        /// Saves this instance.
        /// </summary>
        /// <param name="issueAttachmentToSave">The issue attachment to save.</param>
        /// <returns></returns>
        public static bool SaveIssueAttachment(IssueAttachment issueAttachmentToSave)
        {

            if (issueAttachmentToSave.Id <= Globals.NewId)
            {
                //Start new save attachment code
                if (issueAttachmentToSave.Attachment.Length > 0)
                {
                    bool isFileOk = false;
                    string[] AllowedFileTypes = HostSettingManager.GetHostSetting("AllowedFileExtensions").Split(';');
                    string fileExt = System.IO.Path.GetExtension(issueAttachmentToSave.FileName);
                    string uploadedFileName = string.Empty;

                    uploadedFileName = Path.GetFileName(issueAttachmentToSave.FileName);

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
                        if (Log.IsErrorEnabled) Log.Error(string.Format(LoggingManager.GetErrorMessageResource("InvalidFileType"), uploadedFileName));
                        return false;
                    }

                    //check for illegal filename characters
                    if (uploadedFileName.IndexOfAny(System.IO.Path.GetInvalidFileNameChars()) != -1)
                    {
                        if (Log.IsErrorEnabled) Log.Error(string.Format(LoggingManager.GetErrorMessageResource("InvalidFileName"), uploadedFileName));
                        return false;
                    }

                    //if the file is ok save it.
                    if (isFileOk)
                    {
                        // save the file to the upload directory
                        int projectId = IssueManager.GetIssueById(issueAttachmentToSave.IssueId).ProjectId;
                        Project p = ProjectManager.GetProjectById(projectId);

                        if (p.AllowAttachments)
                        {
                            issueAttachmentToSave.ContentType = issueAttachmentToSave.ContentType.Replace("/x-png", "/png");
                            if (issueAttachmentToSave.ContentType == "image/bmp")
                            {
                                System.Drawing.Image img;

                                using (MemoryStream ms = new MemoryStream(issueAttachmentToSave.Attachment, 0, issueAttachmentToSave.Attachment.Length))
                                {
                                    ms.Write(issueAttachmentToSave.Attachment, 0, issueAttachmentToSave.Attachment.Length);
                                    img = System.Drawing.Image.FromStream(ms);
                                    img.Save(ms, System.Drawing.Imaging.ImageFormat.Png);
                                    ms.Seek(0, SeekOrigin.Begin);
                                    issueAttachmentToSave.Attachment = ms.ToArray();

                                }
                                issueAttachmentToSave.ContentType = "image/png";
                                issueAttachmentToSave.FileName = Path.ChangeExtension(issueAttachmentToSave.FileName, "png");
                            }
                            issueAttachmentToSave.Size = issueAttachmentToSave.Attachment.Length;

                            if (p.AttachmentStorageType == IssueAttachmentStorageType.Database)
                            {
                                //save the attachment record to the database.
                                int TempId = DataProviderManager.Provider.CreateNewIssueAttachment(issueAttachmentToSave);
                                if (TempId > 0)
                                {
                                    issueAttachmentToSave.Id = TempId;
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
                                        throw new ApplicationException(string.Format(LoggingManager.GetErrorMessageResource("UploadPathNotDefined"), p.Name));

                                    Guid attachmentGuid = Guid.NewGuid();
                                    byte[] AttachmentBytes = issueAttachmentToSave.Attachment;
                                    issueAttachmentToSave.Attachment = null;    //set attachment to null    
                                    issueAttachmentToSave.FileName = String.Format("{0}.{1}{2}", System.IO.Path.GetFileNameWithoutExtension(issueAttachmentToSave.FileName), attachmentGuid.ToString(), System.IO.Path.GetExtension(issueAttachmentToSave.FileName));
                                    string UploadedFilePath = HttpContext.Current.Server.MapPath("~" + Globals.UploadFolder + ProjectPath) + "\\" + issueAttachmentToSave.FileName;


                                    //save the attachment record to the database.
                                    int TempId = DataProviderManager.Provider.CreateNewIssueAttachment(issueAttachmentToSave);
                                    if (TempId > 0)
                                    {
                                        issueAttachmentToSave.Id = TempId;
                                        //save file to file system
                                        FileStream fs = File.Create(UploadedFilePath);
                                        fs.Write(AttachmentBytes, 0, issueAttachmentToSave.Size);
                                        fs.Close();
                                        return true;
                                    }
                                    else
                                        return false;
                                }
                                catch (DirectoryNotFoundException ex)
                                {
                                    if (Log.IsErrorEnabled) Log.Error(string.Format(LoggingManager.GetErrorMessageResource("UploadPathNotFound"), ProjectPath), ex);
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
            IssueAttachment att = IssueAttachmentManager.GetIssueAttachmentById(issueAttachmentId);
            Issue b = IssueManager.GetIssueById(att.IssueId);
            Project p = ProjectManager.GetProjectById(b.ProjectId);

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

                        throw new ApplicationException(LoggingManager.GetErrorMessageResource("AttachmentDeleteError"), ex);
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
                return string.Format(LoggingManager.GetErrorMessageResource("InvalidFileName"), fileName);

            bool isFileOk = false;
            string[] AllowedFileTypes = HostSettingManager.GetHostSetting("AllowedFileExtensions").Split(';');
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
                return string.Format(LoggingManager.GetErrorMessageResource("InvalidFileType"), fileName);
            }

            //check for illegal filename characters
            if (fileName.IndexOfAny(System.IO.Path.GetInvalidFileNameChars()) != -1)
            {
                return string.Format(LoggingManager.GetErrorMessageResource("InvalidFileName"), fileName);
            }

            return string.Empty;
        }

        ///// <summary>
        ///// Uploads the file.
        ///// </summary>
        ///// <param name="issueId">The issue id.</param>
        ///// <param name="uploadFile">The upload file.</param>
        ///// <param name="context">The context.</param>
        ///// <returns></returns>
        //[Obsolete("This method is obsolete; use the save method of the issue attachment instead")]
        //public static void UploadFile(int issueId, HttpPostedFile uploadFile, HttpContext context, string description)
        //{
        //    if (issueId <= 0)
        //        throw new ArgumentOutOfRangeException("issueId");
        //    if (uploadFile == null)
        //        throw new ArgumentNullException("uploadFile");
        //    if (uploadFile.ContentLength == 0)
        //        throw new ArgumentOutOfRangeException("uploadFile");
        //    if (context == null)
        //        throw new ArgumentNullException("context");


        //    // get the current file
        //    //HttpPostedFile uploadFile = this.AspUploadFile.PostedFile;
        //    //HttpContext context = HttpContext.Current;

        //    // if there was a file uploaded
        //    if (uploadFile.ContentLength > 0)
        //    {
        //        bool isFileOk = false;
        //        string[] AllowedFileTypes = HostSettingManager.GetHostSetting("AllowedFileExtensions").Split(new char[';']);
        //        string fileExt = System.IO.Path.GetExtension(uploadFile.FileName);
        //        string uploadedFileName = string.Empty;

        //        uploadedFileName = Path.GetFileName(uploadFile.FileName);

        //        if (AllowedFileTypes.Length > 0 && AllowedFileTypes[0].CompareTo("*.*") == 0)
        //        {
        //            isFileOk = true;
        //        }
        //        else
        //        {

        //            foreach (string fileType in AllowedFileTypes)
        //            {
        //                string newfileType = fileType.Substring(fileType.LastIndexOf("."));
        //                if (newfileType.CompareTo(fileExt) == 0)
        //                    isFileOk = true;

        //            }
        //        }

        //        //file type is not valid
        //        if (!isFileOk)
        //        {
        //            if (Log.IsErrorEnabled) Log.Error(string.Format(LoggingManager.GetErrorMessageResource("InvalidFileType"), uploadedFileName));
        //            return;
        //        }

        //        //check for illegal filename characters
        //        if (uploadedFileName.IndexOfAny(System.IO.Path.GetInvalidFileNameChars()) != -1)
        //        {
        //            if (Log.IsErrorEnabled) Log.Error(string.Format(LoggingManager.GetErrorMessageResource("InvalidFileName"), uploadedFileName));
        //            return;
        //        }

        //        //if the file is ok save it.
        //        if (isFileOk)
        //        {
        //            // save the file to the upload directory
        //            int projectId = IssueManager.GetIssueById(issueId).ProjectId;
        //            Project p = Project.GetProjectById(projectId);

        //            if (p.AllowAttachments)
        //            {
        //                IssueAttachment attachment;

        //                Stream input = uploadFile.InputStream;
        //                int fileSize = uploadFile.ContentLength;
        //                string ctype = uploadFile.ContentType.Replace("/x-png", "/png");
        //                if (uploadFile.ContentType == "image/bmp")
        //                {
        //                    MemoryStream memstr = new MemoryStream();
        //                    System.Drawing.Image img = System.Drawing.Image.FromStream(uploadFile.InputStream);
        //                    img.Save(memstr, System.Drawing.Imaging.ImageFormat.Png);
        //                    memstr.Seek(0, SeekOrigin.Begin);
        //                    input = memstr;
        //                    fileSize = (int)memstr.Length;
        //                    ctype = "image/png";
        //                    uploadedFileName = Path.ChangeExtension(uploadedFileName, "png");
        //                }
        //                byte[] fileBytes = new byte[fileSize];
        //                input.Read(fileBytes, 0, fileSize);

        //                if (p.AttachmentStorageType == IssueAttachmentStorageType.Database)
        //                {

        //                    attachment = new IssueAttachment(
        //                        issueId,
        //                        HttpContext.Current.User.Identity.Name,
        //                        uploadedFileName,
        //                        ctype,
        //                        fileBytes,
        //                        fileSize,
        //                        description);

        //                    attachment.Save();
        //                }
        //                else
        //                {
        //                    string ProjectPath = p.UploadPath;

        //                    try
        //                    {
        //                        if (ProjectPath.Length == 0)
        //                            throw new ApplicationException(string.Format(Logging.GetErrorMessageResource("UploadPathNotDefined"), p.Name));

        //                        string UploadedFileName = String.Format("{0:0000}_", issueId) + System.IO.Path.GetFileName(uploadedFileName);
        //                        string UploadedFilePath = context.Server.MapPath("~" + Globals.UploadFolder + ProjectPath) + "\\" + UploadedFileName;
        //                        attachment = new IssueAttachment(issueId, context.User.Identity.Name, UploadedFileName, ctype, null, fileSize, description);
        //                        if (attachment.Save())
        //                        {
        //                            FileStream fs = File.Create(UploadedFilePath);
        //                            fs.Write(fileBytes, 0, fileSize);
        //                            fs.Close();
        //                            return;
        //                        }
        //                    }
        //                    catch (DirectoryNotFoundException ex)
        //                    {
        //                        if (Log.IsErrorEnabled) Log.Error(string.Format(Logging.GetErrorMessageResource("UploadPathNotFound"), ProjectPath), ex);
        //                        throw;
        //                    }
        //                    catch (Exception ex)
        //                    {
        //                        if (Log.IsErrorEnabled) Log.Error(ex.Message, ex);
        //                        throw;
        //                    }
        //                }

        //            }

        //        }
        //    }
        //}


        #endregion
    }
}
