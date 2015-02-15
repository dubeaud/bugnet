
namespace BugNET.UserInterfaceLayer
{

    using System;
    using System.Web.UI.WebControls;
    /// <summary>
    /// Menu Tab Class
    /// </summary>
	public class Tab : HyperLink
	{

        /// <summary>
        /// Initializes a new instance of the <see cref="T:Tab"/> class.
        /// </summary>
        /// <param name="name">The name.</param>
        /// <param name="url">The URL.</param>
		public Tab(string name, string url) 
		{
			this.Text  = String.Format("<span>{0}</span>",name);
			this.NavigateUrl = url;
		}

		
	}

}