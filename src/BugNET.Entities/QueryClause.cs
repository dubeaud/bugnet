using System;
using System.Data;
using BugNET.Common;

namespace BugNET.Entities
{

    /// <summary>
    /// Entity object for a custom issue query clause
    /// </summary>
    public class QueryClause
    {
        /// <summary>
        /// Gets the Boolean operator.
        /// </summary>
        /// <value>The Boolean operator.</value>
        public string BooleanOperator { get; set; }

        /// <summary>
        /// Gets the name of the field.
        /// </summary>
        /// <value>The name of the field.</value>
        public string FieldName { get; set; }

        /// <summary>
        /// Gets the database column name of the field.
        /// </summary>
        /// <value>The name of the field.</value>
        public string DatabaseFieldName { 
            get
            {
                if (string.IsNullOrWhiteSpace(FieldName)) return "";

                return CustomFieldQuery ? 
                    string.Concat(Globals.PROJECT_CUSTOM_FIELDS_PREFIX, FieldName) : 
                    FieldName;
            }
        }

        /// <summary>
        /// Gets the comparison operator.
        /// </summary>
        /// <value>The comparison operator.</value>
        public string ComparisonOperator { get; set; }


        /// <summary>
        /// Gets the field value.
        /// </summary>
        /// <value>The field value.</value>
        public string FieldValue { get; set; }

        /// <summary>
        /// Gets the type of the data.
        /// </summary>
        /// <value>The type of the data.</value>
        public SqlDbType DataType { get; set; }

        /// <summary>
        /// Gets a value indicating whether [custom field query].
        /// </summary>
        /// <value><c>true</c> if [custom field query]; otherwise, <c>false</c>.</value>
        public bool CustomFieldQuery
        {
            get { return CustomFieldId.HasValue; }
        }

        /// <summary>
        /// Gets or sets a value indicating what custom field is used.
        /// </summary>
        /// <returns>The custom field id, otherwise null</returns>
        public int? CustomFieldId { get; set; }

        /// <summary>
        /// Initializes a new instance of the <see cref="QueryClause"/> class.
        /// </summary>
        /// <param name="booleanOperator">The Boolean operator.</param>
        /// <param name="fieldName">Name of the field.</param>
        /// <param name="comparisonOperator">The comparison operator.</param>
        /// <param name="fieldValue">The field value.</param>
        /// <param name="dataType">Type of the data.</param>
        /// <param name="customFieldId"> </param>
        public QueryClause(string booleanOperator, string fieldName, string comparisonOperator, string fieldValue, SqlDbType dataType, int? customFieldId = null)
        {
            BooleanOperator = booleanOperator;
            FieldName = fieldName;
            ComparisonOperator = comparisonOperator;
            FieldValue = fieldValue;
            DataType = dataType;
            CustomFieldId = customFieldId;
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="QueryClause"/> class.
        /// </summary>
        public QueryClause() { }
    }
}
