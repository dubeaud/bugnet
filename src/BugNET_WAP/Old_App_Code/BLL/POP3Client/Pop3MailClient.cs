// POP3 Client
// ===========
//
// copyright by Peter Huber, Singapore, 2006
// this code is provided as is, bugs are probable, free for any use at own risk, no 
// responsibility accepted. All rights, title and interest in and to the accompanying content retained.  :-)
//
// based on POP3 Client as a C# Class, by Bill Dean, http://www.codeproject.com/csharp/Pop3MailClient.asp 
// based on Retrieve Mail From a POP3 Server Using C#, by Agus Kurniawan, http://www.codeproject.com/csharp/popapp.asp 
// based on Post Office Protocol - Version 3, http://www.ietf.org/rfc/rfc1939.txt

using System;
using System.Collections.Generic;
using System.IO;
using System.Net;
using System.Net.Sockets;
using System.Net.Security;
using System.Text;


namespace BugNET.BusinessLogicLayer.POP3Client
{
    // Supporting classes and structs
    // ==============================

    /// <summary>
    /// Combines Email ID with Email UID for one email
    /// The POP3 server assigns to each message a unique Email UID, which will not change for the life time
    /// of the message and no other message should use the same.
    /// 
    /// Exceptions:
    /// Throws Pop3Exception if there is a serious communication problem with the POP3 server, otherwise
    /// 
    /// </summary>
    public struct EmailUid
    {
        /// <summary>
        /// used in POP3 commands to indicate which message (only valid in the present session)
        /// </summary>
        public int EmailId;
        /// <summary>
        /// Uid is always the same for a message, regardless of session
        /// </summary>
        public string Uid;

        /// <summary>
        /// constructor
        /// </summary>
        public EmailUid(int EmailId, string Uid)
        {
            this.EmailId = EmailId;
            this.Uid = Uid;
        }
    }


    /// <summary>
    /// If anything goes wrong within Pop3MailClient, a Pop3Exception is raised
    /// </summary>
    public class Pop3Exception : ApplicationException
    {
        /// <summary>
        /// Pop3 exception with no further explanation
        /// </summary>
        public Pop3Exception() { }
        /// <summary>
        /// Pop3 exception with further explanation
        /// </summary>
        public Pop3Exception(string ErrorMessage) : base(ErrorMessage) { }
    }


    /// <summary>
    /// A pop 3 connection goes through the following states:
    /// </summary>
    public enum Pop3ConnectionStateEnum
    {
        /// <summary>
        /// undefined
        /// </summary>
        None = 0,
        /// <summary>
        /// not connected yet to POP3 server
        /// </summary>
        Disconnected,
        /// <summary>
        /// TCP connection has been opened and the POP3 server has sent the greeting. POP3 server expects user name and password
        /// </summary>
        Authorization,
        /// <summary>
        /// client has identified itself successfully with the POP3, server has locked all messages 
        /// </summary>
        Connected,
        /// <summary>
        /// QUIT command was sent, the server has deleted messages marked for deletion and released the resources
        /// </summary>
        Closed
    }


    // Delegates for Pop3MailClient
    // ============================

    /// <summary>
    /// If POP3 Server doesn't react as expected or this code has a problem, but
    /// can continue with the execution, a Warning is called.
    /// </summary>
    /// <param name="WarningText"></param>
    /// <param name="Response">string received from POP3 server</param>
    public delegate void WarningHandler(string WarningText, string Response);


    /// <summary>
    /// Traces all the information exchanged between POP3 client and POP3 server plus some
    /// status messages from POP3 client.
    /// Helpful to investigate any problem.
    /// Console.WriteLine() can be used
    /// </summary>
    public delegate void TraceHandler(string TraceText);


    // Pop3MailClient Class
    // ====================  

    /// <summary>
    /// provides access to emails on a POP3 Server
    /// </summary>
    public class Pop3MailClient
    {

        //Events
        //------

        /// <summary>
        /// Called whenever POP3 server doesn't react as expected, but no runtime error is thrown.
        /// </summary>
        public event WarningHandler Warning;

        /// <summary>
        /// call warning event
        /// </summary>
        /// <param name="methodName">name of the method where warning is needed</param>
        /// <param name="response">answer from POP3 server causing the warning</param>
        /// <param name="warningText">explanation what went wrong</param>
        /// <param name="warningParameters"></param>
        protected void CallWarning(string methodName, string response, string warningText, params object[] warningParameters)
        {
            try
            {
                warningText = string.Format(warningText, warningParameters);
            }
            catch
            {
            }
            if (Warning != null)
            {
                Warning(methodName + ": " + warningText, response);
            }
            CallTrace("!! {0}", warningText);
        }


        /// <summary>
        /// Shows the communication between PopClient and PopServer, including warnings
        /// </summary>
        public event TraceHandler Trace;

        /// <summary>
        /// call Trace event
        /// </summary>
        /// <param name="text">string to be traced</param>
        /// <param name="parameters"></param>
        protected void CallTrace(string text, params object[] parameters)
        {
            if (Trace != null)
            {
                Trace(DateTime.Now.ToString("hh:mm:ss ") + popServer + " " + string.Format(text, parameters));
            }
        }

        /// <summary>
        /// Trace information received from POP3 server
        /// </summary>
        /// <param name="text">string to be traced</param>
        /// <param name="parameters"></param>
        protected void TraceFrom(string text, params object[] parameters)
        {
            if (Trace != null)
            {
                CallTrace("   " + string.Format(text, parameters));
            }
        }


        //Properties
        //----------

        /// <summary>
        /// Get POP3 server name
        /// </summary>
        public string PopServer
        {
            get { return popServer; }
        }
        /// <summary>
        /// POP3 server name
        /// </summary>
        protected string popServer;


        /// <summary>
        /// Get POP3 server port
        /// </summary>
        public int Port
        {
            get { return port; }
        }
        /// <summary>
        /// POP3 server port
        /// </summary>
        protected int port;


        /// <summary>
        /// Should SSL be used for connection with POP3 server ?
        /// </summary>
        public bool UseSSL
        {
            get { return useSSL; }
        }
        /// <summary>
        /// Should SSL be used for connection with POP3 server ?
        /// </summary>
        private bool useSSL;


        /// <summary>
        /// should Pop3MailClient automatically reconnect if POP3 server has dropped the 
        /// connection due to a timeout ?
        /// </summary>
        public bool IsAutoReconnect
        {
            get { return isAutoReconnect; }
            set { isAutoReconnect = value; }
        }
        private bool isAutoReconnect = false;
        //timeout has occurred, we try to perform an autoreconnect
        private bool isTimeoutReconnect = false;



        /// <summary>
        /// Get / set read timeout (miliseconds)
        /// </summary>
        public int ReadTimeout
        {
            get { return readTimeout; }
            set
            {
                readTimeout = value;
                if (pop3Stream != null && pop3Stream.CanTimeout)
                {
                    pop3Stream.ReadTimeout = readTimeout;
                }
            }
        }
        /// <summary>
        /// POP3 server read timeout
        /// </summary>
        protected int readTimeout = -1;


        /// <summary>
        /// Get owner name of mailbox on POP3 server
        /// </summary>
        public string Username
        {
            get { return username; }
        }
        /// <summary>
        /// Owner name of mailbox on POP3 server
        /// </summary>
        protected string username;


        /// <summary>
        /// Get password for mailbox on POP3 server
        /// </summary>
        public string Password
        {
            get { return password; }
        }
        /// <summary>
        /// Password for mailbox on POP3 server
        /// </summary>
        protected string password;


        /// <summary>
        /// Get connection status with POP3 server
        /// </summary>
        public Pop3ConnectionStateEnum Pop3ConnectionState
        {
            get { return pop3ConnectionState; }
        }
        /// <summary>
        /// connection status with POP3 server
        /// </summary>
        protected Pop3ConnectionStateEnum pop3ConnectionState = Pop3ConnectionStateEnum.Disconnected;


        // Methods
        // -------

        /// <summary>
        /// set POP3 connection state
        /// </summary>
        protected void setPop3ConnectionState(Pop3ConnectionStateEnum State)
        {
            pop3ConnectionState = State;
            CallTrace("   Pop3MailClient Connection State {0} reached", State);
        }

        /// <summary>
        /// throw exception if POP3 connection is not in the required state
        /// </summary>
        protected void EnsureState(Pop3ConnectionStateEnum requiredState)
        {
            if (pop3ConnectionState != requiredState)
            {
                // wrong connection state
                throw new Pop3Exception("GetMailboxStats only accepted during connection state: " + requiredState.ToString() +
                      "\n The connection to server " + popServer + " is in state " + pop3ConnectionState.ToString());
            }
        }


        //private fields
        //--------------
        /// <summary>
        /// TCP to POP3 server
        /// </summary>
        private TcpClient serverTcpConnection;
        /// <summary>
        /// Stream from POP3 server with or without SSL
        /// </summary>
        private Stream pop3Stream;
        /// <summary>
        /// Reader for POP3 message
        /// </summary>
        protected StreamReader pop3StreamReader;
        /// <summary>
        /// char 'array' for carriage return / line feed
        /// </summary>
        protected string CRLF = "\r\n";


        //public methods
        //--------------

        /// <summary>
        /// Make POP3 client ready to connect to POP3 server
        /// </summary>
        /// <param name="PopServer"><example>pop.gmail.com</example></param>
        /// <param name="Port"><example>995</example></param>
        /// <param name="useSSL">True: SSL is used for connection to POP3 server</param>
        /// <param name="Username"><example>abc@gmail.com</example></param>
        /// <param name="Password">Secret</param>
        public Pop3MailClient(string PopServer, int Port, bool useSSL, string Username, string Password)
        {
            this.popServer = PopServer;
            this.port = Port;
            this.useSSL = useSSL;
            this.username = Username;
            this.password = Password;
        }


        /// <summary>
        /// Connect to POP3 server
        /// </summary>
        public void Connect()
        {
            if (pop3ConnectionState != Pop3ConnectionStateEnum.Disconnected &&
              pop3ConnectionState != Pop3ConnectionStateEnum.Closed &&
              !isTimeoutReconnect)
            {
                CallWarning("connect", "", "Connect command received, but connection state is: " + pop3ConnectionState.ToString());
            }
            else
            {
                //establish TCP connection
                try
                {
                    CallTrace("   Connect at port {0}", port);
                    serverTcpConnection = new TcpClient(popServer, port);
                }
                catch (Exception ex)
                {
                    throw new Pop3Exception("Connection to server " + popServer + ", port " + port + " failed.\nRuntime Error: " + ex.ToString());
                }

                if (useSSL)
                {
                    //get SSL stream
                    try
                    {
                        CallTrace("   Get SSL connection");
                        pop3Stream = new SslStream(serverTcpConnection.GetStream(), false);
                        pop3Stream.ReadTimeout = readTimeout;
                    }
                    catch (Exception ex)
                    {
                        throw new Pop3Exception("Server " + popServer + " found, but cannot get SSL data stream.\nRuntime Error: " + ex.ToString());
                    }

                    //perform SSL authentication
                    try
                    {
                        CallTrace("   Get SSL authentication");
                        ((SslStream)pop3Stream).AuthenticateAsClient(popServer);
                    }
                    catch (Exception ex)
                    {
                        throw new Pop3Exception("Server " + popServer + " found, but problem with SSL Authentication.\nRuntime Error: " + ex.ToString());
                    }
                }
                else
                {
                    //create a stream to POP3 server without using SSL
                    try
                    {
                        CallTrace("   Get connection without SSL");
                        pop3Stream = serverTcpConnection.GetStream();
                        pop3Stream.ReadTimeout = readTimeout;
                    }
                    catch (Exception ex)
                    {
                        throw new Pop3Exception("Server " + popServer + " found, but cannot get data stream (without SSL).\nRuntime Error: " + ex.ToString());
                    }
                }
                //get stream for reading from pop server
                //POP3 allows only US-ASCII. The message will be translated in the proper encoding in a later step
                try
                {
                    pop3StreamReader = new StreamReader(pop3Stream, Encoding.ASCII);
                }
                catch (Exception ex)
                {
                    if (useSSL)
                    {
                        throw new Pop3Exception("Server " + popServer + " found, but cannot read from SSL stream.\nRuntime Error: " + ex.ToString());
                    }
                    else
                    {
                        throw new Pop3Exception("Server " + popServer + " found, but cannot read from stream (without SSL).\nRuntime Error: " + ex.ToString());
                    }
                }

                //ready for authorisation
                string response;
                if (!readSingleLine(out response))
                {
                    throw new Pop3Exception("Server " + popServer + " not ready to start AUTHORIZATION.\nMessage: " + response);
                }
                setPop3ConnectionState(Pop3ConnectionStateEnum.Authorization);

                //send user name
                if (!executeCommand("USER " + username, out response))
                {
                    throw new Pop3Exception("Server " + popServer + " doesn't accept username '" + username + "'.\nMessage: " + response);
                }

                //send password
                if (!executeCommand("PASS " + password, out response))
                {
                    throw new Pop3Exception("Server " + popServer + " doesn't accept password '" + password + "' for user '" + username + "'.\nMessage: " + response);
                }

                setPop3ConnectionState(Pop3ConnectionStateEnum.Connected);
            }
        }


        /// <summary>
        /// Disconnect from POP3 Server
        /// </summary>
        public void Disconnect()
        {
            if (pop3ConnectionState == Pop3ConnectionStateEnum.Disconnected ||
              pop3ConnectionState == Pop3ConnectionStateEnum.Closed)
            {
                CallWarning("disconnect", "", "Disconnect received, but was already disconnected.");
            }
            else
            {
                //ask server to end session and possibly to remove emails marked for deletion
                try
                {
                    string response;
                    if (executeCommand("QUIT", out response))
                    {
                        //server says everything is ok
                        setPop3ConnectionState(Pop3ConnectionStateEnum.Closed);
                    }
                    else
                    {
                        //server says there is a problem
                        CallWarning("Disconnect", response, "negative response from server while closing connection: " + response);
                        setPop3ConnectionState(Pop3ConnectionStateEnum.Disconnected);
                    }
                }
                finally
                {
                    //close connection
                    if (pop3Stream != null)
                    {
                        pop3Stream.Close();
                    }

                    pop3StreamReader.Close();
                }
            }
        }


        /// <summary>
        /// Delete message from server.
        /// The POP3 server marks the message as deleted.  Any future
        /// reference to the message-number associated with the message
        /// in a POP3 command generates an error.  The POP3 server does
        /// not actually delete the message until the POP3 session
        /// enters the UPDATE state.
        /// </summary>
        /// <param name="msg_number"></param>
        /// <returns></returns>
        public bool DeleteEmail(int msg_number)
        {
            EnsureState(Pop3ConnectionStateEnum.Connected);
            string response;
            if (!executeCommand("DELE " + msg_number.ToString(), out response))
            {
                CallWarning("DeleteEmail", response, "negative response for email (Id: {0}) delete request", msg_number);
                return false;
            }
            return true;
        }


        /// <summary>
        /// Get a list of all Email IDs available in mailbox
        /// </summary>
        /// <returns></returns>
        public bool GetEmailIdList(out List<int> EmailIds)
        {
            EnsureState(Pop3ConnectionStateEnum.Connected);
            EmailIds = new List<int>();

            //get server response status line
            string response;
            if (!executeCommand("LIST", out response))
            {
                CallWarning("GetEmailIdList", response, "negative response for email list request");
                return false;
            }

            //get every email id
            int EmailId;
            while (readMultiLine(out response))
            {
                if (int.TryParse(response.Split(' ')[0], out EmailId))
                {
                    EmailIds.Add(EmailId);
                }
                else
                {
                    CallWarning("GetEmailIdList", response, "first characters should be integer (EmailId)");
                }
            }
            TraceFrom("{0} email ids received", EmailIds.Count);
            return true;
        }


        /// <summary>
        /// get size of one particular email
        /// </summary>
        /// <param name="msg_number"></param>
        /// <returns></returns>
        public int GetEmailSize(int msg_number)
        {
            EnsureState(Pop3ConnectionStateEnum.Connected);
            string response;
            executeCommand("LIST " + msg_number.ToString(), out response);
            int EmailSize = 0;
            string[] responseSplit = response.Split(' ');
            if (responseSplit.Length < 2 || !int.TryParse(responseSplit[2], out EmailSize))
            {
                CallWarning("GetEmailSize", response, "'+OK int int' format expected (EmailId, EmailSize)");
            }

            return EmailSize;
        }


        /// <summary>
        /// Get a list with the unique IDs of all Email available in mailbox.
        /// 
        /// Explanation:
        /// EmailIds for the same email can change between sessions, whereas the unique Email id
        /// never changes for an email.
        /// </summary>
        /// <param name="EmailIds"></param>
        /// <returns></returns>
        public bool GetUniqueEmailIdList(out List<EmailUid> EmailIds)
        {
            EnsureState(Pop3ConnectionStateEnum.Connected);
            EmailIds = new List<EmailUid>();

            //get server response status line
            string response;
            if (!executeCommand("UIDL ", out response))
            {
                CallWarning("GetUniqueEmailIdList", response, "negative response for email list request");
                return false;
            }

            //get every email unique id
            int EmailId;
            while (readMultiLine(out response))
            {
                string[] responseSplit = response.Split(' ');
                if (responseSplit.Length < 2)
                {
                    CallWarning("GetUniqueEmailIdList", response, "response not in format 'int string'");
                }
                else if (!int.TryParse(responseSplit[0], out EmailId))
                {
                    CallWarning("GetUniqueEmailIdList", response, "first characters should be integer (Unique EmailId)");
                }
                else
                {
                    EmailIds.Add(new EmailUid(EmailId, responseSplit[1]));
                }
            }
            TraceFrom("{0} unique email ids received", EmailIds.Count);
            return true;
        }


        /// <summary>
        /// get a list with all currently available messages and the UIDs
        /// </summary>
        /// <param name="EmailIds">EmailId Uid list</param>
        /// <returns>false: server sent negative response (didn't send list)</returns>
        public bool GetUniqueEmailIdList(out SortedList<string, int> EmailIds)
        {
            EnsureState(Pop3ConnectionStateEnum.Connected);
            EmailIds = new SortedList<string, int>();

            //get server response status line
            string response;
            if (!executeCommand("UIDL", out response))
            {
                CallWarning("GetUniqueEmailIdList", response, "negative response for email list request");
                return false;
            }

            //get every email unique id
            int EmailId;
            while (readMultiLine(out response))
            {
                string[] responseSplit = response.Split(' ');
                if (responseSplit.Length < 2)
                {
                    CallWarning("GetUniqueEmailIdList", response, "response not in format 'int string'");
                }
                else if (!int.TryParse(responseSplit[0], out EmailId))
                {
                    CallWarning("GetUniqueEmailIdList", response, "first characters should be integer (Unique EmailId)");
                }
                else
                {
                    EmailIds.Add(responseSplit[1], EmailId);
                }
            }
            TraceFrom("{0} unique email ids received", EmailIds.Count);
            return true;
        }


        /// <summary>
        /// get size of one particular email
        /// </summary>
        /// <param name="msg_number"></param>
        /// <returns></returns>
        public int GetUniqueEmailId(EmailUid msg_number)
        {
            EnsureState(Pop3ConnectionStateEnum.Connected);
            string response;
            executeCommand("LIST " + msg_number.ToString(), out response);
            int EmailSize = 0;
            string[] responseSplit = response.Split(' ');
            if (responseSplit.Length < 2 || !int.TryParse(responseSplit[2], out EmailSize))
            {
                CallWarning("GetEmailSize", response, "'+OK int int' format expected (EmailId, EmailSize)");
            }

            return EmailSize;
        }


        /// <summary>
        /// Sends an 'empty' command to the POP3 server. Server has to respond with +OK
        /// </summary>
        /// <returns>true: server responds as expected</returns>
        public bool NOOP()
        {
            EnsureState(Pop3ConnectionStateEnum.Connected);
            string response;
            if (!executeCommand("NOOP", out response))
            {
                CallWarning("NOOP", response, "negative response for NOOP request");
                return false;
            }
            return true;
        }

        /// <summary>
        /// Should the raw content, the US-ASCII code as received, be traced
        /// GetRawEmail will switch it on when it starts and off once finished
        /// 
        /// Inheritors might use it to get the raw email
        /// </summary>
        protected bool isTraceRawEmail = false;


        /// <summary>
        /// contains one MIME part of the email in US-ASCII, needs to be translated in .NET string (Unicode)
        /// contains the complete email in US-ASCII, needs to be translated in .NET string (Unicode)
        /// For speed reasons, reuse StringBuilder
        /// </summary>
        protected StringBuilder RawEmailSB;


        /// <summary>
        /// Reads the complete text of a message
        /// </summary>
        /// <param name="MessageNo">Email to retrieve</param>
        /// <param name="EmailText">ASCII string of complete message</param>
        /// <returns></returns>
        public bool GetRawEmail(int MessageNo, out string EmailText)
        {
            //send 'RETR int' command to server
            if (!SendRetrCommand(MessageNo))
            {
                EmailText = null;
                return false;
            }

            //get the lines
            string response;
            int LineCounter = 0;
            //empty StringBuilder
            if (RawEmailSB == null)
            {
                RawEmailSB = new StringBuilder(100000);
            }
            else
            {
                RawEmailSB.Length = 0;
            }
            isTraceRawEmail = true;
            while (readMultiLine(out response))
            {
                LineCounter += 1;
            }
            EmailText = RawEmailSB.ToString();
            TraceFrom("email with {0} lines,  {1} chars received", LineCounter.ToString(), EmailText.Length);
            return true;
        }


        /// <summary>
        /// Unmark any emails from deletion. The server only deletes email really
        /// once the connection is properly closed.
        /// </summary>
        /// <returns>true: emails are unmarked from deletion</returns>
        public bool UndeleteAllEmails()
        {
            EnsureState(Pop3ConnectionStateEnum.Connected);
            string response;
            return executeCommand("RSET", out response);
        }


        /// <summary>
        /// Get mailbox statistics
        /// </summary>
        public bool GetMailboxStats(out int NumberOfMails, out int MailboxSize)
        {
            EnsureState(Pop3ConnectionStateEnum.Connected);

            //interpret response
            string response;
            NumberOfMails = 0;
            MailboxSize = 0;
            if (executeCommand("STAT", out response))
            {
                //got a positive response
                string[] responseParts = response.Split(' ');
                if (responseParts.Length < 2)
                {
                    //response format wrong
                    throw new Pop3Exception("Server " + popServer + " sends illegally formatted response." +
                      "\nExpected format: +OK int int" +
                      "\nReceived response: " + response);
                }
                NumberOfMails = int.Parse(responseParts[1]);
                MailboxSize = int.Parse(responseParts[2]);
                return true;
            }
            return false;
        }


        /// <summary>
        /// Send RETR command to POP 3 server to fetch one particular message
        /// </summary>
        /// <param name="MessageNo">ID of message required</param>
        /// <returns>false: negative server respond, message not delivered</returns>
        protected bool SendRetrCommand(int MessageNo)
        {
            EnsureState(Pop3ConnectionStateEnum.Connected);
            // retrieve mail with message number
            string response;
            if (!executeCommand("RETR " + MessageNo.ToString(), out response))
            {
                CallWarning("GetRawEmail", response, "negative response for email (ID: {0}) request", MessageNo);
                return false;
            }
            return true;
        }


        //Helper methods
        //--------------

        /// <summary>
        /// sends the 4 letter command to POP3 server (adds CRLF) and waits for the
        /// response of the server
        /// </summary>
        /// <param name="command">command to be sent to server</param>
        /// <param name="response">answer from server</param>
        /// <returns>false: server sent negative acknowledge, i.e. server could not execute command</returns>
        private bool executeCommand(string command, out string response)
        {
            //send command to server
            byte[] commandBytes = System.Text.Encoding.ASCII.GetBytes((command + CRLF).ToCharArray());
            CallTrace("Tx '{0}'", command);
            bool isSupressThrow = false;
            try
            {
                pop3Stream.Write(commandBytes, 0, commandBytes.Length);
            }
            catch (IOException ex)
            {
                //Unable to write data to the transport connection. Check if reconnection should be tried
                isSupressThrow = executeReconnect(ex, command, commandBytes);
                if (!isSupressThrow)
                {
                    throw;
                }
            }
            pop3Stream.Flush();

            //read response from server
            response = null;
            try
            {
                response = pop3StreamReader.ReadLine();
            }
            catch (IOException ex)
            {
                //Unable to write data to the transport connection. Check if reconnection should be tried
                isSupressThrow = executeReconnect(ex, command, commandBytes);
                if (isSupressThrow)
                {
                    //wait for response one more time
                    response = pop3StreamReader.ReadLine();
                }
                else
                {
                    throw;
                }
            }
            if (response == null)
            {
                isSupressThrow = executeReconnect(new IOException("Timeout", new SocketException(10053)), command, commandBytes);
                if (isSupressThrow)
                {
                    //wait for response one more time
                    response = pop3StreamReader.ReadLine();
                }
                if (response == null)
                {
                    throw new Pop3Exception("Server " + popServer + " has not responded, timeout has occurred.");
                }
            }
            CallTrace("Rx '{0}'", response);
            return (response.Length > 0 && response[0] == '+');
        }


        /// <summary>
        /// Reconnect, if there is a timeout exception and isAutoReconnect is true
        /// </summary>
        private bool executeReconnect(IOException ex, string command, byte[] commandBytes)
        {
            if (ex.InnerException != null && ex.InnerException is SocketException)
            {
                //SocketException
                SocketException innerEx = (SocketException)ex.InnerException;
                if (innerEx.ErrorCode == 10053)
                {
                    //probably timeout: An established connection was aborted by the software in your host machine.
                    CallWarning("ExecuteCommand", "", "probably timeout occurred");
                    if (isAutoReconnect)
                    {
                        //try to reconnect and send one more time
                        isTimeoutReconnect = true;
                        try
                        {
                            CallTrace("   try to auto reconnect");
                            Connect();

                            CallTrace("   reconnect successful, try to resend command");
                            CallTrace("Tx '{0}'", command);
                            pop3Stream.Write(commandBytes, 0, commandBytes.Length);
                            pop3Stream.Flush();
                            return true;
                        }
                        finally
                        {
                            isTimeoutReconnect = false;
                        }
                    }
                }
            }
            return false;
        }


        /// <summary>
        /// read single line response from POP3 server. 
        /// <example>Example server response: +OK asdfkjahsf</example>
        /// </summary>
        /// <param name="response">response from POP3 server</param>
        /// <returns>true: positive response</returns>
        protected bool readSingleLine(out string response)
        {
            response = null;
            try
            {
                response = pop3StreamReader.ReadLine();
            }
            catch (Exception ex)
            {
                string s = ex.Message;
            }
            if (response == null)
            {
                throw new Pop3Exception("Server " + popServer + " has not responded, timeout has occurred.");
            }
            CallTrace("Rx '{0}'", response);
            return (response.Length > 0 && response[0] == '+');
        }


        /// <summary>
        /// read one line in multiline mode from the POP3 server. 
        /// </summary>
        /// <param name="response">line received</param>
        /// <returns>false: end of message</returns>
        /// <returns></returns>
        protected bool readMultiLine(out string response)
        {
            response = null;
            response = pop3StreamReader.ReadLine();
            if (response == null)
            {
                throw new Pop3Exception("Server " + popServer + " has not responded, probably timeout has occurred.");
            }
            if (isTraceRawEmail)
            {
                //collect all responses as received
                RawEmailSB.Append(response + CRLF);
            }
            //check for byte stuffing, i.e. if a line starts with a '.', another '.' is added, unless
            //it is the last line
            if (response.Length > 0 && response[0] == '.')
            {
                if (response == ".")
                {
                    //closing line found
                    return false;
                }
                //remove the first '.'
                response = response.Substring(1, response.Length - 1);
            }
            return true;
        }

    }
}
