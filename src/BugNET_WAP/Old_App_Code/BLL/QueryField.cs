using System;
using System.Collections;
using System.Web.UI.WebControls;
using BugNET.DataAccessLayer;


namespace BugNET.BusinessLogicLayer
{
    /// <summary>
    /// Represents a query field
    /// </summary>
	public class QueryField
	{

   /*** FIELD PRIVATE ***/
    private string      _Name;
    private string      _FriendlyName;


    /// <summary>
    /// Initializes a new instance of the <see cref="QueryField"/> class.
    /// </summary>
    /// <param name="friendlyName">Name of the friendly.</param>
    /// <param name="name">The name.</param>
    public QueryField(string friendlyName, string name) {
        _FriendlyName = friendlyName;
        _Name = name;
	}


    /// <summary>
    /// Gets or sets the name.
    /// </summary>
    /// <value>The name.</value>
    public string Name
    {
      get
      {
        if (_Name == null ||_Name.Length==0)
          return string.Empty;
        else
          return _Name;
      }
      set {_Name=value;}
    }



    /// <summary>
    /// Gets the name of the friendly.
    /// </summary>
    /// <value>The name of the friendly.</value>
    public string FriendlyName
    {
      get
      {
        if (_FriendlyName == null ||_FriendlyName.Length==0)
          return string.Empty;
        else
          return _FriendlyName;
      }
    }








    }
}
