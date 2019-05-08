using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BugNET.Common;
using BugNET.BLL;
using BugNET.Entities;
using Microsoft.AspNet.FriendlyUrls;

namespace BugNET.Reports
{
    public partial class ReportList : BugNET.UserInterfaceLayer.BasePage 
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                this.Title = GetLocalResourceObject("PageTitle").ToString();

                IList<string> segments = Request.GetFriendlyUrlSegments();
                ProjectId = Int32.Parse(segments[0]);

                Project p = ProjectManager.GetById(ProjectId);
                litProjectCode.Text = p.Code;
                Literal1.Text = p.Name;
            }
        }
    }
}