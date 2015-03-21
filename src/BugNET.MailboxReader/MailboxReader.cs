using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using BugNET.BLL;
using BugNET.BLL.Notifications;
using BugNET.Common;
using BugNET.Entities;
using HtmlAgilityPack;
using LumiSoft.Net.Log;
using LumiSoft.Net.MIME;
using LumiSoft.Net.Mail;
using LumiSoft.Net.POP3.Client;
using log4net;

namespace BugNET.MailboxReader
{
    /// <summary>
    /// The second version of the mailbox reader.
    /// </summary>
    public class MailboxReader
    {
        static readonly ILog Log = LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

        MailboxReaderConfig Config { get; set; }

        /// <summary>
        /// Initializes a new instance of the <see cref="MailboxReader"/> class.
        /// </summary>
        /// <param name="configuration">Options to configure the mail reader</param>
        public MailboxReader(IMailboxReaderConfig configuration)
        {
            Config = configuration as MailboxReaderConfig;

            if (configuration == null) throw new ArgumentNullException("configuration");
        }

        /// <summary>
        /// Reads the mail.
        /// </summary>
        public MailboxReaderResult ReadMail()
        {
            var result = new MailboxReaderResult();
            IList<Project> projects = new List<Project>();

            LogInfo("MailboxReader: Begin read mail.");

            try
            {
                using (var pop3Client = new POP3_Client())
                {
                    // configure the logger
                    pop3Client.Logger = new Logger();
                    pop3Client.Logger.WriteLog += LogPop3Client;

                    // connect to the server
                    pop3Client.Connect(Config.Server, Config.Port, Config.UseSsl);

                    // authenticate
                    pop3Client.Login(Config.Username, Config.Password);

                    // process the messages on the server
                    foreach (POP3_ClientMessage message in pop3Client.Messages)
                    {
                        var mailHeader = Mail_Message.ParseFromByte(message.HeaderToByte());

                        if (mailHeader != null)
                        {
                            var messageFrom = string.Empty;

                            if (mailHeader.From.Count > 0)
                            {
                                messageFrom = string.Join("; ", mailHeader.From.ToList().Select(p => p.Address).ToArray()).Trim();
                            }

                            var recipients = mailHeader.To.Mailboxes.Select(mailbox => mailbox.Address).ToList();

                            if (mailHeader.Cc != null)
                            {
                                recipients.AddRange(mailHeader.Cc.Mailboxes.Select(mailbox => mailbox.Address));
                            }

                            if (mailHeader.Bcc != null)
                            {
                                recipients.AddRange(mailHeader.Bcc.Mailboxes.Select(mailbox => mailbox.Address));
                            }

                            // loop through the mailboxes
                            foreach (var address in recipients)
                            {
                                var pmbox = ProjectMailboxManager.GetByMailbox(address);

                                // cannot find the mailbox skip the rest
                                if (pmbox == null)
                                {
                                    LogWarning(string.Format("MailboxReader: could not find project mailbox: {0} skipping.", address));
                                    continue;
                                }

                                var project = projects.FirstOrDefault(p => p.Id == pmbox.ProjectId);

                                if (project == null)
                                {
                                    project = ProjectManager.GetById(pmbox.ProjectId);

                                    // project is disabled skip
                                    if (project.Disabled)
                                    {
                                        LogWarning(string.Format("MailboxReader: Project {0} - {1} is flagged as disabled skipping.", project.Id, project.Code));
                                        continue;
                                    }

                                    projects.Add(project);
                                }

                                var entry = new MailboxEntry
                                {
                                    Title = mailHeader.Subject.Trim(),
                                    From = messageFrom,
                                    ProjectMailbox = pmbox,
                                    Date = mailHeader.Date,
                                    Project = project,
                                    Content = "Email Body could not be parsed."
                                };

                                var mailbody = Mail_Message.ParseFromByte(message.MessageToByte());

                                if (string.IsNullOrEmpty(mailbody.BodyHtmlText)) // no html must be text
                                {
                                    entry.Content = mailbody.BodyText.Replace("\n\r", "<br/>").Replace("\r\n", "<br/>").Replace("\r", "");
                                }
                                else
                                {
                                    //TODO: Enhancements could include regular expressions / string matching or not matching 
                                    // for particular strings values in the subject or body.
                                    // strip the <body> out of the message (using code from below)
                                    var bodyExtractor = new Regex("<body.*?>(?<content>.*)</body>", RegexOptions.IgnoreCase | RegexOptions.Singleline);
                                    var match = bodyExtractor.Match(mailbody.BodyHtmlText);

                                    var emailContent = match.Success && match.Groups["content"] != null
                                        ? match.Groups["content"].Value
                                        : mailbody.BodyHtmlText;

                                    entry.Content = emailContent.Replace("&lt;", "<").Replace("&gt;", ">");
                                    entry.IsHtml = true;
                                }

                                if (Config.ProcessAttachments && project.AllowAttachments)
                                {
                                    foreach (var attachment in mailbody.GetAttachments(Config.ProcessInlineAttachedPictures).Where(p => p.ContentType != null))
                                    {
                                        entry.MailAttachments.Add(attachment);
                                    }
                                }

                                //save this message
                                Issue issue = SaveMailboxEntry(entry);

                                //send notifications for the new issue
                                SendNotifications(issue);

                                // add the entry if the save did not throw any exceptions
                                result.MailboxEntries.Add(entry);

                                LogInfo(string.Format(
                                    "MailboxReader: Message #{0} processing finished, found [{1}] attachments, total saved [{2}].",
                                    message.SequenceNumber,
                                    entry.MailAttachments.Count, entry.AttachmentsSavedCount));

                                // delete the message?.
                                if (!Config.DeleteAllMessages) continue;

                                try
                                {
                                    message.MarkForDeletion();
                                }
                                catch (Exception)
                                {

                                }
                            }
                        }
                        else
                        {
                            LogWarning(string.Format("pop3Client: Message #{0} header could not be parsed.", message.SequenceNumber));
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                LogException(ex);
                result.LastException = ex;
                result.Status = ResultStatuses.FailedWithException;
            }

            LogInfo("MailboxReader: End read mail.");

            return result;
        }

        /// <summary>
        /// Logs an exception.
        /// </summary>
        /// <param name="ex">The exception.</param>
        /// <returns></returns>
        static void LogException(Exception ex)
        {
            if (Log == null) return;

            if (Log.IsErrorEnabled)
                Log.Error("Mailbox Reader Error", ex);
        }

        /// <summary>
        /// Logs an information message
        /// </summary>
        /// <param name="message">The message to log</param>
        static void LogInfo(string message)
        {
            if (Log == null) return;

            if (Log.IsInfoEnabled)
                Log.Info(message);
        }

        /// <summary>
        /// Logs a warning message
        /// </summary>
        /// <param name="message"></param>
        static void LogWarning(string message)
        {
            if (Log == null) return;

            if (Log.IsWarnEnabled)
                Log.Warn(message);
        }

        /// <summary>
        /// Saves the mailbox entry.
        /// </summary>
        /// <param name="entry">The entry to be saved</param>
        Issue SaveMailboxEntry(MailboxEntry entry)
        {
            try
            {
                //load template 
                var body = string.Format("<div >Sent by:{1} on: {2}<br/>{0}</div>", entry.Content.Trim(), entry.From, entry.Date);

                if (Config.BodyTemplate.Trim().Length > 0)
                {
                    var data = new Dictionary<string, object> { { "MailboxEntry", entry } };
                    body = NotificationManager.GenerateNotificationContent(Config.BodyTemplate, data);
                }

                var projectId = entry.ProjectMailbox.ProjectId;

                // try to find if the creator is valid user in the project, otherwise take
                // the user defined in the mailbox config
                var creator = Config.ReportingUserName;
                var users = UserManager.GetUsersByProjectId(projectId);
                var emails = entry.From.Split(';').Select( e => e.Trim().ToLower());
                var user = users.Find(x => emails.Contains(x.Email.ToLower()));
                if (user != null)
                    creator = user.UserName;

                var mailIssue = IssueManager.GetDefaultIssueByProjectId(
                    projectId,
                    entry.Title.Trim(),
                    body.Trim(),
                    entry.ProjectMailbox.IssueTypeId,
                    entry.ProjectMailbox.AssignToUserName,
                    creator);

                if (!IssueManager.SaveOrUpdate(mailIssue)) return null;

                entry.IssueId = mailIssue.Id;
                entry.WasProcessed = true;

                var project = ProjectManager.GetById(projectId);

                var projectFolderPath = Path.Combine(Config.UploadsFolderPath, project.UploadPath);

                var doc = new HtmlDocument();
                doc.LoadHtml(mailIssue.Description); // load the issue body to we can process it for inline images (if exist)

                //If there is an attached file present then add it to the database 
                //and copy it to the directory specified in the web.config file
                foreach (MIME_Entity mimeEntity in entry.MailAttachments)
                {
                    string fileName;
                    var isInline = false;
                    var contentType = mimeEntity.ContentType.Type.ToLower();

                    var attachment = new IssueAttachment
                        {
                            Id = 0,
                            Description = "File attached by mailbox reader",
                            DateCreated = DateTime.Now,
                            ContentType = mimeEntity.ContentType.TypeWithSubtype,
                            CreatorDisplayName = Config.ReportingUserName,
                            CreatorUserName = Config.ReportingUserName,
                            IssueId = mailIssue.Id,
                            ProjectFolderPath = projectFolderPath
                        };

                    switch (contentType)
                    {
                        case "application":
                            attachment.Attachment = ((MIME_b_SinglepartBase)mimeEntity.Body).Data;
                            break;
                        case "attachment":
                        case "image":
                        case "video":
                        case "audio":

                            attachment.Attachment = ((MIME_b_SinglepartBase)mimeEntity.Body).Data;
                            break;
                        case "message":

                            // we need to pull the actual email message out of the entity, and strip the "content type" out so that
                            // email programs will read the file properly
                            var messageBody = mimeEntity.ToString().Replace(mimeEntity.Header.ToString(), "");
                            if (messageBody.StartsWith("\r\n"))
                            {
                                messageBody = messageBody.Substring(2);
                            }

                            attachment.Attachment = Encoding.UTF8.GetBytes(messageBody);

                            break;
                        default:
                            LogWarning(string.Format("MailboxReader: Attachment type could not be processed {0}", mimeEntity.ContentType.Type));
                            break;
                    }

                    if (contentType.Equals("attachment")) // this is an attached email
                    {
                        fileName = mimeEntity.ContentDisposition.Param_FileName;
                    }
                    else if (contentType.Equals("message")) // message has no filename so we create one
                    {
                        fileName = string.Format("Attached_Message_{0}.eml", entry.AttachmentsSavedCount);
                    }
                    else
                    {
                        isInline = true;
                        fileName = string.IsNullOrWhiteSpace(mimeEntity.ContentType.Param_Name) ?
                            string.Format("untitled.{0}", mimeEntity.ContentType.SubType) :
                            mimeEntity.ContentType.Param_Name;
                    }

                    attachment.FileName = fileName;

                    var saveFile = IsAllowedFileExtension(fileName);
                    var fileSaved = false;

                    // can we save the file?
                    if (saveFile)
                    {
                        fileSaved = IssueAttachmentManager.SaveOrUpdate(attachment);

                        if (fileSaved)
                        {
                            entry.AttachmentsSavedCount++;
                        }
                        else
                        {
                            LogWarning("MailboxReader: Attachment could not be saved, please see previous logs");
                        }
                    }

                    if (!entry.IsHtml || !isInline) continue;

                    if (string.IsNullOrWhiteSpace(mimeEntity.ContentID)) continue;

                    var contentId = mimeEntity.ContentID.Replace("<", "").Replace(">", "").Replace("[", "").Replace("]", "");

                    // this is pretty greedy but since people might be sending screenshots I doubt they will send in dozens of images
                    // embedded in the email.  one would hope
                    foreach (var node in doc.DocumentNode.SelectNodes(XpathElementCaseInsensitive("img")).ToList())
                    {
                        var attr = node.Attributes.FirstOrDefault(p => p.Name.ToLowerInvariant() == "src");// get the src attribute

                        if (attr == null) continue; // image has no src attribute
                        if (!attr.Value.Contains(contentId)) continue; // is the attribute value the content id?

                        // swap out the content of the parent node html will our link to the image
                        var anchor = string.Format("<span class='inline-mail-attachment'>Inline Attachment: <a href='DownloadAttachment.axd?id={0}' target='_blank'>{1}</a></span>", attachment.Id, fileName);

                        // for each image in the body if the file was saved swap out the inline link for a link to the saved attachment
                        // otherwise blank out the content link so we don't get a missing image link
                        node.ParentNode.InnerHtml = fileSaved ? anchor : "";
                    }

                    mailIssue.Description = doc.DocumentNode.InnerHtml;
                    mailIssue.LastUpdateUserName = mailIssue.OwnerUserName;
                    mailIssue.LastUpdate = DateTime.Now;

                    IssueManager.SaveOrUpdate(mailIssue);
                }

                return mailIssue;
            }
            catch (Exception ex)
            {
                LogException(ex);
                throw;
            }
        }

        /// <summary>
        /// Send notifications for the new issue
        /// </summary>
        /// <param name="issue">The issue generated from the email</param>
        void SendNotifications(Issue issue)
        {
            if (issue == null)
            {
                return;
            }

            List<DefaultValue> defValues = IssueManager.GetDefaultIssueTypeByProjectId(issue.ProjectId);
            DefaultValue selectedValue = defValues.FirstOrDefault();

            if (selectedValue != null)
            {
                if (selectedValue.OwnedByNotify)
                {
                    var oUser = UserManager.GetUser(issue.OwnerUserName);
                    if (oUser != null)
                    {
                        var notify = new IssueNotification { IssueId = issue.Id, NotificationUsername = oUser.UserName };
                        IssueNotificationManager.SaveOrUpdate(notify);
                    }
                }

                if (selectedValue.AssignedToNotify)
                {
                    var oUser = UserManager.GetUser(issue.AssignedUserName);
                    if (oUser != null)
                    {
                        var notify = new IssueNotification { IssueId = issue.Id, NotificationUsername = oUser.UserName };
                        IssueNotificationManager.SaveOrUpdate(notify);
                    }
                }
            }

            //send issue notifications
            IssueNotificationManager.SendIssueAddNotifications(issue.Id);
        }

        /// <summary>
        /// Check if the file has an allowed file extension
        /// </summary>
        /// <param name="fileName">The file to check</param>
        /// <returns>True if the file is allowed, otherwise false</returns>
        bool IsAllowedFileExtension(string fileName)
        {
            fileName = fileName.Trim().ToLower();
            var allowedExtensions = Config.AllowedFileExtensions.ToLower().Trim();

            if (allowedExtensions.Length.Equals(0)) return false; // nothing saved so allow nothing

            var allowedFileTypes = allowedExtensions.Split(new[] { ';' }, StringSplitOptions.RemoveEmptyEntries);

            // allow all types
            if (allowedFileTypes.FirstOrDefault(p => p == "*.*") != null) return true;
            if (allowedFileTypes.FirstOrDefault(p => p == ".") != null) return true;

            // match extension in allowed extensions list
            var allowed = allowedFileTypes.Select(allowedFileType => allowedFileType.Replace("*", "")).Any(fileType => fileName.EndsWith(fileType));

            if (!allowed)
            {
                LogWarning(string.Format("MailboxReader: Attachment {0} was not one of the allowed attachment extensions {1} skipping.", fileName, Config.AllowedFileExtensions.ToLower()));
            }

            return allowed;
        }

        /// <summary>
        /// change the xpath element name to all uppercase
        /// </summary>
        /// <param name="elementName">The element name</param>
        /// <returns></returns>
        static string XpathElementCaseInsensitive(string elementName)
        {
            //*[translate(name(), 'abc','ABC')='ABC']"
            return string.Format("//*[translate(name(), '{0}', '{1}') = '{1}']", elementName.ToLower(), elementName.ToUpper());
        }

        /// <summary>
        /// Log the pop 3 client events
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        static void LogPop3Client(object sender, WriteLogEventArgs e)
        {
            try
            {
                var message = "";

                switch (e.LogEntry.EntryType)
                {
                    case LogEntryType.Read:
                        message = string.Format("pop3Client: {0} >> {1}", ObjectToString(e.LogEntry.RemoteEndPoint), e.LogEntry.Text);
                        break;
                    case LogEntryType.Write:
                        message = string.Format("pop3Client: {0} << {1}", ObjectToString(e.LogEntry.RemoteEndPoint), e.LogEntry.Text);
                        break;
                    case LogEntryType.Text:
                        message = string.Format("pop3Client: {0} xx {1}", ObjectToString(e.LogEntry.RemoteEndPoint), e.LogEntry.Text);
                        break;
                }

                LogInfo(message);
            }
            catch (Exception ex)
            {
                LogException(ex);
            }
        }

        /// <summary>
        /// Calls obj.ToSting() if o is not null, otherwise returns "".
        /// </summary>
        /// <param name="o">Object.</param>
        /// <returns>Returns obj.ToSting() if o is not null, otherwise returns "".</returns>
        static string ObjectToString(object o)
        {
            return o == null ? "" : o.ToString();
        }
    }
}