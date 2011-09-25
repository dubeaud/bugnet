using System;
using System.Collections;
using System.ComponentModel;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BugNET.UserInterfaceLayer.WebControls
{
    /// <summary>
    /// 
    /// </summary>
    [ToolboxData("<{0}:GridView runat=\"server\"></{0}:GridView>")]
    public class GridView : System.Web.UI.WebControls.GridView, IPageableItemContainer
    {
        /// <summary>
        /// TotalRowCountAvailable event key
        /// </summary>
        private static readonly object EventTotalRowCountAvailable = new object();
        bool _ShowSortSequence = false;
        bool _EnableMultiColumnSorting = false;
        string _SortAscImageUrl = string.Empty;
        string _SortDescImageUrl = string.Empty;

        #region Multi-Column Sorting
        public string SortField
        {
            get
            {
                object o = ViewState["SortField"];
                if (o == null)
                {
                    return String.Empty;
                }
                return (string)o;
            }

            set
            {
                if (value == SortField)
                {
                    // same as current sort file, toggle sort direction
                    //SortAscending = !SortAscending;
                }
                ViewState["SortField"] = value;
            }
        }
        /// <summary>
        /// Enable/Disable MultiColumn Sorting.
        /// </summary>
        [
        Description("Sorting On more than one column is enabled or not"),
        Category("Behavior"),
        DefaultValue("false"),
        ]
        public bool EnableMultiColumnSorting
        {
            get { return  _EnableMultiColumnSorting; }
            set { AllowSorting = true; _EnableMultiColumnSorting = value; }
        }
        /// <summary>
        /// Enable/Disable Sort Sequence visibility.
        /// </summary>
        [
        Description("Show Sort Sequence or not"),
        Category("Behavior"),
        DefaultValue("false"),
        ]
        public bool ShowSortSequence
        {
            get { return _ShowSortSequence; }
            set { _ShowSortSequence = value; }
        }
        /// <summary>
        /// Get/Set Image for displaying Ascending Sort order.
        /// </summary>
        /// <value>The sort asc image URL.</value>
        [
        Description("Image to display for Ascending Sort"),
        Category("Misc"),
        Editor("System.Web.UI.Design.UrlEditor", typeof(System.Drawing.Design.UITypeEditor)),
        DefaultValue(""),
        ]
        public string SortAscImageUrl
        {
            get { return _SortAscImageUrl; }
            set { _SortAscImageUrl = value; }
        }

        /// <summary>
        /// Get/Set Image for displaying Descending Sort order.
        /// </summary>
        [
        Description("Image to display for Descending Sort"),
        Category("Misc"),
        Editor("System.Web.UI.Design.UrlEditor", typeof(System.Drawing.Design.UITypeEditor)),
        DefaultValue(""),
        ]
        public string SortDescImageUrl
        {
            get { return _SortDescImageUrl; }
            set { _SortDescImageUrl = value; }
        }

        /// <summary>
        /// Raises the <see cref="E:System.Web.UI.WebControls.GridView.Sorting"/> event.
        /// </summary>
        /// <param name="e">A <see cref="T:System.Web.UI.WebControls.GridViewSortEventArgs"/> that contains event data.</param>
        /// <exception cref="T:System.Web.HttpException">
        /// There is no handler for the <see cref="E:System.Web.UI.WebControls.GridView.Sorting"/> event.
        /// </exception>
        protected override void OnSorting(GridViewSortEventArgs e)
        {
            if (EnableMultiColumnSorting)
                e.SortExpression = GetSortExpression(e);
            base.OnSorting(e);
        }

        /// <summary>
        /// Raises the <see cref="E:System.Web.UI.WebControls.GridView.RowCreated"/> event.
        /// </summary>
        /// <param name="e">A <see cref="T:System.Web.UI.WebControls.GridViewRowEventArgs"/> that contains event data.</param>
        protected override void OnRowCreated(GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                if (this.SortField != String.Empty)
                    ShowSortOrderImages(this.SortField, e.Row);
            }
            base.OnRowCreated(e);
        }
        /// <summary>
        ///  Get Sort Expression from existing Grid View Sort Expression 
        /// </summary>
        protected string GetSortExpression(GridViewSortEventArgs e)
        {
            string[] sortColumns = null;
            string sortAttribute = SortField;
            if (sortAttribute != String.Empty)
            {
                sortColumns = sortAttribute.Split(",".ToCharArray());
            }
            if (sortAttribute.IndexOf(e.SortExpression) > 0 || sortAttribute.StartsWith(e.SortExpression))
                sortAttribute = UpdateSortExpression(sortColumns, e.SortExpression);
            else
                sortAttribute += String.Concat(",", e.SortExpression, " ASC ");
            return sortAttribute.TrimStart(",".ToCharArray()).TrimEnd(",".ToCharArray());

        }

        /// <summary>
        ///  Toggle the sort order or remove the column from sort
        /// </summary>
        protected string UpdateSortExpression(string[] sortColumns, string sortExpression)
        {
            string ascSortExpression = String.Concat(sortExpression, " ASC ");
            string descSortExpression = String.Concat(sortExpression, " DESC ");
            for (int i = 0; i < sortColumns.Length; i++)
            {
                if (ascSortExpression.Equals(sortColumns[i]))
                    sortColumns[i] = descSortExpression;
                else if (descSortExpression.Equals(sortColumns[i]))
                    Array.Clear(sortColumns, i, 1);
            }
            return String.Join(",", sortColumns).Replace(",,", ",").TrimStart(",".ToCharArray());
        }

        /// <summary>
        ///  Lookup the Current Sort Expression to determine the Order of a specific item.
        /// </summary>
        protected void SearchSortExpression(string[] sortColumns, string sortColumn, out string sortOrder, out int sortOrderNo)
        {
            sortOrder = "";
            sortOrderNo = -1;
            for (int i = 0; i < sortColumns.Length; i++)
            {
                if (sortColumns[i].StartsWith(sortColumn))
                {
                    sortOrderNo = i + 1;
                    if (EnableMultiColumnSorting)
                        sortOrder = sortColumns[i].Substring(sortColumn.Length).Trim();
                    else
                        sortOrder = ((SortDirection == SortDirection.Ascending) ? "ASC" : "DESC");
                }
            }
        }

        /// <summary>
        ///  Show an image for the Sort Order with sort sequence no.
        /// </summary>
        protected void ShowSortOrderImages(string sortExpression, GridViewRow dgItem)
        {
            string[] sortColumns = sortExpression.Split(",".ToCharArray());
            for (int i = 0; i < dgItem.Cells.Count; i++)
            {
                if (dgItem.Cells[i].Controls.Count > 0 && dgItem.Cells[i].Controls[0] is LinkButton)
                {
                    string sortOrder;
                    int sortOrderNo;
                    string column = ((LinkButton)dgItem.Cells[i].Controls[0]).CommandArgument;
                    SearchSortExpression(sortColumns, column, out sortOrder, out sortOrderNo);
                    if (sortOrderNo > 0)
                    {
                        string sortImgLoc = (sortOrder.Equals("ASC") ? SortAscImageUrl : SortDescImageUrl);

                        if (sortImgLoc != String.Empty)
                        {
                            Image imgSortDirection = new Image();
                            imgSortDirection.ImageUrl = sortImgLoc;
                            dgItem.Cells[i].Controls.Add(imgSortDirection);
                            if (EnableMultiColumnSorting && _ShowSortSequence)
                            {
                                Label lblSortOrder = new Label();
                                lblSortOrder.Font.Size = FontUnit.XSmall;
                                lblSortOrder.Font.Name = "verdana";
                                lblSortOrder.Font.Bold = false;
                                lblSortOrder.Text = sortOrderNo.ToString();
                                dgItem.Cells[i].Controls.Add(lblSortOrder);
                            }
                        }
                        else
                        {
                            Label lblSortDirection = new Label();
                            lblSortDirection.Font.Size = FontUnit.XSmall;
                            lblSortDirection.Font.Name = "verdana";
                            lblSortDirection.EnableTheming = false;
                            lblSortDirection.Text = (sortOrder.Equals("ASC") ? "^" : "v");
                            dgItem.Cells[i].Controls.Add(lblSortDirection);
                            if (EnableMultiColumnSorting && _ShowSortSequence)
                            {
                                Literal litSortSeq = new Literal();
                                litSortSeq.Text = sortOrderNo.ToString();
                                dgItem.Cells[i].Controls.Add(litSortSeq);
                            }
                        }
                    }
                }
            }
        }
        #endregion

        /// <summary>
        /// 
        /// </summary>
        /// <param name="dataSource"></param>
        /// <param name="dataBinding"></param>
        /// <returns></returns>
        protected override int CreateChildControls(IEnumerable dataSource, bool dataBinding)
        {
            int rows = base.CreateChildControls(dataSource, dataBinding);

            //  if the paging feature is enabled, determine
            //  the total number of rows in the datasource
            if (this.AllowPaging)
            {
                //  if we are databinding, use the number of rows that were created,
                //  otherwise cast the datasource to an Collection and use that as the count
                int totalRowCount = dataBinding ? rows : ((ICollection)dataSource).Count;

                //  raise the row count available event
                IPageableItemContainer pageableItemContainer = this as IPageableItemContainer;
                this.OnTotalRowCountAvailable(
                    new PageEventArgs(
                        pageableItemContainer.StartRowIndex,
                        pageableItemContainer.MaximumRows,
                        totalRowCount
                    )
                );

                //  make sure the top and bottom pager rows are not visible
                if (this.TopPagerRow != null)
                {
                    this.TopPagerRow.Visible = false;
                }

                if (this.BottomPagerRow != null)
                {
                    this.BottomPagerRow.Visible = false;
                }
            }

            return rows;
        }

        #region IPageableItemContainer Interface

        /// <summary>
        /// 
        /// </summary>
        /// <param name="startRowIndex"></param>
        /// <param name="maximumRows"></param>
        /// <param name="databind"></param>
        void IPageableItemContainer.SetPageProperties(
            int startRowIndex, int maximumRows, bool databind)
        {
            int newPageIndex = (startRowIndex / maximumRows);
            this.PageSize = maximumRows;

            //this caused a problem with changing the drop down pager list control.
            //if (this.PageIndex != newPageIndex)
            //{
                bool isCanceled = false;
                if (databind)
                {
                    //  create the event args and raise the event
                    GridViewPageEventArgs args = new GridViewPageEventArgs(newPageIndex);
                    this.OnPageIndexChanging(args);

                    isCanceled = args.Cancel;
                    newPageIndex = args.NewPageIndex;
                }

                //  if the event wasn't cancelled
                //  go ahead and change the paging values
                if (!isCanceled)
                {
                    this.PageIndex = newPageIndex;

                    if (databind)
                    {
                        this.OnPageIndexChanged(EventArgs.Empty);
                    }
                }

                if (databind)
                {
                    this.RequiresDataBinding = true;
                }
           // }
           

        }

        /// <summary>
        /// 
        /// </summary>
        int IPageableItemContainer.StartRowIndex
        {
            get { return this.PageSize * this.PageIndex; }
        }

        /// <summary>
        /// 
        /// </summary>
        int IPageableItemContainer.MaximumRows
        {
            get { return this.PageSize; }
        }

        /// <summary>
        /// 
        /// </summary>
        event EventHandler<PageEventArgs> IPageableItemContainer.TotalRowCountAvailable
        {
            add { base.Events.AddHandler(GridView.EventTotalRowCountAvailable, value); }
            remove { base.Events.RemoveHandler(GridView.EventTotalRowCountAvailable, value); }
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="e"></param>
        protected virtual void OnTotalRowCountAvailable(PageEventArgs e)
        {
            EventHandler<PageEventArgs> handler = (EventHandler<PageEventArgs>)base.Events[GridView.EventTotalRowCountAvailable];
            if (handler != null)
            {
                handler(this, e);
            }
        }


        #endregion
    }
}
