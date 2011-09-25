using System;
using System.Collections.Generic;
using System.IO;
using System.Net.Mail;
using System.Text.RegularExpressions;
using BugNET.BLL;
using BugNET.MailboxReader.POP3Client;
using BugNET.Entities;
using log4net;

namespace BugNET.MailboxReader
{
    /// <summary>
    /// The second version of the mailbox reader.
    /// </summary>
    public class MailboxReader
    {
        string _Server;
        string _Username;
        string _Password;
        bool _ProcessInlineAttachedPictures;
        bool _DeleteAllMessages;
        string _ReportingUserName;
        string _BodyTemplate;
        int _Port;
        bool _UseSSL;
        bool _ProcessAttachments;

        private static readonly ILog Log = LogManager.GetLogger(typeof(MailboxReader));

        /// <summary>
        /// Processes the exception.
        /// </summary>
        /// <param name="ex">The exception.</param>
        /// <returns></returns>
        private ApplicationException ProcessException(Exception ex)
        {

            if (Log.IsErrorEnabled)
                Log.Error("Mailbox Reader Error", ex);

            return new ApplicationException(LoggingManager.GetErrorMessageResource("MailboxReaderError"), ex);
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="MailboxReader2"/> class.
        /// </summary>
        /// <param name="server">The server.</param>
        /// <param name="userName">Name of the user.</param>
        /// <param name="password">The password.</param>
        /// <param name="processInlineAttachedPictures">if set to <c>true</c> [process inline attached pictures].</param>
        /// <param name="bodyTemplate">The body template.</param>
        /// <param name="deleteAllMessages">if set to <c>true</c> [delete all messages].</param>
        /// <param name="reportingUserName">Name of the reporting user.</param>
        public MailboxReader(string server,int port,bool useSSL, string userName, string password, bool processInlineAttachedPictures, string bodyTemplate,
           bool deleteAllMessages, string reportingUserName, bool processAttachments)
        {
            _Server = server;
            _Port = port;
            _UseSSL = useSSL;
            _Username = userName;
            _Password = password;
            _ProcessInlineAttachedPictures = processInlineAttachedPictures;
            _BodyTemplate = bodyTemplate;
            _DeleteAllMessages = deleteAllMessages;
            _ReportingUserName = reportingUserName;
            _ProcessAttachments = processAttachments;
        }

        /// <summary>
        /// Saves the mailbox entry.
        /// </summary>
        /// <param name="entry">The entry.</param>
        public void SaveMailboxEntry(MailboxEntry entry)
        {
            try
            {
                // TODO Should use XSLT templates BGN-1591
                string body = string.Format(this._BodyTemplate, entry.Content.ToString().Trim(), entry.From, entry.Date.ToString());
                int projectId = entry.ProjectMailbox.ProjectId;

                Issue MailIssue = IssueManager.GetDefaultIssueByProjectId(projectId, entry.Title.Trim(), body.Trim(), entry.ProjectMailbox.AssignToUserName, this._ReportingUserName);

                if (IssueManager.SaveIssue(MailIssue))
                {
                    //If there is an attached file present then add it to the database 
                    //and copy it to the directory specified in the web.config file
                    foreach (Attachment attMail in entry.MailAttachments)
                    {
                        byte[] attachmentBytes = new byte[attMail.ContentStream.Length];                        
                        this.ReadWholeArray(attMail.ContentStream, attachmentBytes);
                       
                        IssueAttachment att = new IssueAttachment(0,
                            MailIssue.Id,
                            this._ReportingUserName,
                            this._ReportingUserName,
                            DateTime.Now,
                            attMail.ContentDisposition.FileName,
                            attMail.ContentType.ToString(),
                            attachmentBytes,
                            attachmentBytes.Length, "Attached via email");
                        if (!IssueAttachmentManager.SaveIssueAttachment(att))
                            if (Log.IsWarnEnabled) Log.Warn("Attachment was not added via mailbox reader");
                    }                    
                }
            }
            catch (Exception ex)
            {
                throw ProcessException(ex);
            }
        }

        /// <summary>
        /// Reads the whole array.
        /// </summary>
        /// <param name="stream">The stream.</param>
        /// <param name="data">The data.</param>
        private void ReadWholeArray(Stream stream, byte[] data)
        {
            int offset = 0;
            int remaining = data.Length;
            while (remaining > 0)
            {
                int read = stream.Read(data, offset, remaining);
                if (read <= 0)
                    throw new EndOfStreamException
                        (String.Format("End of stream reached with {0} bytes left to read", remaining));
                remaining -= read;
                offset += read;
            }
        }

        /// <summary>
        /// Reads the mail.
        /// </summary>
        public void ReadMail()
        {
            Pop3MimeClient mailClient = new Pop3MimeClient(_Server, _Port, _UseSSL, _Username, _Password);

            try
            {
                mailClient.Connect();
                List<int> messageIds;
                mailClient.GetEmailIdList(out messageIds);
            
                for (int i = 0; i < messageIds.Count; i++)
                {
                    bool messageWasProcessed = false;
                    RxMailMessage message;

                    if (mailClient.GetEmail(messageIds[i], out message))
                    {
                        string messageFrom = string.Empty;

                        if (message.From.Address.Length > 0)
                        {
                            messageFrom = message.From.Address;
                        }

                        List<string> recipients = new List<string>();

                        foreach(MailAddress address in message.To)
                            recipients.Add(address.Address);
                        foreach (MailAddress address in message.CC)
                            recipients.Add(address.Address);
                        foreach (MailAddress address in message.Bcc)
                            recipients.Add(address.Address);

                        foreach (string mailbox in recipients)
                        {
                            ProjectMailbox pmbox = ProjectMailboxManager.GetProjectByMailbox(mailbox);
                            if (pmbox != null)
                            {
                                MailboxEntry entry = new MailboxEntry();
                                Project project = ProjectManager.GetProjectById(pmbox.ProjectId);

                                //TODO: Enhancements could include regex / string matching or not matching 
                                //for particular strings values in the subject or body.
                                entry.Title = message.Subject.Trim();
                                entry.From = messageFrom;
                                entry.ProjectMailbox = pmbox;
                                entry.Date = message.DeliveryDate;

                                if (message.Entities.Count > 0)
                                {
                                    //find if there is an html version.                                  
                                    if (message.Entities.FindAll(m => m.IsBodyHtml).Count > 0)
                                    {
                                        List<RxMailMessage> htmlMessages = message.Entities.FindAll(m => m.IsBodyHtml);
                                        if(htmlMessages.Count > 0)
                                            message = htmlMessages[0];
                                    }

                                }
                                if (!message.IsBodyHtml)
                                    entry.Content.Append(message.Body.Replace("\n", "<br />"));
                                else
                                {
                                    // Strip the <body> out of the message (using code from below)
                                    Regex bodyExtractor = new Regex("<body.*?>(?<content>.*)</body>", RegexOptions.IgnoreCase | RegexOptions.Singleline);
                                    Match match = bodyExtractor.Match(message.Body);
                                    if (match != null && match.Success && match.Groups["content"] != null)
                                    {
                                        entry.Content.Append(match.Groups["content"].Value);
                                    }
                                    else
                                    {
                                        entry.Content.Append(message.Body);
                                    }
                                }

                                if (_ProcessAttachments)
                                { 
                                    foreach (Attachment attachment in message.Attachments)
                                    {
                                        if (attachment.ContentStream != null && attachment.ContentDisposition.FileName != null && attachment.ContentDisposition.FileName.Length > 0)
                                        {
                                            entry.MailAttachments.Add(attachment);
                                        }
                                    }
                                }

                                //save this message the mark the message as processed
                                SaveMailboxEntry(entry);
                                messageWasProcessed = true;

                                //if delete all messages AND the message was processed delete the message from the server.
                                if (_DeleteAllMessages && messageWasProcessed)
                                    mailClient.DeleteEmail(i);
                            }
                            else
                            {
                                if (Log.IsWarnEnabled)
                                    Log.WarnFormat("Project Mailbox Not Found: {0}", message.To.ToString());
                            }
                        }
                    }
                   

                }
            }
            catch (Exception ex)
            {
                if (Log.IsErrorEnabled)
                    Log.Error("Mailbox Reader Error", ex);
            }
            finally
            {            
                try
                {
                    mailClient.Disconnect();
                }
                catch
                {}
            }
        }


    }
}