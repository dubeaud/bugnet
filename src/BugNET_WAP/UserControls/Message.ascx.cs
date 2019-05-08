using System;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BugNET.UserControls
{
    public partial class Message : UserControl
    {
        #region MessageType enum

        /// <summary>
        /// Message Type Enumeration
        /// </summary>
        public enum MessageType
        {
            /// <summary>
            /// None
            /// </summary>
            None = 0,

            /// <summary>
            /// Information Message
            /// </summary>
            Information = 1,

            /// <summary>
            /// Warning Message
            /// </summary>
            Warning = 2,

            /// <summary>
            /// Error Message
            /// </summary>
            Error = 3,

            /// <summary>
            /// Success Message
            /// </summary>
            Success = 4
        }

        #endregion

        private MessageType _messageType;

        public bool ShowStatic { get; internal set; }

        /// <summary>
        /// Gets or sets the type of the icon.
        /// </summary>
        /// <value>The type of the icon.</value>
        public MessageType IconType
        {
            get { return _messageType; }
            set { _messageType = value; }
        }

        /// <summary>
        /// Gets or sets the text.
        /// </summary>
        /// <value>The text.</value>
        public string Text
        {
            get { return lblMessage.Text; }
            set { lblMessage.Text = value; }
        }

        /// <summary>
        /// Gets or sets the width.
        /// </summary>
        /// <value>The width.</value>
        public Unit Width
        {
            get { return MessageContainer.Width; }
            set { MessageContainer.Width = value; }
        }

        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void Page_Load(object sender, EventArgs e)
        {
            Visible = lblMessage.Text.Length > 0;
        }

        /// <summary>
        /// Raises the <see cref="E:System.Web.UI.Control.PreRender"></see> event.
        /// </summary>
        /// <param name="e">An <see cref="T:System.EventArgs"></see> object that contains the event data.</param>
        protected override void OnPreRender(EventArgs e)
        {
            base.OnPreRender(e);

            switch (_messageType)
            {
                case MessageType.Information:
                    MessageContainer.CssClass = "info";
                    break;
                case MessageType.Success:
                    MessageContainer.CssClass = "success";
                    break;
                case MessageType.Error:
                    MessageContainer.CssClass = "error";
                    break;
                case MessageType.Warning:
                    MessageContainer.CssClass = "warn";
                    break;
            }
        }

        /// <summary>
        /// Shows the info message.
        /// </summary>
        /// <param name="message">The message.</param>
        /// <param name="showStatic"> </param>
        public void ShowInfoMessage(string message, bool showStatic = false)
        {
            RenderMessage(message, MessageType.Information, showStatic);
        }

        /// <summary>
        /// Shows the success message.
        /// </summary>
        /// <param name="message">The message.</param>
        /// <param name="showStatic"> </param>
        public void ShowSuccessMessage(string message, bool showStatic = false)
        {
            RenderMessage(message, MessageType.Success, showStatic);
        }

        /// <summary>
        /// Shows the error message.
        /// </summary>
        /// <param name="message">The message.</param>
        /// <param name="showStatic"> </param>
        public void ShowErrorMessage(string message, bool showStatic = false)
        {
            RenderMessage(message, MessageType.Error, showStatic);
        }

        /// <summary>
        /// Shows the warning message.
        /// </summary>
        /// <param name="message">The message.</param>
        /// <param name="showStatic"> </param>
        public void ShowWarningMessage(string message, bool showStatic = false)
        {
            RenderMessage(message, MessageType.Warning, showStatic);
        }

        /// <summary>
        /// Renders the message box type and message
        /// </summary>
        /// <param name="message">THe message to display</param>
        /// <param name="type">The type to render</param>
        /// <param name="showStatic"> </param>
        private void RenderMessage(string message, MessageType type, bool showStatic)
        {
            ShowStatic = showStatic;
            Text = message;
            IconType = type;
            Visible = true;
        }
    }
}