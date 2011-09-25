using System;
using System.Collections;
using System.Collections.Generic;
using System.Web.UI.WebControls;
using BugNET.DataAccessLayer;


namespace BugNET.BusinessLogicLayer {
    /// <summary>
    /// Custom Fields Class
    /// </summary>
    public class CustomField {

        #region Private Variables
            private int _Id;
            private int _ProjectId;
            private string _Name;
            ValidationDataType _DataType;
            bool _Required;
            private string _Value;
            private CustomFieldType _FieldType;
        #endregion

        public enum CustomFieldType : int
        {
            None = 0,
            Text = 1,
            DropDownList = 2,
            Date = 3,
            RichText = 4,
            YesNo = 5,
            UserList = 6
        }
        

        #region Constructors
            /// <summary>
            /// Initializes a new instance of the <see cref="T:CustomField"/> class.
            /// </summary>
            /// <param name="projectId">The project id.</param>
            /// <param name="name">The name.</param>
            /// <param name="dataType">Type of the data.</param>
            /// <param name="required">if set to <c>true</c> [required].</param>
            /// <param name="fieldType">Type of the field.</param>
            public CustomField(int projectId, string name, ValidationDataType dataType, bool required,CustomFieldType fieldType)
                : this(Globals.NewId , projectId, name, dataType, required, String.Empty,fieldType)
            { }


            /// <summary>
            /// Initializes a new instance of the <see cref="T:CustomField"/> class.
            /// </summary>
            /// <param name="id">The id.</param>
            /// <param name="value">The value.</param>
            public CustomField(int id, string value)
                : this(id, Globals.NewId, String.Empty, ValidationDataType.String, false, value,CustomFieldType.Text)
            { }

            /// <summary>
            /// Initializes a new instance of the <see cref="T:CustomField"/> class.
            /// </summary>
            /// <param name="id">The id.</param>
            /// <param name="projectId">The project id.</param>
            /// <param name="name">The name.</param>
            /// <param name="dataType">Type of the data.</param>
            /// <param name="required">if set to <c>true</c> [required].</param>
            /// <param name="value">The value.</param>
            /// <param name="fieldType">Type of the field.</param>
            public CustomField(int id, int projectId, string name, ValidationDataType dataType, bool required, string value, CustomFieldType fieldType)
            {
                _Id = id;
                _ProjectId = projectId;
                _Name = name;
                _DataType = dataType;
                _Required = required;
                _Value = value;
                _FieldType = fieldType;
            } 
            #endregion

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
            /// Gets the project id.
            /// </summary>
            /// <value>The project id.</value>
            public int ProjectId
            {
                get { return _ProjectId; }
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
            /// Gets the type of the data.
            /// </summary>
            /// <value>The type of the data.</value>
            public ValidationDataType DataType
            {
                get { return _DataType; }
                set { _DataType = value; }
            }

            /// <summary>
            /// Gets the type of the field.
            /// </summary>
            /// <value>The type of the field.</value>
            public CustomFieldType FieldType
            {
                get { return _FieldType; }
                set { _FieldType = value; }
            }

            /// <summary>
            /// Gets a value indicating whether this <see cref="T:CustomField"/> is required.
            /// </summary>
            /// <value><c>true</c> if required; otherwise, <c>false</c>.</value>
            public bool Required
            {
                get { return _Required; }
                set { _Required = value; }
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
            #endregion

        #region Instance Methods
            /// <summary>
            /// Saves this instance.
            /// </summary>
            /// <returns></returns>
            public bool Save()
            {
                

                if (Id <= Globals.NewId)
                {
                    int TempId = DataProviderManager.Provider.CreateNewCustomField(this);
                    if (TempId > 0)
                    {
                        _Id = TempId;
                        return true;
                    }
                    else
                        return false;
                }
                else
                    return (DataProviderManager.Provider.UpdateCustomField(this));
            }
            
        #endregion

        #region Static Methods
            /// <summary>
            /// Deletes the custom field.
            /// </summary>
            /// <param name="customFieldId">The custom field id.</param>
            /// <returns></returns>
            public static bool DeleteCustomField(int customFieldId)
            {
                if (customFieldId <= Globals.NewId)
                    throw (new ArgumentOutOfRangeException("customFieldId"));


                return (DataProviderManager.Provider.DeleteCustomField(customFieldId));
            }

            /// <summary>
            /// Saves the custom field values.
            /// </summary>
            /// <param name="issueId">The issue id.</param>
            /// <param name="fields">The fields.</param>
            /// <returns></returns>
            public static bool SaveCustomFieldValues(int issueId, List<CustomField> fields)
            {
                if (issueId <= Globals.NewId)
                    throw new ArgumentNullException("issueId");

                if (fields == null)
                    throw (new ArgumentOutOfRangeException("fields"));


                return (DataProviderManager.Provider.SaveCustomFieldValues(issueId, fields));
            }

            /// <summary>
            /// Gets the custom fields by project id.
            /// </summary>
            /// <param name="projectId">The project id.</param>
            /// <returns></returns>
            public static List<CustomField> GetCustomFieldsByProjectId(int projectId)
            {
                if (projectId <= Globals.NewId)
                    throw (new ArgumentOutOfRangeException("projectId"));


                return (DataProviderManager.Provider.GetCustomFieldsByProjectId(projectId));
            }

            /// <summary>
            /// Gets the custom field by id.
            /// </summary>
            /// <param name="customFieldId">The custom field id.</param>
            /// <returns></returns>
            public static CustomField GetCustomFieldById(int customFieldId)
            {
                if (customFieldId <= Globals.NewId)
                    throw (new ArgumentOutOfRangeException("customFieldId"));

                return DataProviderManager.Provider.GetCustomFieldById(customFieldId);
            }

            /// <summary>
            /// Gets the custom fields by bug id.
            /// </summary>
            /// <param name="bugId">The bug id.</param>
            /// <returns></returns>
            public static List<CustomField> GetCustomFieldsByIssueId(int bugId)
            {
                if (bugId <= Globals.NewId)
                    throw (new ArgumentOutOfRangeException("bugId"));


                return (DataProviderManager.Provider.GetCustomFieldsByIssueId(bugId));
            } 
        #endregion

    }
}
