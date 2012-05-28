using System;
using System.Collections.Generic;
using System.Data;
using System.Web.UI.WebControls;
using BugNET.BLL;
using BugNET.Entities;
using BugNET.UserInterfaceLayer;

namespace BugNET.Administration.Projects.UserControls
{
	/// <summary>
	///		Summary description for ProjectComponents.
	/// </summary>
	public partial class ProjectCategories : System.Web.UI.UserControl, IEditProjectControl
	{

        #region IEditProjectControl Members

        /// <summary>
        /// Gets or sets the project id.
        /// </summary>
        /// <value>The project id.</value>
        public int ProjectId
        {
            get { return ((BasePage)Page).ProjectId; }
            set { ((BasePage)Page).ProjectId = value; }
        }

        /// <summary>
        /// Inits this instance.
        /// </summary>
        public void Initialize()
        {
            var categories = new CategoryTree();
            DropCategory.DataSource = categories.GetCategoryTreeByProjectId(ProjectId);
            DropCategory.DataBind();
        }

        /// <summary>
        /// Updates this instance.
        /// </summary>
        /// <returns></returns>
        public bool Update()
        {
            return Page.IsValid;
        }

        public bool ShowSaveButton
        {
            get { return false; }
        }

        #endregion

        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
		protected void Page_Load(object sender, EventArgs e)
		{
			// Put user code to initialize the page here
            OkButton.OnClientClick = String.Format("onOk('{0}','{1}')", OkButton.UniqueID, "");
		}

        /// <summary>
        /// Handles the Validate event of the ComponentValidation control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.ServerValidateEventArgs"/> instance containing the event data.</param>
        protected void CategoryValidation_Validate(object sender, ServerValidateEventArgs e)
        {
            //validate that at least one version exists.
            e.IsValid = CategoryManager.GetByProjectId(ProjectId).Count > 0;
        }

	    /// <summary>
        /// Handles the Click event of the OkButton control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void OkButton_Click(object sender, EventArgs e)
        {
            var oldCategoryId = 0;

            if(!string.IsNullOrEmpty(HiddenField1.Value))
                oldCategoryId = Convert.ToInt32(HiddenField1.Value);

            if (oldCategoryId != 0)
            {
                var queryClauses = new List<QueryClause>
                {
                    new QueryClause("AND", "iv.[IssueCategoryId]", "=", HiddenField1.Value, SqlDbType.Int, false)
                };

                var issues = IssueManager.PerformQuery(ProjectId, queryClauses, null);

                if (RadioButton1.Checked) //delete category 
                {
                    //if (RecursiveDelete.Checked == true)
                    //Category.DeleteChildCategoriesByCategoryId(OldCategoryId);
                    //delete the category.
                    CategoryManager.Delete(oldCategoryId);
                }

                if (RadioButton2.Checked) //reassign issues to existing category.
                {
                    if (DropCategory.SelectedValue == 0)
                    {
                        Message1.ShowErrorMessage(GetLocalResourceObject("NoCategorySelected").ToString());
                        return;
                    }
                    if (oldCategoryId == DropCategory.SelectedValue)
                    {
                        Message1.ShowErrorMessage(GetLocalResourceObject("SameCategorySelected").ToString());
                        return;
                    }

                    foreach (var issue in issues)
                    {
                        issue.CategoryName = DropCategory.SelectedText;
                        issue.CategoryId = DropCategory.SelectedValue;
                        IssueManager.SaveOrUpdate(issue);
                    }

                    //delete the category.
                    CategoryManager.Delete(oldCategoryId);
                }

                //assign new category 
                if (RadioButton3.Checked)
                {
                    if(string.IsNullOrEmpty(NewCategoryTextBox.Text))
                    {
                        Message1.ShowErrorMessage(GetLocalResourceObject("NewCategoryNotEntered").ToString());
                        return;
                    }
                    var c = new Category { ProjectId = ProjectId, ParentCategoryId = 0, Name = NewCategoryTextBox.Text, ChildCount = 0 };
                    CategoryManager.SaveOrUpdate(c);
                    foreach (var issue in issues)
                    {
                        issue.CategoryName = NewCategoryTextBox.Text;
                        issue.CategoryId = c.Id;
                        IssueManager.SaveOrUpdate(issue);
                    }
                    //delete the category.
                    CategoryManager.Delete(oldCategoryId);

                }
            }
            else
            {
                Message1.ShowErrorMessage(GetLocalResourceObject("CannotDeleteRootCategory").ToString());
            }
        }
    }
}
