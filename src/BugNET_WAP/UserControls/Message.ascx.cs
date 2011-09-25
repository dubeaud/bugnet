using System;
using System.Web.UI.WebControls;

namespace BugNET.UserControls
{
    public partial class Message : System.Web.UI.UserControl
    {
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

        private MessageType _MessageType;

        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void Page_Load(object sender, EventArgs e)
        {
            if (lblMessage.Text.Length > 0)
                this.Visible = true;
            else
                this.Visible = false;
        }
        /// <summary>
        /// Raises the <see cref="E:System.Web.UI.Control.PreRender"></see> event.
        /// </summary>
        /// <param name="e">An <see cref="T:System.EventArgs"></see> object that contains the event data.</param>
        protected override void  OnPreRender(EventArgs e)
        {
            base.OnPreRender(e);

            switch (_MessageType)
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
        /// Gets or sets the type of the icon.
        /// </summary>
        /// <value>The type of the icon.</value>
        public MessageType IconType
        {
            get { return _MessageType; }
            set { _MessageType = value; }
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
        /// Shows the info message.
        /// </summary>
        /// <param name="message">The message.</param>
        public void ShowInfoMessage(string message)
        {
            this.Text = message;
            this.IconType = MessageType.Information;
            this.Visible = true;
        }

        /// <summary>
        /// Shows the success message.
        /// </summary>
        /// <param name="message">The message.</param>
        public void ShowSuccessMessage(string message)
        {
            this.Text = message;
            this.IconType = MessageType.Success;
            this.Visible = true;
        }

        /// <summary>
        /// Shows the error message.
        /// </summary>
        /// <param name="message">The message.</param>
        public void ShowErrorMessage(string message)
        {
            this.Text = message;
            this.IconType = MessageType.Error;
            this.Visible = true;
        }


        /// <summary>
        /// Shows the warning message.
        /// </summary>
        /// <param name="message">The message.</param>
        public void ShowWarningMessage(string message)
        {
            this.Text = message;
            this.IconType = MessageType.Warning;
            this.Visible = true;
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
    }
}