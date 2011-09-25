using System;
using System.Collections.Generic;
using System.Web.UI.WebControls;
using BugNET.BLL;
using BugNET.Entities;
using BugNET.UserInterfaceLayer;

namespace BugNET.Administration.Projects.UserControls
{
    public partial class ProjectNotifications : System.Web.UI.UserControl, IEditProjectControl
    {
        private int _ProjectId = -1;

        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        #region IEditProjectControl Members

        /// <summary>
        /// Gets or sets the project id.
        /// </summary>
        /// <value>The project id.</value>
        public int ProjectId
        {
            get { return _ProjectId; }
            set { _ProjectId = value; }
        }


        /// <summary>
        /// Updates this instance.
        /// </summary>
        /// <returns></returns>
        public bool Update()
        {
          
            return true;
        }

        /// <summary>
        /// Initializes this instance.
        /// </summary>
        public void Initialize()
        {
            lstAllUsers.Items.Clear();
            lstSelectedUsers.Items.Clear();

            lstAllUsers.DataSource = UserManager.GetUsersByProjectId(ProjectId);
            lstAllUsers.DataTextField = "DisplayName";
            lstAllUsers.DataValueField = "Username";
            lstAllUsers.DataBind();

            // Copy selected users into Selected Users List Box
            IEnumerable<ProjectNotification> projectNotifications = ProjectNotificationManager.GetProjectNotificationsByProjectId(ProjectId);
            foreach (ProjectNotification currentNotification in projectNotifications)
            {
                ListItem matchItem = lstAllUsers.Items.FindByValue(currentNotification.NotificationUsername);
                if (matchItem != null)
                {
                    lstSelectedUsers.Items.Add(matchItem);
                    lstAllUsers.Items.Remove(matchItem);
                }
            }

         
        }

        /// <summary>
        /// Gets a value indicating whether [show save button].
        /// </summary>
        /// <value><c>true</c> if [show save button]; otherwise, <c>false</c>.</value>
        public bool ShowSaveButton
        {
            get { return false; }
        }

        #endregion


        /// <summary>
        /// Adds the user.
        /// </summary>
        /// <param name="s">The s.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void AddUser(Object s, EventArgs e)
        {
            //The users must be added to a list first becuase the collection can not
            //be modified while we iterate through it.
            var usersToAdd = new List<ListItem>();

            foreach (ListItem item in lstAllUsers.Items)
                if (item.Selected)
                    usersToAdd.Add(item);


            foreach (var item in usersToAdd)
            {
                ProjectNotification pn = new ProjectNotification(ProjectId,item.Value);
                if (ProjectNotificationManager.SaveProjectNotification(pn))
                {
                    lstSelectedUsers.Items.Add(item);
                    lstAllUsers.Items.Remove(item);
                }
            }

            lstSelectedUsers.SelectedIndex = -1;
        }

        /// <summary>
        /// Removes the user.
        /// </summary>
        /// <param name="s">The s.</param>
        /// <param name="e">The <see cref="T:System.EventArgs"/> instance containing the event data.</param>
        protected void RemoveUser(Object s, EventArgs e)
        {
            //The users must be added to a list first becuase the collection can not
            //be modified while we iterate through it.
            var usersToRemove = new List<ListItem>();

            foreach (ListItem item in lstSelectedUsers.Items)
                if (item.Selected)
                    usersToRemove.Add(item);


            foreach (var item in usersToRemove)
            {             
                if (ProjectNotificationManager.DeleteProjectNotification(ProjectId,item.Value))
                {
                    lstAllUsers.Items.Add(item);
                    lstSelectedUsers.Items.Remove(item);
                }
            }

            lstAllUsers.SelectedIndex = -1;
        }
    }
    
}