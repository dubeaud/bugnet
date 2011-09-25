namespace BugNET.UserControls
{
    using System;
    using System.Collections.Generic;
    using System.IO;
    using System.Web.UI.WebControls;

	/// <summary>
	///		Summary description for PickImage.
	/// </summary>
	public partial class PickImage : System.Web.UI.UserControl
	{
	
		//*********************************************************************
		//
		// PickImage.ascx
		//
		// This user control displays a list of images in a radiobutton list.
		// The control is used by the Status.ascx, Priority.ascx, and Milestone.ascx
		// controls.
		//
		//*********************************************************************


        /// <summary>
        /// Gets or sets the CSS class.
        /// </summary>
        /// <value>The CSS class.</value>
		public string CssClass 
		{
			get { return lstImages.CssClass; }
			set { lstImages.CssClass = value; }
		}


        /// <summary>
        /// Gets or sets the selected value.
        /// </summary>
        /// <value>The selected value.</value>
		public string SelectedValue 
		{
			get { return lstImages.SelectedValue; }
			set { lstImages.SelectedValue = value; }
		}


        /// <summary>
        /// 
        /// </summary>
		public string ImageDirectory = String.Empty;

       
        /// <summary>
        /// Initializes this instance.
        /// </summary>
		public void Initialize() 
		{
          
			DirectoryInfo objDir = new DirectoryInfo(MapPath("~/Images" + ImageDirectory));
			//FileInfo[] files = objDir.GetFiles("*.png");
            List<FileInfo> filesList = new List<FileInfo>();

            //Add the files of the directory to the list
            filesList.AddRange(objDir.GetFiles());

            //Find the files on the list using a delegate
            filesList = filesList.FindAll(delegate(FileInfo f) { return f.Extension.ToLower() == ".png" || f.Extension.ToLower() == ".jpg" || f.Extension.ToLower() == ".gif"; });

            string formatString = "<img valign=\"bottom\" src=\"" + ResolveUrl("~/Images") + ImageDirectory + "/{0}\" />";
    
			lstImages.DataSource = filesList;
			lstImages.DataTextField = "Name";
			lstImages.DataTextFormatString = formatString;
			lstImages.DataValueField = "Name";
			lstImages.DataBind();
    
			lstImages.Items.Insert(0, new ListItem(GetLocalResourceObject("None").ToString(), String.Empty ) );
			lstImages.SelectedIndex = 0;
		}


	
	}
}
