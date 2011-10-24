using System;
using System.Xml.Serialization;

namespace BugNET.Entities
{
    public class RoadMapIssue : Issue
    {
        /// <summary>
        /// Gets or sets the milestone sort order.
        /// </summary>
        /// <value>The milestone sort order.</value>
        public int MilestoneSortOrder { get; set; }

        /// <summary>
        /// Initializes a new instance of the <see cref="RoadMapIssue"/> class.
        /// </summary>
        /// <param name="milestoneSortOrder">The milestone sort order.</param>
        /// <param name="id"></param>
        /// <param name="projectId"></param>
        /// <param name="projectName"></param>
        /// <param name="projectCode"></param>
        /// <param name="title"></param>
        /// <param name="description"></param>
        /// <param name="categoryId"></param>
        /// <param name="categoryName"></param>
        /// <param name="priorityId"></param>
        /// <param name="priorityName"></param>
        /// <param name="priorityImageUrl"></param>
        /// <param name="statusId"></param>
        public RoadMapIssue(int milestoneSortOrder, int id, int projectId,
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
            : base(id,
                   projectId,
                   projectName,
                   projectCode,
                   title,
                   description,
                   categoryId,
                   categoryName,
                   priorityId,
                   priorityName,
                   priorityImageUrl,
                   statusId,
                   statusName,
                   statusImageUrl,
                   issueTypeId,
                   issueTypeName,
                   issueTypeImageUrl,
                   resolutionId,
                   resolutionName,
                   resolutionImageUrl,
                   assignedDisplayName,
                   assignedUserName,
                   assignedUserId,
                   creatorDisplayName,
                   creatorUserName,
                   creatorUserId,
                   ownerDisplayName,
                   ownerUserName,
                   ownerUserId,
                   dueDate,
                   milestoneId,
                   milestoneName,
                   milestoneImageUrl,
                   milestoneDueDate,
                   affectedMilestoneId,
                   affectedMilestoneName,
                   affectedMilestoneImageUrl,
                   visiblity,
                   timeLogged,
                   estimation,
                   dateCreated,
                   lastUpdate,
                   lastUpdateUserName,
                   lastUpdateDisplayName,
                   progress,
                   disabled,
                   votes
                )
        {
            MilestoneSortOrder = milestoneSortOrder;
        }
    }
}
