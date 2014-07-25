INSERT INTO [dbo].[BugNet_Languages] ([CultureCode], [CultureName], [FallbackCulture]) VALUES('zh-CN', 'Chinese (China)', 'en-US')
GO

TRUNCATE TABLE [BugNet_RequiredFieldList]
GO

/****** Object:  Table [dbo].[BugNet_RequiredFieldList]    Script Date: 08/26/2010 14:05:12 ******/
INSERT [BugNet_RequiredFieldList] ([RequiredFieldId], [FieldName], [FieldValue]) VALUES (1, N'-- Select Field --', N'0')
INSERT [BugNet_RequiredFieldList] ([RequiredFieldId], [FieldName], [FieldValue]) VALUES (2, N'Issue Id', N'IssueId')
INSERT [BugNet_RequiredFieldList] ([RequiredFieldId], [FieldName], [FieldValue]) VALUES (3, N'Title', N'IssueTitle')
INSERT [BugNet_RequiredFieldList] ([RequiredFieldId], [FieldName], [FieldValue]) VALUES (4, N'Description', N'IssueDescription')
INSERT [BugNet_RequiredFieldList] ([RequiredFieldId], [FieldName], [FieldValue]) VALUES (5, N'Type', N'IssueTypeId')
INSERT [BugNet_RequiredFieldList] ([RequiredFieldId], [FieldName], [FieldValue]) VALUES (6, N'Category', N'IssueCategoryId')
INSERT [BugNet_RequiredFieldList] ([RequiredFieldId], [FieldName], [FieldValue]) VALUES (7, N'Priority', N'IssuePriorityId')
INSERT [BugNet_RequiredFieldList] ([RequiredFieldId], [FieldName], [FieldValue]) VALUES (8, N'Milestone', N'IssueMilestoneId')
INSERT [BugNet_RequiredFieldList] ([RequiredFieldId], [FieldName], [FieldValue]) VALUES (9, N'Status', N'IssueStatusId')
INSERT [BugNet_RequiredFieldList] ([RequiredFieldId], [FieldName], [FieldValue]) VALUES (10, N'Assigned', N'IssueAssignedUserId')
INSERT [BugNet_RequiredFieldList] ([RequiredFieldId], [FieldName], [FieldValue]) VALUES (11, N'Owner', N'IssueOwnerUserId')
INSERT [BugNet_RequiredFieldList] ([RequiredFieldId], [FieldName], [FieldValue]) VALUES (12, N'Creator', N'IssueCreatorUserId')
INSERT [BugNet_RequiredFieldList] ([RequiredFieldId], [FieldName], [FieldValue]) VALUES (13, N'Date Created', N'DateCreated')
INSERT [BugNet_RequiredFieldList] ([RequiredFieldId], [FieldName], [FieldValue]) VALUES (14, N'Last Update', N'LastUpdate')
INSERT [BugNet_RequiredFieldList] ([RequiredFieldId], [FieldName], [FieldValue]) VALUES (15, N'Resolution', N'IssueResolutionId')
INSERT [BugNet_RequiredFieldList] ([RequiredFieldId], [FieldName], [FieldValue]) VALUES (16, N'Affected Milestone', N'IssueAffectedMilestoneId')
INSERT [BugNet_RequiredFieldList] ([RequiredFieldId], [FieldName], [FieldValue]) VALUES (17, N'Due Date', N'IssueDueDate')
INSERT [BugNet_RequiredFieldList] ([RequiredFieldId], [FieldName], [FieldValue]) VALUES (18, N'Progress', N'IssueProgress')
INSERT [BugNet_RequiredFieldList] ([RequiredFieldId], [FieldName], [FieldValue]) VALUES (19, N'Estimation', N'IssueEstimation')
INSERT [BugNet_RequiredFieldList] ([RequiredFieldId], [FieldName], [FieldValue]) VALUES (20, N'Time Logged', N'TimeLogged')
INSERT [BugNet_RequiredFieldList] ([RequiredFieldId], [FieldName], [FieldValue]) VALUES (21, N'Custom Fields', N'CustomFieldName')
GO