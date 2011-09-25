using System;
using System.Web.UI.WebControls;
using BugNET.Common;


namespace BugNET.Entities {
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
                : this(Globals.NEW_ID , projectId, name, dataType, required, String.Empty,fieldType)
            { }


            /// <summary>
            /// Initializes a new instance of the <see cref="T:CustomField"/> class.
            /// </summary>
            /// <param name="id">The id.</param>
            /// <param name="value">The value.</param>
            public CustomField(int id, string value)
                : this(id, Globals.NEW_ID, String.Empty, ValidationDataType.String, false, value,CustomFieldType.Text)
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
                set { _Id = value; }
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
    }
}
