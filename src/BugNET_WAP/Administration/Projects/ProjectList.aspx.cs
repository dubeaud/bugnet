using System;
using System.Web.UI.WebControls;
using BugNET.BLL;
using BugNET.Common;
using BugNET.Entities;
using BugNET.UserInterfaceLayer;

namespace BugNET.Administration.Projects
{
    /// <summary>
    /// Summary description for ProjectList.
    /// </summary>
    public partial class ProjectList : BasePage
    {
        /// <summary>
        /// Gets or sets the sort field.
        /// </summary>
        /// <value>The sort field.</value>
        string SortField
        {
            get { return ViewState.Get("SortField", "Name"); }
            set
            {
                if (value == SortField)
                    SortAscending = !SortAscending; // same as current sort file, toggle sort direction

                ViewState.Set("SortField", value);
            }
        }

        /// <summary>
        /// Gets or sets a value indicating whether [sort ascending].
        /// </summary>
        /// <value><c>true</c> if [sort ascending]; otherwise, <c>false</c>.</value>
        bool SortAscending
        {
            get { return ViewState.Get("SortAscending", false); }
            set { ViewState.Set("SortAscending", value); }
        }

        /// <summary>
        /// Binds the data.
        /// </summary>
        private void BindData()
        {
            var projects = ProjectManager.GetAllProjects();
            projects.Sort(new ProjectComparer(SortField, SortAscending));
            dgProjects.DataSource = projects;
            dgProjects.DataBind();
        }

        void CreateProjectViews()
        {

            if (UpgradeManager.CreateCustomFieldViews())
            {
                PageMessage.ShowSuccessMessage("Project custom field views were created successfully");
                return;
            }

            PageMessage.ShowSuccessMessage("Project custom field views failed to be created, please see application log for errors");
        }

        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!UserManager.IsSuperUser())
                Response.Redirect("~/Default.aspx");

            btnGenerateCustomFieldViews.OnClientClick = string.Format("return confirm('{0}');", GetLocalResourceObject("ConfirmCustomFieldViewCreation"));
            lbGenerateCustomFieldViews.OnClientClick = string.Format("return confirm('{0}');", GetLocalResourceObject("ConfirmCustomFieldViewCreation"));

            if (IsPostBack) return;

            BindData();
        }

        /// <summary>
        /// Handles the ItemDataBound event of the dgProjects control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.DataGridItemEventArgs"/> instance containing the event data.</param>
        protected void dgProjects_ItemDataBound(object sender, DataGridItemEventArgs e)
        {
            if (e.Item.ItemType != ListItemType.Item && e.Item.ItemType != ListItemType.AlternatingItem) return;

            var p = (Project)e.Item.DataItem;
            var lblActive = (Label)e.Item.FindControl("lblActive");
            var lblCreated = (Label)e.Item.FindControl("lblCreated");

            lblCreated.Text = p.DateCreated.ToShortDateString();
            lblActive.Text = p.Disabled ?
                GetGlobalResourceObject("SharedResources", "Yes").ToString() :
                GetGlobalResourceObject("SharedResources", "No").ToString();

            //permission check to edit project
            if (!UserManager.HasPermission(p.Id, Globals.Permission.AdminEditProject.ToString()))
                e.Item.Visible = false;
        }

        /// <summary>
        /// Handles the SortCommand event of the dgProjects control.
        /// </summary>
        /// <param name="source">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.DataGridSortCommandEventArgs"/> instance containing the event data.</param>
        protected void dgProjects_SortCommand(object source, DataGridSortCommandEventArgs e)
        {
            SortField = e.SortExpression;
            BindData();
        }

        /// <summary>
        /// Handles the ItemCreated event of the dgProjects control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.DataGridItemEventArgs"/> instance containing the event data.</param>
        protected void dgProjects_ItemCreated(object sender, DataGridItemEventArgs e)
        {
            if (e.Item.ItemType != ListItemType.Header) return;

            for (var i = 0; i < e.Item.Cells.Count; i++)
            {
                var tc = e.Item.Cells[i];
                if (!tc.HasControls()) continue;

                // search for the header link  
                var lnk = tc.Controls[0] as LinkButton;

                if (lnk == null) continue;

                // inizialize a new image
                var img = new Image
                {
                    ImageUrl = string.Format("~/images/{0}.png", (SortAscending ? "bullet_arrow_up" : "bullet_arrow_down")),
                    CssClass = "icon"
                };

                // setting the dynamically URL of the image
                // checking if the header link is the user's choice
                if (SortField == lnk.CommandArgument)
                {
                    // adding a space and the image to the header link
                    //tc.Controls.Add(new LiteralControl(" "));
                    tc.Controls.Add(img);
                }
            }
        }

        protected void btnGenerateCustomFieldViews_Click(object sender, System.Web.UI.ImageClickEventArgs e)
        {
            CreateProjectViews();
        }

        protected void lbGenerateCustomFieldViews_Click(object sender, EventArgs e)
        {
            CreateProjectViews();
        }
    }
}
