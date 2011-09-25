using System;
using System.Data;

namespace BugNET.BusinessLogicLayer {



    /// <summary>
    /// Entity object for a custom issue query clause
    /// </summary>
    public class QueryClause 
    {
        private bool _isCustomControl;
        private string _booleanOperator;
        private string _fieldName;
        private string _comparisonOperator;
        private string _fieldValue;
        private SqlDbType _dataType;


        /// <summary>
        /// Gets the boolean operator.
        /// </summary>
        /// <value>The boolean operator.</value>
        public string BooleanOperator {
            get { return _booleanOperator; }
        }

        /// <summary>
        /// Gets the name of the field.
        /// </summary>
        /// <value>The name of the field.</value>
        public string FieldName {
            get { return _fieldName; }
        }


        /// <summary>
        /// Gets the comparison operator.
        /// </summary>
        /// <value>The comparison operator.</value>
        public string ComparisonOperator {
            get { return _comparisonOperator; }
        }


        /// <summary>
        /// Gets the field value.
        /// </summary>
        /// <value>The field value.</value>
        public string FieldValue {
            get { return _fieldValue; }
        }

        /// <summary>
        /// Gets the type of the data.
        /// </summary>
        /// <value>The type of the data.</value>
        public SqlDbType DataType {
            get { return _dataType; }
        }

        /// <summary>
        /// Gets or sets a value indicating whether [custom field query].
        /// </summary>
        /// <value><c>true</c> if [custom field query]; otherwise, <c>false</c>.</value>
        public bool CustomFieldQuery
        {
            get { return _isCustomControl; }
            set { _isCustomControl = value; }
        }


        /// <summary>
        /// Initializes a new instance of the <see cref="QueryClause"/> class.
        /// </summary>
        /// <param name="booleanOperator">The boolean operator.</param>
        /// <param name="fieldName">Name of the field.</param>
        /// <param name="comparisonOperator">The comparison operator.</param>
        /// <param name="fieldValue">The field value.</param>
        /// <param name="dataType">Type of the data.</param>
        public QueryClause(string booleanOperator, string fieldName, string comparisonOperator, string fieldValue, SqlDbType dataType,bool isCustomField) {
            _booleanOperator = booleanOperator;
            _fieldName = fieldName;
            _comparisonOperator = comparisonOperator;
            _fieldValue = fieldValue;
            _dataType = dataType;
            _isCustomControl = isCustomField;
        }
    }
}
