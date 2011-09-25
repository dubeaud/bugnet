using System;
using BugNET.Common;

namespace BugNET.Entities
{
    public class Issue  : IToXml
    {
        #region Private Variables
        private string _AssignedDisplayName;
        private Guid _AssignedUserId;
        private string _AssignedUserName;
        private string _CreatorDisplayName;
        private string _CreatorUserName;
        private Guid _CreatorUserId;
        private string _LastUpdateDisplayName;
        private string _LastUpdateUserName;
        private DateTime _LastUpdate;
        private int _CategoryId;
        private string _CategoryName;
        private DateTime _DateCreated;
        private int _Id;
        private int _MilestoneId;
        private string _MilestoneName;
        private string _MilestoneImageUrl;
        private DateTime? _MilestoneDueDate;
        private int _PriorityId;
        private string _PriorityName;
        private string _PriorityImageUrl;
        private int _StatusId;
        private string _StatusName;
        private string _StatusImageUrl;
        private int _IssueTypeId;
        private string _IssueTypeName;
        private string _IssueTypeImageUrl;
        private int _ResolutionId;
        private string _ResolutionName;
        private string _ResolutionImageUrl;
        private string _ProjectName;
        private int _ProjectId;
        private string _Title;
        private string _Description;
        private bool _NewAssignee;
        private string _ProjectCode;
        private DateTime _DueDate;
        private int _Visibility;
        private double _TimeLogged;
        private decimal _Estimation;
        private string _OwnerUserName;
        private string _OwnerDisplayName;
        private Guid _OwnerUserId;
        private int _AffectedMilestoneId;
        private string _AffectedMilestoneName;
        private string _AffectedMilestoneImageUrl;
        private int _Progress;
        private bool _Disabled;
        private int _Votes;
        private bool _SendNewAssigneeNotification;
        private bool _IsClosed;
        #endregion

        #region Constructors

        /// <summary>
        /// Initializes a new instance of the <see cref="T:Issue"/> class.
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
            _Id = id;
            _ProjectId = projectId;
            _ProjectName = projectName;
            _ProjectCode = projectCode;
            _Title = title;
            _IssueTypeId = issueTypeId;
            _IssueTypeName = issueTypeName;
            _IssueTypeImageUrl = issueTypeImageUrl;
            _Description = description;
            _CategoryId = categoryId;
            _CategoryName = categoryName;
            _MilestoneId = milestoneId;
            _MilestoneName = milestoneName;
            _MilestoneImageUrl = milestoneImageUrl;
            _MilestoneDueDate = milestoneDueDate;
            _AffectedMilestoneId = affectedMilestoneId;
            _AffectedMilestoneName = affectedMilestoneName;
            _AffectedMilestoneImageUrl = affectedMilestoneImageUrl;
            _PriorityId = priorityId;
            _PriorityName = priorityName;
            _PriorityImageUrl = priorityImageUrl;
            _StatusId = statusId;
            _StatusName = statusName;
            _StatusImageUrl = statusImageUrl;
            _IssueTypeId = issueTypeId;
            _IssueTypeName = issueTypeName;
            _IssueTypeImageUrl = issueTypeImageUrl;
            _ResolutionId = resolutionId;
            _ResolutionName = resolutionName;
            _ResolutionImageUrl = resolutionImageUrl;
            _DateCreated = dateCreated;
            _AssignedUserName = assignedUserName;
            _AssignedDisplayName = assignedDisplayName;
            _AssignedUserId = assignedUserId;
            _CreatorDisplayName = creatorDisplayName;
            _CreatorUserName = creatorUserName;
            _CreatorUserId = creatorUserId;
            _OwnerDisplayName = ownerDisplayName;
            _OwnerUserName = ownerUserName;
            _OwnerUserId = ownerUserId;
            _LastUpdateDisplayName = lastUpdateDisplayName;
            _LastUpdate = lastUpdate;
            _LastUpdateUserName = lastUpdateUserName;
            _DueDate = dueDate;
            _Visibility = visiblity;
            _TimeLogged = timeLogged;
            _Estimation = estimation;
            _Progress = progress;
            _Disabled = disabled;
            _Votes = votes;
        }


        /// <summary>
        /// Initializes a new instance of the <see cref="T:Issue"/> class.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <param name="summary">The summary.</param>
        /// <param name="description">The description.</param>
        /// <param name="componentId">The component id.</param>
        /// <param name="versionId">The version id.</param>
        /// <param name="priorityId">The priority id.</param>
        /// <param name="statusId">The status id.</param>
        /// <param name="IssueTypeId">The type id.</param>
        /// <param name="fixedInVersionId">The fixed in version id.</param>
        /// <param name="AssignedToUserName">Name of the assigned to user.</param>
        /// <param name="reporterUserName">The reporter username.</param>
        /// <param name="estimation">The estimation.</param>
        public Issue(int id, int projectId, string title, string description, int categoryId,
            int priorityId, int statusId, int issueTypeId, int milestoneId, int affectedMilestoneId, int resolutionId, string ownerUserName, string assignedUserName, string creatorUserName, decimal estimation, int visibility, DateTime dueDate)
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
            if (!String.IsNullOrEmpty(AssignedUserName))
                _NewAssignee = true;
        }


        /// <summary>
        /// Initializes a new instance of the <see cref="Issue"/> class.
        /// </summary>
        public Issue() { }
        #endregion

        #region Properties

        /// <summary>
        /// Gets or sets a value indicating whether this instance is closed.
        /// </summary>
        /// <value><c>true</c> if this instance is closed; otherwise, <c>false</c>.</value>
        public bool IsClosed
        {
            get
            {
                return _IsClosed;
                //if (ProjectId != 0 && StatusId != 0)
                //{
                //    Status status = Status.GetStatusByProjectId(ProjectId).Find(s => s.Id == this.StatusId);
                //    return status.IsClosedState ? true : false;
                //}
                //else
                //    return false;
            }
            set { _IsClosed = value; }
        }

        /// <summary>
        /// Gets or sets a value indicating whether [send new assignee notification].
        /// </summary>
        /// <value>
        /// 	<c>true</c> if [send new assignee notification]; otherwise, <c>false</c>.
        /// </value>
        public bool SendNewAssigneeNotification
        {
            get;
            set;
        }

        /// <summary>
        /// Gets or sets a value indicating whether [new assignee].
        /// </summary>
        /// <value><c>true</c> if [new assignee]; otherwise, <c>false</c>.</value>
        public bool NewAssignee
        {
            get;
            set;
        }

        /// <summary>
        /// Gets or sets the progress.
        /// </summary>
        /// <value>The progress.</value>
        public int Progress
        {
            get { return _Progress; }
            set { _Progress = value; }
        }

        /// <summary>
        /// Gets or sets the votes.
        /// </summary>
        /// <value>The votes.</value>
        public int Votes
        {
            get { return _Votes; }
            set { _Votes = value; }
        }

        /// <summary>
        /// Gets or sets a value indicating whether this <see cref="Issue"/> is disabled.
        /// </summary>
        /// <value><c>true</c> if disabled; otherwise, <c>false</c>.</value>
        public bool Disabled
        {
            get { return _Disabled; }
            set { _Disabled = value; }
        }

        /// <summary>
        /// Gets or sets the estimation.
        /// </summary>
        /// <value>The estimation.</value>
        public decimal Estimation
        {
            get { return _Estimation; }
            set { _Estimation = value; }
        }

        /// <summary>
        /// Estimations to string.
        /// </summary>
        /// <param name="estimation">The estimation.</param>
        /// <returns></returns>
        private string EstimationToString(decimal estimation)
        {
            return estimation >= 0 ? estimation.ToString() : "empty";
        }

        /// <summary>
        /// Gets the time logged.
        /// </summary>
        /// <value>The time logged.</value>
        public double TimeLogged
        {
            get { return _TimeLogged; }
            set { _TimeLogged = value; } 
        }


        /// <summary>
        /// Gets or sets the display name of the assigned to user.
        /// </summary>
        /// <value>The display name of the assigned to user.</value>
        public string AssignedDisplayName
        {
            get { return (String.IsNullOrEmpty(_AssignedDisplayName)) ? string.Empty : _AssignedDisplayName; }
            set { _AssignedDisplayName = value; }
        }

        /// <summary>
        /// Gets or sets the display name of the assigned.
        /// </summary>
        /// <value>The display name of the assigned.</value>
        public string AssignedUserName
        {
            get { return (String.IsNullOrEmpty(_AssignedUserName)) ? string.Empty : _AssignedUserName; }
            set { _AssignedUserName = value; }
        }


        /// <summary>
        /// Gets or sets the visibility.
        /// </summary>
        /// <value>The visibility.</value>
        public int Visibility
        {
            get { return _Visibility; }
            set { _Visibility = value; }
        }


        /// <summary>
        /// Component Id
        /// </summary>
        public int CategoryId
        {
            get { return _CategoryId; }
            set { _CategoryId = value; }
        }

        /// <summary>
        /// Component Name
        /// </summary>
        public string CategoryName
        {
            get { return _CategoryName; }
            set { _CategoryName = value; }
        }

        /// <summary>
        /// Reporter Display Name
        /// </summary>
        public string CreatorDisplayName
        {
            get { return _CreatorDisplayName; }
            set { _CreatorDisplayName = value; } 
        }

        /// <summary>
        /// Reporter User Name
        /// </summary>
        public string CreatorUserName
        {
            get { return _CreatorUserName; }
            set { _CreatorUserName = value; } 
        }

        /// <summary>
        /// Gets the reporter user id.
        /// </summary>
        /// <value>The reporter user id.</value>
        public Guid CreatorUserId
        {
            get { return (_CreatorUserId); }
            set { _CreatorUserId = value; } 
        }

        /// <summary>
        /// Gets the owner username.
        /// </summary>
        /// <value>The owner username.</value>
        public string OwnerUserName
        {
            get { return (_OwnerUserName); }
            set { _OwnerUserName = value; }
        }


        /// <summary>
        /// Gets the display name of the owner.
        /// </summary>
        /// <value>The display name of the owner.</value>
        public string OwnerDisplayName
        {
            get { return _OwnerDisplayName; }
            set { _OwnerDisplayName = value; } 
        }

        /// <summary>
        /// Gets or sets the owner id.
        /// </summary>
        /// <value>The owner id.</value>
        public Guid OwnerUserId
        {
            get { return _OwnerUserId; }
            set { _OwnerUserId = value; }
        }
        /// <summary>
        /// Gets or sets the assigned to user id.
        /// </summary>
        /// <value>The assigned to user id.</value>
        public Guid AssignedUserId
        {
            get { return _AssignedUserId; }
            set { _AssignedUserId = value; }
        }

        /// <summary>
        /// Gets the date created.
        /// </summary>
        /// <value>The date created.</value>
        public DateTime DateCreated
        {
            get { return _DateCreated; }
            set { _DateCreated = value; } 
        }

        /// <summary>
        /// Gets the id.
        /// </summary>
        /// <value>The id.</value>
        public int Id
        {
            get { return _Id; }
            set { _Id = value; } 
        }

        /// <summary>
        /// Gets the full id.
        /// </summary>
        /// <value>The full id.</value>
        public string FullId
        {
            get { return string.Concat(_ProjectCode, "-", _Id); }
            set { } 
        }

        /// <summary>
        /// Gets the last update.
        /// </summary>
        /// <value>The last update.</value>
        public DateTime LastUpdate
        {
            get { return _LastUpdate; }
            set { _LastUpdate = value; } 
        }

        /// <summary>
        /// Gets the due date.
        /// </summary>
        /// <value>The due date.</value>
        public DateTime DueDate
        {
            get { return _DueDate; }
            set { _DueDate = value; }
        }

        /// <summary>
        /// Gets the name of the last update display.
        /// </summary>
        /// <value>The name of the last update display.</value>
        public string LastUpdateDisplayName
        {
            get { return _LastUpdateDisplayName; }
            set { _LastUpdateDisplayName = value; } 
        }

        /// <summary>
        /// Gets or sets the name of the last update user.
        /// </summary>
        /// <value>The name of the last update user.</value>
        public string LastUpdateUserName
        {
            get { return (String.IsNullOrEmpty(_LastUpdateUserName)) ? string.Empty : _LastUpdateUserName; }
            set { _LastUpdateUserName = value; }
        }

        /// <summary>
        /// Gets or sets the version id.
        /// </summary>
        /// <value>The version id.</value>
        public int MilestoneId
        {
            get { return _MilestoneId; }
            set { _MilestoneId = value; }
        }

        /// <summary>
        /// Gets the name of the version.
        /// </summary>
        /// <value>The name of the version.</value>
        public string MilestoneName
        {
            get { return _MilestoneName; }
            set { _MilestoneName = value; } 
        }

        /// <summary>
        /// Gets the milestone image URL.
        /// </summary>
        /// <value>The milestone image URL.</value>
        public string MilestoneImageUrl
        {
            get { return _MilestoneImageUrl; }
            set { _MilestoneImageUrl = value; } 
        }

        /// <summary>
        /// Gets or sets the affected milestone id.
        /// </summary>
        /// <value>The affected milestone id.</value>
        public int AffectedMilestoneId
        {
            get { return _AffectedMilestoneId; }
            set { _AffectedMilestoneId = value; }
        }


        /// <summary>
        /// Gets the name of the affected milestone.
        /// </summary>
        /// <value>The name of the affected milestone.</value>
        public string AffectedMilestoneName
        {
            get { return _AffectedMilestoneName; }
            set { _AffectedMilestoneName = value; } 
        }

        /// <summary>
        /// Gets the affected milestone image URL.
        /// </summary>
        /// <value>The affected milestone image URL.</value>
        public string AffectedMilestoneImageUrl
        {
            get { return _AffectedMilestoneImageUrl; }
            set { _AffectedMilestoneImageUrl = value; } 
        }

        /// <summary>
        /// Gets the due date of the version.
        /// </summary>
        /// <value>The due date of the version.</value>
        public DateTime? MilestoneDueDate
        {
            get { return _MilestoneDueDate; }
            set { _MilestoneDueDate = value; } 
        }

        /// <summary>
        /// Gets or sets the type id.
        /// </summary>
        /// <value>The type id.</value>
        public int IssueTypeId
        {
            get { return _IssueTypeId; }
            set { _IssueTypeId = value; }
        }

        /// <summary>
        /// Gets the name of the type.
        /// </summary>
        /// <value>The name of the type.</value>
        public string IssueTypeName
        {
            get { return _IssueTypeName; }
            set { _IssueTypeName = value; } 
        }

        /// <summary>
        /// Gets the issue type image URL.
        /// </summary>
        /// <value>The issue type image URL.</value>
        public string IssueTypeImageUrl
        {
            get { return _IssueTypeImageUrl; }
            set { _IssueTypeImageUrl = value; } 
        }


        /// <summary>
        /// Gets or sets the resolution id.
        /// </summary>
        /// <value>The resolution id.</value>
        public int ResolutionId
        {
            get { return _ResolutionId; }
            set { _ResolutionId = value; }
        }

        /// <summary>
        /// Gets the name of the resolution.
        /// </summary>
        /// <value>The name of the resolution.</value>
        public string ResolutionName
        {
            get { return _ResolutionName; }
            set { _ResolutionName = value; } 
        }

        /// <summary>
        /// Gets the resolution image URL.
        /// </summary>
        /// <value>The resolution image URL.</value>
        public string ResolutionImageUrl
        {
            get { return _ResolutionImageUrl; }
            set { _ResolutionImageUrl = value; } 
        }


        /// <summary>
        /// Gets or sets the priority id.
        /// </summary>
        /// <value>The priority id.</value>
        public int PriorityId
        {
            get { return _PriorityId; }
            set { _PriorityId = value; }
        }

        /// <summary>
        /// Gets the name of the priority.
        /// </summary>
        /// <value>The name of the priority.</value>
        public string PriorityName
        {
            get { return _PriorityName; }
            set { _PriorityName = value; } 
        }

        /// <summary>
        /// Gets the priority image URL.
        /// </summary>
        /// <value>The priority image URL.</value>
        public string PriorityImageUrl
        {
            get { return _PriorityImageUrl; }
            set { _PriorityImageUrl = value; } 
        }


        /// <summary>
        /// Gets the project id.
        /// </summary>
        /// <value>The project id.</value>
        public int ProjectId
        {
            get { return _ProjectId; }
            set { _ProjectId = value; } 
        }

        /// <summary>
        /// Gets the name of the project.
        /// </summary>
        /// <value>The name of the project.</value>
        public string ProjectName
        {
            get { return _ProjectName; }
            set { _ProjectName = value; } 
        }

        /// <summary>
        /// Gets the project code.
        /// </summary>
        /// <value>The project code.</value>
        public string ProjectCode
        {
            get { return _ProjectCode; }
            set { _ProjectCode = value; } 
        }

        /// <summary>
        /// Gets or sets the status id.
        /// </summary>
        /// <value>The status id.</value>
        public int StatusId
        {
            get { return _StatusId; }
            set { _StatusId = value; }
        }

        /// <summary>
        /// Gets the name of the status.
        /// </summary>
        /// <value>The name of the status.</value>
        public string StatusName
        {
            get { return _StatusName; }
            set { _StatusName = value; } 
        }

        /// <summary>
        /// Gets the status image URL.
        /// </summary>
        /// <value>The status image URL.</value>
        public string StatusImageUrl
        {
            get { return _StatusImageUrl; }
            set { _StatusImageUrl = value; } 
        }


        /// <summary>
        /// Gets or sets the summary.
        /// </summary>
        /// <value>The summary.</value>
        public string Title
        {
            get { return (_Title == null || _Title.Length == 0) ? string.Empty : _Title; }
            set { _Title = value; }
        }

        /// <summary>
        /// Gets or sets the description.
        /// </summary>
        /// <value>The description.</value>
        public string Description
        {
            get { return (_Description == null || _Description.Length == 0) ? string.Empty : _Description; }
            set { _Description = value; }
        }

        #endregion

        #region IToXml Members

        /// <summary>
        /// Toes the XML.
        /// </summary>
        /// <returns></returns>
        public string ToXml()
        {
            XmlSerializeService<Issue> service = new XmlSerializeService<Issue>();
            return service.ToXml(this);
        }
        #endregion
    }
}
