using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using BugNET.Common;
using BugNET.DAL;
using BugNET.Entities;
using log4net;

namespace BugNET.BLL
{
    public static class IssueAttachmentManager
    {
        private static readonly ILog Log = LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

        #region Instance Methods
        /// <summary>
        /// Saves this instance.
        /// </summary>
        /// <param name="issueAttachmentToSave">The issue attachment to save.</param>
        /// <returns></returns>
        public static bool SaveIssueAttachment(IssueAttachment issueAttachmentToSave)
        {

            if (issueAttachmentToSave.Id <= Globals.NEW_ID)
            {
                //Start new save attachment code
                if (issueAttachmentToSave.Attachment.Length > 0)
                {
                    var isFileOk = false;
                    var allowedFileTypes = HostSettingManager.GetHostSetting("AllowedFileExtensions").Split(';');
                    var fileExt = Path.GetExtension(issueAttachmentToSave.FileName);

                    var uploadedFileName = Path.GetFileName(issueAttachmentToSave.FileName);

                    //check if file type is allowed
                    if (allowedFileTypes.Length > 0 && allowedFileTypes[0].CompareTo("*.*") == 0)
                    {
                        isFileOk = true;
                    }
                    else
                    {
                        if (allowedFileTypes.Select(fileType => fileType.Substring(fileType.LastIndexOf("."))).Any(newfileType => newfileType.CompareTo(fileExt) == 0))
                        {
                            isFileOk = true;
                        }
                    }

                    //file type is not valid
                    if (!isFileOk)
                    {
                        if (Log.IsErrorEnabled) Log.Error(string.Format(LoggingManager.GetErrorMessageResource("InvalidFileType"), uploadedFileName));
                        return false;
                    }

                    //check for illegal filename characters
                    if (uploadedFileName != null && uploadedFileName.IndexOfAny(Path.GetInvalidFileNameChars()) != -1)
                    {
                        if (Log.IsErrorEnabled) Log.Error(string.Format(LoggingManager.GetErrorMessageResource("InvalidFileName"), uploadedFileName));
                        return false;
                    }

                    // save the file to the upload directory
                    var projectId = IssueManager.GetIssueById(issueAttachmentToSave.IssueId).ProjectId;
                    var p = ProjectManager.GetProjectById(projectId);

                    if (p.AllowAttachments)
                    {
                        issueAttachmentToSave.ContentType = issueAttachmentToSave.ContentType.Replace("/x-png", "/png");
                        if (issueAttachmentToSave.ContentType == "image/bmp")
                        {
                            System.Drawing.Image img;

                            using (var ms = new MemoryStream(issueAttachmentToSave.Attachment, 0, issueAttachmentToSave.Attachment.Length))
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
                            var tempId = DataProviderManager.Provider.CreateNewIssueAttachment(issueAttachmentToSave);
                            if (tempId > 0)
                            {
                                issueAttachmentToSave.Id = tempId;
                                return true;
                            }
                            return false;
                        }

                        var projectPath = p.UploadPath;

                        try
                        {
                            if (projectPath.Length == 0)
                                throw new ApplicationException(string.Format(LoggingManager.GetErrorMessageResource("UploadPathNotDefined"), p.Name));

                            var attachmentGuid = Guid.NewGuid();
                            var attachmentBytes = issueAttachmentToSave.Attachment;
                            issueAttachmentToSave.Attachment = null;    //set attachment to null    
                            issueAttachmentToSave.FileName = String.Format("{0}.{1}{2}", Path.GetFileNameWithoutExtension(issueAttachmentToSave.FileName), attachmentGuid, Path.GetExtension(issueAttachmentToSave.FileName));
                            var uploadedFilePath = HttpContext.Current.Server.MapPath("~" + Globals.UPLOAD_FOLDER + projectPath) + "\\" + issueAttachmentToSave.FileName;


                            //save the attachment record to the database.
                            var tempId = DataProviderManager.Provider.CreateNewIssueAttachment(issueAttachmentToSave);
                            if (tempId > 0)
                            {
                                issueAttachmentToSave.Id = tempId;
                                //save file to file system
                                var fs = File.Create(uploadedFilePath);
                                fs.Write(attachmentBytes, 0, issueAttachmentToSave.Size);
                                fs.Close();
                                return true;
                            }

                            return false;
                        }
                        catch (DirectoryNotFoundException ex)
                        {
                            if (Log.IsErrorEnabled) Log.Error(string.Format(LoggingManager.GetErrorMessageResource("UploadPathNotFound"), projectPath), ex);
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
            return false;
        }
        #endregion

        #region Static Methods
        /// <summary>
        /// Gets all IssueAttachments for an issue
        /// </summary>
        /// <param name="issueId"></param>
        /// <returns></returns>
        public static List<IssueAttachment> GetIssueAttachmentsByIssueId(int issueId)
        {
            // validate input
            if (issueId <= Globals.NEW_ID)
                throw (new ArgumentOutOfRangeException("issueId"));

            return DataProviderManager.Provider.GetIssueAttachmentsByIssueId(issueId);
        }

        /// <summary>
        /// Gets an IssueAttachment by id
        /// </summary>
        /// <param name="attachmentId">The IssueAttachment id.</param>
        /// <returns></returns>
        public static IssueAttachment GetIssueAttachmentById(int attachmentId)
        {
            // validate input
            if (attachmentId <= Globals.NEW_ID)
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
            var att = GetIssueAttachmentById(issueAttachmentId);
            var b = IssueManager.GetIssueById(att.IssueId);
            var p = ProjectManager.GetProjectById(b.ProjectId);

            if (DataProviderManager.Provider.DeleteIssueAttachment(issueAttachmentId))
            {
                if (p.AttachmentStorageType == IssueAttachmentStorageType.FileSystem)
                {
                    //delete IssueAttachment from file system.
                    try
                    {
                        File.Delete(HttpContext.Current.Server.MapPath(string.Format("~{2}{0}\\{1}", p.UploadPath, att.FileName, Globals.UPLOAD_FOLDER)));
                    }
                    catch (Exception ex)
                    {
                        //set user to log4net context, so we can use %X{user} in the appenders
                        if (HttpContext.Current.User != null && HttpContext.Current.User.Identity.IsAuthenticated)
                            MDC.Set("user", HttpContext.Current.User.Identity.Name);

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
        /// <param name="queryClauses"></param>
        /// <returns></returns>
        public static List<IssueAttachment> PerformQuery(int issueId, List<QueryClause> queryClauses)
        {
            if (issueId < 0)
                throw new ArgumentOutOfRangeException("issueId", "must be bigger than 0");

            queryClauses.Add(new QueryClause("AND", "IssueId", "=", issueId.ToString(), System.Data.SqlDbType.Int, false));

            return PerformQuery(queryClauses);
        }

        /// <summary>
        /// Stewart Moss
        /// Apr 14 2010 8:30 pm
        /// 
        /// Performs any query containing any number of query clauses
        /// WARNING! Will expose the entire IssueAttachment table, regardless of 
        /// project level privileges. (that's why its private for now)
        /// </summary>        
        /// <param name="queryClauses"></param>
        /// <returns></returns>
        private static List<IssueAttachment> PerformQuery(List<QueryClause> queryClauses)
        {
            if (queryClauses == null)
                throw new ArgumentNullException("queryClauses");

            var lst = new List<IssueAttachment>();
            DataProviderManager.Provider.PerformGenericQuery(ref lst, queryClauses, @"SELECT a.*, b.UserName as CreatorUserName, a.Userid as CreatorUserID, b.Username as CreatorDisplayName from BugNet_IssueAttachment as a, aspnet_Users as b  WHERE a.UserId=b.UserID ", @" ORDER BY IssueAttachmentId DESC");

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

            var isFileOk = false;
            var allowedFileTypes = HostSettingManager.GetHostSetting("AllowedFileExtensions").Split(';');
            var fileExt = Path.GetExtension(fileName);

            if (allowedFileTypes.Length > 0 && allowedFileTypes[0].CompareTo("*.*") == 0)
            {
                isFileOk = true;
            }
            else
            {

                if (allowedFileTypes.Select(fileType => fileType.Substring(fileType.LastIndexOf("."))).Any(newfileType => newfileType.CompareTo(fileExt) == 0))
                {
                    isFileOk = true;
                }
            }

            //file type is not valid
            if (!isFileOk)
            {
                return string.Format(LoggingManager.GetErrorMessageResource("InvalidFileType"), fileName);
            }

            //check for illegal filename characters
            return fileName.IndexOfAny(Path.GetInvalidFileNameChars()) != -1 ? string.Format(LoggingManager.GetErrorMessageResource("InvalidFileName"), fileName) : string.Empty;
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
