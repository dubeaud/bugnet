using BugNET.Entities;
using BugNET.Services.DataContracts;

namespace BugNET.Services.Translators
{
    public static class IssueTranslator
    {
        /// <summary>
        /// Toes the issue.
        /// </summary>
        /// <param name="contract">The contract.</param>
        /// <returns></returns>
        public static Issue ToIssue(IssueContract contract)
        {
            return new Issue { Id = contract.Id,Title = contract.Title, Description = contract.Description, StatusId = contract.StatusId, 
                ResolutionId = contract.ResolutionId, IssueTypeId = contract.IssueTypeId, MilestoneId = contract.MilestoneId, AffectedMilestoneId = contract.AffectedMilestoneId,
            MilestoneDueDate = contract.MilestoneDueDate, Votes = contract.Votes, Visibility = contract.Visibility, CategoryId = contract.CategoryId, Estimation = contract.Estimation,
            Disabled = contract.Disabled, Progress = contract.Progress, AssignedUserId = contract.AssignedUserId, CreatorUserId= contract.CreatorUserId, DateCreated=contract.DateCreated,
            DueDate = contract.DueDate, ProjectId = contract.ProjectId};
        }

        /// <summary>
        /// Toes the issue contract.
        /// </summary>
        /// <param name="issue">The issue.</param>
        /// <returns></returns>
        public static IssueContract ToIssueContract(Issue issue)
        {
            return new IssueContract { Id = issue.Id, Title = issue.Title, Description = issue.Description, StatusId = issue.StatusId, ResolutionId = issue.ResolutionId,
            IssueTypeId = issue.IssueTypeId, MilestoneId = issue.MilestoneId, AffectedMilestoneId = issue.AffectedMilestoneId, MilestoneDueDate = issue.MilestoneDueDate,
            Votes = issue.Votes, Visibility = issue.Visibility, CategoryId = issue.CategoryId, Estimation = issue.Estimation, Disabled = issue.Disabled, Progress = issue.Progress,
            AssignedUserId = issue.AssignedUserId, CreatorUserId = issue.CreatorUserId, DateCreated = issue.DateCreated, DueDate = issue.DueDate, ProjectId = issue.ProjectId,
             LastUpdate = issue.LastUpdate, OwnerUserId = issue.OwnerUserId, PriorityId =issue.PriorityId};
        }
    }
}
