-- Reference Data for BugNet_Permissions 
MERGE INTO BugNet_Permissions AS Target 
USING (VALUES 
  (1, N'CloseIssue', N'Close Issue'),
  (2, N'AddIssue', N'Add Issue'),
  (3, N'AssignIssue', N'Assign Issue'),
  (4, N'EditIssue', N'Edit Issue'),
  (5, N'SubscribeIssue', N'Subscribe Issue'),
  (6, N'DeleteIssue', N'Delete Issue'),
  (7, N'AddComment', N'Add Comment'),
  (8, N'EditComment', N'Edit Comment'),
  (9, N'DeleteComment', N'Delete Comment'),
  (10, N'AddAttachment', N'Add Attachment'),
  (11, N'DeleteAttachment', N'Delete Attachment'),
  (12, N'AddRelated', N'Add Related Issue'),
  (13, N'DeleteRelated', N'Delete Related Issue'),
  (14, N'ReopenIssue', N'Re-Open Issue'),
  (15, N'OwnerEditComment', N'Edit Own Comments'),
  (16, N'EditIssueDescription', N'Edit Issue Description'),
  (17, N'EditIssueTitle', N'Edit Issue Title'),
  (18, N'AdminEditProject', N'Admin Edit Project'),
  (19, N'AddTimeEntry', N'Add Time Entry'),
  (20, N'DeleteTimeEntry', N'Delete Time Entry'),
  (21, N'AdminCreateProject', N'Admin Create Project'),
  (22, N'AddQuery', N'Add Query'),
  (23, N'DeleteQuery', N'Delete Query'),
  (24, N'AdminCloneProject', N'Clone Project'),
  (25, N'AddSubIssue', N'Add Sub Issues'),
  (26, N'DeleteSubIssue', N'Delete Sub Issues'),
  (27, N'AddParentIssue', N'Add Parent Issues'),
  (28, N'DeleteParentIssue', N'Delete Parent Issues'),
  (29, N'AdminDeleteProject', N'Delete a project'),
  (30, N'ViewProjectCalendar', N'View the project calendar'),
  (31, N'ChangeIssueStatus', N'Change an issues status field'),
  (32, N'EditQuery', N'Edit queries')
) 
AS Source (PermissionId, PermissionKey, PermissionName) 
ON Target.PermissionId = Source.PermissionId 
-- update matched rows 
WHEN MATCHED THEN 
UPDATE SET PermissionKey = Source.PermissionKey, PermissionName = Source.PermissionName
-- insert new rows 
WHEN NOT MATCHED BY TARGET THEN 
INSERT (PermissionId,  PermissionKey, PermissionName) 
VALUES (PermissionId,  PermissionKey, PermissionName) 
-- delete rows that are in the target but not the source 
WHEN NOT MATCHED BY SOURCE THEN 
DELETE;