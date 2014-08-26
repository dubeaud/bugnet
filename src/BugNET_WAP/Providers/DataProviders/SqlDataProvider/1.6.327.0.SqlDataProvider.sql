INSERT INTO [dbo].[BugNet_Languages] ([CultureCode], [CultureName], [FallbackCulture]) VALUES('zh-CN', 'Chinese (China)', 'en-US')
GO

ALTER TABLE [dbo].[BugNet_RelatedIssues]
DROP CONSTRAINT PK_BugNet_RelatedIssues
GO

ALTER TABLE [dbo].[BugNet_RelatedIssues]
ADD CONSTRAINT PK_BugNet_RelatedIssues PRIMARY KEY CLUSTERED ([PrimaryIssueId] ASC, [SecondaryIssueId] ASC, [RelationType] ASC)
GO

UPDATE [dbo].[BugNet_ProjectCustomFields] SET CustomFieldDataType = 0 WHERE CustomFieldTypeId = 5
GO
UPDATE QC SET FieldValue = 'False' FROM [dbo].[BugNet_QueryClauses] QC JOIN [dbo].[BugNet_ProjectCustomFields] CF ON QC.CustomFieldId = CF.CustomFieldId  WHERE CF.CustomFieldTypeId = 5 AND FieldValue = '0'
GO
UPDATE QC SET FieldValue = 'True' FROM [dbo].[BugNet_QueryClauses] QC JOIN [dbo].[BugNet_ProjectCustomFields] CF ON QC.CustomFieldId = CF.CustomFieldId  WHERE CF.CustomFieldTypeId = 5 AND FieldValue = '1'
GO
UPDATE QC SET DataType = 12 FROM [dbo].[BugNet_QueryClauses] QC JOIN [dbo].[BugNet_ProjectCustomFields] CF ON QC.CustomFieldId = CF.CustomFieldId  WHERE CF.CustomFieldTypeId = 5
GO

DELETE FROM [dbo].[BugNet_RolePermissions] WHERE PermissionId = 30
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

PRINT N'Creating [dbo].[BugNet_IssueAttachments].[IX_BugNet_IssueAttachments_DateCreated_IssueId]...';
GO
CREATE NONCLUSTERED INDEX [IX_BugNet_IssueAttachments_DateCreated_IssueId]
    ON [dbo].[BugNet_IssueAttachments]([DateCreated] DESC, [IssueId] ASC)
    INCLUDE([IssueAttachmentId], [FileName], [Description], [FileSize], [ContentType], [UserId], [Attachment]);


GO
PRINT N'Creating [dbo].[BugNet_IssueComments].[IX_BugNet_IssueComments_IssueId_UserId_DateCreated]...';


GO
CREATE NONCLUSTERED INDEX [IX_BugNet_IssueComments_IssueId_UserId_DateCreated]
    ON [dbo].[BugNet_IssueComments]([IssueId] ASC, [UserId] ASC, [DateCreated] ASC)
    INCLUDE([IssueCommentId], [Comment]);


GO
PRINT N'Creating [dbo].[BugNet_IssueHistory].[IX_BugNet_IssueHistory_IssueId_UserId_DateCreated]...';


GO
CREATE NONCLUSTERED INDEX [IX_BugNet_IssueHistory_IssueId_UserId_DateCreated]
    ON [dbo].[BugNet_IssueHistory]([IssueId] ASC, [UserId] ASC, [DateCreated] ASC)
    INCLUDE([IssueHistoryId], [FieldChanged], [OldValue], [NewValue]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[IX_BugNet_Issues_IssueCategoryId_ProjectId_Disabled_IssueStatusId]...';


GO
CREATE NONCLUSTERED INDEX [IX_BugNet_Issues_IssueCategoryId_ProjectId_Disabled_IssueStatusId]
    ON [dbo].[BugNet_Issues]([IssueCategoryId] ASC, [ProjectId] ASC, [Disabled] ASC, [IssueStatusId] ASC);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[IX_BugNet_Issues_IssueId_ProjectId_Disabled]...';


GO
CREATE NONCLUSTERED INDEX [IX_BugNet_Issues_IssueId_ProjectId_Disabled]
    ON [dbo].[BugNet_Issues]([IssueId] DESC, [ProjectId] ASC, [Disabled] ASC)
    INCLUDE([IssueStatusId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[IX_BugNet_Issues_K12_K22_K1_K15_K9_K8_K6_K5_K7_K4_K10_K21_K11_K13_2_3_14_16_17_18_19_20]...';


GO
CREATE NONCLUSTERED INDEX [IX_BugNet_Issues_K12_K22_K1_K15_K9_K8_K6_K5_K7_K4_K10_K21_K11_K13_2_3_14_16_17_18_19_20]
    ON [dbo].[BugNet_Issues]([IssueAssignedUserId] ASC, [Disabled] ASC, [IssueId] ASC, [IssueMilestoneId] ASC, [IssueAffectedMilestoneId] ASC, [ProjectId] ASC, [IssueTypeId] ASC, [IssuePriorityId] ASC, [IssueCategoryId] ASC, [IssueStatusId] ASC, [IssueResolutionId] ASC, [LastUpdateUserId] ASC, [IssueCreatorUserId] ASC, [IssueOwnerUserId] ASC)
    INCLUDE([IssueTitle], [IssueDescription], [IssueDueDate], [IssueVisibility], [IssueEstimation], [IssueProgress], [DateCreated], [LastUpdate]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[IX_BugNet_Issues_K8_K22_K1_K13_K11_K21_K12_K10_K15_K9_K4_K7_K5_K6_2_3_14_16_17_18_19_20]...';


GO
CREATE NONCLUSTERED INDEX [IX_BugNet_Issues_K8_K22_K1_K13_K11_K21_K12_K10_K15_K9_K4_K7_K5_K6_2_3_14_16_17_18_19_20]
    ON [dbo].[BugNet_Issues]([ProjectId] ASC, [Disabled] ASC, [IssueId] ASC, [IssueOwnerUserId] ASC, [IssueCreatorUserId] ASC, [LastUpdateUserId] ASC, [IssueAssignedUserId] ASC, [IssueResolutionId] ASC, [IssueMilestoneId] ASC, [IssueAffectedMilestoneId] ASC, [IssueStatusId] ASC, [IssueCategoryId] ASC, [IssuePriorityId] ASC, [IssueTypeId] ASC)
    INCLUDE([IssueTitle], [IssueDescription], [IssueDueDate], [IssueVisibility], [IssueEstimation], [IssueProgress], [DateCreated], [LastUpdate]);


GO
PRINT N'Creating [dbo].[BugNet_IssueAttachments].[ST_1410104064_1_2]...';


GO
CREATE STATISTICS [ST_1410104064_1_2]
    ON [dbo].[BugNet_IssueAttachments]([IssueAttachmentId], [IssueId]);


GO
PRINT N'Creating [dbo].[BugNet_IssueAttachments].[ST_1410104064_1_8]...';


GO
CREATE STATISTICS [ST_1410104064_1_8]
    ON [dbo].[BugNet_IssueAttachments]([IssueAttachmentId], [UserId]);


GO
PRINT N'Creating [dbo].[BugNet_IssueAttachments].[ST_1410104064_2_8_7]...';


GO
CREATE STATISTICS [ST_1410104064_2_8_7]
    ON [dbo].[BugNet_IssueAttachments]([IssueId], [UserId], [DateCreated]);


GO
PRINT N'Creating [dbo].[BugNet_IssueComments].[ST_1474104292_1_5]...';


GO
CREATE STATISTICS [ST_1474104292_1_5]
    ON [dbo].[BugNet_IssueComments]([IssueCommentId], [UserId]);


GO
PRINT N'Creating [dbo].[BugNet_IssueComments].[ST_1474104292_2_1]...';


GO
CREATE STATISTICS [ST_1474104292_2_1]
    ON [dbo].[BugNet_IssueComments]([IssueId], [IssueCommentId]);


GO
PRINT N'Creating [dbo].[BugNet_IssueComments].[ST_1474104292_3_2]...';


GO
CREATE STATISTICS [ST_1474104292_3_2]
    ON [dbo].[BugNet_IssueComments]([DateCreated], [IssueId]);


GO
PRINT N'Creating [dbo].[BugNet_IssueComments].[ST_1474104292_5_2_3]...';


GO
CREATE STATISTICS [ST_1474104292_5_2_3]
    ON [dbo].[BugNet_IssueComments]([UserId], [IssueId], [DateCreated]);


GO
PRINT N'Creating [dbo].[BugNet_IssueHistory].[ST_1442104178_2_3_5_4_7]...';


GO
CREATE STATISTICS [ST_1442104178_2_3_5_4_7]
    ON [dbo].[BugNet_IssueHistory]([IssueId], [FieldChanged], [NewValue], [OldValue], [UserId]);


GO
PRINT N'Creating [dbo].[BugNet_IssueHistory].[ST_1442104178_2_7_3_5]...';


GO
CREATE STATISTICS [ST_1442104178_2_7_3_5]
    ON [dbo].[BugNet_IssueHistory]([IssueId], [UserId], [FieldChanged], [NewValue]);


GO
PRINT N'Creating [dbo].[BugNet_IssueHistory].[ST_1442104178_6_2]...';


GO
CREATE STATISTICS [ST_1442104178_6_2]
    ON [dbo].[BugNet_IssueHistory]([DateCreated], [IssueId]);


GO
PRINT N'Creating [dbo].[BugNet_IssueHistory].[ST_1442104178_7_2_6]...';


GO
CREATE STATISTICS [ST_1442104178_7_2_6]
    ON [dbo].[BugNet_IssueHistory]([UserId], [IssueId], [DateCreated]);


GO
PRINT N'Creating [dbo].[BugNet_IssueHistory].[ST_1442104178_7_3_5_4]...';


GO
CREATE STATISTICS [ST_1442104178_7_3_5_4]
    ON [dbo].[BugNet_IssueHistory]([UserId], [FieldChanged], [NewValue], [OldValue]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_1_12_21_11_13_6_5_7_4_9_15]...';


GO
CREATE STATISTICS [ST_914102297_1_12_21_11_13_6_5_7_4_9_15]
    ON [dbo].[BugNet_Issues]([IssueId], [IssueAssignedUserId], [LastUpdateUserId], [IssueCreatorUserId], [IssueOwnerUserId], [IssueTypeId], [IssuePriorityId], [IssueCategoryId], [IssueStatusId], [IssueAffectedMilestoneId], [IssueMilestoneId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_1_12_8_22_15]...';


GO
CREATE STATISTICS [ST_914102297_1_12_8_22_15]
    ON [dbo].[BugNet_Issues]([IssueId], [IssueAssignedUserId], [ProjectId], [Disabled], [IssueMilestoneId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_1_4_22]...';


GO
CREATE STATISTICS [ST_914102297_1_4_22]
    ON [dbo].[BugNet_Issues]([IssueId], [IssueStatusId], [Disabled]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_1_4_6_5]...';


GO
CREATE STATISTICS [ST_914102297_1_4_6_5]
    ON [dbo].[BugNet_Issues]([IssueId], [IssueStatusId], [IssueTypeId], [IssuePriorityId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_1_8_22_10_15]...';


GO
CREATE STATISTICS [ST_914102297_1_8_22_10_15]
    ON [dbo].[BugNet_Issues]([IssueId], [ProjectId], [Disabled], [IssueResolutionId], [IssueMilestoneId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_1_8_6_5_7_4_9_15_10_12_21_11]...';


GO
CREATE STATISTICS [ST_914102297_1_8_6_5_7_4_9_15_10_12_21_11]
    ON [dbo].[BugNet_Issues]([IssueId], [ProjectId], [IssueTypeId], [IssuePriorityId], [IssueCategoryId], [IssueStatusId], [IssueAffectedMilestoneId], [IssueMilestoneId], [IssueResolutionId], [IssueAssignedUserId], [LastUpdateUserId], [IssueCreatorUserId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_1_9]...';


GO
CREATE STATISTICS [ST_914102297_1_9]
    ON [dbo].[BugNet_Issues]([IssueId], [IssueAffectedMilestoneId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_10_1_4]...';


GO
CREATE STATISTICS [ST_914102297_10_1_4]
    ON [dbo].[BugNet_Issues]([IssueResolutionId], [IssueId], [IssueStatusId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_10_1_6_5_7_4_9]...';


GO
CREATE STATISTICS [ST_914102297_10_1_6_5_7_4_9]
    ON [dbo].[BugNet_Issues]([IssueResolutionId], [IssueId], [IssueTypeId], [IssuePriorityId], [IssueCategoryId], [IssueStatusId], [IssueAffectedMilestoneId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_10_12_8_22_1_15_9_4_6_5]...';


GO
CREATE STATISTICS [ST_914102297_10_12_8_22_1_15_9_4_6_5]
    ON [dbo].[BugNet_Issues]([IssueResolutionId], [IssueAssignedUserId], [ProjectId], [Disabled], [IssueId], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueStatusId], [IssueTypeId], [IssuePriorityId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_10_15_9_1_4_6_5_7_12_21_11_13_22]...';


GO
CREATE STATISTICS [ST_914102297_10_15_9_1_4_6_5_7_12_21_11_13_22]
    ON [dbo].[BugNet_Issues]([IssueResolutionId], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueId], [IssueStatusId], [IssueTypeId], [IssuePriorityId], [IssueCategoryId], [IssueAssignedUserId], [LastUpdateUserId], [IssueCreatorUserId], [IssueOwnerUserId], [Disabled]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_10_15_9_8_6_5_7_4_12_21_13_1_22]...';


GO
CREATE STATISTICS [ST_914102297_10_15_9_8_6_5_7_4_12_21_13_1_22]
    ON [dbo].[BugNet_Issues]([IssueResolutionId], [IssueMilestoneId], [IssueAffectedMilestoneId], [ProjectId], [IssueTypeId], [IssuePriorityId], [IssueCategoryId], [IssueStatusId], [IssueAssignedUserId], [LastUpdateUserId], [IssueOwnerUserId], [IssueId], [Disabled]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_10_22_13_11_21_12_15]...';


GO
CREATE STATISTICS [ST_914102297_10_22_13_11_21_12_15]
    ON [dbo].[BugNet_Issues]([IssueResolutionId], [Disabled], [IssueOwnerUserId], [IssueCreatorUserId], [LastUpdateUserId], [IssueAssignedUserId], [IssueMilestoneId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_10_8_11]...';


GO
CREATE STATISTICS [ST_914102297_10_8_11]
    ON [dbo].[BugNet_Issues]([IssueResolutionId], [ProjectId], [IssueCreatorUserId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_10_8_12_22_1_4_6_5_7_9]...';


GO
CREATE STATISTICS [ST_914102297_10_8_12_22_1_4_6_5_7_9]
    ON [dbo].[BugNet_Issues]([IssueResolutionId], [ProjectId], [IssueAssignedUserId], [Disabled], [IssueId], [IssueStatusId], [IssueTypeId], [IssuePriorityId], [IssueCategoryId], [IssueAffectedMilestoneId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_10_8_12_22_15_9_6_5_7]...';


GO
CREATE STATISTICS [ST_914102297_10_8_12_22_15_9_6_5_7]
    ON [dbo].[BugNet_Issues]([IssueResolutionId], [ProjectId], [IssueAssignedUserId], [Disabled], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueTypeId], [IssuePriorityId], [IssueCategoryId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_10_8_13]...';


GO
CREATE STATISTICS [ST_914102297_10_8_13]
    ON [dbo].[BugNet_Issues]([IssueResolutionId], [ProjectId], [IssueOwnerUserId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_10_8_22_1_13_11_21]...';


GO
CREATE STATISTICS [ST_914102297_10_8_22_1_13_11_21]
    ON [dbo].[BugNet_Issues]([IssueResolutionId], [ProjectId], [Disabled], [IssueId], [IssueOwnerUserId], [IssueCreatorUserId], [LastUpdateUserId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_11_10_15_9]...';


GO
CREATE STATISTICS [ST_914102297_11_10_15_9]
    ON [dbo].[BugNet_Issues]([IssueCreatorUserId], [IssueResolutionId], [IssueMilestoneId], [IssueAffectedMilestoneId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_12_10_15_9]...';


GO
CREATE STATISTICS [ST_914102297_12_10_15_9]
    ON [dbo].[BugNet_Issues]([IssueAssignedUserId], [IssueResolutionId], [IssueMilestoneId], [IssueAffectedMilestoneId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_12_15_9_22_8_6]...';


GO
CREATE STATISTICS [ST_914102297_12_15_9_22_8_6]
    ON [dbo].[BugNet_Issues]([IssueAssignedUserId], [IssueMilestoneId], [IssueAffectedMilestoneId], [Disabled], [ProjectId], [IssueTypeId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_12_21_11_13_4_8_22]...';


GO
CREATE STATISTICS [ST_914102297_12_21_11_13_4_8_22]
    ON [dbo].[BugNet_Issues]([IssueAssignedUserId], [LastUpdateUserId], [IssueCreatorUserId], [IssueOwnerUserId], [IssueStatusId], [ProjectId], [Disabled]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_12_21_11_8_13_22_10_15_9_6_5_7]...';


GO
CREATE STATISTICS [ST_914102297_12_21_11_8_13_22_10_15_9_6_5_7]
    ON [dbo].[BugNet_Issues]([IssueAssignedUserId], [LastUpdateUserId], [IssueCreatorUserId], [ProjectId], [IssueOwnerUserId], [Disabled], [IssueResolutionId], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueTypeId], [IssuePriorityId], [IssueCategoryId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_12_22_21_11]...';


GO
CREATE STATISTICS [ST_914102297_12_22_21_11]
    ON [dbo].[BugNet_Issues]([IssueAssignedUserId], [Disabled], [LastUpdateUserId], [IssueCreatorUserId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_12_4]...';


GO
CREATE STATISTICS [ST_914102297_12_4]
    ON [dbo].[BugNet_Issues]([IssueAssignedUserId], [IssueStatusId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_12_8_22_1_21_11]...';


GO
CREATE STATISTICS [ST_914102297_12_8_22_1_21_11]
    ON [dbo].[BugNet_Issues]([IssueAssignedUserId], [ProjectId], [Disabled], [IssueId], [LastUpdateUserId], [IssueCreatorUserId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_12_8_22_1_6_15_9]...';


GO
CREATE STATISTICS [ST_914102297_12_8_22_1_6_15_9]
    ON [dbo].[BugNet_Issues]([IssueAssignedUserId], [ProjectId], [Disabled], [IssueId], [IssueTypeId], [IssueMilestoneId], [IssueAffectedMilestoneId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_13_10_15_9_22]...';


GO
CREATE STATISTICS [ST_914102297_13_10_15_9_22]
    ON [dbo].[BugNet_Issues]([IssueOwnerUserId], [IssueResolutionId], [IssueMilestoneId], [IssueAffectedMilestoneId], [Disabled]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_13_11_21_12_10_15_9_4_7_5_6_1_22]...';


GO
CREATE STATISTICS [ST_914102297_13_11_21_12_10_15_9_4_7_5_6_1_22]
    ON [dbo].[BugNet_Issues]([IssueOwnerUserId], [IssueCreatorUserId], [LastUpdateUserId], [IssueAssignedUserId], [IssueResolutionId], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueStatusId], [IssueCategoryId], [IssuePriorityId], [IssueTypeId], [IssueId], [Disabled]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_13_11_21_12_8]...';


GO
CREATE STATISTICS [ST_914102297_13_11_21_12_8]
    ON [dbo].[BugNet_Issues]([IssueOwnerUserId], [IssueCreatorUserId], [LastUpdateUserId], [IssueAssignedUserId], [ProjectId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_13_12]...';


GO
CREATE STATISTICS [ST_914102297_13_12]
    ON [dbo].[BugNet_Issues]([IssueOwnerUserId], [IssueAssignedUserId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_15_4_8]...';


GO
CREATE STATISTICS [ST_914102297_15_4_8]
    ON [dbo].[BugNet_Issues]([IssueMilestoneId], [IssueStatusId], [ProjectId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_15_8_22]...';


GO
CREATE STATISTICS [ST_914102297_15_8_22]
    ON [dbo].[BugNet_Issues]([IssueMilestoneId], [ProjectId], [Disabled]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_15_9_12_8_22_1]...';


GO
CREATE STATISTICS [ST_914102297_15_9_12_8_22_1]
    ON [dbo].[BugNet_Issues]([IssueMilestoneId], [IssueAffectedMilestoneId], [IssueAssignedUserId], [ProjectId], [Disabled], [IssueId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_15_9_22_13_11_21_12_10_1_8_6_5_7_4]...';


GO
CREATE STATISTICS [ST_914102297_15_9_22_13_11_21_12_10_1_8_6_5_7_4]
    ON [dbo].[BugNet_Issues]([IssueMilestoneId], [IssueAffectedMilestoneId], [Disabled], [IssueOwnerUserId], [IssueCreatorUserId], [LastUpdateUserId], [IssueAssignedUserId], [IssueResolutionId], [IssueId], [ProjectId], [IssueTypeId], [IssuePriorityId], [IssueCategoryId], [IssueStatusId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_15_9_4_8]...';


GO
CREATE STATISTICS [ST_914102297_15_9_4_8]
    ON [dbo].[BugNet_Issues]([IssueMilestoneId], [IssueAffectedMilestoneId], [IssueStatusId], [ProjectId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_15_9_8_11]...';


GO
CREATE STATISTICS [ST_914102297_15_9_8_11]
    ON [dbo].[BugNet_Issues]([IssueMilestoneId], [IssueAffectedMilestoneId], [ProjectId], [IssueCreatorUserId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_15_9_8_13_22]...';


GO
CREATE STATISTICS [ST_914102297_15_9_8_13_22]
    ON [dbo].[BugNet_Issues]([IssueMilestoneId], [IssueAffectedMilestoneId], [ProjectId], [IssueOwnerUserId], [Disabled]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_15_9_8_22_1_13_11_21_12]...';


GO
CREATE STATISTICS [ST_914102297_15_9_8_22_1_13_11_21_12]
    ON [dbo].[BugNet_Issues]([IssueMilestoneId], [IssueAffectedMilestoneId], [ProjectId], [Disabled], [IssueId], [IssueOwnerUserId], [IssueCreatorUserId], [LastUpdateUserId], [IssueAssignedUserId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_15_9_8_6_5_7_4_10_21_11_13_1_22]...';


GO
CREATE STATISTICS [ST_914102297_15_9_8_6_5_7_4_10_21_11_13_1_22]
    ON [dbo].[BugNet_Issues]([IssueMilestoneId], [IssueAffectedMilestoneId], [ProjectId], [IssueTypeId], [IssuePriorityId], [IssueCategoryId], [IssueStatusId], [IssueResolutionId], [LastUpdateUserId], [IssueCreatorUserId], [IssueOwnerUserId], [IssueId], [Disabled]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_21_1]...';


GO
CREATE STATISTICS [ST_914102297_21_1]
    ON [dbo].[BugNet_Issues]([LastUpdateUserId], [IssueId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_21_11_13_12_22_15_9_8_6_5_7_4]...';


GO
CREATE STATISTICS [ST_914102297_21_11_13_12_22_15_9_8_6_5_7_4]
    ON [dbo].[BugNet_Issues]([LastUpdateUserId], [IssueCreatorUserId], [IssueOwnerUserId], [IssueAssignedUserId], [Disabled], [IssueMilestoneId], [IssueAffectedMilestoneId], [ProjectId], [IssueTypeId], [IssuePriorityId], [IssueCategoryId], [IssueStatusId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_21_11_13_12_8_22_1_15_9_4_6_5_7]...';


GO
CREATE STATISTICS [ST_914102297_21_11_13_12_8_22_1_15_9_4_6_5_7]
    ON [dbo].[BugNet_Issues]([LastUpdateUserId], [IssueCreatorUserId], [IssueOwnerUserId], [IssueAssignedUserId], [ProjectId], [Disabled], [IssueId], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueStatusId], [IssueTypeId], [IssuePriorityId], [IssueCategoryId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_22_1_13_11_21_12_10_15]...';


GO
CREATE STATISTICS [ST_914102297_22_1_13_11_21_12_10_15]
    ON [dbo].[BugNet_Issues]([Disabled], [IssueId], [IssueOwnerUserId], [IssueCreatorUserId], [LastUpdateUserId], [IssueAssignedUserId], [IssueResolutionId], [IssueMilestoneId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_22_10_15_9_11]...';


GO
CREATE STATISTICS [ST_914102297_22_10_15_9_11]
    ON [dbo].[BugNet_Issues]([Disabled], [IssueResolutionId], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueCreatorUserId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_22_10_15_9_12]...';


GO
CREATE STATISTICS [ST_914102297_22_10_15_9_12]
    ON [dbo].[BugNet_Issues]([Disabled], [IssueResolutionId], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueAssignedUserId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_22_12_13]...';


GO
CREATE STATISTICS [ST_914102297_22_12_13]
    ON [dbo].[BugNet_Issues]([Disabled], [IssueAssignedUserId], [IssueOwnerUserId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_22_12_8_15]...';


GO
CREATE STATISTICS [ST_914102297_22_12_8_15]
    ON [dbo].[BugNet_Issues]([Disabled], [IssueAssignedUserId], [ProjectId], [IssueMilestoneId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_22_13_11_21_12_10_15_9_4_7_5_6_8]...';


GO
CREATE STATISTICS [ST_914102297_22_13_11_21_12_10_15_9_4_7_5_6_8]
    ON [dbo].[BugNet_Issues]([Disabled], [IssueOwnerUserId], [IssueCreatorUserId], [LastUpdateUserId], [IssueAssignedUserId], [IssueResolutionId], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueStatusId], [IssueCategoryId], [IssuePriorityId], [IssueTypeId], [ProjectId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_22_13_8_10_15_9_6]...';


GO
CREATE STATISTICS [ST_914102297_22_13_8_10_15_9_6]
    ON [dbo].[BugNet_Issues]([Disabled], [IssueOwnerUserId], [ProjectId], [IssueResolutionId], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueTypeId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_22_15_4]...';


GO
CREATE STATISTICS [ST_914102297_22_15_4]
    ON [dbo].[BugNet_Issues]([Disabled], [IssueMilestoneId], [IssueStatusId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_22_15_9_12]...';


GO
CREATE STATISTICS [ST_914102297_22_15_9_12]
    ON [dbo].[BugNet_Issues]([Disabled], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueAssignedUserId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_22_15_9_4_8]...';


GO
CREATE STATISTICS [ST_914102297_22_15_9_4_8]
    ON [dbo].[BugNet_Issues]([Disabled], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueStatusId], [ProjectId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_22_4_13_11_21_12_10_15_9_1_8_6_5]...';


GO
CREATE STATISTICS [ST_914102297_22_4_13_11_21_12_10_15_9_1_8_6_5]
    ON [dbo].[BugNet_Issues]([Disabled], [IssueStatusId], [IssueOwnerUserId], [IssueCreatorUserId], [LastUpdateUserId], [IssueAssignedUserId], [IssueResolutionId], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueId], [ProjectId], [IssueTypeId], [IssuePriorityId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_22_5_8_4]...';


GO
CREATE STATISTICS [ST_914102297_22_5_8_4]
    ON [dbo].[BugNet_Issues]([Disabled], [IssuePriorityId], [ProjectId], [IssueStatusId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_22_7_13_11_21_12_10_15_9_1_8_6]...';


GO
CREATE STATISTICS [ST_914102297_22_7_13_11_21_12_10_15_9_1_8_6]
    ON [dbo].[BugNet_Issues]([Disabled], [IssueCategoryId], [IssueOwnerUserId], [IssueCreatorUserId], [LastUpdateUserId], [IssueAssignedUserId], [IssueResolutionId], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueId], [ProjectId], [IssueTypeId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_22_7_4]...';


GO
CREATE STATISTICS [ST_914102297_22_7_4]
    ON [dbo].[BugNet_Issues]([Disabled], [IssueCategoryId], [IssueStatusId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_22_8_10_15_9_1_4_6_5]...';


GO
CREATE STATISTICS [ST_914102297_22_8_10_15_9_1_4_6_5]
    ON [dbo].[BugNet_Issues]([Disabled], [ProjectId], [IssueResolutionId], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueId], [IssueStatusId], [IssueTypeId], [IssuePriorityId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_22_8_13_11_21_12_10_15_9_4_7_5]...';


GO
CREATE STATISTICS [ST_914102297_22_8_13_11_21_12_10_15_9_4_7_5]
    ON [dbo].[BugNet_Issues]([Disabled], [ProjectId], [IssueOwnerUserId], [IssueCreatorUserId], [LastUpdateUserId], [IssueAssignedUserId], [IssueResolutionId], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueStatusId], [IssueCategoryId], [IssuePriorityId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_4_1_22]...';


GO
CREATE STATISTICS [ST_914102297_4_1_22]
    ON [dbo].[BugNet_Issues]([IssueStatusId], [IssueId], [Disabled]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_4_8_11]...';


GO
CREATE STATISTICS [ST_914102297_4_8_11]
    ON [dbo].[BugNet_Issues]([IssueStatusId], [ProjectId], [IssueCreatorUserId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_4_8_12_22_10_15_9_6_5]...';


GO
CREATE STATISTICS [ST_914102297_4_8_12_22_10_15_9_6_5]
    ON [dbo].[BugNet_Issues]([IssueStatusId], [ProjectId], [IssueAssignedUserId], [Disabled], [IssueResolutionId], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueTypeId], [IssuePriorityId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_4_8_12_22_15_9_6_5]...';


GO
CREATE STATISTICS [ST_914102297_4_8_12_22_15_9_6_5]
    ON [dbo].[BugNet_Issues]([IssueStatusId], [ProjectId], [IssueAssignedUserId], [Disabled], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueTypeId], [IssuePriorityId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_4_8_13]...';


GO
CREATE STATISTICS [ST_914102297_4_8_13]
    ON [dbo].[BugNet_Issues]([IssueStatusId], [ProjectId], [IssueOwnerUserId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_4_8_22_1_10_15]...';


GO
CREATE STATISTICS [ST_914102297_4_8_22_1_10_15]
    ON [dbo].[BugNet_Issues]([IssueStatusId], [ProjectId], [Disabled], [IssueId], [IssueResolutionId], [IssueMilestoneId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_4_8_22_15]...';


GO
CREATE STATISTICS [ST_914102297_4_8_22_15]
    ON [dbo].[BugNet_Issues]([IssueStatusId], [ProjectId], [Disabled], [IssueMilestoneId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_4_8_7]...';


GO
CREATE STATISTICS [ST_914102297_4_8_7]
    ON [dbo].[BugNet_Issues]([IssueStatusId], [ProjectId], [IssueCategoryId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_5_1]...';


GO
CREATE STATISTICS [ST_914102297_5_1]
    ON [dbo].[BugNet_Issues]([IssuePriorityId], [IssueId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_5_12_8_22_1_15_9_4]...';


GO
CREATE STATISTICS [ST_914102297_5_12_8_22_1_15_9_4]
    ON [dbo].[BugNet_Issues]([IssuePriorityId], [IssueAssignedUserId], [ProjectId], [Disabled], [IssueId], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueStatusId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_5_22_13_11_21_12_10_15_9_1_8]...';


GO
CREATE STATISTICS [ST_914102297_5_22_13_11_21_12_10_15_9_1_8]
    ON [dbo].[BugNet_Issues]([IssuePriorityId], [Disabled], [IssueOwnerUserId], [IssueCreatorUserId], [LastUpdateUserId], [IssueAssignedUserId], [IssueResolutionId], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueId], [ProjectId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_5_4_8_22_1_15_9]...';


GO
CREATE STATISTICS [ST_914102297_5_4_8_22_1_15_9]
    ON [dbo].[BugNet_Issues]([IssuePriorityId], [IssueStatusId], [ProjectId], [Disabled], [IssueId], [IssueMilestoneId], [IssueAffectedMilestoneId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_5_8_11]...';


GO
CREATE STATISTICS [ST_914102297_5_8_11]
    ON [dbo].[BugNet_Issues]([IssuePriorityId], [ProjectId], [IssueCreatorUserId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_5_8_12_22_1_4]...';


GO
CREATE STATISTICS [ST_914102297_5_8_12_22_1_4]
    ON [dbo].[BugNet_Issues]([IssuePriorityId], [ProjectId], [IssueAssignedUserId], [Disabled], [IssueId], [IssueStatusId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_5_8_12_22_10_15_9]...';


GO
CREATE STATISTICS [ST_914102297_5_8_12_22_10_15_9]
    ON [dbo].[BugNet_Issues]([IssuePriorityId], [ProjectId], [IssueAssignedUserId], [Disabled], [IssueResolutionId], [IssueMilestoneId], [IssueAffectedMilestoneId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_5_8_22]...';


GO
CREATE STATISTICS [ST_914102297_5_8_22]
    ON [dbo].[BugNet_Issues]([IssuePriorityId], [ProjectId], [Disabled]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_6_1_5_7_4_9_15_10_12_21_11_13_8]...';


GO
CREATE STATISTICS [ST_914102297_6_1_5_7_4_9_15_10_12_21_11_13_8]
    ON [dbo].[BugNet_Issues]([IssueTypeId], [IssueId], [IssuePriorityId], [IssueCategoryId], [IssueStatusId], [IssueAffectedMilestoneId], [IssueMilestoneId], [IssueResolutionId], [IssueAssignedUserId], [LastUpdateUserId], [IssueCreatorUserId], [IssueOwnerUserId], [ProjectId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_6_12_22_15_9]...';


GO
CREATE STATISTICS [ST_914102297_6_12_22_15_9]
    ON [dbo].[BugNet_Issues]([IssueTypeId], [IssueAssignedUserId], [Disabled], [IssueMilestoneId], [IssueAffectedMilestoneId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_6_12_8_22]...';


GO
CREATE STATISTICS [ST_914102297_6_12_8_22]
    ON [dbo].[BugNet_Issues]([IssueTypeId], [IssueAssignedUserId], [ProjectId], [Disabled]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_6_22_13_11_21_12_10_15_9_1]...';


GO
CREATE STATISTICS [ST_914102297_6_22_13_11_21_12_10_15_9_1]
    ON [dbo].[BugNet_Issues]([IssueTypeId], [Disabled], [IssueOwnerUserId], [IssueCreatorUserId], [LastUpdateUserId], [IssueAssignedUserId], [IssueResolutionId], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_6_4_8_22_1_15]...';


GO
CREATE STATISTICS [ST_914102297_6_4_8_22_1_15]
    ON [dbo].[BugNet_Issues]([IssueTypeId], [IssueStatusId], [ProjectId], [Disabled], [IssueId], [IssueMilestoneId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_6_5_7_4_9_15_10_12_21_11_13_8]...';


GO
CREATE STATISTICS [ST_914102297_6_5_7_4_9_15_10_12_21_11_13_8]
    ON [dbo].[BugNet_Issues]([IssueTypeId], [IssuePriorityId], [IssueCategoryId], [IssueStatusId], [IssueAffectedMilestoneId], [IssueMilestoneId], [IssueResolutionId], [IssueAssignedUserId], [LastUpdateUserId], [IssueCreatorUserId], [IssueOwnerUserId], [ProjectId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_6_8_11_22_10_15]...';


GO
CREATE STATISTICS [ST_914102297_6_8_11_22_10_15]
    ON [dbo].[BugNet_Issues]([IssueTypeId], [ProjectId], [IssueCreatorUserId], [Disabled], [IssueResolutionId], [IssueMilestoneId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_6_8_12_22_10_15]...';


GO
CREATE STATISTICS [ST_914102297_6_8_12_22_10_15]
    ON [dbo].[BugNet_Issues]([IssueTypeId], [ProjectId], [IssueAssignedUserId], [Disabled], [IssueResolutionId], [IssueMilestoneId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_6_8_13]...';


GO
CREATE STATISTICS [ST_914102297_6_8_13]
    ON [dbo].[BugNet_Issues]([IssueTypeId], [ProjectId], [IssueOwnerUserId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_6_8_22_1_13_11_21_12_10_15_9_4_7]...';


GO
CREATE STATISTICS [ST_914102297_6_8_22_1_13_11_21_12_10_15_9_4_7]
    ON [dbo].[BugNet_Issues]([IssueTypeId], [ProjectId], [Disabled], [IssueId], [IssueOwnerUserId], [IssueCreatorUserId], [LastUpdateUserId], [IssueAssignedUserId], [IssueResolutionId], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueStatusId], [IssueCategoryId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_7_1_6]...';


GO
CREATE STATISTICS [ST_914102297_7_1_6]
    ON [dbo].[BugNet_Issues]([IssueCategoryId], [IssueId], [IssueTypeId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_7_12_8_22_1_15_9_4_6]...';


GO
CREATE STATISTICS [ST_914102297_7_12_8_22_1_15_9_4_6]
    ON [dbo].[BugNet_Issues]([IssueCategoryId], [IssueAssignedUserId], [ProjectId], [Disabled], [IssueId], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueStatusId], [IssueTypeId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_7_4_8_22_1_15_9_6]...';


GO
CREATE STATISTICS [ST_914102297_7_4_8_22_1_15_9_6]
    ON [dbo].[BugNet_Issues]([IssueCategoryId], [IssueStatusId], [ProjectId], [Disabled], [IssueId], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueTypeId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_7_8_11_22_10_15_9_6]...';


GO
CREATE STATISTICS [ST_914102297_7_8_11_22_10_15_9_6]
    ON [dbo].[BugNet_Issues]([IssueCategoryId], [ProjectId], [IssueCreatorUserId], [Disabled], [IssueResolutionId], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueTypeId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_7_8_12_22_10_15_9_6]...';


GO
CREATE STATISTICS [ST_914102297_7_8_12_22_10_15_9_6]
    ON [dbo].[BugNet_Issues]([IssueCategoryId], [ProjectId], [IssueAssignedUserId], [Disabled], [IssueResolutionId], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueTypeId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_7_8_12_22_15_9_6]...';


GO
CREATE STATISTICS [ST_914102297_7_8_12_22_15_9_6]
    ON [dbo].[BugNet_Issues]([IssueCategoryId], [ProjectId], [IssueAssignedUserId], [Disabled], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueTypeId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_7_8_13]...';


GO
CREATE STATISTICS [ST_914102297_7_8_13]
    ON [dbo].[BugNet_Issues]([IssueCategoryId], [ProjectId], [IssueOwnerUserId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_8_11_22_15_9]...';


GO
CREATE STATISTICS [ST_914102297_8_11_22_15_9]
    ON [dbo].[BugNet_Issues]([ProjectId], [IssueCreatorUserId], [Disabled], [IssueMilestoneId], [IssueAffectedMilestoneId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_8_11_22_4_10_15_9_6_5]...';


GO
CREATE STATISTICS [ST_914102297_8_11_22_4_10_15_9_6_5]
    ON [dbo].[BugNet_Issues]([ProjectId], [IssueCreatorUserId], [Disabled], [IssueStatusId], [IssueResolutionId], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueTypeId], [IssuePriorityId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_8_11_22_5_10_15_9]...';


GO
CREATE STATISTICS [ST_914102297_8_11_22_5_10_15_9]
    ON [dbo].[BugNet_Issues]([ProjectId], [IssueCreatorUserId], [Disabled], [IssuePriorityId], [IssueResolutionId], [IssueMilestoneId], [IssueAffectedMilestoneId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_8_12_22_1_15_9_6_5_7_4_10_21_11]...';


GO
CREATE STATISTICS [ST_914102297_8_12_22_1_15_9_6_5_7_4_10_21_11]
    ON [dbo].[BugNet_Issues]([ProjectId], [IssueAssignedUserId], [Disabled], [IssueId], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueTypeId], [IssuePriorityId], [IssueCategoryId], [IssueStatusId], [IssueResolutionId], [LastUpdateUserId], [IssueCreatorUserId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_8_12_22_1_7_4_6]...';


GO
CREATE STATISTICS [ST_914102297_8_12_22_1_7_4_6]
    ON [dbo].[BugNet_Issues]([ProjectId], [IssueAssignedUserId], [Disabled], [IssueId], [IssueCategoryId], [IssueStatusId], [IssueTypeId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_8_12_22_1_9]...';


GO
CREATE STATISTICS [ST_914102297_8_12_22_1_9]
    ON [dbo].[BugNet_Issues]([ProjectId], [IssueAssignedUserId], [Disabled], [IssueId], [IssueAffectedMilestoneId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_8_12_22_5_15_9_6_7_4_10_21_11]...';


GO
CREATE STATISTICS [ST_914102297_8_12_22_5_15_9_6_7_4_10_21_11]
    ON [dbo].[BugNet_Issues]([ProjectId], [IssueAssignedUserId], [Disabled], [IssuePriorityId], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueTypeId], [IssueCategoryId], [IssueStatusId], [IssueResolutionId], [LastUpdateUserId], [IssueCreatorUserId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_8_12_22_6_15]...';


GO
CREATE STATISTICS [ST_914102297_8_12_22_6_15]
    ON [dbo].[BugNet_Issues]([ProjectId], [IssueAssignedUserId], [Disabled], [IssueTypeId], [IssueMilestoneId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_8_13_22_12_21]...';


GO
CREATE STATISTICS [ST_914102297_8_13_22_12_21]
    ON [dbo].[BugNet_Issues]([ProjectId], [IssueOwnerUserId], [Disabled], [IssueAssignedUserId], [LastUpdateUserId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_8_13_22_15]...';


GO
CREATE STATISTICS [ST_914102297_8_13_22_15]
    ON [dbo].[BugNet_Issues]([ProjectId], [IssueOwnerUserId], [Disabled], [IssueMilestoneId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_8_13_22_4_10_15_9_6_5]...';


GO
CREATE STATISTICS [ST_914102297_8_13_22_4_10_15_9_6_5]
    ON [dbo].[BugNet_Issues]([ProjectId], [IssueOwnerUserId], [Disabled], [IssueStatusId], [IssueResolutionId], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueTypeId], [IssuePriorityId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_8_13_22_6_10_15]...';


GO
CREATE STATISTICS [ST_914102297_8_13_22_6_10_15]
    ON [dbo].[BugNet_Issues]([ProjectId], [IssueOwnerUserId], [Disabled], [IssueTypeId], [IssueResolutionId], [IssueMilestoneId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_8_13_22_7_10_15_9_6]...';


GO
CREATE STATISTICS [ST_914102297_8_13_22_7_10_15_9_6]
    ON [dbo].[BugNet_Issues]([ProjectId], [IssueOwnerUserId], [Disabled], [IssueCategoryId], [IssueResolutionId], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueTypeId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_8_22_1_15]...';


GO
CREATE STATISTICS [ST_914102297_8_22_1_15]
    ON [dbo].[BugNet_Issues]([ProjectId], [Disabled], [IssueId], [IssueMilestoneId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_8_22_1_4_13_11_21_12_10_15]...';


GO
CREATE STATISTICS [ST_914102297_8_22_1_4_13_11_21_12_10_15]
    ON [dbo].[BugNet_Issues]([ProjectId], [Disabled], [IssueId], [IssueStatusId], [IssueOwnerUserId], [IssueCreatorUserId], [LastUpdateUserId], [IssueAssignedUserId], [IssueResolutionId], [IssueMilestoneId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_8_22_1_4_15_9]...';


GO
CREATE STATISTICS [ST_914102297_8_22_1_4_15_9]
    ON [dbo].[BugNet_Issues]([ProjectId], [Disabled], [IssueId], [IssueStatusId], [IssueMilestoneId], [IssueAffectedMilestoneId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_8_22_1_5_10_15_9_4]...';


GO
CREATE STATISTICS [ST_914102297_8_22_1_5_10_15_9_4]
    ON [dbo].[BugNet_Issues]([ProjectId], [Disabled], [IssueId], [IssuePriorityId], [IssueResolutionId], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueStatusId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_8_22_1_5_13_11_21_12_10_15_9_4]...';


GO
CREATE STATISTICS [ST_914102297_8_22_1_5_13_11_21_12_10_15_9_4]
    ON [dbo].[BugNet_Issues]([ProjectId], [Disabled], [IssueId], [IssuePriorityId], [IssueOwnerUserId], [IssueCreatorUserId], [LastUpdateUserId], [IssueAssignedUserId], [IssueResolutionId], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueStatusId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_8_22_1_6_10_15_9]...';


GO
CREATE STATISTICS [ST_914102297_8_22_1_6_10_15_9]
    ON [dbo].[BugNet_Issues]([ProjectId], [Disabled], [IssueId], [IssueTypeId], [IssueResolutionId], [IssueMilestoneId], [IssueAffectedMilestoneId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_8_22_13_11_21_12_10_15_9]...';


GO
CREATE STATISTICS [ST_914102297_8_22_13_11_21_12_10_15_9]
    ON [dbo].[BugNet_Issues]([ProjectId], [Disabled], [IssueOwnerUserId], [IssueCreatorUserId], [LastUpdateUserId], [IssueAssignedUserId], [IssueResolutionId], [IssueMilestoneId], [IssueAffectedMilestoneId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_8_22_4_6]...';


GO
CREATE STATISTICS [ST_914102297_8_22_4_6]
    ON [dbo].[BugNet_Issues]([ProjectId], [Disabled], [IssueStatusId], [IssueTypeId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_8_7_22_4]...';


GO
CREATE STATISTICS [ST_914102297_8_7_22_4]
    ON [dbo].[BugNet_Issues]([ProjectId], [IssueCategoryId], [Disabled], [IssueStatusId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_9_15_1_6_5_7]...';


GO
CREATE STATISTICS [ST_914102297_9_15_1_6_5_7]
    ON [dbo].[BugNet_Issues]([IssueAffectedMilestoneId], [IssueMilestoneId], [IssueId], [IssueTypeId], [IssuePriorityId], [IssueCategoryId]);


GO
PRINT N'Creating [dbo].[BugNet_Issues].[ST_914102297_9_15_8_12_22_1_4_6_5]...';


GO
CREATE STATISTICS [ST_914102297_9_15_8_12_22_1_4_6_5]
    ON [dbo].[BugNet_Issues]([IssueAffectedMilestoneId], [IssueMilestoneId], [ProjectId], [IssueAssignedUserId], [Disabled], [IssueId], [IssueStatusId], [IssueTypeId], [IssuePriorityId]);


GO
PRINT N'Creating [dbo].[BugNet_Projects].[ST_1813581499_1_10_9_7]...';


GO
CREATE STATISTICS [ST_1813581499_1_10_9_7]
    ON [dbo].[BugNet_Projects]([ProjectId], [ProjectCreatorUserId], [ProjectManagerUserId], [ProjectDisabled]);


GO
PRINT N'Creating [dbo].[BugNet_Projects].[ST_1813581499_1_8_9_7_10_2]...';


GO
CREATE STATISTICS [ST_1813581499_1_8_9_7_10_2]
    ON [dbo].[BugNet_Projects]([ProjectId], [ProjectAccessType], [ProjectManagerUserId], [ProjectDisabled], [ProjectCreatorUserId], [ProjectName]);


GO
PRINT N'Creating [dbo].[BugNet_Projects].[ST_1813581499_10_9_8]...';


GO
CREATE STATISTICS [ST_1813581499_10_9_8]
    ON [dbo].[BugNet_Projects]([ProjectCreatorUserId], [ProjectManagerUserId], [ProjectAccessType]);


GO
PRINT N'Creating [dbo].[BugNet_Projects].[ST_1813581499_2_1_8_9_7]...';


GO
CREATE STATISTICS [ST_1813581499_2_1_8_9_7]
    ON [dbo].[BugNet_Projects]([ProjectName], [ProjectId], [ProjectAccessType], [ProjectManagerUserId], [ProjectDisabled]);


GO
PRINT N'Creating [dbo].[BugNet_Projects].[ST_1813581499_7_1_8_10]...';


GO
CREATE STATISTICS [ST_1813581499_7_1_8_10]
    ON [dbo].[BugNet_Projects]([ProjectDisabled], [ProjectId], [ProjectAccessType], [ProjectCreatorUserId]);


GO
PRINT N'Creating [dbo].[BugNet_Projects].[ST_1813581499_7_8]...';


GO
CREATE STATISTICS [ST_1813581499_7_8]
    ON [dbo].[BugNet_Projects]([ProjectDisabled], [ProjectAccessType]);


GO
PRINT N'Creating [dbo].[BugNet_Projects].[ST_1813581499_8_9_7_10]...';


GO
CREATE STATISTICS [ST_1813581499_8_9_7_10]
    ON [dbo].[BugNet_Projects]([ProjectAccessType], [ProjectManagerUserId], [ProjectDisabled], [ProjectCreatorUserId]);


GO
PRINT N'Creating [dbo].[BugNet_Projects].[ST_1813581499_9_1_7]...';


GO
CREATE STATISTICS [ST_1813581499_9_1_7]
    ON [dbo].[BugNet_Projects]([ProjectManagerUserId], [ProjectId], [ProjectDisabled]);


GO

ALTER VIEW [dbo].[BugNet_IssuesView]
AS
SELECT        dbo.BugNet_Issues.IssueId, dbo.BugNet_Issues.IssueTitle, dbo.BugNet_Issues.IssueDescription, dbo.BugNet_Issues.IssueStatusId, dbo.BugNet_Issues.IssuePriorityId, dbo.BugNet_Issues.IssueTypeId, 
                         dbo.BugNet_Issues.IssueCategoryId, dbo.BugNet_Issues.ProjectId, dbo.BugNet_Issues.IssueResolutionId, dbo.BugNet_Issues.IssueCreatorUserId, dbo.BugNet_Issues.IssueAssignedUserId, 
                         dbo.BugNet_Issues.IssueOwnerUserId, dbo.BugNet_Issues.IssueDueDate, dbo.BugNet_Issues.IssueMilestoneId, dbo.BugNet_Issues.IssueAffectedMilestoneId, dbo.BugNet_Issues.IssueVisibility, 
                         dbo.BugNet_Issues.IssueEstimation, dbo.BugNet_Issues.DateCreated, dbo.BugNet_Issues.LastUpdate, dbo.BugNet_Issues.LastUpdateUserId, dbo.BugNet_Projects.ProjectName, 
                         dbo.BugNet_Projects.ProjectCode, ISNULL(dbo.BugNet_ProjectPriorities.PriorityName, N'Unassigned') AS PriorityName, ISNULL(dbo.BugNet_ProjectIssueTypes.IssueTypeName, N'Unassigned') 
                         AS IssueTypeName, ISNULL(dbo.BugNet_ProjectCategories.CategoryName, N'Unassigned') AS CategoryName, ISNULL(dbo.BugNet_ProjectStatus.StatusName, N'Unassigned') AS StatusName, 
                         ISNULL(dbo.BugNet_ProjectMilestones.MilestoneName, N'Unassigned') AS MilestoneName, ISNULL(AffectedMilestone.MilestoneName, N'Unassigned') AS AffectedMilestoneName, 
                         ISNULL(dbo.BugNet_ProjectResolutions.ResolutionName, 'Unassigned') AS ResolutionName, LastUpdateUsers.UserName AS LastUpdateUserName, ISNULL(AssignedUsers.UserName, N'Unassigned') 
                         AS AssignedUserName, ISNULL(AssignedUsersProfile.DisplayName, N'Unassigned') AS AssignedDisplayName, CreatorUsers.UserName AS CreatorUserName, ISNULL(CreatorUsersProfile.DisplayName, 
                         N'Unassigned') AS CreatorDisplayName, ISNULL(OwnerUsers.UserName, 'Unassigned') AS OwnerUserName, ISNULL(OwnerUsersProfile.DisplayName, N'Unassigned') AS OwnerDisplayName, 
                         ISNULL(LastUpdateUsersProfile.DisplayName, 'Unassigned') AS LastUpdateDisplayName, ISNULL(dbo.BugNet_ProjectPriorities.PriorityImageUrl, '') AS PriorityImageUrl, 
                         ISNULL(dbo.BugNet_ProjectIssueTypes.IssueTypeImageUrl, '') AS IssueTypeImageUrl, ISNULL(dbo.BugNet_ProjectStatus.StatusImageUrl, '') AS StatusImageUrl, 
                         ISNULL(dbo.BugNet_ProjectMilestones.MilestoneImageUrl, '') AS MilestoneImageUrl, ISNULL(dbo.BugNet_ProjectResolutions.ResolutionImageUrl, '') AS ResolutionImageUrl, 
                         ISNULL(AffectedMilestone.MilestoneImageUrl, '') AS AffectedMilestoneImageUrl, ISNULL(dbo.BugNet_ProjectStatus.SortOrder, 0) AS StatusSortOrder, ISNULL(dbo.BugNet_ProjectPriorities.SortOrder, 0) 
                         AS PrioritySortOrder, ISNULL(dbo.BugNet_ProjectIssueTypes.SortOrder, 0) AS IssueTypeSortOrder, ISNULL(dbo.BugNet_ProjectMilestones.SortOrder, 0) AS MilestoneSortOrder, 
                         ISNULL(AffectedMilestone.SortOrder, 0) AS AffectedMilestoneSortOrder, ISNULL(dbo.BugNet_ProjectResolutions.SortOrder, 0) AS ResolutionSortOrder, ISNULL
                             ((SELECT        SUM(Duration) AS Expr1
                                 FROM            dbo.BugNet_IssueWorkReports AS WR
                                 WHERE        (IssueId = dbo.BugNet_Issues.IssueId)), 0.00) AS TimeLogged, ISNULL
                             ((SELECT        COUNT(IssueId) AS Expr1
                                 FROM            dbo.BugNet_IssueVotes AS V
                                 WHERE        (IssueId = dbo.BugNet_Issues.IssueId)), 0) AS IssueVotes, dbo.BugNet_Issues.Disabled, dbo.BugNet_Issues.IssueProgress, dbo.BugNet_ProjectMilestones.MilestoneDueDate, 
                         dbo.BugNet_Projects.ProjectDisabled, CAST(COALESCE (dbo.BugNet_ProjectStatus.IsClosedState, 0) AS BIT) AS IsClosed, CAST(CONVERT(VARCHAR(8), dbo.BugNet_Issues.LastUpdate, 112) AS DATETIME) 
                         AS LastUpdateAsDate, CAST(CONVERT(VARCHAR(8), dbo.BugNet_Issues.DateCreated, 112) AS DATETIME) AS DateCreatedAsDate
FROM            dbo.BugNet_Issues LEFT OUTER JOIN
                         dbo.BugNet_ProjectIssueTypes ON dbo.BugNet_Issues.IssueTypeId = dbo.BugNet_ProjectIssueTypes.IssueTypeId LEFT OUTER JOIN
                         dbo.BugNet_ProjectPriorities ON dbo.BugNet_Issues.IssuePriorityId = dbo.BugNet_ProjectPriorities.PriorityId LEFT OUTER JOIN
                         dbo.BugNet_ProjectCategories ON dbo.BugNet_Issues.IssueCategoryId = dbo.BugNet_ProjectCategories.CategoryId LEFT OUTER JOIN
                         dbo.BugNet_ProjectStatus ON dbo.BugNet_Issues.IssueStatusId = dbo.BugNet_ProjectStatus.StatusId LEFT OUTER JOIN
                         dbo.BugNet_ProjectMilestones AS AffectedMilestone ON dbo.BugNet_Issues.IssueAffectedMilestoneId = AffectedMilestone.MilestoneId LEFT OUTER JOIN
                         dbo.BugNet_ProjectMilestones ON dbo.BugNet_Issues.IssueMilestoneId = dbo.BugNet_ProjectMilestones.MilestoneId LEFT OUTER JOIN
                         dbo.BugNet_ProjectResolutions ON dbo.BugNet_Issues.IssueResolutionId = dbo.BugNet_ProjectResolutions.ResolutionId LEFT OUTER JOIN
                         dbo.Users AS AssignedUsers ON dbo.BugNet_Issues.IssueAssignedUserId = AssignedUsers.UserId LEFT OUTER JOIN
                         dbo.Users AS LastUpdateUsers ON dbo.BugNet_Issues.LastUpdateUserId = LastUpdateUsers.UserId LEFT OUTER JOIN
                         dbo.Users AS CreatorUsers ON dbo.BugNet_Issues.IssueCreatorUserId = CreatorUsers.UserId LEFT OUTER JOIN
                         dbo.Users AS OwnerUsers ON dbo.BugNet_Issues.IssueOwnerUserId = OwnerUsers.UserId LEFT OUTER JOIN
                         dbo.BugNet_UserProfiles AS CreatorUsersProfile ON CreatorUsers.UserName = CreatorUsersProfile.UserName LEFT OUTER JOIN
                         dbo.BugNet_UserProfiles AS AssignedUsersProfile ON AssignedUsers.UserName = AssignedUsersProfile.UserName LEFT OUTER JOIN
                         dbo.BugNet_UserProfiles AS OwnerUsersProfile ON OwnerUsers.UserName = OwnerUsersProfile.UserName LEFT OUTER JOIN
                         dbo.BugNet_UserProfiles AS LastUpdateUsersProfile ON LastUpdateUsers.UserName = LastUpdateUsersProfile.UserName LEFT OUTER JOIN
                         dbo.BugNet_Projects ON dbo.BugNet_Issues.ProjectId = dbo.BugNet_Projects.ProjectId
GO

ALTER PROCEDURE [dbo].[BugNet_Project_GetAllProjects]
	@ActiveOnly BIT = NULL
AS
SELECT 
	ProjectId,
	ProjectName,
	ProjectCode,
	ProjectDescription,
	AttachmentUploadPath,
	ProjectManagerUserId,
	ProjectCreatorUserId,
	DateCreated,
	ProjectDisabled,
	ProjectAccessType,
	ManagerUserName,
	ManagerDisplayName,
	CreatorUserName,
	CreatorDisplayName,
	AllowAttachments,
	AllowAttachments,
	AttachmentStorageType,
	SvnRepositoryUrl,
	AllowIssueVoting
FROM 
	BugNet_ProjectsView 
WHERE (@ActiveOnly IS NULL OR (ProjectDisabled = ~@ActiveOnly))
GO

DROP VIEW [dbo].[BugNet_Issue_IssueTypeCountView]
GO
DROP VIEW [dbo].[BugNet_IssueMilestoneCountView]
GO
DROP VIEW [dbo].[BugNet_IssuePriorityCountView]
GO
DROP VIEW [dbo].[BugNet_IssueStatusCountView]
GO

ALTER PROCEDURE [dbo].[BugNet_Issue_GetIssueMilestoneCountByProject] 
	@ProjectId int
AS

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT v.MilestoneName, COUNT(nt.IssueMilestoneId) AS 'Number', v.MilestoneId, v.MilestoneImageUrl
	FROM BugNet_ProjectMilestones v 
	LEFT OUTER JOIN
	(SELECT IssueMilestoneId
	FROM   
		BugNet_IssuesView
	WHERE  
		BugNet_IssuesView.Disabled = 0 
		AND BugNet_IssuesView.IsClosed = 0) nt 
	ON 
		v.MilestoneId = nt.IssueMilestoneId 
	WHERE 
		(v.ProjectId = @ProjectId) AND v.MilestoneCompleted = 0
	GROUP BY 
		v.MilestoneName, v.MilestoneId,v.SortOrder, v.MilestoneImageUrl
	ORDER BY 
		v.SortOrder ASC
END
GO

ALTER PROCEDURE [dbo].[BugNet_Issue_GetIssuePriorityCountByProject]
	@ProjectId int
AS
SELECT 
	p.PriorityName, COUNT(nt.IssuePriorityId) AS 'Number', p.PriorityId,  p.PriorityImageUrl
FROM   
	BugNet_ProjectPriorities p	
LEFT OUTER JOIN 
	(SELECT  
		IssuePriorityId, ProjectId 
	FROM   
		BugNet_IssuesView
	WHERE  
		BugNet_IssuesView.Disabled = 0 
		AND BugNet_IssuesView.IsClosed = 0) nt
ON 
	p.PriorityId = nt.IssuePriorityId AND nt.ProjectId = @ProjectId
WHERE 
	p.ProjectId = @ProjectId
GROUP BY 
	p.PriorityName, p.PriorityId, p.PriorityImageUrl, p.SortOrder
ORDER BY p.SortOrder
GO

ALTER PROCEDURE [dbo].[BugNet_Issue_GetIssueStatusCountByProject]
 @ProjectId int
AS
SELECT 
	s.StatusName,COUNT(nt.IssueStatusId) as 'Number', s.StatusId, s.StatusImageUrl
FROM 
	BugNet_ProjectStatus s 
LEFT OUTER JOIN 
(SELECT  
		IssueStatusId, ProjectId 
	FROM   
	BugNet_IssuesView
	WHERE  
		BugNet_IssuesView.Disabled = 0 
		AND IssueStatusId IN (SELECT StatusId FROM BugNet_ProjectStatus WHERE ProjectId = @ProjectId)) nt  
	ON 
		s.StatusId = nt.IssueStatusId AND nt.ProjectId = @ProjectId
	WHERE 
		s.ProjectId = @ProjectId
	GROUP BY 
		s.StatusName, s.StatusId, s.StatusImageUrl, s.SortOrder
	ORDER BY
		s.SortOrder
GO

ALTER PROCEDURE [dbo].[BugNet_Issue_GetIssueTypeCountByProject]
	@ProjectId int
AS

SELECT 
	t.IssueTypeName, COUNT(nt.IssueTypeId) AS 'Number', t.IssueTypeId, t.IssueTypeImageUrl
FROM  
	BugNet_ProjectIssueTypes t 
LEFT OUTER JOIN 
(SELECT  
		IssueTypeId, ProjectId 
	FROM   
		BugNet_IssuesView
	WHERE  
		BugNet_IssuesView.Disabled = 0 
		AND BugNet_IssuesView.IsClosed = 0) nt  
	ON 
		t.IssueTypeId = nt.IssueTypeId AND nt.ProjectId = @ProjectId
	WHERE 
		t.ProjectId = @ProjectId
	GROUP BY 
		t.IssueTypeName, t.IssueTypeId, t.IssueTypeImageUrl, t.SortOrder
	ORDER BY
		t.SortOrder
GO