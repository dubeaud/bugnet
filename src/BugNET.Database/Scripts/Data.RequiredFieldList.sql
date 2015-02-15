-- Reference Data for BugNet_RequiredFieldList 
MERGE INTO BugNet_RequiredFieldList AS Target 
USING (VALUES 
	(1, N'-- Select Field --', N'0'),
	(2, N'Issue Id', N'IssueId'),
	(3, N'Title', N'IssueTitle'),
	(4, N'Description', N'IssueDescription'),
	(5, N'Type', N'IssueTypeId'),
	(6, N'Category', N'IssueCategoryId'),
	(7, N'Priority', N'IssuePriorityId'),
	(8, N'Milestone', N'IssueMilestoneId'),
	(9, N'Status', N'IssueStatusId'),
	(10, N'Assigned', N'IssueAssignedUserId'),
	(11, N'Owner', N'IssueOwnerUserId'),
	(12, N'Creator', N'IssueCreatorUserId'),
	(13, N'Date Created', N'DateCreated'),
	(14, N'Last Update', N'LastUpdate'),
	(15, N'Resolution', N'IssueResolutionId'),
	(16, N'Affected Milestone', N'IssueAffectedMilestoneId'),
	(17, N'Due Date', N'IssueDueDate'),
	(18, N'Progress', N'IssueProgress'),
	(19, N'Estimation', N'IssueEstimation'),
	(20, N'Time Logged', N'TimeLogged'),
	(21, N'Custom Fields', N'CustomFieldName')
) 
AS Source (RequiredFieldId, FieldName, FieldValue) 
ON Target.RequiredFieldId = Source.RequiredFieldId
-- update matched rows 
WHEN MATCHED THEN 
UPDATE SET FieldName = Source.FieldName , FieldValue = Source.FieldValue
-- insert new rows 
WHEN NOT MATCHED BY TARGET THEN 
INSERT (RequiredFieldId, FieldName, FieldValue) 
VALUES (RequiredFieldId, FieldName, FieldValue) 
-- delete rows that are in the target but not the source 
WHEN NOT MATCHED BY SOURCE THEN 
DELETE;