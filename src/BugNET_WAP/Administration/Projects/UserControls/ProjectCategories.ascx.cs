namespace BugNET.Administration.Projects.UserControls
{
    using System;
    using System.Collections.Generic;
    using System.Data;
    using System.Web.UI.WebControls;
    using BugNET.BLL;
    using BugNET.Entities;
    using BugNET.UserInterfaceLayer;

	/// <summary>
	///		Summary description for ProjectComponents.
	/// </summary>
	public partial class ProjectCategories : System.Web.UI.UserControl, IEditProjectControl
	{
        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
		protected void Page_Load(object sender, System.EventArgs e)
		{
			// Put user code to initialize the page here
            OkButton.OnClientClick = String.Format("onOk('{0}','{1}')", OkButton.UniqueID, "");
		}



		#region IEditProjectControl Members

        /// <summary>
        /// Gets or sets the project id.
        /// </summary>
        /// <value>The project id.</value>
		public int ProjectId
		{
            get{return ((BasePage)Page).ProjectId;}
            set { ((BasePage)Page).ProjectId = value; }
		}

        /// <summary>
        /// Inits this instance.
        /// </summary>
		public void Initialize()
		{
            CategoryTree categories = new CategoryTree();
            DropCategory.DataSource = categories.GetCategoryTreeByProjectId(ProjectId);
            DropCategory.DataBind();
		}

        /// <summary>
        /// Updates this instance.
        /// </summary>
        /// <returns></returns>
		public bool Update()
		{
			if (Page.IsValid)
				return true;
			else
				return false;
		}

		#endregion

        /// <summary>
        /// Handles the Validate event of the ComponentValidation control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.ServerValidateEventArgs"/> instance containing the event data.</param>
        protected void CategoryValidation_Validate(object sender, ServerValidateEventArgs e)
        {
            //validate that at least one version exists.
            if (CategoryManager.GetCategoriesByProjectId(ProjectId).Count > 0)
            {
                e.IsValid = true;
            }
            else
            {
                e.IsValid = false;
            }
        }

        /// <summary>
        /// Handles the Click event of the OkButton control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void OkButton_Click(object sender, EventArgs e)
        {
            int OldCategoryId = 0;
            if(!string.IsNullOrEmpty(HiddenField1.Value))
                OldCategoryId = Convert.ToInt32(HiddenField1.Value);

            if (OldCategoryId != 0)
            {
                List<QueryClause> queryClauses = new List<QueryClause>();
                QueryClause q = new QueryClause("AND", "IssueCategoryId", "=", HiddenField1.Value, SqlDbType.Int, false);
                queryClauses.Add(q);

                List<Issue> issues = IssueManager.PerformQuery(ProjectId, queryClauses);

                if (RadioButton1.Checked) //delete category 
                {
                    //if (RecursiveDelete.Checked == true)
                    //Category.DeleteChildCategoriesByCategoryId(OldCategoryId);
                    //delete the category.
                    CategoryManager.DeleteCategory(OldCategoryId);
                }

                if (RadioButton2.Checked) //reassign issues to existing category.
                {
                    if (DropCategory.SelectedValue == 0)
                    {
                        Message1.ShowErrorMessage(GetLocalResourceObject("NoCategorySelected").ToString());
                        return;
                    }
                    if (OldCategoryId == DropCategory.SelectedValue)
                    {
                        Message1.ShowErrorMessage(GetLocalResourceObject("SameCategorySelected").ToString());
                        return;
                    }

                    foreach (Issue issue in issues)
                    {
                        issue.CategoryName = DropCategory.SelectedText;
                        issue.CategoryId = DropCategory.SelectedValue;
                        IssueManager.SaveIssue(issue);
                    }

                    //delete the category.
                    CategoryManager.DeleteCategory(OldCategoryId);
                }

                //assign new category 
                if (RadioButton3.Checked)
                {
                    if(string.IsNullOrEmpty(NewCategoryTextBox.Text))
                    {
                        Message1.ShowErrorMessage(GetLocalResourceObject("NewCategoryNotEntered").ToString());
                        return;
                    }
                    Category c = new Category(ProjectId, 0, NewCategoryTextBox.Text, 0);
                    CategoryManager.SaveCategory(c);
                    foreach (Issue issue in issues)
                    {
                        issue.CategoryName = NewCategoryTextBox.Text;
                        issue.CategoryId = c.Id;
                        IssueManager.SaveIssue(issue);
                    }
                    //delete the category.
                    CategoryManager.DeleteCategory(OldCategoryId);

                }
            }
            else
            {
                Message1.ShowErrorMessage(GetLocalResourceObject("CannotDeleteRootCategory").ToString());
                return;
            }
        }

        #region IEditProjectControl Members


        public bool ShowSaveButton
        {
            get { return false; }
        }

        #endregion
    }
}
