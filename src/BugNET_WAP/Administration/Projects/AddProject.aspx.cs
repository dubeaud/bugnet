using System;
using System.Collections;
using System.Web.UI;
using BugNET.BLL;
using BugNET.Common;
using BugNET.UserInterfaceLayer;
using log4net;

namespace BugNET.Administration.Projects
{
    /// <summary>
    /// Summary description for AddProject.
    /// </summary>
	public partial class AddProject :  BasePage
	{
        ArrayList WizardSteps = new ArrayList();
        Control ctlWizardStep;
        private static readonly ILog Log = LogManager.GetLogger(typeof(AddProject));
        /// <summary>
        /// Gets or sets the index of the step.
        /// </summary>
        /// <value>The index of the step.</value>
        int StepIndex
        {
            get
            {
                if (ViewState["StepIndex"] == null)
                    return 0;
                else
                    return (int)ViewState["StepIndex"];
            }

            set { ViewState["StepIndex"] = value; }
        }

        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
		protected void Page_Load(object sender, System.EventArgs e)
		{
            if (!UserManager.HasPermission(Convert.ToInt32(Request.QueryString["id"]), Globals.Permission.AdminCreateProject.ToString()))
                Response.Redirect("~/Errors/AccessDenied.aspx");

            if (Request.Cookies[Globals.SKIP_PROJECT_INTRO] == null)
                WizardSteps.Add("UserControls/NewProjectIntro.ascx");        

            WizardSteps.Add("UserControls/ProjectDescription.ascx");
            WizardSteps.Add("UserControls/ProjectCategories.ascx");
            WizardSteps.Add("UserControls/ProjectStatus.ascx");
            WizardSteps.Add("UserControls/ProjectPriorities.ascx");
            WizardSteps.Add("UserControls/ProjectMilestones.ascx");
            WizardSteps.Add("UserControls/ProjectIssueTypes.ascx");
            WizardSteps.Add("UserControls/ProjectResolutions.ascx");
            WizardSteps.Add("UserControls/ProjectCustomFields.ascx");
            WizardSteps.Add("UserControls/ProjectRoles.ascx");
            WizardSteps.Add("UserControls/ProjectMembers.ascx");  
            WizardSteps.Add("UserControls/NewProjectSummary.ascx");

            LoadWizardStep();
		}

        /// <summary>
        /// Handles the PreRender event of the AddProject control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        private void AddProject_PreRender(object sender, EventArgs e)
        {
            if (StepIndex == 0)
                btnBack.Visible = false;
            else
                btnBack.Visible = true;

            if (StepIndex == (WizardSteps.Count - 1))
                btnNext.Text = "Finish";
            else
                btnNext.Text = "Next";
        }

        /// <summary>
        /// Loads the wizard step.
        /// </summary>
        private void LoadWizardStep()
        {
            ctlWizardStep = Page.LoadControl((string)WizardSteps[StepIndex]);
            ctlWizardStep.ID = "ctlWizardStep";
            ((IEditProjectControl)ctlWizardStep).ProjectId = ProjectId;
            plhWizardStep.Controls.Clear();
            plhWizardStep.Controls.Add(ctlWizardStep);
            ((IEditProjectControl)ctlWizardStep).Initialize();
            lblStepNumber.Text = String.Format("{2} {0} {3} {1}", StepIndex + 1, WizardSteps.Count, GetLocalResourceObject("Step").ToString(), GetLocalResourceObject("Of").ToString());
        

        }

        /// <summary>
        /// Handles the Click event of the btnCancel control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        private void btnCancel_Click(object sender, EventArgs e)
        {
            //delete any project that has already been created to prevent bad project data.
            if (ProjectId != -1)
            {
                if (!ProjectManager.Delete(ProjectId))
                    Log.Error("Error Deleting Project");
            }
            Response.Redirect("ProjectList.aspx");
        }

        /// <summary>
        /// Handles the Click event of the btnBack control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        private void btnBack_Click(object sender, EventArgs e)
        {
            StepIndex--;
            LoadWizardStep();
        }

        /// <summary>
        /// Handles the Click event of the btnNext control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        private void btnNext_Click(object sender, EventArgs e)
        {
            if (((IEditProjectControl)ctlWizardStep).Update())
            {
                ProjectId = ((IEditProjectControl)ctlWizardStep).ProjectId;
                StepIndex++;
                if (StepIndex == WizardSteps.Count)
                    Response.Redirect("ProjectList.aspx");
                else
                    LoadWizardStep();
            }
        }

		#region Web Form Designer generated code
        /// <summary>
        /// Overrides the default OnInit to provide a security check for pages
        /// </summary>
        /// <param name="e"></param>
		override protected void OnInit(EventArgs e)
		{
			//
			// CODEGEN: This call is required by the ASP.NET Web Form Designer.
			//
			InitializeComponent();
			base.OnInit(e);
		}
		
		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{    
            //this.Load += new System.EventHandler(this.Page_Load);
            this.PreRender += new EventHandler(AddProject_PreRender);
            this.btnCancel.Click += new EventHandler(btnCancel_Click);
            this.btnBack.Click += new EventHandler(btnBack_Click);
            this.btnNext.Click += new EventHandler(btnNext_Click);
		}

    
		#endregion
}
}
