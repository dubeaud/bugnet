using System;
using System.Globalization;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BugNET.UserInterfaceLayer.WebControls
{
    public class BugNetPagerField : DataPagerField
    {
        private int _startRowIndex;
        private int _maximumRows;
        private int _totalRowCount;

        //Next and previous buttons by default are always enabled.
        private bool _showFirstPage = true;
        private bool _showPreviousPage = true;
        private bool _showNextPage = true;
        private bool _showLastPage = true;

        /// <summary>
        /// Initializes a new instance of the <see cref="BugNetPagerField"/> class.
        /// </summary>
        public BugNetPagerField()
        {}

        #region Properties
        /// <summary>
        /// Gets or sets the next page text.
        /// </summary>
        /// <value>The next page text.</value>
        public string NextPageText
        {
            get
            {
                object obj2 = base.ViewState["NextPageText"];
                if (obj2 != null)
                {
                    return (string)obj2;
                }
                return "Next";
            }
            set
            {
                if (value != this.NextPageText)
                {
                    base.ViewState["NextPageText"] = value;
                    this.OnFieldChanged();
                }
            }
        }

        /// <summary>
        /// Gets or sets the first page text.
        /// </summary>
        /// <value>The first page text.</value>
        public string FirstPageText
        {
            get
            {
                object obj2 = base.ViewState["FirstPageText"];
                if (obj2 != null)
                {
                    return (string)obj2;
                }
                return "First";
            }
            set
            {
                if (value != this.FirstPageText)
                {
                    base.ViewState["FirstPageText"] = value;
                    this.OnFieldChanged();
                }
            }
        }

        /// <summary>
        /// Gets or sets the previous page text.
        /// </summary>
        /// <value>The previous page text.</value>
        public string PreviousPageText
        {
            get
            {
                object obj2 = base.ViewState["PreviousPageText"];
                if (obj2 != null)
                {
                    return (string)obj2;
                }

                return "Previous";
            }
            set
            {
                if (value != this.PreviousPageText)
                {
                    base.ViewState["PreviousPageText"] = value;
                    this.OnFieldChanged();
                }
            }
        }

        /// <summary>
        /// Gets or sets the last page text.
        /// </summary>
        /// <value>The last page text.</value>
        public string LastPageText
        {
            get
            {
                object obj2 = base.ViewState["LastPageText"];
                if (obj2 != null)
                {
                    return (string)obj2;
                }

                return "Last";
            }
            set
            {
                if (value != this.PreviousPageText)
                {
                    base.ViewState["LastPageText"] = value;
                    this.OnFieldChanged();
                }
            }
        }

        /// <summary>
        /// Gets or sets the next page image URL.
        /// </summary>
        /// <value>The next page image URL.</value>
        public string NextPageImageUrl
        {
            get
            {
                object obj2 = base.ViewState["NextPageImageUrl"];
                if (obj2 != null)
                {
                    return (string)obj2;
                }
                return string.Empty;
            }
            set
            {
                if (value != this.NextPageImageUrl)
                {
                    base.ViewState["NextPageImageUrl"] = value;
                    this.OnFieldChanged();
                }
            }
        }

        /// <summary>
        /// Gets or sets the first page image URL.
        /// </summary>
        /// <value>The first page image URL.</value>
        public string FirstPageImageUrl
        {
            get
            {
                object obj2 = base.ViewState["FirstPageImageUrl"];
                if (obj2 != null)
                {
                    return (string)obj2;
                }
                return string.Empty;
            }
            set
            {
                if (value != this.FirstPageImageUrl)
                {
                    base.ViewState["FirstPageImageUrl"] = value;
                    this.OnFieldChanged();
                }
            }
        }

        /// <summary>
        /// Gets or sets the previous page image URL.
        /// </summary>
        /// <value>The previous page image URL.</value>
        public string PreviousPageImageUrl
        {
            get
            {
                object obj2 = base.ViewState["PreviousPageImageUrl"];
                if (obj2 != null)
                {
                    return (string)obj2;
                }
                return string.Empty;
            }
            set
            {
                if (value != this.PreviousPageImageUrl)
                {
                    base.ViewState["PreviousPageImageUrl"] = value;
                    this.OnFieldChanged();
                }
            }
        }

        /// <summary>
        /// Gets or sets the last page image URL.
        /// </summary>
        /// <value>The last page image URL.</value>
        public string LastPageImageUrl
        {
            get
            {
                object obj2 = base.ViewState["LastPageImageUrl"];
                if (obj2 != null)
                {
                    return (string)obj2;
                }
                return string.Empty;
            }
            set
            {
                if (value != this.LastPageImageUrl)
                {
                    base.ViewState["LastPageImageUrl"] = value;
                    this.OnFieldChanged();
                }
            }
        }

        /// <summary>
        /// Gets or sets a value indicating whether [render non breaking spaces between controls].
        /// </summary>
        /// <value>
        /// 	<c>true</c> if [render non breaking spaces between controls]; otherwise, <c>false</c>.
        /// </value>
        public bool RenderNonBreakingSpacesBetweenControls
        {
            get
            {
                object obj2 = base.ViewState["RenderNonBreakingSpacesBetweenControls"];
                if (obj2 != null)
                {
                    return (bool)obj2;
                }
                return true;
            }
            set
            {
                if (value != this.RenderNonBreakingSpacesBetweenControls)
                {
                    base.ViewState["RenderNonBreakingSpacesBetweenControls"] = value;
                    this.OnFieldChanged();
                }
            }
        }

        /// <summary>
        /// Gets or sets the button CSS class.
        /// </summary>
        /// <value>The button CSS class.</value>
        [CssClassProperty]
        public string ButtonCssClass
        {
            get
            {
                object obj2 = base.ViewState["ButtonCssClass"];
                if (obj2 != null)
                {
                    return (string)obj2;
                }
                return string.Empty;
            }
            set
            {
                if (value != this.ButtonCssClass)
                {
                    base.ViewState["ButtonCssClass"] = value;
                    this.OnFieldChanged();
                }
            }
        }

        /// <summary>
        /// Gets a value indicating whether [enable previous page].
        /// </summary>
        /// <value><c>true</c> if [enable previous page]; otherwise, <c>false</c>.</value>
        private bool EnablePreviousPage
        {
            get
            {
                return (this._startRowIndex > 0);
            }
        }

        /// <summary>
        /// Gets a value indicating whether [enable next page].
        /// </summary>
        /// <value><c>true</c> if [enable next page]; otherwise, <c>false</c>.</value>
        private bool EnableNextPage
        {
            get
            {
                return ((this._startRowIndex + this._maximumRows) < this._totalRowCount);
            }
        }
        #endregion

        /// <summary>
        /// When overridden in a derived class, creates the user interface (UI) controls for the data pager field object and adds them to the specified container.
        /// </summary>
        /// <param name="container">The container that is used to store the controls.</param>
        /// <param name="startRowIndex">The index of the first record on the page.</param>
        /// <param name="maximumRows">The maximum number of items on a single page.</param>
        /// <param name="totalRowCount">The total number of items.</param>
        /// <param name="fieldIndex">The index of the data pager field in the <see cref="P:System.Web.UI.WebControls.DataPager.Fields"/> collection.</param>
        public override void CreateDataPagers(DataPagerFieldItem container, int startRowIndex, int maximumRows, int totalRowCount, int fieldIndex)
        {
            this._startRowIndex = startRowIndex;
            this._maximumRows = maximumRows;
            this._totalRowCount = totalRowCount;

            if (string.IsNullOrEmpty(base.DataPager.QueryStringField))
            {
                this.CreateDataPagersForCommand(container, fieldIndex);
            }
            else
            {
                this.CreateDataPagersForQueryString(container, fieldIndex);
            }
        }

        /// <summary>
        /// When overridden in a derived class, creates an empty object that is derived <see cref="T:System.Web.UI.WebControls.DataPagerField"/>.
        /// </summary>
        /// <returns>
        /// An empty object that is derived from <see cref="T:System.Web.UI.WebControls.DataPagerField"/>.
        /// </returns>
        protected override DataPagerField CreateField()
        {
            return new BugNetPagerField();
        }

        /// <summary>
        /// When overridden in a derived class, handles events that occur in the data pager field object.
        /// </summary>
        /// <param name="e">The event data.</param>
        public override void HandleEvent(CommandEventArgs e)
        {
            if (string.Equals(e.CommandName, "UpdatePageSize"))
            {
                base.DataPager.PageSize = Int32.Parse(e.CommandArgument.ToString());
                base.DataPager.SetPageProperties(this._startRowIndex, base.DataPager.PageSize, true);
                return;
            }

            //if (string.Equals(e.CommandName, "GoToItem"))
            //{
            //    //int newStartRowIndex = Int32.Parse(e.CommandArgument.ToString()) - 1;
            //    //base.DataPager.SetPageProperties(newStartRowIndex, base.DataPager.PageSize, true);
            //    //return;

            //    int pageNumber;
            //    int newStartRowIndex;
            //    if (int.TryParse(e.CommandArgument.ToString(), out pageNumber) && pageNumber > 0 && pageNumber <= (this._totalRowCount / base.DataPager.PageSize) +1)
            //    {
            //        newStartRowIndex= pageNumber;
            //    }
            //    else
            //    {
            //        newStartRowIndex = 0;
            //    }

            //    base.DataPager.SetPageProperties(newStartRowIndex,base.DataPager.PageSize, true);
            //    return;
            //}
            if (string.Equals(e.CommandName, "GoToItem"))
            {
                int newStartRowIndex = 0;
                try
                {
                    newStartRowIndex = Int32.Parse(e.CommandArgument.ToString());
                    if (newStartRowIndex == 1)
                        newStartRowIndex = 0;
                    else
                        newStartRowIndex--;
                }
                catch (FormatException)
                {
                    newStartRowIndex = 0;
                }

                base.DataPager.SetPageProperties(newStartRowIndex, base.DataPager.PageSize, true);
                return;
            }
           
            if (string.IsNullOrEmpty(base.DataPager.QueryStringField))
            {
                if (string.Equals(e.CommandName, "First"))
                {
                    base.DataPager.SetPageProperties(0, base.DataPager.PageSize, true);
                }
                else if (string.Equals(e.CommandName, "Last"))
                {
                    base.DataPager.SetPageProperties(this._totalRowCount, base.DataPager.PageSize, true);
                }
                else if (string.Equals(e.CommandName, "Prev"))
                {
                    int startRowIndex = this._startRowIndex - base.DataPager.PageSize;
                    if (startRowIndex < 0)
                    {
                        startRowIndex = 0;
                    }
                    base.DataPager.SetPageProperties(startRowIndex, base.DataPager.PageSize, true);
                }
                else if (string.Equals(e.CommandName, "Next"))
                {
                    int nextStartRowIndex = this._startRowIndex + base.DataPager.PageSize;

                    if (nextStartRowIndex >= this._totalRowCount)  
                        nextStartRowIndex = this._startRowIndex;   

                    if (nextStartRowIndex < 0)
                        nextStartRowIndex = 0;

                    base.DataPager.SetPageProperties(nextStartRowIndex, base.DataPager.PageSize, true);
                }
            }
        }

        /// <summary>
        /// Creates the data pagers for command.
        /// </summary>
        /// <param name="container">The container.</param>
        /// <param name="fieldIndex">Index of the field.</param>
        private void CreateDataPagersForCommand(DataPagerFieldItem container, int fieldIndex)
        {
            //Goto item texbox
            //this.CreateGoToTexBox(container);
           
            //Control used to set the page size.
            this.CreatePageSizeControl(container);

            //Set of records - total records
            this.CreateLabelRecordControl(container);

            //First button
            if (this._showFirstPage)
            {
                container.Controls.Add(this.CreateControl("First", this.FirstPageText, fieldIndex, this.FirstPageImageUrl, this._showFirstPage));
                this.AddNonBreakingSpace(container);
            }

            //Previous button
            if (this._showPreviousPage)
            {
                container.Controls.Add(this.CreateControl("Prev", this.PreviousPageText, fieldIndex, this.PreviousPageImageUrl, this._showPreviousPage));
                this.AddNonBreakingSpace(container);
            }

            //Next button
            if (this._showNextPage)
            {
                container.Controls.Add(this.CreateControl("Next", this.NextPageText, fieldIndex, this.NextPageImageUrl, this._showNextPage));
                this.AddNonBreakingSpace(container);
            }

            if (this._showLastPage)
            {
                container.Controls.Add(this.CreateControl("Last", this.LastPageText, fieldIndex, this.LastPageImageUrl, this._showLastPage));
                this.AddNonBreakingSpace(container);
            }
        }

        /// <summary>
        /// Creates the control.
        /// </summary>
        /// <param name="commandName">Name of the command.</param>
        /// <param name="buttonText">The button text.</param>
        /// <param name="fieldIndex">Index of the field.</param>
        /// <param name="imageUrl">The image URL.</param>
        /// <param name="enabled">if set to <c>true</c> [enabled].</param>
        /// <returns></returns>
        private Control CreateControl(string commandName, string buttonText, int fieldIndex, string imageUrl, bool enabled)
        {
            IButtonControl control;

            control = new ImageButton();
            ((ImageButton)control).ImageUrl = imageUrl;
            ((ImageButton)control).Enabled = enabled;
            ((ImageButton)control).AlternateText = HttpUtility.HtmlDecode(buttonText);

            control.Text = buttonText;
            control.CommandName = commandName;
            control.CommandArgument = fieldIndex.ToString(CultureInfo.InvariantCulture);
            WebControl control2 = control as WebControl;
            if ((control2 != null) && !string.IsNullOrEmpty(this.ButtonCssClass))
            {
                control2.CssClass = this.ButtonCssClass;
            }

            return (control as Control);
        }

        /// <summary>
        /// Adds the non breaking space.
        /// </summary>
        /// <param name="container">The container.</param>
        private void AddNonBreakingSpace(DataPagerFieldItem container)
        {
            if (this.RenderNonBreakingSpacesBetweenControls)
            {
                container.Controls.Add(new LiteralControl("&nbsp;"));
            }
        }

        /// <summary>
        /// Creates the label record control.
        /// </summary>
        /// <param name="container">The container.</param>
        private void CreateLabelRecordControl(DataPagerFieldItem container)
        {
            int endRowIndex = this._startRowIndex + base.DataPager.PageSize;

            if (endRowIndex > this._totalRowCount)
                endRowIndex = this._totalRowCount;

            container.Controls.Add(new LiteralControl(string.Format("{0} - {1} of {2}", this._startRowIndex + 1, endRowIndex, this._totalRowCount)));

            this.AddNonBreakingSpace(container);
            this.AddNonBreakingSpace(container);
            this.AddNonBreakingSpace(container);
        }

        /// <summary>
        /// Creates the page size control.
        /// </summary>
        /// <param name="container">The container.</param>
        private void CreatePageSizeControl(DataPagerFieldItem container)
        {
            container.Controls.Add(new LiteralControl("Show rows: "));

            ButtonDropDownList pageSizeDropDownList = new ButtonDropDownList();

            pageSizeDropDownList.CommandName = "UpdatePageSize";

            pageSizeDropDownList.Items.Add(new ListItem("5", "5"));
            pageSizeDropDownList.Items.Add(new ListItem("10", "10"));
            pageSizeDropDownList.Items.Add(new ListItem("15", "15"));
            pageSizeDropDownList.Items.Add(new ListItem("25", "25"));
            pageSizeDropDownList.Items.Add(new ListItem("50", "50"));
            pageSizeDropDownList.Items.Add(new ListItem("75", "75"));
            pageSizeDropDownList.Items.Add(new ListItem("100", "100"));

            ListItem pageSizeItem = pageSizeDropDownList.Items.FindByValue(base.DataPager.PageSize.ToString());

            if (pageSizeItem == null)
            {
                pageSizeItem = new ListItem(base.DataPager.PageSize.ToString(), base.DataPager.PageSize.ToString());
                pageSizeDropDownList.Items.Insert(0, pageSizeItem);
            }

            pageSizeItem.Selected = true;
            container.Controls.Add(pageSizeDropDownList);
            
            this.AddNonBreakingSpace(container);
            this.AddNonBreakingSpace(container);
        }

        /// <summary>
        /// Creates the go to tex box.
        /// </summary>
        /// <param name="container">The container.</param>
        private void CreateGoToTexBox(DataPagerFieldItem container)
        {
            Label label = new Label();
            label.Text = "Go to: ";
            container.Controls.Add(label);

            ButtonTextBox goToTextBox = new ButtonTextBox();
            
            goToTextBox.CommandName = "GoToItem";
            goToTextBox.Width = new Unit("20px");
            container.Controls.Add(goToTextBox);

            this.AddNonBreakingSpace(container);
            this.AddNonBreakingSpace(container);
        }

        /// <summary>
        /// Creates the data pagers for query string.
        /// </summary>
        /// <param name="container">The container.</param>
        /// <param name="fieldIndex">Index of the field.</param>
        private void CreateDataPagersForQueryString(DataPagerFieldItem container, int fieldIndex)
        {
            bool validPageIndex = false;
            if (!base.QueryStringHandled)
            {
                int num;
                base.QueryStringHandled = true;
                if (int.TryParse(base.QueryStringValue, out num))
                {
                    num--;
                    int currentPageIndex = this._startRowIndex / this._maximumRows;
                    int maxPageIndex = (this._totalRowCount - 1) / this._maximumRows;
                    if ((num >= 0) && (num <= maxPageIndex))
                    {
                        this._startRowIndex = num * this._maximumRows;
                        validPageIndex = true;
                    }
                }
            }

            //Goto item texbox
            this.CreateGoToTexBox(container);

            //Control used to set the page size.
            this.CreatePageSizeControl(container);

            //Set of records - total records
            this.CreateLabelRecordControl(container);

            if (this._showPreviousPage)
            {
                int pageIndex = (this._startRowIndex / this._maximumRows) - 1;
                container.Controls.Add(this.CreateLink(this.PreviousPageText, pageIndex, this.PreviousPageImageUrl, this.EnablePreviousPage));
                this.AddNonBreakingSpace(container);
            }
            if (this._showNextPage)
            {
                int num4 = (this._startRowIndex + this._maximumRows) / this._maximumRows;
                container.Controls.Add(this.CreateLink(this.NextPageText, num4, this.NextPageImageUrl, this.EnableNextPage));
                this.AddNonBreakingSpace(container);
            }
            if (this._showFirstPage)
            {
                container.Controls.Add(this.CreateLink(this.FirstPageText, 0, this.FirstPageImageUrl, true));
                this.AddNonBreakingSpace(container);
            }
            if (this._showLastPage)
            {
                container.Controls.Add(this.CreateLink(this.LastPageText, _totalRowCount, this.LastPageImageUrl, true));
                this.AddNonBreakingSpace(container);
            }
            if (validPageIndex)
            {
                base.DataPager.SetPageProperties(this._startRowIndex, this._maximumRows, true);
            }
        }

        /// <summary>
        /// Creates the link.
        /// </summary>
        /// <param name="buttonText">The button text.</param>
        /// <param name="pageIndex">Index of the page.</param>
        /// <param name="imageUrl">The image URL.</param>
        /// <param name="enabled">if set to <c>true</c> [enabled].</param>
        /// <returns></returns>
        private HyperLink CreateLink(string buttonText, int pageIndex, string imageUrl, bool enabled)
        {
            int pageNumber = pageIndex + 1;
            HyperLink link = new HyperLink();
            link.Text = buttonText;
            link.NavigateUrl = base.GetQueryStringNavigateUrl(pageNumber);
            link.ImageUrl = imageUrl;
            link.Enabled = enabled;
            if (!string.IsNullOrEmpty(this.ButtonCssClass))
            {
                link.CssClass = this.ButtonCssClass;
            }
            return link;
        }
    }
}