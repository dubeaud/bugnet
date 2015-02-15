using System;

namespace BugNET.UserControls
{
    public partial class PickDate : System.Web.UI.UserControl
    {
        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        /// <summary>
        /// Gets or sets the selected value.
        /// </summary>
        /// <value>The selected value.</value>
        public DateTime? SelectedValue
        {
            get 
            {
                DateTime selectedDate;
                DateTime.TryParse(DateTextBox.Text.Trim(), out selectedDate);  
                return selectedDate == DateTime.MinValue ? null : (DateTime?)selectedDate;
            }
            set
            {
                if (value != null)
                    DateTextBox.Text = ((DateTime)value).ToShortDateString();
                else
                    DateTextBox.Text = string.Empty;
            }
        }


        /// <summary>
        /// Gets or sets a value indicating whether this <see cref="PickDate"/> is enabled.
        /// </summary>
        /// <value><c>true</c> if enabled; otherwise, <c>false</c>.</value>
        public bool Enabled
        {
            get { return DateTextBox.Enabled; }
            set 
            {
                DateTextBox.Enabled = value;
                imgCalendar.Visible = value;
            }
        }
 
    }
}