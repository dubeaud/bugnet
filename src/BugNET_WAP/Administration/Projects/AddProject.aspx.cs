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
    public partial class AddProject : BasePage
    {
        readonly ArrayList _wizardSteps = new ArrayList();

        Control _ctlWizardStep;

        private static readonly ILog Log = LogManager.GetLogger(typeof(AddProject));

        /// <summary>
        /// Gets or sets the index of the step.
        /// </summary>
        /// <value>The index of the step.</value>
        int StepIndex
        {
            get { return ViewState.Get("StepIndex", 0); }
            set { ViewState.Set("StepIndex", value); }
        }

        /// <summary>
        /// Loads the wizard step.
        /// </summary>
        private void LoadWizardStep()
        {
            _ctlWizardStep = Page.LoadControl((string)_wizardSteps[StepIndex]);
            _ctlWizardStep.ID = "ctlWizardStep";
            ((IEditProjectControl)_ctlWizardStep).ProjectId = ProjectId;
            plhWizardStep.Controls.Clear();
            plhWizardStep.Controls.Add(_ctlWizardStep);
            ((IEditProjectControl)_ctlWizardStep).Initialize();
            lblStepNumber.Text = String.Format("{2} {0} {3} {1}", StepIndex + 1, _wizardSteps.Count, GetLocalResourceObject("Step"), GetLocalResourceObject("Of"));

            //Hide BACK button on StepIndex = 0 (Wizard step 1 of 10)
            btnBack.Visible = StepIndex != 0;
        }

        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!UserManager.IsSuperUser())
                Response.Redirect("~/Errors/AccessDenied.aspx");

            if (Request.Cookies[Globals.SKIP_PROJECT_INTRO] == null)
                _wizardSteps.Add("UserControls/NewProjectIntro.ascx");

            _wizardSteps.Add("UserControls/ProjectDescription.ascx");
            _wizardSteps.Add("UserControls/ProjectCategories.ascx");
            _wizardSteps.Add("UserControls/ProjectStatus.ascx");
            _wizardSteps.Add("UserControls/ProjectPriorities.ascx");
            _wizardSteps.Add("UserControls/ProjectMilestones.ascx");
            _wizardSteps.Add("UserControls/ProjectIssueTypes.ascx");
            _wizardSteps.Add("UserControls/ProjectResolutions.ascx");
            _wizardSteps.Add("UserControls/ProjectMembers.ascx");
            _wizardSteps.Add("UserControls/NewProjectSummary.ascx");

            LoadWizardStep();
        }

        /// <summary>
        /// Raises the <see cref="E:System.Web.UI.Control.PreRender"/> event.
        /// </summary>
        /// <param name="e">An <see cref="T:System.EventArgs"/> object that contains the event data.</param>
        protected override void OnPreRender(EventArgs e)
        {
            base.OnPreRender(e);

            btnNext.Text = StepIndex == (_wizardSteps.Count - 1) ?
                GetLocalResourceObject("Finish").ToString() :
                GetLocalResourceObject("Next").ToString();
        }

        /// <summary>
        /// Handles the Click event of the btnCancel control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void btnCancel_Click(object sender, EventArgs e)
        {
            //delete any project that has already been created to prevent bad project data.
            if (ProjectId != 0)
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
        protected void btnBack_Click(object sender, EventArgs e)
        {
            StepIndex--;
            LoadWizardStep();
        }

        /// <summary>
        /// Handles the Click event of the btnNext control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void btnNext_Click(object sender, EventArgs e)
        {
            if (((IEditProjectControl)_ctlWizardStep).Update())
            {
                ProjectId = ((IEditProjectControl)_ctlWizardStep).ProjectId;
                
                StepIndex++;
                
                if (StepIndex == _wizardSteps.Count)
                    Response.Redirect("ProjectList.aspx");
                else
                    LoadWizardStep();
            }
        }
    }
}
