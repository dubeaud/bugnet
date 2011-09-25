using System;
using System.Runtime.Serialization;

namespace BugNET.Services.DataContracts
{
    [DataContract]
    public class IssueContract
    {
        /// <summary>
        /// Gets or sets the id.
        /// </summary>
        /// <value>The id.</value>
        [DataMember]
        public int Id
        {
            get;
            set;
        }

        /// <summary>
        /// Gets or sets the title.
        /// </summary>
        /// <value>The title.</value>
        [DataMember]
        public string Title
        {
            get;
            set;
        }

        /// <summary>
        /// Gets or sets the description.
        /// </summary>
        /// <value>The description.</value>
        [DataMember]
        public string Description
        {
            get;
            set;
        }

        /// <summary>
        /// Gets or sets the status id.
        /// </summary>
        /// <value>The status id.</value>
        [DataMember]
        public int StatusId
        {
            get;
            set;
        }

        /// <summary>
        /// Gets or sets the issue type id.
        /// </summary>
        /// <value>The issue type id.</value>
        [DataMember]
        public int IssueTypeId
        {
            get;
            set;
        }

        /// <summary>
        /// Gets or sets the milestone id.
        /// </summary>
        /// <value>The milestone id.</value>
        [DataMember]
        public int MilestoneId
        {
            get;
            set;
        }
        /// <summary>
        /// Gets or sets the milestone id.
        /// </summary>
        /// <value>The milestone id.</value>
        [DataMember]
        public int AffectedMilestoneId
        {
            get;
            set;
        }
        /// <summary>
        /// Gets or sets the milestone due date.
        /// </summary>
        /// <value>The milestone due date.</value>
        [DataMember]
        public DateTime? MilestoneDueDate
        {
            get;
            set;
        }

        /// <summary>
        /// Gets or sets the priority id.
        /// </summary>
        /// <value>The priority id.</value>
        [DataMember]
        public int PriorityId
        {
            get;
            set;
        }
        /// <summary>
        /// Gets or sets the resolution id.
        /// </summary>
        /// <value>The resolution id.</value>
        [DataMember]
        public int ResolutionId
        {
            get;
            set;
        }
        /// <summary>
        /// Gets or sets the project id.
        /// </summary>
        /// <value>The project id.</value>
        [DataMember]
        public int ProjectId
        {
            get;
            set;
        }

        /// <summary>
        /// Gets or sets the due date.
        /// </summary>
        /// <value>The due date.</value>
        [DataMember]
        public DateTime DueDate
        {
            get;
            set;
        }
        /// <summary>
        /// Gets or sets the date created.
        /// </summary>
        /// <value>The date created.</value>
        [DataMember]
        public DateTime DateCreated
        {
            get;
            set;
        }

        /// <summary>
        /// Gets or sets the last update.
        /// </summary>
        /// <value>The last update.</value>
        [DataMember]
        public DateTime LastUpdate
        {
            get;
            set;
        }

        /// <summary>
        /// Gets or sets the progress.
        /// </summary>
        /// <value>The progress.</value>
        [DataMember]
        public int Progress
        {
            get;
            set;
        }

        /// <summary>
        /// Gets or sets the votes.
        /// </summary>
        /// <value>The votes.</value>
        [DataMember]
        public int Votes
        {
            get;
            set;
        }


        /// <summary>
        /// Gets or sets the owner user id.
        /// </summary>
        /// <value>The owner user id.</value>
        [DataMember]
        public Guid OwnerUserId
        {
            get;
            set;
        }
        /// <summary>
        /// Gets or sets the assigned user id.
        /// </summary>
        /// <value>The assigned user id.</value>
        [DataMember]
        public Guid AssignedUserId
        {
            get;
            set;
        }

        /// <summary>
        /// Gets or sets the creator user id.
        /// </summary>
        /// <value>The creator user id.</value>
        [DataMember]
        public Guid CreatorUserId
        {
            get;
            set;
        }

        /// <summary>
        /// Gets or sets the last update user id.
        /// </summary>
        /// <value>The last update user id.</value>
        [DataMember]
        public Guid LastUpdateUserId
        {
            get;
            set;
        }

        /// <summary>
        /// Gets or sets the visibility.
        /// </summary>
        /// <value>The visibility.</value>
        [DataMember]
        public int Visibility
        {
            get;
            set;
        }

        /// <summary>
        /// Gets or sets the category id.
        /// </summary>
        /// <value>The category id.</value>
        [DataMember]
        public int CategoryId
        {
            get;
            set;
        }

        /// <summary>
        /// Gets or sets the estimation.
        /// </summary>
        /// <value>The estimation.</value>
        [DataMember]
        public decimal Estimation
        {
            get;
            set;
        }

        /// <summary>
        /// Gets or sets a value indicating whether this <see cref="IssueContract"/> is disabled.
        /// </summary>
        /// <value><c>true</c> if disabled; otherwise, <c>false</c>.</value>
        [DataMember]
        public bool Disabled
        {
            get;
            set;
        }

    
    }
}
