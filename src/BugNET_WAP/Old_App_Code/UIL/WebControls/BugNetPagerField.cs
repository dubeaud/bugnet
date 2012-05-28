using System;
using System.Globalization;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BugNET.Common;

namespace BugNET.UserInterfaceLayer.WebControls
{
    public class BugNetPagerField : DataPagerField
    {
        private readonly string _goTo = HttpContext.GetGlobalResourceObject("SharedResources", "GoTo").ToString();
        private readonly string _rowXofY = HttpContext.GetGlobalResourceObject("SharedResources", "RowXofY").ToString();

        private readonly string _ShowRows =
            HttpContext.GetGlobalResourceObject("SharedResources", "ShowRows").ToString();

        private int _maximumRows;

        //Next and previous buttons by default are always enabled.
        private const bool SHOW_FIRST_PAGE = true;
        private const bool SHOW_LAST_PAGE = true;
        private const bool SHOW_NEXT_PAGE = true;
        private const bool SHOW_PREVIOUS_PAGE = true;
        private int _startRowIndex;
        private int _totalRowCount;

        #region Properties

        /// <summary>
        /// Gets or sets the next page text.
        /// </summary>
        /// <value>The next page text.</value>
        public string NextPageText
        {
            get { return ViewState.Get("NextPageText", "Next"); }
            set
            {
                if (value == NextPageText) return;
                ViewState.Set("NextPageText", value);
                OnFieldChanged();
            }
        }

        /// <summary>
        /// Gets or sets the first page text.
        /// </summary>
        /// <value>The first page text.</value>
        public string FirstPageText
        {
            get { return ViewState.Get("FirstPageText", "First"); }
            set
            {
                if (value == FirstPageText) return;
                ViewState.Set("FirstPageText", value);
                OnFieldChanged();
            }
        }

        /// <summary>
        /// Gets or sets the previous page text.
        /// </summary>
        /// <value>The previous page text.</value>
        public string PreviousPageText
        {
            get { return ViewState.Get("PreviousPageText", "Previous"); }
            set
            {
                if (value == PreviousPageText) return;
                ViewState.Set("PreviousPageText", value);
                OnFieldChanged();
            }
        }

        /// <summary>
        /// Gets or sets the last page text.
        /// </summary>
        /// <value>The last page text.</value>
        public string LastPageText
        {
            get { return ViewState.Get("LastPageText", "Last"); }
            set
            {
                if (value == LastPageText) return;
                ViewState.Set("LastPageText", value);
                OnFieldChanged();
            }
        }

        /// <summary>
        /// Gets or sets the next page image URL.
        /// </summary>
        /// <value>The next page image URL.</value>
        public string NextPageImageUrl
        {
            get { return ViewState.Get("NextPageImageUrl", string.Empty); }
            set
            {
                if (value == NextPageImageUrl) return;
                ViewState.Set("NextPageImageUrl", value);
                OnFieldChanged();
            }
        }

        /// <summary>
        /// Gets or sets the first page image URL.
        /// </summary>
        /// <value>The first page image URL.</value>
        public string FirstPageImageUrl
        {
            get { return ViewState.Get("FirstPageImageUrl", string.Empty); }
            set
            {
                if (value == FirstPageImageUrl) return;
                ViewState.Set("FirstPageImageUrl", value);
                OnFieldChanged();
            }
        }

        /// <summary>
        /// Gets or sets the previous page image URL.
        /// </summary>
        /// <value>The previous page image URL.</value>
        public string PreviousPageImageUrl
        {
            get { return ViewState.Get("PreviousPageImageUrl", string.Empty); }
            set
            {
                if (value == PreviousPageImageUrl) return;
                ViewState.Set("PreviousPageImageUrl", value);
                OnFieldChanged();
            }
        }

        /// <summary>
        /// Gets or sets the last page image URL.
        /// </summary>
        /// <value>The last page image URL.</value>
        public string LastPageImageUrl
        {
            get { return ViewState.Get("LastPageImageUrl", string.Empty); }
            set
            {
                if (value == LastPageImageUrl) return;
                ViewState.Set("LastPageImageUrl", value);
                OnFieldChanged();
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
            get { return ViewState.Get("RenderNonBreakingSpacesBetweenControls", true); }
            set
            {
                if (value == RenderNonBreakingSpacesBetweenControls) return;
                ViewState.Set("RenderNonBreakingSpacesBetweenControls", value);
                OnFieldChanged();
            }
        }

        /// <summary>
        /// Gets or sets the button CSS class.
        /// </summary>
        /// <value>The button CSS class.</value>
        [CssClassProperty]
        public string ButtonCssClass
        {
            get { return ViewState.Get("ButtonCssClass", string.Empty); }
            set
            {
                if (value == ButtonCssClass) return;
                ViewState.Set("ButtonCssClass", value);
                OnFieldChanged();
            }
        }

        /// <summary>
        /// Gets a value indicating whether [enable previous page].
        /// </summary>
        /// <value><c>true</c> if [enable previous page]; otherwise, <c>false</c>.</value>
        private bool EnablePreviousPage
        {
            get { return (_startRowIndex > 0); }
        }

        /// <summary>
        /// Gets a value indicating whether [enable next page].
        /// </summary>
        /// <value><c>true</c> if [enable next page]; otherwise, <c>false</c>.</value>
        private bool EnableNextPage
        {
            get { return ((_startRowIndex + _maximumRows) < _totalRowCount); }
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
        public override void CreateDataPagers(DataPagerFieldItem container, int startRowIndex, int maximumRows,
                                              int totalRowCount, int fieldIndex)
        {
            _startRowIndex = startRowIndex;
            _maximumRows = maximumRows;
            _totalRowCount = totalRowCount;

            if (string.IsNullOrEmpty(DataPager.QueryStringField))
            {
                CreateDataPagersForCommand(container, fieldIndex);
            }
            else
            {
                CreateDataPagersForQueryString(container);
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
                DataPager.PageSize = Int32.Parse(e.CommandArgument.ToString());
                DataPager.SetPageProperties(_startRowIndex, DataPager.PageSize, true);
                return;
            }

            //if (string.Equals(e.CommandName, "GoToItem"))
            //{
            //    //int newStartRowIndex = Int32.Parse(e.CommandArgument.ToString()) - 1;
            //    //DataPager.SetPageProperties(newStartRowIndex, DataPager.PageSize, true);
            //    //return;

            //    int pageNumber;
            //    int newStartRowIndex;
            //    if (int.TryParse(e.CommandArgument.ToString(), out pageNumber) && pageNumber > 0 && pageNumber <= (this._totalRowCount / DataPager.PageSize) +1)
            //    {
            //        newStartRowIndex= pageNumber;
            //    }
            //    else
            //    {
            //        newStartRowIndex = 0;
            //    }

            //    DataPager.SetPageProperties(newStartRowIndex,DataPager.PageSize, true);
            //    return;
            //}
            if (string.Equals(e.CommandName, "GoToItem"))
            {
                int newStartRowIndex;
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

                DataPager.SetPageProperties(newStartRowIndex, DataPager.PageSize, true);
                return;
            }

            if (string.IsNullOrEmpty(DataPager.QueryStringField))
            {
                if (string.Equals(e.CommandName, "First"))
                {
                    DataPager.SetPageProperties(0, DataPager.PageSize, true);
                }
                else if (string.Equals(e.CommandName, "Last"))
                {
                    DataPager.SetPageProperties(_totalRowCount, DataPager.PageSize, true);
                }
                else if (string.Equals(e.CommandName, "Prev"))
                {
                    int startRowIndex = _startRowIndex - DataPager.PageSize;
                    if (startRowIndex < 0)
                    {
                        startRowIndex = 0;
                    }
                    DataPager.SetPageProperties(startRowIndex, DataPager.PageSize, true);
                }
                else if (string.Equals(e.CommandName, "Next"))
                {
                    int nextStartRowIndex = _startRowIndex + DataPager.PageSize;

                    if (nextStartRowIndex >= _totalRowCount)
                        nextStartRowIndex = _startRowIndex;

                    if (nextStartRowIndex < 0)
                        nextStartRowIndex = 0;

                    DataPager.SetPageProperties(nextStartRowIndex, DataPager.PageSize, true);
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
            CreatePageSizeControl(container);

            //Set of records - total records
            CreateLabelRecordControl(container);

            //First button
            container.Controls.Add(CreateControl("First", FirstPageText, fieldIndex, FirstPageImageUrl, SHOW_FIRST_PAGE));

            AddNonBreakingSpace(container);

            //Previous button
            container.Controls.Add(CreateControl("Prev", PreviousPageText, fieldIndex, PreviousPageImageUrl, SHOW_PREVIOUS_PAGE));
            AddNonBreakingSpace(container);

            //Next button
            container.Controls.Add(CreateControl("Next", NextPageText, fieldIndex, NextPageImageUrl, SHOW_NEXT_PAGE));
            AddNonBreakingSpace(container);

            container.Controls.Add(CreateControl("Last", LastPageText, fieldIndex, LastPageImageUrl, SHOW_LAST_PAGE));
            AddNonBreakingSpace(container);
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
        private Control CreateControl(string commandName, string buttonText, int fieldIndex, string imageUrl,
                                      bool enabled)
        {
            IButtonControl control = new ImageButton();
            ((ImageButton) control).ImageUrl = imageUrl;
            ((ImageButton) control).Enabled = enabled;
            ((ImageButton) control).AlternateText = HttpUtility.HtmlDecode(buttonText);

            control.Text = buttonText;
            control.CommandName = commandName;
            control.CommandArgument = fieldIndex.ToString(CultureInfo.InvariantCulture);
            var control2 = control as WebControl;
            if (!string.IsNullOrEmpty(ButtonCssClass))
            {
                control2.CssClass = ButtonCssClass;
            }

            return (control as Control);
        }

        /// <summary>
        /// Adds the non breaking space.
        /// </summary>
        /// <param name="container">The container.</param>
        private void AddNonBreakingSpace(DataPagerFieldItem container)
        {
            if (RenderNonBreakingSpacesBetweenControls)
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
            int endRowIndex = _startRowIndex + DataPager.PageSize;

            if (endRowIndex > _totalRowCount)
                endRowIndex = _totalRowCount;

            container.Controls.Add(
                new LiteralControl(string.Format(_rowXofY, _startRowIndex + 1, endRowIndex, _totalRowCount)));
            AddNonBreakingSpace(container);
            AddNonBreakingSpace(container);
            AddNonBreakingSpace(container);
        }

        /// <summary>
        /// Creates the page size control.
        /// </summary>
        /// <param name="container">The container.</param>
        private void CreatePageSizeControl(DataPagerFieldItem container)
        {
            container.Controls.Add(new LiteralControl(_ShowRows));

            var pageSizeDropDownList = new ButtonDropDownList {CommandName = "UpdatePageSize"};

            pageSizeDropDownList.Items.Add(new ListItem("5", "5"));
            pageSizeDropDownList.Items.Add(new ListItem("10", "10"));
            pageSizeDropDownList.Items.Add(new ListItem("15", "15"));
            pageSizeDropDownList.Items.Add(new ListItem("25", "25"));
            pageSizeDropDownList.Items.Add(new ListItem("50", "50"));
            pageSizeDropDownList.Items.Add(new ListItem("75", "75"));
            pageSizeDropDownList.Items.Add(new ListItem("100", "100"));

            var pageSizeItem = pageSizeDropDownList.Items.FindByValue(DataPager.PageSize.ToString());

            if (pageSizeItem == null)
            {
                pageSizeItem = new ListItem(DataPager.PageSize.ToString(), DataPager.PageSize.ToString());
                pageSizeDropDownList.Items.Insert(0, pageSizeItem);
            }

            pageSizeItem.Selected = true;
            container.Controls.Add(pageSizeDropDownList);

            AddNonBreakingSpace(container);
            AddNonBreakingSpace(container);
        }

        /// <summary>
        /// Creates the go to tex box.
        /// </summary>
        /// <param name="container">The container.</param>
        private void CreateGoToTexBox(DataPagerFieldItem container)
        {
            var label = new Label {Text = _goTo};
            container.Controls.Add(label);

            var goToTextBox = new ButtonTextBox {CommandName = "GoToItem", Width = new Unit("20px")};

            container.Controls.Add(goToTextBox);

            AddNonBreakingSpace(container);
            AddNonBreakingSpace(container);
        }

        /// <summary>
        /// Creates the data pagers for query string.
        /// </summary>
        /// <param name="container">The container.</param>
        private void CreateDataPagersForQueryString(DataPagerFieldItem container)
        {
            var validPageIndex = false;
            if (!QueryStringHandled)
            {
                int num;
                QueryStringHandled = true;
                if (int.TryParse(QueryStringValue, out num))
                {
                    num--;
                    var maxPageIndex = (_totalRowCount - 1)/_maximumRows;
                    if ((num >= 0) && (num <= maxPageIndex))
                    {
                        _startRowIndex = num*_maximumRows;
                        validPageIndex = true;
                    }
                }
            }

            //Goto item texbox
            CreateGoToTexBox(container);

            //Control used to set the page size.
            CreatePageSizeControl(container);

            //Set of records - total records
            CreateLabelRecordControl(container);

            var pageIndex = (_startRowIndex/_maximumRows) - 1;
            container.Controls.Add(CreateLink(PreviousPageText, pageIndex, PreviousPageImageUrl, EnablePreviousPage));
            AddNonBreakingSpace(container);

            var num4 = (_startRowIndex + _maximumRows)/_maximumRows;
            container.Controls.Add(CreateLink(NextPageText, num4, NextPageImageUrl, EnableNextPage));
            AddNonBreakingSpace(container);

            container.Controls.Add(CreateLink(FirstPageText, 0, FirstPageImageUrl, true));
            AddNonBreakingSpace(container);

            container.Controls.Add(CreateLink(LastPageText, _totalRowCount, LastPageImageUrl, true));
            AddNonBreakingSpace(container);

            if (validPageIndex)
            {
                DataPager.SetPageProperties(_startRowIndex, _maximumRows, true);
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
            var pageNumber = pageIndex;
            var link = new HyperLink
                           {
                               Text = buttonText,
                               NavigateUrl = GetQueryStringNavigateUrl(pageNumber),
                               ImageUrl = imageUrl,
                               Enabled = enabled
                           };
            if (!string.IsNullOrEmpty(ButtonCssClass))
            {
                link.CssClass = ButtonCssClass;
            }
            return link;
        }
    }
}