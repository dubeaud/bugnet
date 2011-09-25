using System;
using System.Data;
using System.Configuration;
using System.Collections.Generic;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using BugNET.DataAccessLayer;
using BugNET.BusinessLogicLayer;
namespace BugNET.BusinessLogicLayer
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
        public CustomFieldSelection(int customFieldId, string name, string value) :this(Globals.NewId,customFieldId,name, value, Globals.NewId)
        { }


        #region Properties
        /// <summary>
        /// Gets the id.
        /// </summary>
        /// <value>The id.</value>
        public int Id
        {
            get { return _Id; }
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

        /// <summary>
        /// Saves this instance.
        /// </summary>
        /// <returns></returns>
        public bool Save()
        {
            

            if (Id <= Globals.NewId)
            {
                int TempId = DataProviderManager.Provider.CreateNewCustomFieldSelection(this);
                if (TempId > 0)
                {
                    _Id = TempId;
                    return true;
                }
                else
                    return false;
            }
            else
                return (DataProviderManager.Provider.UpdateCustomFieldSelection(this));
        }


        #region Static Methods

        /// <summary>
        /// Deletes the custom field selection.
        /// </summary>
        /// <param name="customFieldSelectionId">The custom field selection id.</param>
        /// <returns></returns>
        public static bool DeleteCustomFieldSelection(int customFieldSelectionId)
        {
            if (customFieldSelectionId <= Globals.NewId)
                throw (new ArgumentOutOfRangeException("customFieldSelectionId"));


            return (DataProviderManager.Provider.DeleteCustomFieldSelection(customFieldSelectionId));
        }


        /// <summary>
        /// Gets the custom fields selections by custom field id.
        /// </summary>
        /// <param name="customFieldId">The custom field id.</param>
        /// <returns></returns>
        public static List<CustomFieldSelection> GetCustomFieldsSelectionsByCustomFieldId(int customFieldId)
        {
            if (customFieldId <= Globals.NewId)
                throw (new ArgumentOutOfRangeException("customFieldId"));


            return (DataProviderManager.Provider.GetCustomFieldSelectionsByCustomFieldId(customFieldId));
        }

        /// <summary>
        /// Updates the custom field selection.
        /// </summary>
        /// <param name="id">The id.</param>
        /// <param name="name">The name.</param>
        /// <param name="value">The value.</param>
        /// <param name="sortOrder">The sort order.</param>
        /// <param name="customFieldId">The custom field id.</param>
        /// <returns></returns>
        public static bool UpdateCustomFieldSelection(int id, string name, string value, int sortOrder,int customFieldId)
        {

            
            CustomFieldSelection cfs = GetCustomFieldSelectionById(id);
            
            cfs.Name = name;
            cfs.Value = value;
            cfs.SortOrder = sortOrder;
            //cfs.CustomFieldId = customFieldId;

            return (DataProviderManager.Provider.UpdateCustomFieldSelection(cfs));
        }

        /// <summary>
        /// Creates the custom field selection.
        /// </summary>
        /// <param name="name">The name.</param>
        /// <param name="value">The value.</param>
        /// <param name="customFieldId">The custom field id.</param>
        /// <param name="sortOrder">The sort order.</param>
        /// <returns></returns>
        public static int CreateCustomFieldSelection(string name, string value, 
             int customFieldId, int sortOrder)
        {

            
            CustomFieldSelection cfs = new CustomFieldSelection(Globals.NewId, customFieldId,
                name, value, sortOrder);

            return (DataProviderManager.Provider.CreateNewCustomFieldSelection(cfs));
        }

        /// <summary>
        /// Gets the custom field selection by id.
        /// </summary>
        /// <param name="id">The id.</param>
        /// <returns></returns>
        public static CustomFieldSelection GetCustomFieldSelectionById(int id)
        {
            return (DataProviderManager.Provider.GetCustomFieldSelectionById(id));
        }
        #endregion
    }
    
}