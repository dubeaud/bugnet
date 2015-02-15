using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Web;
using System.Linq;

namespace BugNET.Entities
{
   public class DefaultValue
   {
        public bool StatusVisibility { get; set; }

        public bool OwnedByVisibility { get; set; }

        public bool PriorityVisibility { get; set; }

        public bool AssignedToVisibility { get; set; }

        public bool PrivateVisibility { get; set; }

        public bool CategoryVisibility { get; set; }

        public bool DueDateVisibility { get; set; }

        public bool TypeVisibility { get; set; }
  
        public bool PercentCompleteVisibility { get; set; }

        public bool MilestoneVisibility { get; set; }
   
        public bool EstimationVisibility { get; set; }

        public bool ResolutionVisibility { get; set; }

        public bool AffectedMilestoneVisibility { get; set; }

        public bool StatusEditVisibility { get; set; }

        public bool OwnedByEditVisibility { get; set; }

        public bool PriorityEditVisibility { get; set; }

        public bool AssignedToEditVisibility { get; set; }

        public bool PrivateEditVisibility { get; set; }

        public bool CategoryEditVisibility { get; set; }

        public bool DueDateEditVisibility { get; set; }

        public bool TypeEditVisibility { get; set; }

        public bool PercentCompleteEditVisibility { get; set; }

        public bool MilestoneEditVisibility { get; set; }

        public bool EstimationEditVisibility { get; set; }

        public bool ResolutionEditVisibility { get; set; }

        public bool AffectedMilestoneEditVisibility { get; set; }
     
        public bool AssignedToNotify { get; set; }
       
        public bool OwnedByNotify { get; set; }
       
        public int IssueVisibility { get; set; }

        /// <summary>
        /// Category Id
        /// </summary>
        public int CategoryId { get; set; }
        
        /// <summary>
        /// Gets the owner username.
        /// </summary>
        /// <value>The owner username.</value>
        public string OwnerUserName { get; set; }

        public string AssignedUserName { get; set; }
      
        /// <summary>
        /// Gets or sets the version id.
        /// </summary>
        /// <value>The version id.</value>
        public int MilestoneId { get; set; }
        
        /// <summary>
        /// Gets or sets the affected milestone id.
        /// </summary>
        /// <value>The affected milestone id.</value>
        public int AffectedMilestoneId { get; set; }
       
        /// <summary>
        /// Gets or sets the type id.
        /// </summary>
        /// <value>The type id.</value>
        public int IssueTypeId { get; set; }
       
        /// <summary>
        /// Gets or sets the resolution id.
        /// </summary>
        /// <value>The resolution id.</value>
        public int ResolutionId { get; set; }

        /// <summary>
        /// Gets or sets the priority id.
        /// </summary>
        /// <value>The priority id.</value>
        public int PriorityId { get; set; } 

        /// <summary>
        /// Gets the project id.
        /// </summary>
        /// <value>The project id.</value>
        public int ProjectId { get; set; }     

        /// <summary>
        /// Gets or sets the status id.
        /// </summary>
        /// <value>The status id.</value>
        public int StatusId { get; set; }
        

        /// <summary>
        /// Gets or sets the due date.
        /// </summary>
        /// <value>
        /// The due date.
        /// </value>
        public int? DueDate { get; set; }

        /// <summary>
        /// Gets or sets the estimation.
        /// </summary>
        /// <value>
        /// The estimation.
        /// </value>
        public decimal Estimation { get; set; }

        /// <summary>
        /// Gets or sets the progress.
        /// </summary>
        /// <value>
        /// The progress.
        /// </value>
        public int Progress { get; set; }

    }
}