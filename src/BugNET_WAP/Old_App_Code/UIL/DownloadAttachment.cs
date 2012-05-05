// According to http://msdn2.microsoft.com/en-us/library/system.web.httppostedfile.aspx
// "Files are uploaded in MIME multipart/form-data format. 
// By default, all requests, including form fields and uploaded files, 
// larger than 256 KB are buffered to disk, rather than held in server memory."
// So we can use an HttpHandler to handle uploaded files and not have to worry
// about the server recycling the request do to low memory. 
// don't forget to increase the MaxRequestLength in the web.config.
// If you server is still giving errors, then something else is wrong.
// I've uploaded a 1.3 gig file without any problems. One thing to note, 
// when the SaveAs function is called, it takes time for the server to 
// save the file. The larger the file, the longer it takes.
// So if a progress bar is used in the upload, it may read 100%, but the upload won't
// be complete until the file is saved.  So it may look like it is stalled, but it
// is not.
using System;
using System.Web;
using BugNET.BLL;
using BugNET.Common;
using BugNET.Entities;
using log4net;

//using BugNET.BusinessLogicLayer;
namespace BugNET.UserInterfaceLayer
{
    /// <summary>
    /// Upload handler for uploading files.
    /// </summary>
    public class DownloadAttachment : IHttpHandler
    {
        private static readonly ILog Log = LogManager.GetLogger(typeof(DownloadAttachment));

        #region IHttpHandler Members

        /// <summary>
        /// Gets a value indicating whether another request can use the <see cref="T:System.Web.IHttpHandler"/> instance.
        /// </summary>
        /// <value></value>
        /// <returns>true if the <see cref="T:System.Web.IHttpHandler"/> instance is reusable; otherwise, false.</returns>
        public bool IsReusable
        {
            get { return true; }
        }

        /// <summary>
        /// Enables processing of HTTP Web requests by a custom HttpHandler that implements the <see cref="T:System.Web.IHttpHandler"/> interface.
        /// </summary>
        /// <param name="context">An <see cref="T:System.Web.HttpContext"/> object that provides references to the intrinsic server objects (for example, Request, Response, Session, and Server) used to service HTTP requests.</param>
        public void ProcessRequest(HttpContext context)
        {
            if (context.Request.QueryString["mode"] == "project")
            {
                var projectId = context.Request.QueryString.Get("id", Globals.NEW_ID);

                var projectImage = ProjectManager.GetProjectImageById(projectId);

                if (projectImage != null)
                {
                    // Write out the attachment
                    context.Server.ScriptTimeout = 600;
                    context.Response.Buffer = true;
                    context.Response.Clear();
                    context.Response.ContentType = "application/octet-stream";
                    context.Response.AddHeader("Content-Length", projectImage.ImageFileLength.ToString());
                    context.Response.BinaryWrite(projectImage.ImageContent);
                }
                else
                {
                    context.Response.WriteFile("~/Images/project.png");
                }

            }
            else
            {
                // Get the attachment
                var attachmentId = context.Request.Get("id", Globals.NEW_ID);

                // cannot parse the attachment from the querystring bail without trying
                if (attachmentId.Equals(Globals.NEW_ID))
                {
                    context.Response.Write("<h1>Attachment Not Found.</h1>  It may have been deleted from the server.");
                    context.Response.End();
                    return;
                }

                try
                {
                    var attachment = IssueAttachmentManager.GetAttachmentForDownload(attachmentId);

                    if(attachment == null)
                    {
                        context.Response.Write("<h1>Attachment Not Found.</h1>  It may have been deleted from the server.");
                        context.Response.End();
                        return;
                    }

                    var cleanFileName = IssueAttachmentManager.StripGuidFromFileName(attachment.FileName);
                    var fileName = attachment.FileName;

                    if (attachment.Attachment != null)
                    {
                        // Write out the attachment
                        context.Server.ScriptTimeout = 600;
                        context.Response.Buffer = true;
                        context.Response.Clear();

                        if (attachment.ContentType.ToLower().StartsWith("image/"))
                        {
                            context.Response.ContentType = attachment.ContentType;
                            context.Response.AddHeader("Content-Disposition", string.Format("inline; filename=\"{0}\";", cleanFileName));
                        }
                        else
                        {
                            context.Response.ContentType = "application/octet-stream";
                            context.Response.AddHeader("Content-Disposition", string.Format("attachment; filename=\"{0}\";", cleanFileName));
                        }
                        context.Response.AddHeader("Content-Length", attachment.Attachment.Length.ToString());
                        context.Response.BinaryWrite(attachment.Attachment);
                    }
                    else
                    {

                        var p = ProjectManager.GetById(IssueManager.GetById(attachment.IssueId).ProjectId);
                        var projectPath = p.UploadPath;

                        //append a trailing slash if it doesn't exist
                        if (!projectPath.EndsWith("\\"))
                            projectPath = String.Concat(projectPath, "\\");

                        var path = String.Concat("~", Globals.UPLOAD_FOLDER, projectPath, fileName);

                        if (System.IO.File.Exists(context.Server.MapPath(path)))
                        {
                            context.Response.Clear();
                            context.Response.ContentType = attachment.ContentType;
                            context.Response.AddHeader("Content-Disposition",
                                                       attachment.ContentType.ToLower().StartsWith("image/")
                                                           ? string.Format("inline; filename=\"{0}\";", cleanFileName)
                                                           : string.Format("attachment; filename=\"{0}\";",
                                                                           cleanFileName));
                            context.Response.WriteFile(path);
                        }
                        else
                        {
                            context.Response.Write("<h1>Attachment Not Found.</h1>  It may have been deleted from the server.");
                        }
                    }
                }
                catch(DataAccessException dx)
                {
                    if(dx.StatusCode > 0)
                    {
                        var statusCode = dx.StatusCode.ToEnum(Globals.DownloadAttachmentStatusCodes.NoAccess);

                        var url = context.Request.Url.PathAndQuery.Trim().ToLower();
                        var fullPath = context.Request.Url.ToString().ToLower();
                        var authority = fullPath.Replace(url, "");

                        var redirectUrl =
                            string.Format("~/Account/Login.aspx?ReturnUrl={0}{1}", authority, context.Server.UrlEncode(url));

                        switch(statusCode)
                        {
                            case Globals.DownloadAttachmentStatusCodes.InvalidAttachmentId:
                                context.Response.Write("<h1>Attachment Not Found.</h1>  It may have been deleted from the server.");
                                break;
                            case Globals.DownloadAttachmentStatusCodes.AuthenticationRequired:
                                context.Response.Redirect(redirectUrl);
                                break;
                            case Globals.DownloadAttachmentStatusCodes.ProjectOrIssueDisabled:
                                context.Response.Write("<h1>Attachment Not Found.</h1>  It may have been deleted from the server.");
                                break;
                            case Globals.DownloadAttachmentStatusCodes.NoAccess:
                                context.Response.Write("<h1>Access Denied.</h1>  You do not have proper permissions to access this Attachment.");
                                break;
                            default:
                                throw new ArgumentOutOfRangeException();
                        }
                    }
                }
            }

            // End the response
            context.Response.End();
        }

        #endregion
    }

}