using System;
using System.Collections;
using System.Collections.Generic;
using BugNET.DataAccessLayer;
using System.Data;
using System.Web;
using System.Linq;
using BugNET.BusinessLogicLayer.Notifications;

namespace BugNET.BusinessLogicLayer
{
    /// <summary>
    /// Issue business object
    /// </summary>
    public class Issue : IToXml
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
        /// <param name="visiblity">The visiblity.</param>
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

        public bool IsClosed
        {
            get
            {
                if (ProjectId != 0 && StatusId != 0)
                {
                    Status status = Status.GetStatusByProjectId(ProjectId).Find(s => s.Id == this.StatusId);
                    return status.IsClosedState ? true : false;
                }
                else
                    return false;
            }
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
            set { } // needed for xml serialization
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
            set { } // needed for xml serialization
        }

        /// <summary>
        /// Reporter User Name
        /// </summary>
        public string CreatorUserName
        {
            get { return _CreatorUserName; }
            set { } // needed for xml serialization
        }

        /// <summary>
        /// Gets the reporter user id.
        /// </summary>
        /// <value>The reporter user id.</value>
        public Guid CreatorUserId
        {
            get { return (_CreatorUserId); }
            set { } // needed for xml serialization
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
            set { } // needed for xml serialization
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
            set { } // needed for xml serialization
        }

        /// <summary>
        /// Gets the id.
        /// </summary>
        /// <value>The id.</value>
        public int Id
        {
            get { return _Id; }
            set { } // needed for xml serialization
        }

        /// <summary>
        /// Gets the full id.
        /// </summary>
        /// <value>The full id.</value>
        public string FullId
        {
            get { return string.Concat(_ProjectCode, "-", _Id); }
            set { } // needed for xml serialization
        }

        /// <summary>
        /// Gets the last update.
        /// </summary>
        /// <value>The last update.</value>
        public DateTime LastUpdate
        {
            get { return _LastUpdate; }
            set { } // needed for xml serialization
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
            set { } // needed for xml serialization
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
            set { } // needed for xml serialization
        }

        /// <summary>
        /// Gets the milestone image URL.
        /// </summary>
        /// <value>The milestone image URL.</value>
        public string MilestoneImageUrl
        {
            get { return _MilestoneImageUrl; }
            set { } // needed for xml serialization
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
            set { } // needed for xml serialization
        }

        /// <summary>
        /// Gets the affected milestone image URL.
        /// </summary>
        /// <value>The affected milestone image URL.</value>
        public string AffectedMilestoneImageUrl
        {
            get { return _AffectedMilestoneImageUrl; }
            set { } // needed for xml serialization
        }

        /// <summary>
        /// Gets the due date of the version.
        /// </summary>
        /// <value>The due date of the version.</value>
        public DateTime? MilestoneDueDate
        {
            get { return _MilestoneDueDate; }
            set { } // needed for xml serialization
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
            set { } // needed for xml serialization
        }

        /// <summary>
        /// Gets the issue type image URL.
        /// </summary>
        /// <value>The issue type image URL.</value>
        public string IssueTypeImageUrl
        {
            get { return _IssueTypeImageUrl; }
            set { } // needed for xml serialization
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
            set { } // needed for xml serialization
        }

        /// <summary>
        /// Gets the resolution image URL.
        /// </summary>
        /// <value>The resolution image URL.</value>
        public string ResolutionImageUrl
        {
            get { return _ResolutionImageUrl; }
            set { } // needed for xml serialization
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
            set { } // needed for xml serialization
        }

        /// <summary>
        /// Gets the priority image URL.
        /// </summary>
        /// <value>The priority image URL.</value>
        public string PriorityImageUrl
        {
            get { return _PriorityImageUrl; }
            set { } // needed for xml serialization
        }


        /// <summary>
        /// Gets the project id.
        /// </summary>
        /// <value>The project id.</value>
        public int ProjectId
        {
            get { return _ProjectId; }
            set { } // needed for xml serialization
        }

        /// <summary>
        /// Gets the name of the project.
        /// </summary>
        /// <value>The name of the project.</value>
        public string ProjectName
        {
            get { return _ProjectName; }
            set { } // needed for xml serialization
        }

        /// <summary>
        /// Gets the project code.
        /// </summary>
        /// <value>The project code.</value>
        public string ProjectCode
        {
            get { return _ProjectCode; }
            set { } // needed for xml serialization
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
            set { } // needed for xml serialization
        }

        /// <summary>
        /// Gets the status image URL.
        /// </summary>
        /// <value>The status image URL.</value>
        public string StatusImageUrl
        {
            get { return _StatusImageUrl; }
            set { } // needed for xml serialization
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

        #region Instance Methods
        /// <summary>
        /// Saves the bug
        /// </summary>
        /// <returns></returns>
        public bool Save()
        {
            if (Id <= Globals.NewId)
            {
                int TempId = DataProviderManager.Provider.CreateNewIssue(this);

                if (TempId > 0)
                {
                    _Id = TempId;

                    return true;
                }
                else
                    return false;
            }
            else
            {
                List<IssueHistory> issueChanges = GetIssueChanges();
                if (issueChanges.Count > 0)
                {

                    bool result = DataProviderManager.Provider.UpdateIssue(this);
                    if (result)
                    {
                        UpdateIssueHistory(issueChanges);

                        IssueNotification.SendIssueNotifications(Id, issueChanges);
                        if (this._SendNewAssigneeNotification)
                        {
                            //add this user to notifications and send them a notification
                            IssueNotification issueNotification = new IssueNotification(Id, this.AssignedUserName);
                            issueNotification.Save();
                            IssueNotification.SendNewAssigneeNotification(Id, this.AssignedDisplayName);
                        }
                    }
                    return result;
                }
                return true;
            }
        }

        /// <summary>
        /// Updates the IssueHistory objects in the changes arraylist
        /// </summary>
        /// <param name="issueChanges">The issue changes.</param>
        private void UpdateIssueHistory(List<IssueHistory> issueChanges)
        {
            foreach (IssueHistory issueHistory in issueChanges)
                issueHistory.Save();
        }


        /// <summary>
        /// Gets the issue changes.
        /// </summary>
        /// <returns></returns>
        private List<IssueHistory> GetIssueChanges()
        {
            List<IssueHistory> issueChanges = new List<IssueHistory>();
            Issue orgIssue = GetIssueById(_Id);
            if (orgIssue != null)
            {
                string createdUserName = Security.GetUserName();

                if (orgIssue.Title.ToLower() != Title.ToLower())
                    issueChanges.Add(new IssueHistory(_Id, createdUserName, "Title", orgIssue.Title, Title));
                if (orgIssue.Description.ToLower() != Description.ToLower())
                    issueChanges.Add(new IssueHistory(_Id, createdUserName, "Description", orgIssue.Description, Description));
                if (orgIssue.CategoryId != CategoryId)
                    issueChanges.Add(new IssueHistory(_Id, createdUserName, "Category", orgIssue.CategoryName, CategoryName));
                if (orgIssue.PriorityId != PriorityId)
                    issueChanges.Add(new IssueHistory(_Id, createdUserName, "Priority", orgIssue.PriorityName, PriorityName));
                if (orgIssue.StatusId != StatusId)
                    issueChanges.Add(new IssueHistory(_Id, createdUserName, "Status", orgIssue.StatusName, StatusName));
                if (orgIssue.MilestoneId != MilestoneId)
                    issueChanges.Add(new IssueHistory(_Id, createdUserName, "Milestone", orgIssue.MilestoneName, MilestoneName));
                if (orgIssue.AffectedMilestoneId != AffectedMilestoneId)
                    issueChanges.Add(new IssueHistory(_Id, createdUserName, "Affected Milestone", orgIssue.AffectedMilestoneName, AffectedMilestoneName));
                if (orgIssue.IssueTypeId != IssueTypeId)
                    issueChanges.Add(new IssueHistory(_Id, createdUserName, "Issue Type", orgIssue.IssueTypeName, IssueTypeName));
                if (orgIssue.ResolutionId != ResolutionId)
                    issueChanges.Add(new IssueHistory(_Id, createdUserName, "Resolution", orgIssue.ResolutionName, ResolutionName));
                
                string newAssignedUserName = String.IsNullOrEmpty(AssignedUserName) ? Globals.UnassignedDisplayText : AssignedUserName;
                
                if ((orgIssue.AssignedUserName != newAssignedUserName))
                {
                    // if the new assigned user is the unassigned user then don't trigger the new assignee notification
                    this._SendNewAssigneeNotification = (newAssignedUserName != Globals.UnassignedDisplayText);
                    this._NewAssignee = true;

                    string newAssignedDisplayName = (newAssignedUserName == Globals.UnassignedDisplayText) ? newAssignedUserName :
                        ITUser.GetUserDisplayName(newAssignedUserName);
                    issueChanges.Add(new IssueHistory(_Id, createdUserName, "Assigned to", orgIssue.AssignedDisplayName, newAssignedDisplayName));
                }
                if (orgIssue.OwnerUserName != OwnerUserName)
                {
                    string newOwnerDisplayName = ITUser.GetUserDisplayName(OwnerUserName);
                    issueChanges.Add(new IssueHistory(_Id, createdUserName, "Owner", orgIssue.OwnerDisplayName, newOwnerDisplayName));
                }
                if (orgIssue.Estimation != Estimation)
                    issueChanges.Add(new IssueHistory(_Id, createdUserName, "Estimation", EstimationToString(orgIssue.Estimation), EstimationToString(Estimation)));
                if (orgIssue.Visibility != Visibility)
                    issueChanges.Add(new IssueHistory(_Id, createdUserName, "Visibility", orgIssue.Visibility == 0 ? Boolean.FalseString : Boolean.TrueString, Visibility == 0 ? Boolean.FalseString : Boolean.TrueString));
                if (orgIssue.DueDate != DueDate)
                    issueChanges.Add(new IssueHistory(_Id, createdUserName, "Due Date", orgIssue.DueDate == DateTime.MinValue ? string.Empty : orgIssue.DueDate.ToShortDateString(), DueDate.ToShortDateString()));
                if (orgIssue.Progress != Progress)
                    issueChanges.Add(new IssueHistory(_Id, createdUserName, "Percent complete", string.Format("{0}%", orgIssue.Progress), string.Format("{0}%", Progress)));
            }
            else
            {
                throw new Exception("Unable to retrieve original issue data");
            }

            return issueChanges;

        }

        #endregion

        #region Static Methods

        /// <summary>
        /// Calculate issue's percentage of issue list.
        /// </summary>
        /// <param name="issueCountList">The issue count list.</param>
        private static List<IssueCount> CalculateIssueCountListPercentage(List<IssueCount> issueCountList)
        {
            int issueSum = 0;

            // calculate the total issues count
            foreach (IssueCount issueCount in issueCountList)
            {
                issueSum += issueCount.Count;
            }

            // update each issue percentage
            foreach (IssueCount issueCount in issueCountList)
            {
                if (issueSum != 0)
                    issueCount.Percentage = Math.Round((decimal)((issueCount.Count * 100) / issueSum));
                else
                    issueCount.Percentage = 0;
            }

            return issueCountList;
        }

        /// <summary>
        /// Gets the issue by id.
        /// </summary>
        /// <param name="issueId">The issue id.</param>
        /// <returns></returns>
        public static Issue GetIssueById(int issueId)
        {
            if (issueId <= DefaultValues.GetIssueIdMinValue())
                throw (new ArgumentOutOfRangeException("issueId"));

            return (DataProviderManager.Provider.GetIssueById(issueId));
        }

        /// <summary>
        /// Gets the bugs by project id.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public static List<Issue> GetIssuesByProjectId(int projectId)
        {
            if (projectId <= DefaultValues.GetProjectIdMinValue())
                throw (new ArgumentOutOfRangeException("projectId"));

            return (DataProviderManager.Provider.GetIssuesByProjectId(projectId));
        }

        /// <summary>
        /// Gets the bug status count by project.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public static List<IssueCount> GetIssueStatusCountByProject(int projectId)
        {
            if (projectId <= DefaultValues.GetProjectIdMinValue())
                throw (new ArgumentOutOfRangeException("projectId"));

            return CalculateIssueCountListPercentage(DataProviderManager.Provider.GetIssueStatusCountByProject(projectId));
        }

        /// <summary>
        /// Gets the bug version count by project.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public static List<IssueCount> GetIssueMilestoneCountByProject(int projectId)
        {
            if (projectId <= DefaultValues.GetProjectIdMinValue())
                throw (new ArgumentOutOfRangeException("projectId"));

            return CalculateIssueCountListPercentage(DataProviderManager.Provider.GetIssueMilestoneCountByProject(projectId));
        }
        /// <summary>
        /// Gets the bug priority count by project.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public static List<IssueCount> GetIssuePriorityCountByProject(int projectId)
        {
            if (projectId <= DefaultValues.GetProjectIdMinValue())
                throw (new ArgumentOutOfRangeException("projectId"));

            return DataProviderManager.Provider.GetIssuePriorityCountByProject(projectId);
        }
        /// <summary>
        /// Gets the bug user count by project.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public static List<IssueCount> GetIssueUserCountByProject(int projectId)
        {
            if (projectId <= DefaultValues.GetProjectIdMinValue())
                throw (new ArgumentOutOfRangeException("projectId"));

            return DataProviderManager.Provider.GetIssueUserCountByProject(projectId);
        }

        /// <summary>
        /// Gets the issue unassigned count by project.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public static int GetIssueUnassignedCountByProject(int projectId)
        {
            if (projectId <= DefaultValues.GetProjectIdMinValue())
                throw (new ArgumentOutOfRangeException("projectId"));

            return DataProviderManager.Provider.GetIssueUnassignedCountByProject(projectId);
        }


        /// <summary>
        /// Gets the issue unscheduled milestone count by project.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public static int GetIssueUnscheduledMilestoneCountByProject(int projectId)
        {
            if (projectId <= DefaultValues.GetProjectIdMinValue())
                throw (new ArgumentOutOfRangeException("projectId"));

            return DataProviderManager.Provider.GetIssueUnscheduledMilestoneCountByProject(projectId);
        }

        /// <summary>
        /// Gets the bug type count by project.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public static List<IssueCount> GetIssueTypeCountByProject(int projectId)
        {
            if (projectId <= DefaultValues.GetProjectIdMinValue())
                throw (new ArgumentOutOfRangeException("projectId"));

            return DataProviderManager.Provider.GetIssueTypeCountByProject(projectId);
        }

        /// <summary>
        /// Gets the issue count by project and category.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <param name="categoryId">The category id.</param>
        /// <returns></returns>
        public static int GetIssueCountByProjectAndCategory(int projectId, int categoryId)
        {
            if (projectId <= DefaultValues.GetProjectIdMinValue())
                throw (new ArgumentOutOfRangeException("projectId"));

            return DataProviderManager.Provider.GetIssueCountByProjectAndCategory(projectId, categoryId);
        }

        /// <summary>
        /// Gets the bugs by criteria.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <param name="componentId">The component id.</param>
        /// <param name="versionId">The version id.</param>
        /// <param name="IssueTypeId">The type id.</param>
        /// <param name="priorityId">The priority id.</param>
        /// <param name="statusId">The status id.</param>
        /// <param name="AssignedToUserName">Name of the assigned to user.</param>
        /// <param name="resolutionId">The resolution id.</param>
        /// <param name="keywords">The keywords.</param>
        /// <param name="excludeClosed">if set to <c>true</c> [exclude closed].</param>
        /// <returns></returns>
        public static List<Issue> GetIssuesByCriteria(int projectId, int componentId, int versionId, int IssueTypeId,
            int priorityId, int statusId, string AssignedToUserName,
            int resolutionId, string keywords, bool excludeClosed)
        {

            return Issue.GetIssuesByCriteria(projectId, componentId, versionId, IssueTypeId,
                 priorityId, statusId, AssignedToUserName,
                  resolutionId, keywords, excludeClosed, string.Empty, -1);
        }

        /// <summary>
        /// Gets the bugs by criteria.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <param name="componentId">The component id.</param>
        /// <param name="versionId">The version id.</param>
        /// <param name="IssueTypeId">The type id.</param>
        /// <param name="priorityId">The priority id.</param>
        /// <param name="statusId">The status id.</param>
        /// <param name="AssignedToUserName">Name of the assigned to user.</param>
        /// <param name="resolutionId">The resolution id.</param>
        /// <param name="keywords">The keywords.</param>
        /// <param name="excludeClosed">if set to <c>true</c> [exclude closed].</param>
        /// <param name="reporterUserName">Name of the reporter user.</param>
        /// <param name="fixedInVersionId">The fixed in version id.</param>
        /// <returns></returns>
        public static List<Issue> GetIssuesByCriteria(int projectId, int componentId, int versionId, int IssueTypeId,
                int priorityId, int statusId, string AssignedToUserName,
                int resolutionId, string keywords, bool excludeClosed, string reporterUserName, int fixedInVersionId)
        {


            throw new NotImplementedException();
            //return DataProviderManager.Provider.GetIssuesByCriteria(projectId, componentId, versionId, IssueTypeId,
            //    priorityId, statusId, AssignedToUserName, resolutionId, keywords, excludeClosed,reporterUserName,fixedInVersionId);
        }

        /// <summary>
        /// Gets the recently added bugs by project id.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public static List<Issue> GetRecentlyAddedIssuesByProjectId(int projectId)
        {
            if (projectId <= DefaultValues.GetProjectIdMinValue())
                throw (new ArgumentOutOfRangeException("projectId"));

            throw new NotImplementedException();
            //return DataProviderManager.Provider.GetRecentlyAddedIssuesByProjectId(projectId);
        }

        /// <summary>
        /// Deletes the issue
        /// </summary>
        /// <param name="issueId">The issue id.</param>
        /// <returns></returns>
        public static bool DeleteIssue(int issueId)
        {
            if (issueId <= DefaultValues.GetIssueIdMinValue())
                throw (new ArgumentOutOfRangeException("issueId"));


            return DataProviderManager.Provider.DeleteIssue(issueId); ;
        }

        /// <summary>
        /// Gets the issues by assigned username.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <param name="username">The username.</param>
        /// <returns></returns>
        public static List<Issue> GetIssuesByAssignedUserName(int projectId, string username)
        {
            if (projectId <= DefaultValues.GetProjectIdMinValue())
                throw (new ArgumentOutOfRangeException("projectId"));

            if (username == null || username.Length == 0)
                throw (new ArgumentOutOfRangeException("username"));

            return (DataProviderManager.Provider.GetIssuesByAssignedUserName(projectId, username));
        }

        /// <summary>
        /// Gets the issues by creator username.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <param name="username">The username.</param>
        /// <returns></returns>
        public static List<Issue> GetIssuesByCreatorUserName(int projectId, string username)
        {
            if (projectId <= DefaultValues.GetProjectIdMinValue())
                throw (new ArgumentOutOfRangeException("projectId"));

            if (username == null || username.Length == 0)
                throw (new ArgumentOutOfRangeException("username"));

            return (DataProviderManager.Provider.GetIssuesByCreatorUserName(projectId, username));
        }

        /// <summary>
        /// Gets the issues by owner username.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <param name="username">The username.</param>
        /// <returns></returns>
        public static List<Issue> GetIssuesByOwnerUserName(int projectId, string username)
        {
            if (projectId <= DefaultValues.GetProjectIdMinValue())
                throw (new ArgumentOutOfRangeException("projectId"));
            if (username == null || username.Length == 0)
                throw (new ArgumentOutOfRangeException("username"));

            return DataProviderManager.Provider.GetIssuesByOwnerUserName(projectId, username);
        }

        /// <summary>
        /// Gets the issues by relevancy.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <param name="username">The username.</param>
        /// <returns></returns>
        public static List<Issue> GetIssuesByRelevancy(int projectId, string username)
        {
            if (projectId <= DefaultValues.GetProjectIdMinValue())
                throw (new ArgumentOutOfRangeException("projectId"));
            if (username == null || username.Length == 0)
                throw (new ArgumentOutOfRangeException("username"));

            return (DataProviderManager.Provider.GetIssuesByRelevancy(projectId, username));
        }

        /// <summary>
        /// Gets the name of the monitored issues by user.
        /// </summary>
        /// <param name="username">The username.</param>
        /// <param name="excludeClosedStatus">if set to <c>true</c> [exclude closed status].</param>
        /// <returns></returns>
        public static List<Issue> GetMonitoredIssuesByUserName(string username, bool excludeClosedStatus)
        {
            if (username == null || username.Length == 0)
                throw (new ArgumentOutOfRangeException("username"));

            return DataProviderManager.Provider.GetMonitoredIssuesByUserName(username, excludeClosedStatus);
        }

        /// <summary>
        /// Returns an Issue object, pre-populated with defaults settings.
        /// </summary>
        /// <param name="projectId">The project id.</param> 
        /// <param name="AssignedName">The Assigned To username.</param> 
        /// <param name="OwnerName">The owner and reporter username.</param> 
        /// <returns></returns>
        public static Issue GetDefaultIssueByProjectId(int projectId, string Title, string Description, string AssignedName, string OwnerName)
        {
            if (projectId < DefaultValues.GetProjectIdMinValue())
                throw new ArgumentOutOfRangeException(string.Format("ProjectID must be {0} or larger.", DefaultValues.GetProjectIdMinValue()));

            Project CurProject = Project.GetProjectById(projectId);

            if (CurProject == null)
                throw new ArgumentException("Project not found for ProjectID.");

            List<Category> Cats = Category.GetCategoriesByProjectId(projectId);
            Category defCat = null;
            List<Status> Statuses = Status.GetStatusByProjectId(projectId);
            Status defStatus = null;
            List<Priority> Priorities = Priority.GetPrioritiesByProjectId(projectId);
            Priority defPriority = null;
            List<IssueType> IssueTypes = IssueType.GetIssueTypesByProjectId(projectId);
            IssueType defIssueType = null;
            List<Resolution> Resolutions = Resolution.GetResolutionsByProjectId(projectId);
            Resolution defResolution = null;
            List<Milestone> AffectedMilestones = Milestone.GetMilestoneByProjectId(projectId);
            Milestone defAffectedMilestone = null;
            List<Milestone> Milestones = Milestone.GetMilestoneByProjectId(projectId);
            Milestone defMilestone = null;

            // Select the first one in the list, not really the default intended.
            defCat = Cats[0];
            defStatus = Statuses[0];
            defPriority = Priorities[0];
            defIssueType = IssueTypes[0];
            defResolution = Resolutions[0];
            defAffectedMilestone = AffectedMilestones[0];
            defMilestone = Milestones[0];

            // Now create an issue                
            Issue iss = new Issue(0, projectId, Title, Description, defCat.Id, defPriority.Id, defStatus.Id,
                defIssueType.Id, defMilestone.Id, defAffectedMilestone.Id, defResolution.Id,
                OwnerName, AssignedName, OwnerName, 0, 0, DateTime.MinValue);

            return iss;
        }

        /// <summary>
        /// Gets the open issues.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <returns></returns>
        public static List<Issue> GetOpenIssues(int projectId)
        {
            if (projectId <= DefaultValues.GetProjectIdMinValue())
                throw (new ArgumentOutOfRangeException("projectId"));

            return (DataProviderManager.Provider.GetOpenIssues(projectId));
        }


        /// <summary>
        /// Performs the query.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <param name="queryClauses">The query clauses.</param>
        /// <returns></returns>
        public static List<Issue> PerformQuery(int projectId, List<QueryClause> queryClauses)
        {
            if (queryClauses.Count == 0)
                throw new ArgumentOutOfRangeException("queryClauses");

            return DataProviderManager.Provider.PerformQuery(projectId, queryClauses);
        }

        /// <summary>
        /// Performs the saved query.
        /// </summary>
        /// <param name="projectId">The project id.</param>
        /// <param name="queryId">The query id.</param>
        /// <returns></returns>
        public static List<Issue> PerformSavedQuery(int projectId, int queryId)
        {
            if (queryId <= DefaultValues.GetQueryIdMinValue())
                throw (new ArgumentOutOfRangeException("queryId"));

            return DataProviderManager.Provider.PerformSavedQuery(projectId, queryId);
        }

        /// <summary>
        /// Checks the Issue ID passed in to verify that it exists.
        /// </summary>
        /// <param name="issueId">Issue ID to check</param>
        /// <returns>True if the ID is valid. False otherwise.</returns>
        public static bool IsValidId(int issueId)
        {
            bool isValid = false;
            Issue requestedIssue = null;

            requestedIssue = DataProviderManager.Provider.GetIssueById(issueId);

            isValid = requestedIssue != null;

            return isValid;
        }
        #endregion

        #region IToXml Members

        public string ToXml()
        {
            XmlSerializeService<Issue> service = new XmlSerializeService<Issue>();
            return service.ToXml(this);
        }

        #endregion
    }
}
