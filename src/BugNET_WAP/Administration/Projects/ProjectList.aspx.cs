using System;
using System.Collections.Generic;
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
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
		protected void Page_Load(object sender, System.EventArgs e)
		{
            if (!IsPostBack)
            {
                BindData();
  
                if (!UserManager.HasPermission(Convert.ToInt32(Request.QueryString["id"]), Globals.Permission.ADMIN_CLONE_PROJECT.ToString()))
                    CloneProject.Visible = false;
                if (!UserManager.HasPermission(Convert.ToInt32(Request.QueryString["id"]), Globals.Permission.ADMIN_CREATE_PROJECT.ToString()))
                    NewProject.Visible = false;
            }

           
		}

        /// <summary>
        /// Binds the data.
        /// </summary>
        private void BindData()
        {
            List<Project> projects = ProjectManager.GetAllProjects();
            projects.Sort(new ProjectComparer(SortField, SortAscending));
            dgProjects.DataSource = projects;
            dgProjects.DataBind();
        }

        /// <summary>
        /// Handles the Click event of the btnNewProject control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void btnNewProject_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Administration/Projects/AddProject.aspx");
        }

        /// <summary>
        /// Handles the Click event of the btnCloneProject control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void btnCloneProject_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Administration/Projects/CloneProject.aspx");
        }

        /// <summary>
        /// Gets or sets the sort field.
        /// </summary>
        /// <value>The sort field.</value>
        string SortField
        {
            get
            {
                object o = ViewState["SortField"];
                if (o == null)
                {
                    return "Name";
                }
                return (string)o;
            }

            set
            {
                if (value == SortField)
                {
                    // same as current sort file, toggle sort direction
                    SortAscending = !SortAscending;
                }
                ViewState["SortField"] = value;
            }
        }

        /// <summary>
        /// Gets or sets a value indicating whether [sort ascending].
        /// </summary>
        /// <value><c>true</c> if [sort ascending]; otherwise, <c>false</c>.</value>
        bool SortAscending
        {
            get
            {
                object o = ViewState["SortAscending"];
                if (o == null)
                {
                    return false;
                }
                return (bool)o;
            }

            set
            {
                ViewState["SortAscending"] = value;
            }
        }

		#region Web Form Designer generated code
		override protected void OnInit(EventArgs e)
		{
			//
			// CODEGEN: This call is required by the ASP.NET Web Form Designer.
			//
			InitializeComponent();
			base.OnInit(e);
		}
		
		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{    
			dgProjects.ItemDataBound +=new DataGridItemEventHandler(dgProjects_ItemDataBound);
            dgProjects.ItemCreated += new DataGridItemEventHandler(dgProjects_ItemCreated);
            dgProjects.SortCommand += new DataGridSortCommandEventHandler(dgProjects_SortCommand);
		}

        /// <summary>
        /// Handles the SortCommand event of the dgProjects control.
        /// </summary>
        /// <param name="source">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.DataGridSortCommandEventArgs"/> instance containing the event data.</param>
        void dgProjects_SortCommand(object source, DataGridSortCommandEventArgs e)
        {
            SortField = e.SortExpression;
            BindData();
        }

        /// <summary>
        /// Handles the ItemCreated event of the dgProjects control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.DataGridItemEventArgs"/> instance containing the event data.</param>
        void dgProjects_ItemCreated(object sender, DataGridItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Header)
            {
                for (int i = 0; i < e.Item.Cells.Count; i++)
                {
                    TableCell tc = e.Item.Cells[i];
                    if (tc.HasControls())
                    {
                        // search for the header link  
                        LinkButton lnk = (LinkButton)tc.Controls[0];
                        if (lnk != null)
                        {
                            // inizialize a new image
                            System.Web.UI.WebControls.Image img = new System.Web.UI.WebControls.Image();
                            // setting the dynamically URL of the image
                            img.ImageUrl = "~/images/" + (SortAscending ? "bullet_arrow_up" : "bullet_arrow_down") + ".png";
                            img.CssClass = "icon";
                            // checking if the header link is the user's choice
                            if (SortField == lnk.CommandArgument)
                            {
                                // adding a space and the image to the header link
                                //tc.Controls.Add(new LiteralControl(" "));
                                tc.Controls.Add(img);
                            }


                        }
                    }
                }
            }
        }
		#endregion

        /// <summary>
        /// Handles the ItemDataBound event of the dgProjects control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.DataGridItemEventArgs"/> instance containing the event data.</param>
		private void dgProjects_ItemDataBound(object sender, DataGridItemEventArgs e)
		{ 
			if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem) 
			{
				Project p = (Project)e.Item.DataItem;
				Label lblActive = (Label)e.Item.FindControl("lblActive");
				Label lblCreated= (Label)e.Item.FindControl("lblCreated");
		
				lblCreated.Text= p.DateCreated.ToShortDateString();
                lblActive.Text = p.Disabled == true ? GetGlobalResourceObject("SharedResources", "Yes").ToString() : GetGlobalResourceObject("SharedResources", "No").ToString();
				

				//permission check to edit project
                if(!UserManager.HasPermission(p.Id,Globals.Permission.ADMIN_EDIT_PROJECT.ToString()))
                    e.Item.Visible = false;
			}
		}
	}
}
