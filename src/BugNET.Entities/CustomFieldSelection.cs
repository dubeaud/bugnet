using BugNET.Common;

namespace BugNET.Entities
{

    /// <summary>
    /// Summary description for CustomFieldSelection
    /// </summary>
    public class CustomFieldSelection
    {

        #region Private Variables
        private int _Id;
        private int _CustomFieldId;
        private string _Name;
        private string _Value;
        private int _SortOrder;
        #endregion

        /// <summary>
        /// Initializes a new instance of the <see cref="T:CustomFieldSelection"/> class.
        /// </summary>
        /// <param name="id">The id.</param>
        /// <param name="customFieldId">The custom field id.</param>
        /// <param name="name">The name.</param>
        /// <param name="value">The value.</param>
        /// <param name="sortOrder">The sort order.</param>
        public CustomFieldSelection(int id, int customFieldId, string name, string value, int sortOrder)
        {
            _Id = id;
            _CustomFieldId = customFieldId;
            _Name = name;
            _Value = value;
            _SortOrder = sortOrder;
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="T:CustomFieldSelection"/> class.
        /// </summary>
        /// <param name="customFieldId">The custom field id.</param>
        /// <param name="name">The name.</param>
        /// <param name="value">The value.</param>
        public CustomFieldSelection(int customFieldId, string name, string value) :this(Globals.NEW_ID,customFieldId,name, value, Globals.NEW_ID)
        { }


        #region Properties
        /// <summary>
        /// Gets the id.
        /// </summary>
        /// <value>The id.</value>
        public int Id
        {
            get { return _Id; }
            set { _Id = value; }
        }


        /// <summary>
        /// Gets the custom field id.
        /// </summary>
        /// <value>The custom field id.</value>
        public int CustomFieldId
        {
            get { return _CustomFieldId; }
        }

        /// <summary>
        /// Gets or sets the name.
        /// </summary>
        /// <value>The name.</value>
        public string Name
        {
            get
            {
                if (_Name == null || _Name.Length == 0)
                    return string.Empty;
                else
                    return _Name;
            }
            set { _Name = value; }
        }

        /// <summary>
        /// Gets or sets the value.
        /// </summary>
        /// <value>The value.</value>
        public string Value
        {
            get
            {
                if (_Value == null || _Value.Length == 0)
                    return string.Empty;
                else
                    return _Value;
            }
            set { _Value = value; }
        }


        /// <summary>
        /// Gets or sets the sort order.
        /// </summary>
        /// <value>The sort order.</value>
        public int SortOrder
        {
            get { return _SortOrder; }
            set { _SortOrder = value; }
        }
        #endregion

      
    }
    
}