using System;
using System.Collections.Generic;
using System.Web.Script.Serialization;
using System.Web.UI.WebControls;
using BugNET.BLL;
using BugNET.Common;
using BugNET.Entities;

namespace BugNET.UserControls
{
    public partial class CategoryTreeView : System.Web.UI.UserControl
    {

        private const int MAX_LENGTH_OF_TEXT = 35;

        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="T:System.EventArgs"/> instance containing the event data.</param>
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        /// <summary>
        /// Gets or sets a value indicating whether [show issue count].
        /// </summary>
        /// <value><c>true</c> if [show issue count]; otherwise, <c>false</c>.</value>
        public bool ShowIssueCount
        {
            get { return ViewState.Get("ShowIssueCount", true); }
            set { ViewState.Set("ShowIssueCount", value); }
        }

        /// <summary>
        /// Gets or sets a value indicating whether [show root].
        /// </summary>
        /// <value><c>true</c> if [show root]; otherwise, <c>false</c>.</value>
        public bool ShowRoot
        {
            get { return ViewState.Get("ShowRoot", false); }
            set { ViewState.Set("ShowRoot", value); }
        }

        /// <summary>
        /// Gets or sets the project id.
        /// </summary>
        /// <value>The project id.</value>
        public int ProjectId
        {
            get { return ViewState.Get("ProjectId", -1); }
            set { ViewState.Set("ProjectId", value); }
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
                return tvCategory.Nodes.Count;
            }
        }

        /// <summary>
        /// Binds the data.
        /// </summary>
        public void BindData()
        {
            var allCategories = CategoryManager.GetByProjectId(ProjectId);

            tvCategory.Nodes.Clear();

            var tree = tvCategory.Nodes;

            if(ShowRoot)
                tree.Add(new TreeNode(GetLocalResourceObject("RootCategory").ToString(), ""));

            var depth = ShowRoot ? 1 : 0;

            PopulateTreeView(tree, depth, allCategories);

            var tn = new TreeNode
                         {
                             Text = String.Format("{0}</a></td><td style='width:100%;text-align:right;'><a>{1}&nbsp;",
                                               GetLocalResourceObject("Unassigned"),
                                               IssueManager.GetCountByProjectAndCategoryId(ProjectId)),
                             NavigateUrl = String.Format("~/Issues/IssueList.aspx?pid={0}&c={1}", ProjectId, 0)
                         };

            tvCategory.Nodes.Add(tn);

            tvCategory.ExpandAll();
        }

        /// <summary>
        ///  Main function the populate the tree view of categories
        /// </summary>
        /// <param name="nodes">The tree view nodes to populate</param>
        /// <param name="depth">The current depth of the node structure</param>
        /// <param name="allCategories">All the categories for the project</param>
        private void PopulateTreeView(TreeNodeCollection nodes,int depth, List<Category> allCategories)
        {
            if (nodes == null) throw new ArgumentNullException("nodes");
            if (allCategories == null) throw new ArgumentNullException("allCategories");

            var parentCategories = allCategories.FindAll(p => p.ParentCategoryId == 0);

            foreach (var pCat in parentCategories)
            {
                var node = GetTreeNode(pCat, depth);

                if (pCat.ChildCount > 0)
                {
                    PopulateChildNodes(pCat, node.ChildNodes, depth + 1, allCategories);
                }

                nodes.Add(node);
            }
        }

        /// <summary>
        /// Populate the child nodes for the treeview
        /// </summary>
        /// <param name="parent">The parent category to populate the children for</param>
        /// <param name="nodes">The actual tree nodes to populate</param>
        /// <param name="depth">The current depth of the node structure</param>
        /// <param name="all">The full category list for the project</param>
        private void PopulateChildNodes(Category parent, TreeNodeCollection nodes, int depth, List<Category> all)
        {
            foreach (var pCat in all.FindAll(p => p.ParentCategoryId == parent.Id))
            {
                var node = GetTreeNode(pCat, depth);

                if (pCat.ChildCount > 0)
                {
                    PopulateChildNodes(pCat, node.ChildNodes, depth + 1, all);
                }

                nodes.Add(node);
            }
        }

        /// <summary>
        /// Builds a Tree node
        /// </summary>
        /// <param name="category">The category information for the node</param>
        /// <param name="depth">The depth at which the node resides</param>
        /// <returns>A node for the tree view</returns>
        private TreeNode GetTreeNode(Category category, int depth)
        {
            var tNode = new TreeNode();

            // now cut it if it needs it
            var catText = GetCategoryText(category.Name, depth);

            if (ShowIssueCount)
            {
                tNode.Text = String.Format("{0}</a></td><td style='width:100%;text-align:right;'><a>{1}&nbsp;", catText, category.IssueCount);
                tNode.NavigateUrl = String.Format("~/Issues/IssueList.aspx?pid={0}&c={1}", ProjectId, category.Id);
            }
            else
            {
                tNode.Text = catText;
            }

            tNode.Value = category.Id.ToString();

            //If node has child nodes, then enable on-demand populating
            tNode.PopulateOnDemand = (category.ChildCount > 0);

            return tNode;
        }

        /// <summary>
        /// Modified by Stewart Moss
        /// 10-May-2009
        ///
        /// Fix for [BGN-938]  The Project Summary page cannot show long categories 
        /// 
        /// The category name is not truncated intelligently and long category names 
        /// break the category list in the project summary page. 
        /// (or anywhere else this control is used)
        ///
        /// This code performs the required truncation. An elipsis is also added.
        /// This code does take bool ShowIssueCount in accout by adding 5 to the maxSize
        ///
        /// Example: The test category "this is a new test category ra ra ra" at a level 4 depth 
        /// exibits this problem.
        /// </summary>
        /// <param name="text">The category text</param>
        /// <param name="depth">The depth in the tree view the text will be displayed</param>
        /// <returns>A proper formatted category name</returns>
        private string GetCategoryText(string text, int depth)
        {
            var maxSize = MAX_LENGTH_OF_TEXT;

            if (depth > 0)
                maxSize = maxSize - (((depth) - 1)*2);

            if (!ShowIssueCount) { maxSize += 5; }

            // now cut it if it needs it
            var catText = text.Trim();

            if (catText.Length > maxSize)
            {
                catText = catText.Remove(maxSize - 1) + ".."; // add an elipsis
            }

            return catText;
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
                // This code performs the required truncation. An ellipsis is also added.
                // This code does take bool ShowIssueCount in account by adding 5 to the maxSize
                //
                // Example: The test category "this is a new test category ra ra ra" at a level 4 depth 
                // exhibits this problem. 

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
                        tn.Text = String.Format("{0}</a></td><td style='width:100%;text-align:right;'><a>{1}&nbsp;", tmpstr, c.IssueCount);
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
