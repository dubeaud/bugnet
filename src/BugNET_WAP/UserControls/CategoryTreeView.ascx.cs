namespace BugNET.UserControls
{
    using System;
    using System.Collections.Generic;
    using System.Web.UI.WebControls;
    using BugNET.BLL;
    using BugNET.Entities;

    public partial class CategoryTreeView : System.Web.UI.UserControl
    {
        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="T:System.EventArgs"/> instance containing the event data.</param>
        protected void Page_Load(object sender, EventArgs e)
        { }

        /// <summary>
        /// Gets or sets a value indicating whether [show bug count].
        /// </summary>
        /// <value><c>true</c> if [show bug count]; otherwise, <c>false</c>.</value>
        public bool ShowIssueCount
        {
            get
            {
                if (ViewState["ShowIssueCount"] == null)
                    return true;
                else
                    return (bool)ViewState["ShowIssueCount"];
            }
            set { ViewState["ShowIssueCount"] = value; }
        }

        /// <summary>
        /// Gets or sets a value indicating whether [show root].
        /// </summary>
        /// <value><c>true</c> if [show root]; otherwise, <c>false</c>.</value>
        public bool ShowRoot
        {
            get
            {
                if (ViewState["ShowRoot"] == null)
                    return false;
                else
                    return (bool)ViewState["ShowRoot"];
            }
            set { ViewState["ShowRoot"] = value; }
        }

        /// <summary>
        /// Gets or sets the project id.
        /// </summary>
        /// <value>The project id.</value>
        public int ProjectId
        {
            get
            {
                if (ViewState["ProjectId"] == null)
                    return -1;
                else
                    return (int)ViewState["ProjectId"];
            }
            set { ViewState["ProjectId"] = value; }
        }

        /// <summary>
        /// Gets the component count.
        /// </summary>
        /// <value>The component count.</value>
        public int CategoryCount
        {
            get
            {

                if (ShowRoot && tvCategory.Nodes.Count > 1)
                {
                    return tvCategory.Nodes.Count - 1;
                }
                else
                {
                    return tvCategory.Nodes.Count;
                }

            }

        }

        /// <summary>
        /// Binds the data.
        /// </summary>
        public void BindData()
        {
            tvCategory.Nodes.Clear();
            List<Category> categories = CategoryManager.GetRootCategoriesByProjectId(ProjectId);

            if (ShowRoot)
            {
                tvCategory.Nodes.Add(new TreeNode(GetLocalResourceObject("RootCategory").ToString(), ""));
                PopulateNodes(categories, tvCategory.Nodes[0].ChildNodes);
                
            }
            else
            {
                PopulateNodes(categories, tvCategory.Nodes);
            }
            TreeNode tn = new TreeNode();
            tn.Text = String.Format("{0}</a></td><td style='width:100%;text-align:right;'><a>{1}&nbsp;",GetLocalResourceObject("Unassigned"), IssueManager.GetCountByProjectAndCategoryId(ProjectId));
            tn.NavigateUrl = String.Format("~/Issues/IssueList.aspx?pid={0}&c={1}", ProjectId, 0);
            tvCategory.Nodes.Add(tn);

            tvCategory.ExpandAll();
        }
        /// <summary>
        /// Populates the nodes.
        /// </summary>
        /// <param name="list">The list.</param>
        /// <param name="nodes">The nodes.</param>
        private void PopulateNodes(List<Category> list, TreeNodeCollection nodes)
        {
            foreach (Category c in list)
            {

                // Modified by Stewart Moss
                // 10-May-2009
                //
                // Fix for [BGN-938]  The Project Summary page cannot show long categories 
                // 
                // The category name is not truncated intelligently and long category names 
                // break the category list in the project summary page. 
                // (or anywhere else this control is used)
                //
                // This code performs the required truncation. An elipsis is also added.
                // This code does take bool ShowIssueCount in accout by adding 5 to the maxSize
                //
                // Example: The test category "this is a new test category ra ra ra" at a level 4 depth 
                // exibits this problem. 

                TreeNode tn = new TreeNode();
                nodes.Add(tn);
                try
                {
                    // Calculate the right trimming length
                    // 
                    // This is not an exact science here, becuase tn.depth is not always right
                    int maxSize;
                    int tmpint = tn.Depth > 0 ? tn.Depth : 1;
                    maxSize = 35 - (((tmpint) - 1) * 2);
                    if (!ShowIssueCount) { maxSize += 5; }
                    // when the depth gets high, the formula goes wonky, so correct it
                    if (tmpint >= 5) maxSize -= 2;

                    // now cut it if it needs it
                    string tmpstr = c.Name;
                    if (tmpstr.Length > maxSize)
                    {
                        tmpstr = tmpstr.Remove(maxSize - 1) + ".."; // add an elipsis
                    }

                    if (ShowIssueCount)
                    {
                        tn.Text = String.Format("{0}</a></td><td style='width:100%;text-align:right;'><a>{1}&nbsp;", tmpstr, IssueManager.GetCountByProjectAndCategoryId(ProjectId, c.Id));
                        tn.NavigateUrl = String.Format("~/Issues/IssueList.aspx?pid={0}&c={1}", ProjectId, c.Id);
                    }
                    else
                    {
                        tn.Text = tmpstr;
                    }
                    tn.Value = c.Id.ToString();

                    //If node has child nodes, then enable on-demand populating
                    tn.PopulateOnDemand = (c.ChildCount > 0);
                }
                catch (Exception ex)
                {
                    nodes.Remove(tn);
                    throw ex;
                }
            }
        }

        /// <summary>
        /// Gets the selected node.
        /// </summary>
        /// <value>The selected node.</value>
        public TreeNode SelectedNode
        {
            get { return tvCategory.SelectedNode; }
        }

        /// <summary>
        /// Gets the selected value.
        /// </summary>
        /// <value>The selected value.</value>
        public string SelectedValue
        {
            get { return tvCategory.SelectedValue; }
        }
        /// <summary>
        /// Populates the sub level.
        /// </summary>
        /// <param name="parentid">The parentid.</param>
        /// <param name="parentNode">The parent node.</param>
        private void PopulateSubLevel(int parentid, TreeNode parentNode)
        {
            PopulateNodes(CategoryManager.GetChildCategoriesByCategoryId(parentid), parentNode.ChildNodes);
        }

        /// <summary>
        /// Handles the TreeNodePopulate event of the tvComponent control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="T:System.Web.UI.WebControls.TreeNodeEventArgs"/> instance containing the event data.</param>
        protected void tvCategory_TreeNodePopulate(object sender, TreeNodeEventArgs e)
        {
            PopulateSubLevel(Int32.Parse(e.Node.Value), e.Node);
        }
    }
}
