namespace BugNET.Entities
{
    /// <summary>
    /// Required issue fields for query list.
    /// </summary>
    public class RequiredField
	{
        /// <summary>
        /// Initializes a new instance of the <see cref="RequiredField"/> class.
        /// </summary>
        /// <param name="fn">The fn.</param>
        /// <param name="fv">The fv.</param>
	    public RequiredField(string fn, string fv )
	    {
		    Name = fn;
		    Value = fv;
	    }

        /// <summary>
        /// Gets the value.
        /// </summary>
        /// <value>The value.</value>
        public string Value { get; private set; }

        /// <summary>
        /// Gets the name.
        /// </summary>
        /// <value>The name.</value>
        public string Name { get; private set; }
	}
}
