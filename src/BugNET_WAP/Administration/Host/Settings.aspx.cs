using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using BugNET.BLL;
using BugNET.Common;
using BugNET.UserInterfaceLayer;

namespace BugNET.Administration.Host
{
	/// <summary>
	/// Administration page that controls the application configuration
	/// </summary>
	public partial class Settings : BasePage
	{
        /// <summary>
        /// Message1 control.
        /// </summary>
        /// <remarks>
        /// Auto-generated field.
        /// To modify move field declaration from designer file to code-behind file.
        /// </remarks>
        public BugNET.UserControls.Message Message1;

        Control _ctlHostSettings;
	    readonly Dictionary<string, string> _menuItems = new Dictionary<string, string>();

        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="T:System.EventArgs"/> instance containing the event data.</param>
		protected void Page_Load(object sender, EventArgs e)
		{
            if (!UserManager.IsSuperUser())
                Response.Redirect("~/Errors/AccessDenied.aspx");

            _menuItems.Add(GetLocalResourceObject("Basic").ToString(), "page_white_gear.png");
            _menuItems.Add(GetLocalResourceObject("Authentication").ToString(), "lock.gif");
            _menuItems.Add(GetLocalResourceObject("Mail").ToString(), "email.gif");
            _menuItems.Add(GetLocalResourceObject("Logging").ToString(), "page_white_error.png");
            _menuItems.Add(GetLocalResourceObject("Subversion").ToString(), "svnLogo_sm.jpg");
            _menuItems.Add(GetLocalResourceObject("Notifications").ToString(), "email_go.gif");
            _menuItems.Add(GetLocalResourceObject("Attachments").ToString(), "attach.gif");
            _menuItems.Add(GetLocalResourceObject("POP3Mailbox").ToString(), "mailbox.png");
            _menuItems.Add(GetLocalResourceObject("Languages").ToString(), "page_white_world.png");

            AdminMenu.DataSource = _menuItems;
            AdminMenu.DataBind();   
 
            if (TabId != -1)
                LoadTab(TabId);
                
		}

        /// <summary>
        /// Handles the ItemDataBound event of the AdminMenu control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.RepeaterItemEventArgs"/> instance containing the event data.</param>
        protected void AdminMenu_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType != ListItemType.Item && e.Item.ItemType != ListItemType.AlternatingItem) return;

            var dataItem = (KeyValuePair<string, string>)e.Item.DataItem;
            var listItem = e.Item.FindControl("ListItem") as HtmlGenericControl;
            var lb = e.Item.FindControl("MenuButton") as LinkButton;

            //if (listItem != null)
            //    listItem.Attributes.Add("style", string.Format("background: #C4EFA1 url(../../images/{0}) no-repeat 5px 4px;", dataItem.Value));

            if (lb != null) 
                lb.Text = dataItem.Key;
        }

        /// <summary>
        /// Handles the ItemCommand event of the AdminMenu control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.RepeaterCommandEventArgs"/> instance containing the event data.</param>
        protected void AdminMenu_ItemCommand(object sender, RepeaterCommandEventArgs e)
        {
            TabId = e.Item.ItemIndex;
            LoadTab(TabId);
        }

        /// <summary>
        /// Loads the tab.
        /// </summary>
        /// <param name="selectedTab">The selected tab.</param>
        private void LoadTab(int selectedTab)
        {
            string controlName = "BasicSettings.ascx";

            switch (selectedTab)
            {
                case 0:
                    controlName = "BasicSettings.ascx";
                    break;
                case 1:
                    controlName = "AuthenticationSettings.ascx";
                    break;
                case 2:
                    controlName = "MailSettings.ascx";
                    break;
                case 3:
                    controlName = "LoggingSettings.ascx";
                    break;
                case 4:
                    controlName = "SubversionSettings.ascx";
                    break;
                case 5:
                    controlName = "NotificationSettings.ascx";
                    break;
                case 6:
                    controlName = "AttachmentSettings.ascx";
                    break;
                case 7:
                    controlName = "POP3Settings.ascx";
                    break;
                case 8:
                    controlName = "LanguageSettings.ascx";
                    break;
            }

            for (int i = 0; i < _menuItems.Count; i++)
            {
                if (i == TabId)
                   ((HtmlGenericControl)AdminMenu.Items[i].FindControl("ListItem")).Attributes.Add("class", "active");
                else
                   ((HtmlGenericControl)AdminMenu.Items[i].FindControl("ListItem")).Attributes.Add("class", "");
            }
         

            _ctlHostSettings = Page.LoadControl("~/Administration/Host/UserControls/" + controlName);
            _ctlHostSettings.ID = "ctlHostSetting";
            plhSettingsControl.Controls.Clear();
            plhSettingsControl.Controls.Add(_ctlHostSettings);
            ((IEditHostSettingControl)_ctlHostSettings).Initialize();
        }

        /// <summary>
        /// Gets or sets the tab id.
        /// </summary>
        /// <value>The tab id.</value>
        int TabId
        {
            get { return ViewState.Get("TabId", 0); }
            set { ViewState.Set("TabId", value); }
        }

        /// <summary>
        /// Handles the Init event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void Page_Init(object sender, EventArgs e)
        {
          
              
        }

        /// <summary>
        /// Handles the Click event of the cmdUpdate control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="T:System.EventArgs"/> instance containing the event data.</param>
        protected void cmdUpdate_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            if (((IEditHostSettingControl)_ctlHostSettings).Update())
            {
                if (Message1.Text.Trim().Length.Equals(0))
                {
                    Message1.ShowSuccessMessage(GetLocalResourceObject("SaveMessage").ToString());   
                }
            }
        }
	}
}
