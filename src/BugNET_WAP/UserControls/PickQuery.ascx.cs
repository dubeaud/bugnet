using System;
using System.Collections.Generic;
using System.Web.UI.WebControls;
using BugNET.Common;
using BugNET.Entities;

namespace BugNET.UserControls
{
    /// <summary>
    ///	This user control displays a dropdown list of queries.
    /// </summary>
    public partial class PickQuery : System.Web.UI.UserControl
    {
        private List<Query> _dataSource;
        private bool _displayDefault;

        /// <summary>
        /// Gets the item count.
        /// </summary>
        /// <value>The item count.</value>
        public int ItemCount
        {
            get { return dropQueries.Items.Count; }
        }

        /// <summary>
        /// Gets or sets the selected value.
        /// </summary>
        /// <value>The selected value.</value>
        public int SelectedValue
        {
            get { return dropQueries.SelectedValue.ToOrDefault(0); }
            set { dropQueries.SelectedValue = value.ToString(); }
        }

        /// <summary>
        /// Gets or sets a value indicating whether [display default].
        /// </summary>
        /// <value><c>true</c> if [display default]; otherwise, <c>false</c>.</value>
        public bool DisplayDefault
        {
            get { return _displayDefault; }
            set { _displayDefault = value; }
        }


        /// <summary>
        /// Gets or sets the CSS class.
        /// </summary>
        /// <value>The CSS class.</value>
        public string CssClass
        {
            get { return dropQueries.CssClass; }
            set { dropQueries.CssClass = value; }
        }


        /// <summary>
        /// Gets or sets the data source.
        /// </summary>
        /// <value>The data source.</value>
        public List<Query> DataSource
        {
            get { return _dataSource; }
            set { _dataSource = value; }
        }

        /// <summary>
        /// Binds a data source to the invoked server control and all its child controls.
        /// </summary>
        public new void DataBind()
        {
            dropQueries.Items.Clear();
            dropQueries.DataSource = _dataSource;
            dropQueries.DataTextField = "Name";
            dropQueries.DataValueField = "Id";
            dropQueries.DataBind();
            if (_displayDefault)
                dropQueries.Items.Insert(0, new ListItem(GetLocalResourceObject("SelectQuery").ToString(), "0"));
        }
    }
}
