namespace BugNET.Administration.Projects.UserControls
{
    using System;
    using System.Collections;
    using System.ComponentModel;
    using System.Data;
    using System.Drawing;
    using System.Web;
    using System.Web.SessionState;
    using System.Web.UI;
    using System.Web.UI.WebControls;
    using System.Web.UI.HtmlControls;
    using BugNET.UserControls;
    using System.Threading;
    using System.Collections.Generic;
    using System.Linq;
    using BugNET.UserInterfaceLayer;
    using BugNET.Entities;
    using BugNET.BLL;


    /// <summary>
    /// 
    /// </summary>
    public partial class ProjectDefaultValues : System.Web.UI.UserControl, IEditProjectControl
    {
        /// <summary>
        /// Binds the options.
        /// </summary>
        private void BindOptions()
        {
            FillDropDownLists();
            ReadDefaultValuesForProject();
        }

        /// <summary>
        /// Reads the default values for project.
        /// </summary>
        private void ReadDefaultValuesForProject()
        {
            List<DefaultValue> defValues = IssueManager.GetDefaultIssueTypeByProjectId(ProjectId);
            DefaultValue selectedValue = null;
            if (defValues.Count > 0)
                selectedValue = defValues.ElementAt<DefaultValue>(0);

            if (selectedValue != null)
            {
                DropIssueType.SelectedValue = selectedValue.IssueTypeId;
                DropPriority.SelectedValue = selectedValue.PriorityId;
                DropResolution.SelectedValue = selectedValue.ResolutionId;
                DropCategory.SelectedValue = selectedValue.CategoryId;
                DropMilestone.SelectedValue = selectedValue.MilestoneId;
                DropAffectedMilestone.SelectedValue = selectedValue.AffectedMilestoneId;

                if (selectedValue.AssignedUserName != "none")
                    DropAssignedTo.SelectedValue = selectedValue.AssignedUserName;

                if (selectedValue.OwnerUserName != "none")
                    DropOwned.SelectedValue = selectedValue.OwnerUserName;

                DropStatus.SelectedValue = selectedValue.StatusId;

                if (selectedValue.IssueVisibility == 0) chkPrivate.Checked = false;
                if (selectedValue.IssueVisibility == 1) chkPrivate.Checked = true;

                if (selectedValue.DueDate.HasValue)
                {
                    DueDate.Text = selectedValue.DueDate.Value.ToString();
                }
               
                ProgressSlider.Text = selectedValue.Progress.ToString();
                txtEstimation.Text = selectedValue.Estimation.ToString();

                //Visibility Section

                chkStatusVisibility.Checked = selectedValue.StatusVisibility;
                chkOwnedByVisibility.Checked = selectedValue.OwnedByVisibility;
                chkPriorityVisibility.Checked = selectedValue.PriorityVisibility;
                chkAssignedToVisibility.Checked = selectedValue.AssignedToVisibility;
                chkPrivateVisibility.Checked = selectedValue.PrivateVisibility;
                chkCategoryVisibility.Checked = selectedValue.CategoryVisibility;
                chkDueDateVisibility.Checked = selectedValue.DueDateVisibility;
                chkTypeVisibility.Checked = selectedValue.TypeVisibility;
                chkPercentCompleteVisibility.Checked = selectedValue.PercentCompleteVisibility;
                chkMilestoneVisibility.Checked = selectedValue.MilestoneVisibility;
                chkEstimationVisibility.Checked = selectedValue.EstimationVisibility;
                chkResolutionVisibility.Checked = selectedValue.ResolutionVisibility;
                chkAffectedMilestoneVisibility.Checked = selectedValue.AffectedMilestoneVisibility;
                chkNotifyAssignedTo.Checked = selectedValue.AssignedToNotify;
                chkNotifyOwner.Checked = selectedValue.OwnedByNotify;
            }                                             
        }

        /// <summary>
        /// Fills the drop down lists.
        /// </summary>
        private void FillDropDownLists()
        {
            List<ITUser> users = UserManager.GetUsersByProjectId(ProjectId);
            //Get Type 

            DropIssueType.DataSource = IssueTypeManager.GetByProjectId(ProjectId);
            DropIssueType.DataBind();

            //Get Priority
            DropPriority.DataSource = PriorityManager.GetByProjectId(ProjectId);
            DropPriority.DataBind();

            //Get Resolutions
            DropResolution.DataSource = ResolutionManager.GetByProjectId(ProjectId);
            DropResolution.DataBind();

            //Get categories
            CategoryTree categories = new CategoryTree();
            DropCategory.DataSource = categories.GetCategoryTreeByProjectId(ProjectId);
            DropCategory.DataBind();

            //Get milestones          
            DropMilestone.DataSource = MilestoneManager.GetByProjectId(ProjectId, false);
            DropMilestone.DataBind();

            DropAffectedMilestone.DataSource = MilestoneManager.GetByProjectId(ProjectId, false);
            DropAffectedMilestone.DataBind();

            //Get Users
            DropAssignedTo.DataSource = users;
            DropAssignedTo.DataBind();

            DropOwned.DataSource = users;
            DropOwned.DataBind();

            DropStatus.DataSource = StatusManager.GetByProjectId(ProjectId);
            DropStatus.DataBind();
        }
       
        #region IEditProjectControl Members
        /// <summary>
        /// Gets or sets the project id.
        /// </summary>
        /// <value>The project id.</value>
        public int ProjectId
        {
            get { return ((BasePage)Page).ProjectId; }
            set { ((BasePage)Page).ProjectId = value; }
        }

        /// <summary>
        /// Gets a value indicating whether [show save button].
        /// </summary>
        /// <value>
        ///   <c>true</c> if [show save button]; otherwise, <c>false</c>.
        /// </value>
        public bool ShowSaveButton
        {
            get { return true; }
        }

        /// <summary>
        /// Inits this instance.
        /// </summary>
        public void Initialize()
        {
            DueDateLabel.Text = String.Format(" ({0})   +", DateTime.Today.ToShortDateString());
            BindOptions();
        }

        /// <summary>
        /// Updates this instance.
        /// </summary>
        /// <returns></returns>
        public bool Update()
        {
            if (Page.IsValid)
                return SaveDefaultValues();
            else
                return false;
        }

        /// <summary>
        /// Saves the default values.
        /// </summary>
        /// <returns></returns>
        private bool SaveDefaultValues()
        {
            int privateValue = chkPrivate.Checked ? 1 : 0;
            int? date = 0;
            if (!string.IsNullOrWhiteSpace(DueDate.Text))
            {
                date = Int32.Parse(DueDate.Text);
            }
            else
            {
                date = null;
            }

            Decimal estimation = 0;
            if (!string.IsNullOrWhiteSpace(txtEstimation.Text))
            {
                estimation = Convert.ToDecimal(txtEstimation.Text);
            }

            DefaultValue newDefaultValues = new DefaultValue()
            {
                ProjectId = this.ProjectId,
                IssueTypeId = DropIssueType.SelectedValue,
                StatusId = DropStatus.SelectedValue,
                OwnerUserName = DropOwned.SelectedValue,
                PriorityId = DropPriority.SelectedValue,
                AffectedMilestoneId = DropAffectedMilestone.SelectedValue,
                AssignedUserName = DropAssignedTo.SelectedValue,
                PrivateVisibility = chkPrivateVisibility.Checked,
                IssueVisibility = privateValue,
                Progress = Convert.ToInt32(ProgressSlider.Text),
                MilestoneId = DropMilestone.SelectedValue,
                CategoryId = DropCategory.SelectedValue,
                DueDate = date,
                Estimation = estimation,
                ResolutionId = DropResolution.SelectedValue,
                StatusVisibility = chkStatusVisibility.Checked,
                OwnedByVisibility = chkOwnedByVisibility.Checked,
                PriorityVisibility = chkPriorityVisibility.Checked,
                AssignedToVisibility = chkAssignedToVisibility.Checked,
                TypeVisibility = chkTypeVisibility.Checked,
                PercentCompleteVisibility = chkPercentCompleteVisibility.Checked,
                MilestoneVisibility = chkMilestoneVisibility.Checked,
                EstimationVisibility = chkEstimationVisibility.Checked,
                ResolutionVisibility = chkResolutionVisibility.Checked,
                AffectedMilestoneVisibility = chkAffectedMilestoneVisibility.Checked,
                AssignedToNotify = chkNotifyAssignedTo.Checked,
                OwnedByNotify = chkNotifyOwner.Checked,
                CategoryVisibility = chkCategoryVisibility.Checked,
                DueDateVisibility = chkDueDateVisibility.Checked
            };

            return IssueManager.SaveDefaultValues(newDefaultValues);
        }
    
        #endregion
    }
}
