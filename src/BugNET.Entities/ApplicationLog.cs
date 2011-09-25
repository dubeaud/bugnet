using System;

namespace BugNET.Entities
{
    /// <summary>
    /// Summary description for ApplicationLog
    /// </summary>
    public class ApplicationLog
    {
        #region Private Variables
        private int _Id;
        private DateTime _Date;
        private string _Thread;
        private string _Level;
        private string _User;
        private string _Logger;
        private string _Message;
        private string _Exception;      
        #endregion

        /// <summary>
        /// Initializes a new instance of the <see cref="T:ApplicationLog"/> class.
        /// </summary>
        /// <param name="id">The id.</param>
        /// <param name="date">The date.</param>
        /// <param name="thread">The thread.</param>
        /// <param name="level">The level.</param>
        /// <param name="user">The user.</param>
        /// <param name="logger">The logger.</param>
        /// <param name="message">The message.</param>
        /// <param name="exception">The exception.</param>
        public ApplicationLog(int id, DateTime date, string thread,string level,string user,string logger,string message,string exception)
        {
            _Id = id;
            _Date = date;
            _Thread = thread;
            _Level = level;
            _User = user;
            _Logger = logger;
            _Message = message;
            _Exception = exception;
        }

        /// <summary>
        /// Gets the id.
        /// </summary>
        /// <value>The id.</value>
        public int Id
        {

            get { return _Id; }
            set { _Id = value; }
        }

        /// <summary>
        /// Gets the date.
        /// </summary>
        /// <value>The date.</value>
        public DateTime Date
        {
            get{return _Date;}
        }

        /// <summary>
        /// Gets the thread.
        /// </summary>
        /// <value>The thread.</value>
        public string Thread
        {
            get { return _Thread; }
        }

        /// <summary>
        /// Gets the level.
        /// </summary>
        /// <value>The level.</value>
        public string Level
        {
            get { return _Level; }
        }

        /// <summary>
        /// Gets the user.
        /// </summary>
        /// <value>The user.</value>
        public string User
        {
            get { return _User; }
        }

        /// <summary>
        /// Gets the logger.
        /// </summary>
        /// <value>The logger.</value>
        public string Logger
        {
            get { return _Logger; }
        }

        /// <summary>
        /// Gets the message.
        /// </summary>
        /// <value>The message.</value>
        public string Message
        {
            get { return _Message; }
        }

        /// <summary>
        /// Gets the exception.
        /// </summary>
        /// <value>The exception.</value>
        public string Exception
        {
            get { return _Exception; }
        }
        
       
    }
    
}