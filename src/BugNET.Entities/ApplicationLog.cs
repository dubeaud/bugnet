using System;

namespace BugNET.Entities
{
    /// <summary>
    /// Summary description for ApplicationLog
    /// </summary>
    public class ApplicationLog
    {
        /// <summary>
        /// Gets the id.
        /// </summary>
        /// <value>The id.</value>
        public int Id { get; set; }

        /// <summary>
        /// Gets the date.
        /// </summary>
        /// <value>The date.</value>
        public DateTime Date { get; set; }

        /// <summary>
        /// Gets the thread.
        /// </summary>
        /// <value>The thread.</value>
        public string Thread { get; set; }

        /// <summary>
        /// Gets the level.
        /// </summary>
        /// <value>The level.</value>
        public string Level { get; set; }

        /// <summary>
        /// Gets the user.
        /// </summary>
        /// <value>The user.</value>
        public string User { get; set; }

        /// <summary>
        /// Gets the logger.
        /// </summary>
        /// <value>The logger.</value>
        public string Logger { get; set; }

        /// <summary>
        /// Gets the message.
        /// </summary>
        /// <value>The message.</value>
        public string Message { get; set; }

        /// <summary>
        /// Gets the exception.
        /// </summary>
        /// <value>The exception.</value>
        public string Exception { get; set; }
    }
}