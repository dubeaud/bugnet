using System;
using System.Xml.Serialization;
using BugNET.Common;

namespace BugNET.Entities
{
    public class Issue
    {
        #region Constructors

        /// <summary>
        /// Initializes a new instance of the <see cref="Issue"/> class.
        /// </summary>
        /// <param name="id">The id.</param>
        /// <param name="projectId">The project id.</param>
        /// <param name="projectName">Name of the project.</param>
        /// <param name="projectCode">The project code.</param>
        /// <param name="title">The title.</param>
        /// <param name="description">The description.</param>
        /// <param name="categoryId">The category id.</param>
        /// <param name="categoryName">Name of the category.</param>
        /// <param name="priorityId">The priority id.</param>
        /// <param name="priorityName">Name of the priority.</param>
        /// <param name="priorityImageUrl">The priority image URL.</param>
        /// <param name="statusId">The status id.</param>
        /// <param name="statusName">Name of the status.</param>
        /// <param name="statusImageUrl">The status image URL.</param>
        /// <param name="issueTypeId">The issue type id.</param>
        /// <param name="issueTypeName">Name of the issue type.</param>
        /// <param name="issueTypeImageUrl">The issue type image URL.</param>
        /// <param name="resolutionId">The resolution id.</param>
        /// <param name="resolutionName">Name of the resolution.</param>
        /// <param name="resolutionImageUrl">The resolution image URL.</param>
        /// <param name="assignedDisplayName">Name of the assigned display.</param>
        /// <param name="assignedUserName">The assigned username.</param>
        /// <param name="assignedUserId">The assigned user id.</param>
        /// <param name="creatorDisplayName">Display name of the creator.</param>
        /// <param name="creatorUserName">The creator username.</param>
        /// <param name="creatorUserId">The creator user id.</param>
        /// <param name="ownerDisplayName">Display name of the owner.</param>
        /// <param name="ownerUserName">The owner username.</param>
        /// <param name="ownerUserId">The owner user id.</param>
        /// <param name="dueDate">The due date.</param>
        /// <param name="milestoneId">The milestone id.</param>
        /// <param name="milestoneName">Name of the milestone.</param>
        /// <param name="milestoneImageUrl">The milestone image URL.</param>
        /// <param name="milestoneDueDate">The milestone due date.</param>
        /// <param name="affectedMilestoneId">The affected milestone id.</param>
        /// <param name="affectedMilestoneName">Name of the affected milestone.</param>
        /// <param name="affectedMilestoneImageUrl">The affected milestone image URL.</param>
        /// <param name="visiblity">The visibility.</param>
        /// <param name="timeLogged">The time logged.</param>
        /// <param name="estimation">The estimation.</param>
        /// <param name="dateCreated">The date created.</param>
        /// <param name="lastUpdate">The last update.</param>
        /// <param name="lastUpdateUserName">The last update username.</param>
        /// <param name="lastUpdateDisplayName">Last name of the update display.</param>
        /// <param name="progress">The progress.</param>
        /// <param name="disabled">if set to <c>true</c> [disabled].</param>
        /// <param name="votes"></param>
        public Issue(
            int id,
            int projectId,
            string projectName,
            string projectCode,
            string title,
            string description,
            int categoryId,
            string categoryName,
            int priorityId,
            string priorityName,
            string priorityImageUrl,
            int statusId,
            string statusName,
            string statusImageUrl,
            int issueTypeId,
            string issueTypeName,
            string issueTypeImageUrl,
            int resolutionId,
            string resolutionName,
            string resolutionImageUrl,
            string assignedDisplayName,
            string assignedUserName,
            Guid assignedUserId,
            string creatorDisplayName,
            string creatorUserName,
            Guid creatorUserId,
            string ownerDisplayName,
            string ownerUserName,
            Guid ownerUserId,
            DateTime dueDate,
            int milestoneId,
            string milestoneName,
            string milestoneImageUrl,
            DateTime? milestoneDueDate,
            int affectedMilestoneId,
            string affectedMilestoneName,
            string affectedMilestoneImageUrl,
            int visiblity,
            double timeLogged,
            decimal estimation,
            DateTime dateCreated,
            DateTime lastUpdate,
            string lastUpdateUserName,
            string lastUpdateDisplayName,
            int progress,
            bool disabled,
            int votes)
        {
            Id = id;
            ProjectId = projectId;
            ProjectName = projectName;
            ProjectCode = projectCode;
            Title = title;
            IssueTypeId = issueTypeId;
            IssueTypeName = issueTypeName;
            IssueTypeImageUrl = issueTypeImageUrl;
            Description = description;
            CategoryId = categoryId;
            CategoryName = categoryName;
            MilestoneId = milestoneId;
            MilestoneName = milestoneName;
            MilestoneImageUrl = milestoneImageUrl;
            MilestoneDueDate = milestoneDueDate;
            AffectedMilestoneId = affectedMilestoneId;
            AffectedMilestoneName = affectedMilestoneName;
            AffectedMilestoneImageUrl = affectedMilestoneImageUrl;
            PriorityId = priorityId;
            PriorityName = priorityName;
            PriorityImageUrl = priorityImageUrl;
            StatusId = statusId;
            StatusName = statusName;
            StatusImageUrl = statusImageUrl;
            IssueTypeId = issueTypeId;
            IssueTypeName = issueTypeName;
            IssueTypeImageUrl = issueTypeImageUrl;
            ResolutionId = resolutionId;
            ResolutionName = resolutionName;
            ResolutionImageUrl = resolutionImageUrl;
            DateCreated = dateCreated;
            AssignedUserName = assignedUserName;
            AssignedDisplayName = assignedDisplayName;
            AssignedUserId = assignedUserId;
            CreatorDisplayName = creatorDisplayName;
            CreatorUserName = creatorUserName;
            CreatorUserId = creatorUserId;
            OwnerDisplayName = ownerDisplayName;
            OwnerUserName = ownerUserName;
            OwnerUserId = ownerUserId;
            LastUpdateDisplayName = lastUpdateDisplayName;
            LastUpdate = lastUpdate;
            LastUpdateUserName = lastUpdateUserName;
            DueDate = dueDate;
            Visibility = visiblity;
            TimeLogged = timeLogged;
            Estimation = estimation;
            Progress = progress;
            Disabled = disabled;
            Votes = votes;
        }


        /// <summary>
        /// Initializes a new instance of the <see cref="Issue"/> class.
        /// </summary>
        /// <param name="id"></param>
        /// <param name="projectId">The project id.</param>
        /// <param name="title"></param>
        /// <param name="description">The description.</param>
        /// <param name="categoryId"></param>
        /// <param name="priorityId">The priority id.</param>
        /// <param name="statusId">The status id.</param>
        /// <param name="creatorUserName"></param>
        /// <param name="estimation">The estimation.</param>
        /// <param name="issueTypeId"></param>
        /// <param name="milestoneId"></param>
        /// <param name="affectedMilestoneId"></param>
        /// <param name="resolutionId"></param>
        /// <param name="ownerUserName"></param>
        /// <param name="assignedUserName"></param>
        /// <param name="visibility"></param>
        /// <param name="dueDate"></param>
        public Issue(int id, int projectId, string title, string description, int categoryId,
                     int priorityId, int statusId, int issueTypeId, int milestoneId, int affectedMilestoneId,
                     int resolutionId, string ownerUserName, string assignedUserName, string creatorUserName,
                     decimal estimation, int visibility, DateTime dueDate)
            : this
                (
                id,
                projectId,
                String.Empty,
                String.Empty,
                title,
                description,
                categoryId,
                String.Empty,
                priorityId,
                string.Empty,
                string.Empty,
                statusId,
                string.Empty,
                string.Empty,
                issueTypeId,
                string.Empty,
                string.Empty,
                resolutionId,
                string.Empty,
                string.Empty,
                string.Empty,
                assignedUserName,
                Guid.Empty,
                String.Empty,
                creatorUserName,
                Guid.Empty,
                string.Empty,
                ownerUserName,
                Guid.Empty,
                dueDate,
                milestoneId,
                String.Empty,
                string.Empty,
                null,
                affectedMilestoneId,
                string.Empty,
                string.Empty,
                visibility,
                0,
                estimation,
                DateTime.Now,
                DateTime.Now,
                creatorUserName,
                string.Empty,
                0,
                false,
                0
                )
        {
            NewAssignee = (!String.IsNullOrEmpty(AssignedUserName));
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="Issue"/> class.
        /// </summary>
        public Issue()
        {
            AssignedDisplayName = string.Empty;
            AssignedUserName = string.Empty;
            LastUpdateUserName = string.Empty;
            Title = string.Empty;
            Description = string.Empty;
        }

        #endregion

        #region Properties

        /// <summary>
        /// Gets or sets a value indicating whether this instance is closed.
        /// </summary>
        /// <value><c>true</c> if this instance is closed; otherwise, <c>false</c>.</value>
        public bool IsClosed { get; set; }

        /// <summary>
        /// Gets or sets a value indicating whether [send new assignee notification].
        /// </summary>
        /// <value>
        /// 	<c>true</c> if [send new assignee notification]; otherwise, <c>false</c>.
        /// </value>
        public bool SendNewAssigneeNotification { get; set; }

        /// <summary>
        /// Gets or sets a value indicating whether [new assignee].
        /// </summary>
        /// <value><c>true</c> if [new assignee]; otherwise, <c>false</c>.</value>
        public bool NewAssignee { get; set; }

        /// <summary>
        /// Gets or sets the progress.
        /// </summary>
        /// <value>The progress.</value>
        public int Progress { get; set; }

        /// <summary>
        /// Gets or sets the votes.
        /// </summary>
        /// <value>The votes.</value>
        public int Votes { get; set; }

        /// <summary>
        /// Gets or sets a value indicating whether this <see cref="Issue"/> is disabled.
        /// </summary>
        /// <value><c>true</c> if disabled; otherwise, <c>false</c>.</value>
        public bool Disabled { get; set; }

        /// <summary>
        /// Gets or sets the estimation.
        /// </summary>
        /// <value>The estimation.</value>
        public decimal Estimation { get; set; }

        /// <summary>
        /// Gets the time logged.
        /// </summary>
        /// <value>The time logged.</value>
        public double TimeLogged { get; set; }


        /// <summary>
        /// Gets or sets the display name of the assigned to user.
        /// </summary>
        /// <value>The display name of the assigned to user.</value>
        public string AssignedDisplayName { get; set; }

        /// <summary>
        /// Gets or sets the display name of the assigned.
        /// </summary>
        /// <value>The display name of the assigned.</value>
        public string AssignedUserName { get; set; }


        /// <summary>
        /// Gets or sets the visibility.
        /// </summary>
        /// <value>The visibility.</value>
        public int Visibility { get; set; }


        /// <summary>
        /// Component Id
        /// </summary>
        public int CategoryId { get; set; }

        /// <summary>
        /// Component Name
        /// </summary>
        public string CategoryName { get; set; }

        /// <summary>
        /// Reporter Display Name
        /// </summary>
        public string CreatorDisplayName { get; set; }

        /// <summary>
        /// Reporter User Name
        /// </summary>
        public string CreatorUserName { get; set; }

        /// <summary>
        /// Gets the reporter user id.
        /// </summary>
        /// <value>The reporter user id.</value>
        public Guid CreatorUserId { get; set; }

        /// <summary>
        /// Gets the owner username.
        /// </summary>
        /// <value>The owner username.</value>
        public string OwnerUserName { get; set; }


        /// <summary>
        /// Gets the display name of the owner.
        /// </summary>
        /// <value>The display name of the owner.</value>
        public string OwnerDisplayName { get; set; }

        /// <summary>
        /// Gets or sets the owner id.
        /// </summary>
        /// <value>The owner id.</value>
        public Guid OwnerUserId { get; set; }

        /// <summary>
        /// Gets or sets the assigned to user id.
        /// </summary>
        /// <value>The assigned to user id.</value>
        public Guid AssignedUserId { get; set; }

        /// <summary>
        /// Gets the date created.
        /// </summary>
        /// <value>The date created.</value>
        public DateTime DateCreated { get; set; }

        /// <summary>
        /// Gets the id.
        /// </summary>
        /// <value>The id.</value>
        public int Id { get; set; }

        /// <summary>
        /// Gets the full id.
        /// </summary>
        /// <value>The full id.</value>
        [XmlIgnore]
        public string FullId
        {
            get { return string.Concat(ProjectCode, "-", Id); }
        }

        /// <summary>
        /// Gets the last update.
        /// </summary>
        /// <value>The last update.</value>
        public DateTime LastUpdate { get; set; }

        /// <summary>
        /// Gets the due date.
        /// </summary>
        /// <value>The due date.</value>
        public DateTime DueDate { get; set; }

        /// <summary>
        /// Gets the name of the last update display.
        /// </summary>
        /// <value>The name of the last update display.</value>
        public string LastUpdateDisplayName { get; set; }

        /// <summary>
        /// Gets or sets the name of the last update user.
        /// </summary>
        /// <value>The name of the last update user.</value>
        public string LastUpdateUserName { get; set; }

        /// <summary>
        /// Gets or sets the version id.
        /// </summary>
        /// <value>The version id.</value>
        public int MilestoneId { get; set; }

        /// <summary>
        /// Gets the name of the version.
        /// </summary>
        /// <value>The name of the version.</value>
        public string MilestoneName { get; set; }

        /// <summary>
        /// Gets the milestone image URL.
        /// </summary>
        /// <value>The milestone image URL.</value>
        public string MilestoneImageUrl { get; set; }

        /// <summary>
        /// Gets or sets the affected milestone id.
        /// </summary>
        /// <value>The affected milestone id.</value>
        public int AffectedMilestoneId { get; set; }


        /// <summary>
        /// Gets the name of the affected milestone.
        /// </summary>
        /// <value>The name of the affected milestone.</value>
        public string AffectedMilestoneName { get; set; }

        /// <summary>
        /// Gets the affected milestone image URL.
        /// </summary>
        /// <value>The affected milestone image URL.</value>
        public string AffectedMilestoneImageUrl { get; set; }

        /// <summary>
        /// Gets the due date of the version.
        /// </summary>
        /// <value>The due date of the version.</value>
        public DateTime? MilestoneDueDate { get; set; }

        /// <summary>
        /// Gets or sets the type id.
        /// </summary>
        /// <value>The type id.</value>
        public int IssueTypeId { get; set; }

        /// <summary>
        /// Gets the name of the type.
        /// </summary>
        /// <value>The name of the type.</value>
        public string IssueTypeName { get; set; }

        /// <summary>
        /// Gets the issue type image URL.
        /// </summary>
        /// <value>The issue type image URL.</value>
        public string IssueTypeImageUrl { get; set; }


        /// <summary>
        /// Gets or sets the resolution id.
        /// </summary>
        /// <value>The resolution id.</value>
        public int ResolutionId { get; set; }

        /// <summary>
        /// Gets the name of the resolution.
        /// </summary>
        /// <value>The name of the resolution.</value>
        public string ResolutionName { get; set; }

        /// <summary>
        /// Gets the resolution image URL.
        /// </summary>
        /// <value>The resolution image URL.</value>
        public string ResolutionImageUrl { get; set; }

        /// <summary>
        /// Gets or sets the priority id.
        /// </summary>
        /// <value>The priority id.</value>
        public int PriorityId { get; set; }

        /// <summary>
        /// Gets the name of the priority.
        /// </summary>
        /// <value>The name of the priority.</value>
        public string PriorityName { get; set; }

        /// <summary>
        /// Gets the priority image URL.
        /// </summary>
        /// <value>The priority image URL.</value>
        public string PriorityImageUrl { get; set; }


        /// <summary>
        /// Gets the project id.
        /// </summary>
        /// <value>The project id.</value>
        public int ProjectId { get; set; }

        /// <summary>
        /// Gets the name of the project.
        /// </summary>
        /// <value>The name of the project.</value>
        public string ProjectName { get; set; }

        /// <summary>
        /// Gets the project code.
        /// </summary>
        /// <value>The project code.</value>
        public string ProjectCode { get; set; }

        /// <summary>
        /// Gets or sets the status id.
        /// </summary>
        /// <value>The status id.</value>
        public int StatusId { get; set; }

        /// <summary>
        /// Gets the name of the status.
        /// </summary>
        /// <value>The name of the status.</value>
        public string StatusName { get; set; }

        /// <summary>
        /// Gets the status image URL.
        /// </summary>
        /// <value>The status image URL.</value>
        public string StatusImageUrl { get; set; }


        /// <summary>
        /// Gets or sets the summary.
        /// </summary>
        /// <value>The summary.</value>
        public string Title { get; set; }

        /// <summary>
        /// Gets or sets the description.
        /// </summary>
        /// <value>The description.</value>
        public string Description { get; set; }

        #endregion

        /// <summary>
        /// Estimations to string.
        /// </summary>
        /// <param name="estimation">The estimation.</param>
        /// <returns></returns>
        private string EstimationToString(decimal estimation)
        {
            return estimation >= 0 ? estimation.ToString() : "empty";
        }
    }
}
