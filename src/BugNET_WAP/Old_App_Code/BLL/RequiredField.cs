using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Collections.Generic;
using BugNET.DataAccessLayer;

namespace BugNET.BusinessLogicLayer
{
    /// <summary>
    /// Required issue fields for query list.
    /// </summary>
    public class RequiredField
	{
	    private string _FieldName;  //store the field name from the table
	    private string _FieldValue; //store the field value from the table


        /// <summary>
        /// Initializes a new instance of the <see cref="RequiredField"/> class.
        /// </summary>
        /// <param name="fn">The fn.</param>
        /// <param name="fv">The fv.</param>
	    public RequiredField(string fn, string fv )
	    {
		    _FieldName = fn;
		    _FieldValue = fv;
	    }

        /// <summary>
        /// Gets the value.
        /// </summary>
        /// <value>The value.</value>
	    public  string Value
	    {
		    get { return _FieldValue; }
	    }

        /// <summary>
        /// Gets the name.
        /// </summary>
        /// <value>The name.</value>
	    public string Name
	    {
		    get {return _FieldName;}
	    }


        /// <summary>
        /// Gets the required fields.
        /// </summary>
        /// <returns></returns>
	    public static List<RequiredField> GetRequiredFields()
	    {
            return DataProviderManager.Provider.GetRequiredFieldsForIssues();	    
	    }

    }
}
