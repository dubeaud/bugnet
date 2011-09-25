using System.Collections.Generic;

namespace BugNET.Entities
{

    /// <summary>
    /// 
    /// </summary>
    public class JsTreeNode
    {
        public JsTreeNode()
        {}

        /// <summary>
        /// Gets or sets the attributes.
        /// </summary>
        /// <value>The attributes.</value>
        public Attributes attr
        {
            get;
            set;
        }

        /// <summary>
        /// Gets or sets the data.
        /// </summary>
        /// <value>The data.</value>
        public Data data
        {
            get;
            set;
        }
        /// <summary>
        /// Gets or sets the state.
        /// </summary>
        /// <value>The state.</value>
        public string state
        {
            get;
            set;
        }

        /// <summary>
        /// 
        /// </summary>
        public List<JsTreeNode> children = new List<JsTreeNode>();

    }

    /// <summary>
    /// 
    /// </summary>
    public class Attributes
    {
        /// <summary>
        /// Gets or sets the id.
        /// </summary>
        /// <value>The id.</value>
        public string id
        {
            get;
            set;
        }

        /// <summary>
        /// Gets or sets the rel.
        /// </summary>
        /// <value>The rel.</value>
        public string rel
        {
            get;
            set;
        }

        /// <summary>
        /// Gets or sets the mdata.
        /// </summary>
        /// <value>The mdata.</value>
        public string mdata
        {
            get;
            set;
        }
    }

    /// <summary>
    /// 
    /// </summary>
    public class Data
    {

        /// <summary>
        /// Gets or sets the title.
        /// </summary>
        /// <value>The title.</value>
        public string title
        {
            get;
            set;
        }

        /// <summary>
        /// Gets or sets the icon.
        /// </summary>
        /// <value>The icon.</value>
        public string icon
        {
            get;
            set;
        }
    }

}