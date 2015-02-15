using System.Web.UI;
using System.Web.UI.WebControls;

namespace BugNET.UserInterfaceLayer.WebControls
{
    /// <summary>
    /// Summary description for ButtonDropDownList
    /// </summary>
    public class ButtonDropDownList : DropDownList, IPostBackEventHandler
    {
        private static readonly object EventCommand = new object();

        /// <summary>
        /// Initializes a new instance of the <see cref="ButtonDropDownList"/> class.
        /// </summary>
        public ButtonDropDownList()
        {
            base.AutoPostBack = true;
        }

        /// <summary>
        /// Gets or sets the command argument.
        /// </summary>
        /// <value>The command argument.</value>
        public string CommandArgument
        {
            get
            {
                string str = (string)this.ViewState["CommandArgument"];
                if (str != null)
                {
                    return str;
                }
                return string.Empty;
            }
            set
            {
                this.ViewState["CommandArgument"] = value;
            }
        }

        /// <summary>
        /// Gets or sets the name of the command.
        /// </summary>
        /// <value>The name of the command.</value>
        public string CommandName
        {
            get
            {
                string str = (string)this.ViewState["CommandName"];
                if (str != null)
                {
                    return str;
                }
                return string.Empty;
            }
            set
            {
                this.ViewState["CommandName"] = value;
            }
        }

        #region IPostBackEventHandler implementation
        /// <summary>
        /// When implemented by a class, enables a server control to process an event raised when a form is posted to the server.
        /// </summary>
        /// <param name="eventArgument">A <see cref="T:System.String"/> that represents an optional event argument to be passed to the event handler.</param>
        void IPostBackEventHandler.RaisePostBackEvent(string eventArgument)
        {
            this.CommandArgument = "0";

            if (base.SelectedItem != null)
                this.CommandArgument = this.SelectedItem.Value;

            this.RaisePostBackEvent(eventArgument);
        }
        #endregion

        /// <summary>
        /// Raises the <see cref="E:Command"/> event.
        /// </summary>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.CommandEventArgs"/> instance containing the event data.</param>
        protected virtual void OnCommand(CommandEventArgs e)
        {
            CommandEventHandler handler = (CommandEventHandler)base.Events[EventCommand];
            if (handler != null)
            {
                handler(this, e);
            }
            //It bubbles the event to the HandleEvent method of the GooglePagerField class.
            base.RaiseBubbleEvent(this, e);
        }

        /// <summary>
        /// When implemented by a class, enables a server control to process an event raised when a form is posted to the server.
        /// </summary>
        /// <param name="eventArgument">A <see cref="T:System.String"/> that represents an optional event argument to be passed to the event handler.</param>
        protected virtual void RaisePostBackEvent(string eventArgument)
        {
            if (this.CausesValidation)
            {
                this.Page.Validate(this.ValidationGroup);
            }
            this.OnCommand(new CommandEventArgs(this.CommandName, this.CommandArgument));
        }
    }
}