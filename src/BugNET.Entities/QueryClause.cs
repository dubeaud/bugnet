using System.Data;

namespace BugNET.Entities
{

    /// <summary>
    /// Entity object for a custom issue query clause
    /// </summary>
    public class QueryClause
    {
        /// <summary>
        /// Gets the boolean operator.
        /// </summary>
        /// <value>The boolean operator.</value>
        public string BooleanOperator { get; set; }

        /// <summary>
        /// Gets the name of the field.
        /// </summary>
        /// <value>The name of the field.</value>
        public string FieldName { get; set; }


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
        /// Gets or sets a value indicating whether [custom field query].
        /// </summary>
        /// <value><c>true</c> if [custom field query]; otherwise, <c>false</c>.</value>
        public bool CustomFieldQuery { get; set; }


        /// <summary>
        /// Initializes a new instance of the <see cref="QueryClause"/> class.
        /// </summary>
        /// <param name="booleanOperator">The boolean operator.</param>
        /// <param name="fieldName">Name of the field.</param>
        /// <param name="comparisonOperator">The comparison operator.</param>
        /// <param name="fieldValue">The field value.</param>
        /// <param name="dataType">Type of the data.</param>
        /// <param name="isCustomField"></param>
        public QueryClause(string booleanOperator, string fieldName, string comparisonOperator, string fieldValue, SqlDbType dataType, bool isCustomField)
        {
            BooleanOperator = booleanOperator;
            FieldName = fieldName;
            ComparisonOperator = comparisonOperator;
            FieldValue = fieldValue;
            DataType = dataType;
            CustomFieldQuery = isCustomField;
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="QueryClause"/> class.
        /// </summary>
        public QueryClause() { }
    }
}
