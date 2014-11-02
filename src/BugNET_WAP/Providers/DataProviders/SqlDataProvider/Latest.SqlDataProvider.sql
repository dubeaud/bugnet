SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_BugNet_IssueAttachments_DateCreated_IssueId]    Script Date: 9/11/2014 9:36:14 PM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_IssueAttachments]') AND name = N'IX_BugNet_IssueAttachments_DateCreated_IssueId')
CREATE NONCLUSTERED INDEX [IX_BugNet_IssueAttachments_DateCreated_IssueId] ON [dbo].[BugNet_IssueAttachments]
(
	[DateCreated] DESC,
	[IssueId] ASC
)
INCLUDE ( 	[IssueAttachmentId],
	[FileName],
	[Description],
	[FileSize],
	[ContentType],
	[UserId],
	[Attachment]) WITH (STATISTICS_NORECOMPUTE = OFF, DROP_EXISTING = OFF, ONLINE = OFF)
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_BugNet_IssueComments_IssueId_UserId_DateCreated]    Script Date: 9/11/2014 9:36:14 PM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_IssueComments]') AND name = N'IX_BugNet_IssueComments_IssueId_UserId_DateCreated')
CREATE NONCLUSTERED INDEX [IX_BugNet_IssueComments_IssueId_UserId_DateCreated] ON [dbo].[BugNet_IssueComments]
(
	[IssueId] ASC,
	[UserId] ASC,
	[DateCreated] ASC
)
INCLUDE ( 	[IssueCommentId],
	[Comment]) WITH (STATISTICS_NORECOMPUTE = OFF, DROP_EXISTING = OFF, ONLINE = OFF)
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_BugNet_IssueHistory_IssueId_UserId_DateCreated]    Script Date: 9/11/2014 9:36:14 PM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_IssueHistory]') AND name = N'IX_BugNet_IssueHistory_IssueId_UserId_DateCreated')
CREATE NONCLUSTERED INDEX [IX_BugNet_IssueHistory_IssueId_UserId_DateCreated] ON [dbo].[BugNet_IssueHistory]
(
	[IssueId] ASC,
	[UserId] ASC,
	[DateCreated] ASC
)
INCLUDE ( 	[IssueHistoryId],
	[FieldChanged],
	[OldValue],
	[NewValue]) WITH (STATISTICS_NORECOMPUTE = OFF, DROP_EXISTING = OFF, ONLINE = OFF)
GO
/****** Object:  Index [IX_BugNet_Issues_IssueCategoryId_ProjectId_Disabled_IssueStatusId]    Script Date: 9/11/2014 9:36:14 PM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Issues]') AND name = N'IX_BugNet_Issues_IssueCategoryId_ProjectId_Disabled_IssueStatusId')
CREATE NONCLUSTERED INDEX [IX_BugNet_Issues_IssueCategoryId_ProjectId_Disabled_IssueStatusId] ON [dbo].[BugNet_Issues]
(
	[IssueCategoryId] ASC,
	[ProjectId] ASC,
	[Disabled] ASC,
	[IssueStatusId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, DROP_EXISTING = OFF, ONLINE = OFF)
GO
/****** Object:  Index [IX_BugNet_Issues_IssueId_ProjectId_Disabled]    Script Date: 9/11/2014 9:36:14 PM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Issues]') AND name = N'IX_BugNet_Issues_IssueId_ProjectId_Disabled')
CREATE NONCLUSTERED INDEX [IX_BugNet_Issues_IssueId_ProjectId_Disabled] ON [dbo].[BugNet_Issues]
(
	[IssueId] DESC,
	[ProjectId] ASC,
	[Disabled] ASC
)
INCLUDE ( 	[IssueStatusId]) WITH (STATISTICS_NORECOMPUTE = OFF, DROP_EXISTING = OFF, ONLINE = OFF)
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_BugNet_Issues_K12_K22_K1_K15_K9_K8_K6_K5_K7_K4_K10_K21_K11_K13_2_3_14_16_17_18_19_20]    Script Date: 9/11/2014 9:36:14 PM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Issues]') AND name = N'IX_BugNet_Issues_K12_K22_K1_K15_K9_K8_K6_K5_K7_K4_K10_K21_K11_K13_2_3_14_16_17_18_19_20')
CREATE NONCLUSTERED INDEX [IX_BugNet_Issues_K12_K22_K1_K15_K9_K8_K6_K5_K7_K4_K10_K21_K11_K13_2_3_14_16_17_18_19_20] ON [dbo].[BugNet_Issues]
(
	[IssueAssignedUserId] ASC,
	[Disabled] ASC,
	[IssueId] ASC,
	[IssueMilestoneId] ASC,
	[IssueAffectedMilestoneId] ASC,
	[ProjectId] ASC,
	[IssueTypeId] ASC,
	[IssuePriorityId] ASC,
	[IssueCategoryId] ASC,
	[IssueStatusId] ASC,
	[IssueResolutionId] ASC,
	[LastUpdateUserId] ASC,
	[IssueCreatorUserId] ASC,
	[IssueOwnerUserId] ASC
)
INCLUDE ( 	[IssueTitle],
	[IssueDescription],
	[IssueDueDate],
	[IssueVisibility],
	[IssueEstimation],
	[IssueProgress],
	[DateCreated],
	[LastUpdate]) WITH (STATISTICS_NORECOMPUTE = OFF, DROP_EXISTING = OFF, ONLINE = OFF)
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_BugNet_Issues_K8_K22_K1_K13_K11_K21_K12_K10_K15_K9_K4_K7_K5_K6_2_3_14_16_17_18_19_20]    Script Date: 9/11/2014 9:36:14 PM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[BugNet_Issues]') AND name = N'IX_BugNet_Issues_K8_K22_K1_K13_K11_K21_K12_K10_K15_K9_K4_K7_K5_K6_2_3_14_16_17_18_19_20')
CREATE NONCLUSTERED INDEX [IX_BugNet_Issues_K8_K22_K1_K13_K11_K21_K12_K10_K15_K9_K4_K7_K5_K6_2_3_14_16_17_18_19_20] ON [dbo].[BugNet_Issues]
(
	[ProjectId] ASC,
	[Disabled] ASC,
	[IssueId] ASC,
	[IssueOwnerUserId] ASC,
	[IssueCreatorUserId] ASC,
	[LastUpdateUserId] ASC,
	[IssueAssignedUserId] ASC,
	[IssueResolutionId] ASC,
	[IssueMilestoneId] ASC,
	[IssueAffectedMilestoneId] ASC,
	[IssueStatusId] ASC,
	[IssueCategoryId] ASC,
	[IssuePriorityId] ASC,
	[IssueTypeId] ASC
)
INCLUDE ( 	[IssueTitle],
	[IssueDescription],
	[IssueDueDate],
	[IssueVisibility],
	[IssueEstimation],
	[IssueProgress],
	[DateCreated],
	[LastUpdate]) WITH (STATISTICS_NORECOMPUTE = OFF, DROP_EXISTING = OFF, ONLINE = OFF)
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IDX_UserName]    Script Date: 9/11/2014 9:36:14 PM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Users]') AND name = N'IDX_UserName')
CREATE NONCLUSTERED INDEX [IDX_UserName] ON [dbo].[Users]
(
	[UserName] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, DROP_EXISTING = OFF, ONLINE = OFF)
GO

/****** Object:  Statistic [ST_1410104064_1_2]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_1410104064_1_2' and object_id = object_id(N'[dbo].[BugNet_IssueAttachments]'))
CREATE STATISTICS [ST_1410104064_1_2] ON [dbo].[BugNet_IssueAttachments]([IssueAttachmentId], [IssueId])
GO
/****** Object:  Statistic [ST_1410104064_1_8]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_1410104064_1_8' and object_id = object_id(N'[dbo].[BugNet_IssueAttachments]'))
CREATE STATISTICS [ST_1410104064_1_8] ON [dbo].[BugNet_IssueAttachments]([IssueAttachmentId], [UserId])
GO
/****** Object:  Statistic [ST_1410104064_2_8_7]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_1410104064_2_8_7' and object_id = object_id(N'[dbo].[BugNet_IssueAttachments]'))
CREATE STATISTICS [ST_1410104064_2_8_7] ON [dbo].[BugNet_IssueAttachments]([IssueId], [UserId], [DateCreated])
GO
/****** Object:  Statistic [ST_1474104292_1_5]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_1474104292_1_5' and object_id = object_id(N'[dbo].[BugNet_IssueComments]'))
CREATE STATISTICS [ST_1474104292_1_5] ON [dbo].[BugNet_IssueComments]([IssueCommentId], [UserId])
GO
/****** Object:  Statistic [ST_1474104292_2_1]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_1474104292_2_1' and object_id = object_id(N'[dbo].[BugNet_IssueComments]'))
CREATE STATISTICS [ST_1474104292_2_1] ON [dbo].[BugNet_IssueComments]([IssueId], [IssueCommentId])
GO
/****** Object:  Statistic [ST_1474104292_3_2]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_1474104292_3_2' and object_id = object_id(N'[dbo].[BugNet_IssueComments]'))
CREATE STATISTICS [ST_1474104292_3_2] ON [dbo].[BugNet_IssueComments]([DateCreated], [IssueId])
GO
/****** Object:  Statistic [ST_1474104292_5_2_3]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_1474104292_5_2_3' and object_id = object_id(N'[dbo].[BugNet_IssueComments]'))
CREATE STATISTICS [ST_1474104292_5_2_3] ON [dbo].[BugNet_IssueComments]([UserId], [IssueId], [DateCreated])
GO
/****** Object:  Statistic [ST_1442104178_2_3_5_4_7]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_1442104178_2_3_5_4_7' and object_id = object_id(N'[dbo].[BugNet_IssueHistory]'))
CREATE STATISTICS [ST_1442104178_2_3_5_4_7] ON [dbo].[BugNet_IssueHistory]([IssueId], [FieldChanged], [NewValue], [OldValue], [UserId])
GO
/****** Object:  Statistic [ST_1442104178_2_7_3_5]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_1442104178_2_7_3_5' and object_id = object_id(N'[dbo].[BugNet_IssueHistory]'))
CREATE STATISTICS [ST_1442104178_2_7_3_5] ON [dbo].[BugNet_IssueHistory]([IssueId], [UserId], [FieldChanged], [NewValue])
GO
/****** Object:  Statistic [ST_1442104178_6_2]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_1442104178_6_2' and object_id = object_id(N'[dbo].[BugNet_IssueHistory]'))
CREATE STATISTICS [ST_1442104178_6_2] ON [dbo].[BugNet_IssueHistory]([DateCreated], [IssueId])
GO
/****** Object:  Statistic [ST_1442104178_7_2_6]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_1442104178_7_2_6' and object_id = object_id(N'[dbo].[BugNet_IssueHistory]'))
CREATE STATISTICS [ST_1442104178_7_2_6] ON [dbo].[BugNet_IssueHistory]([UserId], [IssueId], [DateCreated])
GO
/****** Object:  Statistic [ST_1442104178_7_3_5_4]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_1442104178_7_3_5_4' and object_id = object_id(N'[dbo].[BugNet_IssueHistory]'))
CREATE STATISTICS [ST_1442104178_7_3_5_4] ON [dbo].[BugNet_IssueHistory]([UserId], [FieldChanged], [NewValue], [OldValue])
GO
/****** Object:  Statistic [ST_914102297_1_12_21_11_13_6_5_7_4_9_15]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_1_12_21_11_13_6_5_7_4_9_15' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_1_12_21_11_13_6_5_7_4_9_15] ON [dbo].[BugNet_Issues]([IssueId], [IssueAssignedUserId], [LastUpdateUserId], [IssueCreatorUserId], [IssueOwnerUserId], [IssueTypeId], [IssuePriorityId], [IssueCategoryId], [IssueStatusId], [IssueAffectedMilestoneId], [IssueMilestoneId])
GO
/****** Object:  Statistic [ST_914102297_1_12_8_22_15]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_1_12_8_22_15' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_1_12_8_22_15] ON [dbo].[BugNet_Issues]([IssueId], [IssueAssignedUserId], [ProjectId], [Disabled], [IssueMilestoneId])
GO
/****** Object:  Statistic [ST_914102297_1_4_22]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_1_4_22' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_1_4_22] ON [dbo].[BugNet_Issues]([IssueId], [IssueStatusId], [Disabled])
GO
/****** Object:  Statistic [ST_914102297_1_4_6_5]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_1_4_6_5' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_1_4_6_5] ON [dbo].[BugNet_Issues]([IssueId], [IssueStatusId], [IssueTypeId], [IssuePriorityId])
GO
/****** Object:  Statistic [ST_914102297_1_8_22_10_15]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_1_8_22_10_15' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_1_8_22_10_15] ON [dbo].[BugNet_Issues]([IssueId], [ProjectId], [Disabled], [IssueResolutionId], [IssueMilestoneId])
GO
/****** Object:  Statistic [ST_914102297_1_8_6_5_7_4_9_15_10_12_21_11]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_1_8_6_5_7_4_9_15_10_12_21_11' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_1_8_6_5_7_4_9_15_10_12_21_11] ON [dbo].[BugNet_Issues]([IssueId], [ProjectId], [IssueTypeId], [IssuePriorityId], [IssueCategoryId], [IssueStatusId], [IssueAffectedMilestoneId], [IssueMilestoneId], [IssueResolutionId], [IssueAssignedUserId], [LastUpdateUserId], [IssueCreatorUserId])
GO
/****** Object:  Statistic [ST_914102297_1_9]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_1_9' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_1_9] ON [dbo].[BugNet_Issues]([IssueId], [IssueAffectedMilestoneId])
GO
/****** Object:  Statistic [ST_914102297_10_1_4]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_10_1_4' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_10_1_4] ON [dbo].[BugNet_Issues]([IssueResolutionId], [IssueId], [IssueStatusId])
GO
/****** Object:  Statistic [ST_914102297_10_1_6_5_7_4_9]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_10_1_6_5_7_4_9' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_10_1_6_5_7_4_9] ON [dbo].[BugNet_Issues]([IssueResolutionId], [IssueId], [IssueTypeId], [IssuePriorityId], [IssueCategoryId], [IssueStatusId], [IssueAffectedMilestoneId])
GO
/****** Object:  Statistic [ST_914102297_10_12_8_22_1_15_9_4_6_5]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_10_12_8_22_1_15_9_4_6_5' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_10_12_8_22_1_15_9_4_6_5] ON [dbo].[BugNet_Issues]([IssueResolutionId], [IssueAssignedUserId], [ProjectId], [Disabled], [IssueId], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueStatusId], [IssueTypeId], [IssuePriorityId])
GO
/****** Object:  Statistic [ST_914102297_10_15_9_1_4_6_5_7_12_21_11_13_22]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_10_15_9_1_4_6_5_7_12_21_11_13_22' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_10_15_9_1_4_6_5_7_12_21_11_13_22] ON [dbo].[BugNet_Issues]([IssueResolutionId], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueId], [IssueStatusId], [IssueTypeId], [IssuePriorityId], [IssueCategoryId], [IssueAssignedUserId], [LastUpdateUserId], [IssueCreatorUserId], [IssueOwnerUserId], [Disabled])
GO
/****** Object:  Statistic [ST_914102297_10_15_9_8_6_5_7_4_12_21_13_1_22]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_10_15_9_8_6_5_7_4_12_21_13_1_22' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_10_15_9_8_6_5_7_4_12_21_13_1_22] ON [dbo].[BugNet_Issues]([IssueResolutionId], [IssueMilestoneId], [IssueAffectedMilestoneId], [ProjectId], [IssueTypeId], [IssuePriorityId], [IssueCategoryId], [IssueStatusId], [IssueAssignedUserId], [LastUpdateUserId], [IssueOwnerUserId], [IssueId], [Disabled])
GO
/****** Object:  Statistic [ST_914102297_10_22_13_11_21_12_15]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_10_22_13_11_21_12_15' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_10_22_13_11_21_12_15] ON [dbo].[BugNet_Issues]([IssueResolutionId], [Disabled], [IssueOwnerUserId], [IssueCreatorUserId], [LastUpdateUserId], [IssueAssignedUserId], [IssueMilestoneId])
GO
/****** Object:  Statistic [ST_914102297_10_8_11]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_10_8_11' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_10_8_11] ON [dbo].[BugNet_Issues]([IssueResolutionId], [ProjectId], [IssueCreatorUserId])
GO
/****** Object:  Statistic [ST_914102297_10_8_12_22_1_4_6_5_7_9]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_10_8_12_22_1_4_6_5_7_9' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_10_8_12_22_1_4_6_5_7_9] ON [dbo].[BugNet_Issues]([IssueResolutionId], [ProjectId], [IssueAssignedUserId], [Disabled], [IssueId], [IssueStatusId], [IssueTypeId], [IssuePriorityId], [IssueCategoryId], [IssueAffectedMilestoneId])
GO
/****** Object:  Statistic [ST_914102297_10_8_12_22_15_9_6_5_7]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_10_8_12_22_15_9_6_5_7' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_10_8_12_22_15_9_6_5_7] ON [dbo].[BugNet_Issues]([IssueResolutionId], [ProjectId], [IssueAssignedUserId], [Disabled], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueTypeId], [IssuePriorityId], [IssueCategoryId])
GO
/****** Object:  Statistic [ST_914102297_10_8_13]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_10_8_13' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_10_8_13] ON [dbo].[BugNet_Issues]([IssueResolutionId], [ProjectId], [IssueOwnerUserId])
GO
/****** Object:  Statistic [ST_914102297_10_8_22_1_13_11_21]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_10_8_22_1_13_11_21' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_10_8_22_1_13_11_21] ON [dbo].[BugNet_Issues]([IssueResolutionId], [ProjectId], [Disabled], [IssueId], [IssueOwnerUserId], [IssueCreatorUserId], [LastUpdateUserId])
GO
/****** Object:  Statistic [ST_914102297_11_10_15_9]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_11_10_15_9' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_11_10_15_9] ON [dbo].[BugNet_Issues]([IssueCreatorUserId], [IssueResolutionId], [IssueMilestoneId], [IssueAffectedMilestoneId])
GO
/****** Object:  Statistic [ST_914102297_12_10_15_9]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_12_10_15_9' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_12_10_15_9] ON [dbo].[BugNet_Issues]([IssueAssignedUserId], [IssueResolutionId], [IssueMilestoneId], [IssueAffectedMilestoneId])
GO
/****** Object:  Statistic [ST_914102297_12_15_9_22_8_6]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_12_15_9_22_8_6' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_12_15_9_22_8_6] ON [dbo].[BugNet_Issues]([IssueAssignedUserId], [IssueMilestoneId], [IssueAffectedMilestoneId], [Disabled], [ProjectId], [IssueTypeId])
GO
/****** Object:  Statistic [ST_914102297_12_21_11_13_4_8_22]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_12_21_11_13_4_8_22' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_12_21_11_13_4_8_22] ON [dbo].[BugNet_Issues]([IssueAssignedUserId], [LastUpdateUserId], [IssueCreatorUserId], [IssueOwnerUserId], [IssueStatusId], [ProjectId], [Disabled])
GO
/****** Object:  Statistic [ST_914102297_12_21_11_8_13_22_10_15_9_6_5_7]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_12_21_11_8_13_22_10_15_9_6_5_7' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_12_21_11_8_13_22_10_15_9_6_5_7] ON [dbo].[BugNet_Issues]([IssueAssignedUserId], [LastUpdateUserId], [IssueCreatorUserId], [ProjectId], [IssueOwnerUserId], [Disabled], [IssueResolutionId], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueTypeId], [IssuePriorityId], [IssueCategoryId])
GO
/****** Object:  Statistic [ST_914102297_12_22_21_11]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_12_22_21_11' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_12_22_21_11] ON [dbo].[BugNet_Issues]([IssueAssignedUserId], [Disabled], [LastUpdateUserId], [IssueCreatorUserId])
GO
/****** Object:  Statistic [ST_914102297_12_4]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_12_4' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_12_4] ON [dbo].[BugNet_Issues]([IssueAssignedUserId], [IssueStatusId])
GO
/****** Object:  Statistic [ST_914102297_12_8_22_1_21_11]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_12_8_22_1_21_11' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_12_8_22_1_21_11] ON [dbo].[BugNet_Issues]([IssueAssignedUserId], [ProjectId], [Disabled], [IssueId], [LastUpdateUserId], [IssueCreatorUserId])
GO
/****** Object:  Statistic [ST_914102297_12_8_22_1_6_15_9]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_12_8_22_1_6_15_9' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_12_8_22_1_6_15_9] ON [dbo].[BugNet_Issues]([IssueAssignedUserId], [ProjectId], [Disabled], [IssueId], [IssueTypeId], [IssueMilestoneId], [IssueAffectedMilestoneId])
GO
/****** Object:  Statistic [ST_914102297_13_10_15_9_22]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_13_10_15_9_22' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_13_10_15_9_22] ON [dbo].[BugNet_Issues]([IssueOwnerUserId], [IssueResolutionId], [IssueMilestoneId], [IssueAffectedMilestoneId], [Disabled])
GO
/****** Object:  Statistic [ST_914102297_13_11_21_12_10_15_9_4_7_5_6_1_22]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_13_11_21_12_10_15_9_4_7_5_6_1_22' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_13_11_21_12_10_15_9_4_7_5_6_1_22] ON [dbo].[BugNet_Issues]([IssueOwnerUserId], [IssueCreatorUserId], [LastUpdateUserId], [IssueAssignedUserId], [IssueResolutionId], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueStatusId], [IssueCategoryId], [IssuePriorityId], [IssueTypeId], [IssueId], [Disabled])
GO
/****** Object:  Statistic [ST_914102297_13_11_21_12_8]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_13_11_21_12_8' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_13_11_21_12_8] ON [dbo].[BugNet_Issues]([IssueOwnerUserId], [IssueCreatorUserId], [LastUpdateUserId], [IssueAssignedUserId], [ProjectId])
GO
/****** Object:  Statistic [ST_914102297_13_12]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_13_12' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_13_12] ON [dbo].[BugNet_Issues]([IssueOwnerUserId], [IssueAssignedUserId])
GO
/****** Object:  Statistic [ST_914102297_15_4_8]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_15_4_8' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_15_4_8] ON [dbo].[BugNet_Issues]([IssueMilestoneId], [IssueStatusId], [ProjectId])
GO
/****** Object:  Statistic [ST_914102297_15_8_22]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_15_8_22' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_15_8_22] ON [dbo].[BugNet_Issues]([IssueMilestoneId], [ProjectId], [Disabled])
GO
/****** Object:  Statistic [ST_914102297_15_9_12_8_22_1]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_15_9_12_8_22_1' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_15_9_12_8_22_1] ON [dbo].[BugNet_Issues]([IssueMilestoneId], [IssueAffectedMilestoneId], [IssueAssignedUserId], [ProjectId], [Disabled], [IssueId])
GO
/****** Object:  Statistic [ST_914102297_15_9_22_13_11_21_12_10_1_8_6_5_7_4]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_15_9_22_13_11_21_12_10_1_8_6_5_7_4' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_15_9_22_13_11_21_12_10_1_8_6_5_7_4] ON [dbo].[BugNet_Issues]([IssueMilestoneId], [IssueAffectedMilestoneId], [Disabled], [IssueOwnerUserId], [IssueCreatorUserId], [LastUpdateUserId], [IssueAssignedUserId], [IssueResolutionId], [IssueId], [ProjectId], [IssueTypeId], [IssuePriorityId], [IssueCategoryId], [IssueStatusId])
GO
/****** Object:  Statistic [ST_914102297_15_9_4_8]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_15_9_4_8' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_15_9_4_8] ON [dbo].[BugNet_Issues]([IssueMilestoneId], [IssueAffectedMilestoneId], [IssueStatusId], [ProjectId])
GO
/****** Object:  Statistic [ST_914102297_15_9_8_11]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_15_9_8_11' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_15_9_8_11] ON [dbo].[BugNet_Issues]([IssueMilestoneId], [IssueAffectedMilestoneId], [ProjectId], [IssueCreatorUserId])
GO
/****** Object:  Statistic [ST_914102297_15_9_8_13_22]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_15_9_8_13_22' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_15_9_8_13_22] ON [dbo].[BugNet_Issues]([IssueMilestoneId], [IssueAffectedMilestoneId], [ProjectId], [IssueOwnerUserId], [Disabled])
GO
/****** Object:  Statistic [ST_914102297_15_9_8_22_1_13_11_21_12]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_15_9_8_22_1_13_11_21_12' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_15_9_8_22_1_13_11_21_12] ON [dbo].[BugNet_Issues]([IssueMilestoneId], [IssueAffectedMilestoneId], [ProjectId], [Disabled], [IssueId], [IssueOwnerUserId], [IssueCreatorUserId], [LastUpdateUserId], [IssueAssignedUserId])
GO
/****** Object:  Statistic [ST_914102297_15_9_8_6_5_7_4_10_21_11_13_1_22]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_15_9_8_6_5_7_4_10_21_11_13_1_22' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_15_9_8_6_5_7_4_10_21_11_13_1_22] ON [dbo].[BugNet_Issues]([IssueMilestoneId], [IssueAffectedMilestoneId], [ProjectId], [IssueTypeId], [IssuePriorityId], [IssueCategoryId], [IssueStatusId], [IssueResolutionId], [LastUpdateUserId], [IssueCreatorUserId], [IssueOwnerUserId], [IssueId], [Disabled])
GO
/****** Object:  Statistic [ST_914102297_21_1]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_21_1' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_21_1] ON [dbo].[BugNet_Issues]([LastUpdateUserId], [IssueId])
GO
/****** Object:  Statistic [ST_914102297_21_11_13_12_22_15_9_8_6_5_7_4]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_21_11_13_12_22_15_9_8_6_5_7_4' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_21_11_13_12_22_15_9_8_6_5_7_4] ON [dbo].[BugNet_Issues]([LastUpdateUserId], [IssueCreatorUserId], [IssueOwnerUserId], [IssueAssignedUserId], [Disabled], [IssueMilestoneId], [IssueAffectedMilestoneId], [ProjectId], [IssueTypeId], [IssuePriorityId], [IssueCategoryId], [IssueStatusId])
GO
/****** Object:  Statistic [ST_914102297_21_11_13_12_8_22_1_15_9_4_6_5_7]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_21_11_13_12_8_22_1_15_9_4_6_5_7' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_21_11_13_12_8_22_1_15_9_4_6_5_7] ON [dbo].[BugNet_Issues]([LastUpdateUserId], [IssueCreatorUserId], [IssueOwnerUserId], [IssueAssignedUserId], [ProjectId], [Disabled], [IssueId], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueStatusId], [IssueTypeId], [IssuePriorityId], [IssueCategoryId])
GO
/****** Object:  Statistic [ST_914102297_22_1_13_11_21_12_10_15]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_22_1_13_11_21_12_10_15' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_22_1_13_11_21_12_10_15] ON [dbo].[BugNet_Issues]([Disabled], [IssueId], [IssueOwnerUserId], [IssueCreatorUserId], [LastUpdateUserId], [IssueAssignedUserId], [IssueResolutionId], [IssueMilestoneId])
GO
/****** Object:  Statistic [ST_914102297_22_10_15_9_11]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_22_10_15_9_11' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_22_10_15_9_11] ON [dbo].[BugNet_Issues]([Disabled], [IssueResolutionId], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueCreatorUserId])
GO
/****** Object:  Statistic [ST_914102297_22_10_15_9_12]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_22_10_15_9_12' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_22_10_15_9_12] ON [dbo].[BugNet_Issues]([Disabled], [IssueResolutionId], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueAssignedUserId])
GO
/****** Object:  Statistic [ST_914102297_22_12_13]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_22_12_13' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_22_12_13] ON [dbo].[BugNet_Issues]([Disabled], [IssueAssignedUserId], [IssueOwnerUserId])
GO
/****** Object:  Statistic [ST_914102297_22_12_8_15]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_22_12_8_15' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_22_12_8_15] ON [dbo].[BugNet_Issues]([Disabled], [IssueAssignedUserId], [ProjectId], [IssueMilestoneId])
GO
/****** Object:  Statistic [ST_914102297_22_13_11_21_12_10_15_9_4_7_5_6_8]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_22_13_11_21_12_10_15_9_4_7_5_6_8' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_22_13_11_21_12_10_15_9_4_7_5_6_8] ON [dbo].[BugNet_Issues]([Disabled], [IssueOwnerUserId], [IssueCreatorUserId], [LastUpdateUserId], [IssueAssignedUserId], [IssueResolutionId], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueStatusId], [IssueCategoryId], [IssuePriorityId], [IssueTypeId], [ProjectId])
GO
/****** Object:  Statistic [ST_914102297_22_13_8_10_15_9_6]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_22_13_8_10_15_9_6' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_22_13_8_10_15_9_6] ON [dbo].[BugNet_Issues]([Disabled], [IssueOwnerUserId], [ProjectId], [IssueResolutionId], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueTypeId])
GO
/****** Object:  Statistic [ST_914102297_22_15_4]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_22_15_4' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_22_15_4] ON [dbo].[BugNet_Issues]([Disabled], [IssueMilestoneId], [IssueStatusId])
GO
/****** Object:  Statistic [ST_914102297_22_15_9_12]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_22_15_9_12' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_22_15_9_12] ON [dbo].[BugNet_Issues]([Disabled], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueAssignedUserId])
GO
/****** Object:  Statistic [ST_914102297_22_15_9_4_8]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_22_15_9_4_8' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_22_15_9_4_8] ON [dbo].[BugNet_Issues]([Disabled], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueStatusId], [ProjectId])
GO
/****** Object:  Statistic [ST_914102297_22_4_13_11_21_12_10_15_9_1_8_6_5]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_22_4_13_11_21_12_10_15_9_1_8_6_5' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_22_4_13_11_21_12_10_15_9_1_8_6_5] ON [dbo].[BugNet_Issues]([Disabled], [IssueStatusId], [IssueOwnerUserId], [IssueCreatorUserId], [LastUpdateUserId], [IssueAssignedUserId], [IssueResolutionId], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueId], [ProjectId], [IssueTypeId], [IssuePriorityId])
GO
/****** Object:  Statistic [ST_914102297_22_5_8_4]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_22_5_8_4' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_22_5_8_4] ON [dbo].[BugNet_Issues]([Disabled], [IssuePriorityId], [ProjectId], [IssueStatusId])
GO
/****** Object:  Statistic [ST_914102297_22_7_13_11_21_12_10_15_9_1_8_6]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_22_7_13_11_21_12_10_15_9_1_8_6' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_22_7_13_11_21_12_10_15_9_1_8_6] ON [dbo].[BugNet_Issues]([Disabled], [IssueCategoryId], [IssueOwnerUserId], [IssueCreatorUserId], [LastUpdateUserId], [IssueAssignedUserId], [IssueResolutionId], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueId], [ProjectId], [IssueTypeId])
GO
/****** Object:  Statistic [ST_914102297_22_7_4]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_22_7_4' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_22_7_4] ON [dbo].[BugNet_Issues]([Disabled], [IssueCategoryId], [IssueStatusId])
GO
/****** Object:  Statistic [ST_914102297_22_8_10_15_9_1_4_6_5]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_22_8_10_15_9_1_4_6_5' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_22_8_10_15_9_1_4_6_5] ON [dbo].[BugNet_Issues]([Disabled], [ProjectId], [IssueResolutionId], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueId], [IssueStatusId], [IssueTypeId], [IssuePriorityId])
GO
/****** Object:  Statistic [ST_914102297_22_8_13_11_21_12_10_15_9_4_7_5]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_22_8_13_11_21_12_10_15_9_4_7_5' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_22_8_13_11_21_12_10_15_9_4_7_5] ON [dbo].[BugNet_Issues]([Disabled], [ProjectId], [IssueOwnerUserId], [IssueCreatorUserId], [LastUpdateUserId], [IssueAssignedUserId], [IssueResolutionId], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueStatusId], [IssueCategoryId], [IssuePriorityId])
GO
/****** Object:  Statistic [ST_914102297_4_1_22]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_4_1_22' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_4_1_22] ON [dbo].[BugNet_Issues]([IssueStatusId], [IssueId], [Disabled])
GO
/****** Object:  Statistic [ST_914102297_4_8_11]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_4_8_11' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_4_8_11] ON [dbo].[BugNet_Issues]([IssueStatusId], [ProjectId], [IssueCreatorUserId])
GO
/****** Object:  Statistic [ST_914102297_4_8_12_22_10_15_9_6_5]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_4_8_12_22_10_15_9_6_5' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_4_8_12_22_10_15_9_6_5] ON [dbo].[BugNet_Issues]([IssueStatusId], [ProjectId], [IssueAssignedUserId], [Disabled], [IssueResolutionId], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueTypeId], [IssuePriorityId])
GO
/****** Object:  Statistic [ST_914102297_4_8_12_22_15_9_6_5]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_4_8_12_22_15_9_6_5' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_4_8_12_22_15_9_6_5] ON [dbo].[BugNet_Issues]([IssueStatusId], [ProjectId], [IssueAssignedUserId], [Disabled], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueTypeId], [IssuePriorityId])
GO
/****** Object:  Statistic [ST_914102297_4_8_13]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_4_8_13' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_4_8_13] ON [dbo].[BugNet_Issues]([IssueStatusId], [ProjectId], [IssueOwnerUserId])
GO
/****** Object:  Statistic [ST_914102297_4_8_22_1_10_15]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_4_8_22_1_10_15' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_4_8_22_1_10_15] ON [dbo].[BugNet_Issues]([IssueStatusId], [ProjectId], [Disabled], [IssueId], [IssueResolutionId], [IssueMilestoneId])
GO
/****** Object:  Statistic [ST_914102297_4_8_22_15]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_4_8_22_15' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_4_8_22_15] ON [dbo].[BugNet_Issues]([IssueStatusId], [ProjectId], [Disabled], [IssueMilestoneId])
GO
/****** Object:  Statistic [ST_914102297_4_8_7]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_4_8_7' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_4_8_7] ON [dbo].[BugNet_Issues]([IssueStatusId], [ProjectId], [IssueCategoryId])
GO
/****** Object:  Statistic [ST_914102297_5_1]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_5_1' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_5_1] ON [dbo].[BugNet_Issues]([IssuePriorityId], [IssueId])
GO
/****** Object:  Statistic [ST_914102297_5_12_8_22_1_15_9_4]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_5_12_8_22_1_15_9_4' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_5_12_8_22_1_15_9_4] ON [dbo].[BugNet_Issues]([IssuePriorityId], [IssueAssignedUserId], [ProjectId], [Disabled], [IssueId], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueStatusId])
GO
/****** Object:  Statistic [ST_914102297_5_22_13_11_21_12_10_15_9_1_8]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_5_22_13_11_21_12_10_15_9_1_8' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_5_22_13_11_21_12_10_15_9_1_8] ON [dbo].[BugNet_Issues]([IssuePriorityId], [Disabled], [IssueOwnerUserId], [IssueCreatorUserId], [LastUpdateUserId], [IssueAssignedUserId], [IssueResolutionId], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueId], [ProjectId])
GO
/****** Object:  Statistic [ST_914102297_5_4_8_22_1_15_9]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_5_4_8_22_1_15_9' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_5_4_8_22_1_15_9] ON [dbo].[BugNet_Issues]([IssuePriorityId], [IssueStatusId], [ProjectId], [Disabled], [IssueId], [IssueMilestoneId], [IssueAffectedMilestoneId])
GO
/****** Object:  Statistic [ST_914102297_5_8_11]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_5_8_11' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_5_8_11] ON [dbo].[BugNet_Issues]([IssuePriorityId], [ProjectId], [IssueCreatorUserId])
GO
/****** Object:  Statistic [ST_914102297_5_8_12_22_1_4]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_5_8_12_22_1_4' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_5_8_12_22_1_4] ON [dbo].[BugNet_Issues]([IssuePriorityId], [ProjectId], [IssueAssignedUserId], [Disabled], [IssueId], [IssueStatusId])
GO
/****** Object:  Statistic [ST_914102297_5_8_12_22_10_15_9]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_5_8_12_22_10_15_9' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_5_8_12_22_10_15_9] ON [dbo].[BugNet_Issues]([IssuePriorityId], [ProjectId], [IssueAssignedUserId], [Disabled], [IssueResolutionId], [IssueMilestoneId], [IssueAffectedMilestoneId])
GO
/****** Object:  Statistic [ST_914102297_5_8_22]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_5_8_22' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_5_8_22] ON [dbo].[BugNet_Issues]([IssuePriorityId], [ProjectId], [Disabled])
GO
/****** Object:  Statistic [ST_914102297_6_1_5_7_4_9_15_10_12_21_11_13_8]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_6_1_5_7_4_9_15_10_12_21_11_13_8' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_6_1_5_7_4_9_15_10_12_21_11_13_8] ON [dbo].[BugNet_Issues]([IssueTypeId], [IssueId], [IssuePriorityId], [IssueCategoryId], [IssueStatusId], [IssueAffectedMilestoneId], [IssueMilestoneId], [IssueResolutionId], [IssueAssignedUserId], [LastUpdateUserId], [IssueCreatorUserId], [IssueOwnerUserId], [ProjectId])
GO
/****** Object:  Statistic [ST_914102297_6_12_22_15_9]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_6_12_22_15_9' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_6_12_22_15_9] ON [dbo].[BugNet_Issues]([IssueTypeId], [IssueAssignedUserId], [Disabled], [IssueMilestoneId], [IssueAffectedMilestoneId])
GO
/****** Object:  Statistic [ST_914102297_6_12_8_22]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_6_12_8_22' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_6_12_8_22] ON [dbo].[BugNet_Issues]([IssueTypeId], [IssueAssignedUserId], [ProjectId], [Disabled])
GO
/****** Object:  Statistic [ST_914102297_6_22_13_11_21_12_10_15_9_1]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_6_22_13_11_21_12_10_15_9_1' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_6_22_13_11_21_12_10_15_9_1] ON [dbo].[BugNet_Issues]([IssueTypeId], [Disabled], [IssueOwnerUserId], [IssueCreatorUserId], [LastUpdateUserId], [IssueAssignedUserId], [IssueResolutionId], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueId])
GO
/****** Object:  Statistic [ST_914102297_6_4_8_22_1_15]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_6_4_8_22_1_15' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_6_4_8_22_1_15] ON [dbo].[BugNet_Issues]([IssueTypeId], [IssueStatusId], [ProjectId], [Disabled], [IssueId], [IssueMilestoneId])
GO
/****** Object:  Statistic [ST_914102297_6_5_7_4_9_15_10_12_21_11_13_8]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_6_5_7_4_9_15_10_12_21_11_13_8' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_6_5_7_4_9_15_10_12_21_11_13_8] ON [dbo].[BugNet_Issues]([IssueTypeId], [IssuePriorityId], [IssueCategoryId], [IssueStatusId], [IssueAffectedMilestoneId], [IssueMilestoneId], [IssueResolutionId], [IssueAssignedUserId], [LastUpdateUserId], [IssueCreatorUserId], [IssueOwnerUserId], [ProjectId])
GO
/****** Object:  Statistic [ST_914102297_6_8_11_22_10_15]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_6_8_11_22_10_15' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_6_8_11_22_10_15] ON [dbo].[BugNet_Issues]([IssueTypeId], [ProjectId], [IssueCreatorUserId], [Disabled], [IssueResolutionId], [IssueMilestoneId])
GO
/****** Object:  Statistic [ST_914102297_6_8_12_22_10_15]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_6_8_12_22_10_15' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_6_8_12_22_10_15] ON [dbo].[BugNet_Issues]([IssueTypeId], [ProjectId], [IssueAssignedUserId], [Disabled], [IssueResolutionId], [IssueMilestoneId])
GO
/****** Object:  Statistic [ST_914102297_6_8_13]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_6_8_13' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_6_8_13] ON [dbo].[BugNet_Issues]([IssueTypeId], [ProjectId], [IssueOwnerUserId])
GO
/****** Object:  Statistic [ST_914102297_6_8_22_1_13_11_21_12_10_15_9_4_7]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_6_8_22_1_13_11_21_12_10_15_9_4_7' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_6_8_22_1_13_11_21_12_10_15_9_4_7] ON [dbo].[BugNet_Issues]([IssueTypeId], [ProjectId], [Disabled], [IssueId], [IssueOwnerUserId], [IssueCreatorUserId], [LastUpdateUserId], [IssueAssignedUserId], [IssueResolutionId], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueStatusId], [IssueCategoryId])
GO
/****** Object:  Statistic [ST_914102297_7_1_6]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_7_1_6' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_7_1_6] ON [dbo].[BugNet_Issues]([IssueCategoryId], [IssueId], [IssueTypeId])
GO
/****** Object:  Statistic [ST_914102297_7_12_8_22_1_15_9_4_6]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_7_12_8_22_1_15_9_4_6' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_7_12_8_22_1_15_9_4_6] ON [dbo].[BugNet_Issues]([IssueCategoryId], [IssueAssignedUserId], [ProjectId], [Disabled], [IssueId], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueStatusId], [IssueTypeId])
GO
/****** Object:  Statistic [ST_914102297_7_4_8_22_1_15_9_6]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_7_4_8_22_1_15_9_6' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_7_4_8_22_1_15_9_6] ON [dbo].[BugNet_Issues]([IssueCategoryId], [IssueStatusId], [ProjectId], [Disabled], [IssueId], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueTypeId])
GO
/****** Object:  Statistic [ST_914102297_7_8_11_22_10_15_9_6]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_7_8_11_22_10_15_9_6' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_7_8_11_22_10_15_9_6] ON [dbo].[BugNet_Issues]([IssueCategoryId], [ProjectId], [IssueCreatorUserId], [Disabled], [IssueResolutionId], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueTypeId])
GO
/****** Object:  Statistic [ST_914102297_7_8_12_22_10_15_9_6]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_7_8_12_22_10_15_9_6' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_7_8_12_22_10_15_9_6] ON [dbo].[BugNet_Issues]([IssueCategoryId], [ProjectId], [IssueAssignedUserId], [Disabled], [IssueResolutionId], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueTypeId])
GO
/****** Object:  Statistic [ST_914102297_7_8_12_22_15_9_6]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_7_8_12_22_15_9_6' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_7_8_12_22_15_9_6] ON [dbo].[BugNet_Issues]([IssueCategoryId], [ProjectId], [IssueAssignedUserId], [Disabled], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueTypeId])
GO
/****** Object:  Statistic [ST_914102297_7_8_13]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_7_8_13' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_7_8_13] ON [dbo].[BugNet_Issues]([IssueCategoryId], [ProjectId], [IssueOwnerUserId])
GO
/****** Object:  Statistic [ST_914102297_8_11_22_15_9]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_8_11_22_15_9' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_8_11_22_15_9] ON [dbo].[BugNet_Issues]([ProjectId], [IssueCreatorUserId], [Disabled], [IssueMilestoneId], [IssueAffectedMilestoneId])
GO
/****** Object:  Statistic [ST_914102297_8_11_22_4_10_15_9_6_5]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_8_11_22_4_10_15_9_6_5' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_8_11_22_4_10_15_9_6_5] ON [dbo].[BugNet_Issues]([ProjectId], [IssueCreatorUserId], [Disabled], [IssueStatusId], [IssueResolutionId], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueTypeId], [IssuePriorityId])
GO
/****** Object:  Statistic [ST_914102297_8_11_22_5_10_15_9]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_8_11_22_5_10_15_9' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_8_11_22_5_10_15_9] ON [dbo].[BugNet_Issues]([ProjectId], [IssueCreatorUserId], [Disabled], [IssuePriorityId], [IssueResolutionId], [IssueMilestoneId], [IssueAffectedMilestoneId])
GO
/****** Object:  Statistic [ST_914102297_8_12_22_1_15_9_6_5_7_4_10_21_11]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_8_12_22_1_15_9_6_5_7_4_10_21_11' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_8_12_22_1_15_9_6_5_7_4_10_21_11] ON [dbo].[BugNet_Issues]([ProjectId], [IssueAssignedUserId], [Disabled], [IssueId], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueTypeId], [IssuePriorityId], [IssueCategoryId], [IssueStatusId], [IssueResolutionId], [LastUpdateUserId], [IssueCreatorUserId])
GO
/****** Object:  Statistic [ST_914102297_8_12_22_1_7_4_6]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_8_12_22_1_7_4_6' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_8_12_22_1_7_4_6] ON [dbo].[BugNet_Issues]([ProjectId], [IssueAssignedUserId], [Disabled], [IssueId], [IssueCategoryId], [IssueStatusId], [IssueTypeId])
GO
/****** Object:  Statistic [ST_914102297_8_12_22_1_9]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_8_12_22_1_9' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_8_12_22_1_9] ON [dbo].[BugNet_Issues]([ProjectId], [IssueAssignedUserId], [Disabled], [IssueId], [IssueAffectedMilestoneId])
GO
/****** Object:  Statistic [ST_914102297_8_12_22_5_15_9_6_7_4_10_21_11]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_8_12_22_5_15_9_6_7_4_10_21_11' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_8_12_22_5_15_9_6_7_4_10_21_11] ON [dbo].[BugNet_Issues]([ProjectId], [IssueAssignedUserId], [Disabled], [IssuePriorityId], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueTypeId], [IssueCategoryId], [IssueStatusId], [IssueResolutionId], [LastUpdateUserId], [IssueCreatorUserId])
GO
/****** Object:  Statistic [ST_914102297_8_12_22_6_15]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_8_12_22_6_15' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_8_12_22_6_15] ON [dbo].[BugNet_Issues]([ProjectId], [IssueAssignedUserId], [Disabled], [IssueTypeId], [IssueMilestoneId])
GO
/****** Object:  Statistic [ST_914102297_8_13_22_12_21]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_8_13_22_12_21' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_8_13_22_12_21] ON [dbo].[BugNet_Issues]([ProjectId], [IssueOwnerUserId], [Disabled], [IssueAssignedUserId], [LastUpdateUserId])
GO
/****** Object:  Statistic [ST_914102297_8_13_22_15]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_8_13_22_15' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_8_13_22_15] ON [dbo].[BugNet_Issues]([ProjectId], [IssueOwnerUserId], [Disabled], [IssueMilestoneId])
GO
/****** Object:  Statistic [ST_914102297_8_13_22_4_10_15_9_6_5]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_8_13_22_4_10_15_9_6_5' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_8_13_22_4_10_15_9_6_5] ON [dbo].[BugNet_Issues]([ProjectId], [IssueOwnerUserId], [Disabled], [IssueStatusId], [IssueResolutionId], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueTypeId], [IssuePriorityId])
GO
/****** Object:  Statistic [ST_914102297_8_13_22_6_10_15]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_8_13_22_6_10_15' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_8_13_22_6_10_15] ON [dbo].[BugNet_Issues]([ProjectId], [IssueOwnerUserId], [Disabled], [IssueTypeId], [IssueResolutionId], [IssueMilestoneId])
GO
/****** Object:  Statistic [ST_914102297_8_13_22_7_10_15_9_6]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_8_13_22_7_10_15_9_6' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_8_13_22_7_10_15_9_6] ON [dbo].[BugNet_Issues]([ProjectId], [IssueOwnerUserId], [Disabled], [IssueCategoryId], [IssueResolutionId], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueTypeId])
GO
/****** Object:  Statistic [ST_914102297_8_22_1_15]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_8_22_1_15' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_8_22_1_15] ON [dbo].[BugNet_Issues]([ProjectId], [Disabled], [IssueId], [IssueMilestoneId])
GO
/****** Object:  Statistic [ST_914102297_8_22_1_4_13_11_21_12_10_15]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_8_22_1_4_13_11_21_12_10_15' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_8_22_1_4_13_11_21_12_10_15] ON [dbo].[BugNet_Issues]([ProjectId], [Disabled], [IssueId], [IssueStatusId], [IssueOwnerUserId], [IssueCreatorUserId], [LastUpdateUserId], [IssueAssignedUserId], [IssueResolutionId], [IssueMilestoneId])
GO
/****** Object:  Statistic [ST_914102297_8_22_1_4_15_9]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_8_22_1_4_15_9' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_8_22_1_4_15_9] ON [dbo].[BugNet_Issues]([ProjectId], [Disabled], [IssueId], [IssueStatusId], [IssueMilestoneId], [IssueAffectedMilestoneId])
GO
/****** Object:  Statistic [ST_914102297_8_22_1_5_10_15_9_4]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_8_22_1_5_10_15_9_4' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_8_22_1_5_10_15_9_4] ON [dbo].[BugNet_Issues]([ProjectId], [Disabled], [IssueId], [IssuePriorityId], [IssueResolutionId], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueStatusId])
GO
/****** Object:  Statistic [ST_914102297_8_22_1_5_13_11_21_12_10_15_9_4]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_8_22_1_5_13_11_21_12_10_15_9_4' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_8_22_1_5_13_11_21_12_10_15_9_4] ON [dbo].[BugNet_Issues]([ProjectId], [Disabled], [IssueId], [IssuePriorityId], [IssueOwnerUserId], [IssueCreatorUserId], [LastUpdateUserId], [IssueAssignedUserId], [IssueResolutionId], [IssueMilestoneId], [IssueAffectedMilestoneId], [IssueStatusId])
GO
/****** Object:  Statistic [ST_914102297_8_22_1_6_10_15_9]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_8_22_1_6_10_15_9' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_8_22_1_6_10_15_9] ON [dbo].[BugNet_Issues]([ProjectId], [Disabled], [IssueId], [IssueTypeId], [IssueResolutionId], [IssueMilestoneId], [IssueAffectedMilestoneId])
GO
/****** Object:  Statistic [ST_914102297_8_22_13_11_21_12_10_15_9]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_8_22_13_11_21_12_10_15_9' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_8_22_13_11_21_12_10_15_9] ON [dbo].[BugNet_Issues]([ProjectId], [Disabled], [IssueOwnerUserId], [IssueCreatorUserId], [LastUpdateUserId], [IssueAssignedUserId], [IssueResolutionId], [IssueMilestoneId], [IssueAffectedMilestoneId])
GO
/****** Object:  Statistic [ST_914102297_8_22_4_6]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_8_22_4_6' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_8_22_4_6] ON [dbo].[BugNet_Issues]([ProjectId], [Disabled], [IssueStatusId], [IssueTypeId])
GO
/****** Object:  Statistic [ST_914102297_8_7_22_4]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_8_7_22_4' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_8_7_22_4] ON [dbo].[BugNet_Issues]([ProjectId], [IssueCategoryId], [Disabled], [IssueStatusId])
GO
/****** Object:  Statistic [ST_914102297_9_15_1_6_5_7]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_9_15_1_6_5_7' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_9_15_1_6_5_7] ON [dbo].[BugNet_Issues]([IssueAffectedMilestoneId], [IssueMilestoneId], [IssueId], [IssueTypeId], [IssuePriorityId], [IssueCategoryId])
GO
/****** Object:  Statistic [ST_914102297_9_15_8_12_22_1_4_6_5]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_914102297_9_15_8_12_22_1_4_6_5' and object_id = object_id(N'[dbo].[BugNet_Issues]'))
CREATE STATISTICS [ST_914102297_9_15_8_12_22_1_4_6_5] ON [dbo].[BugNet_Issues]([IssueAffectedMilestoneId], [IssueMilestoneId], [ProjectId], [IssueAssignedUserId], [Disabled], [IssueId], [IssueStatusId], [IssueTypeId], [IssuePriorityId])
GO
/****** Object:  Statistic [ST_1813581499_1_10_9_7]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_1813581499_1_10_9_7' and object_id = object_id(N'[dbo].[BugNet_Projects]'))
CREATE STATISTICS [ST_1813581499_1_10_9_7] ON [dbo].[BugNet_Projects]([ProjectId], [ProjectCreatorUserId], [ProjectManagerUserId], [ProjectDisabled])
GO
/****** Object:  Statistic [ST_1813581499_1_8_9_7_10_2]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_1813581499_1_8_9_7_10_2' and object_id = object_id(N'[dbo].[BugNet_Projects]'))
CREATE STATISTICS [ST_1813581499_1_8_9_7_10_2] ON [dbo].[BugNet_Projects]([ProjectId], [ProjectAccessType], [ProjectManagerUserId], [ProjectDisabled], [ProjectCreatorUserId], [ProjectName])
GO
/****** Object:  Statistic [ST_1813581499_10_9_8]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_1813581499_10_9_8' and object_id = object_id(N'[dbo].[BugNet_Projects]'))
CREATE STATISTICS [ST_1813581499_10_9_8] ON [dbo].[BugNet_Projects]([ProjectCreatorUserId], [ProjectManagerUserId], [ProjectAccessType])
GO
/****** Object:  Statistic [ST_1813581499_2_1_8_9_7]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_1813581499_2_1_8_9_7' and object_id = object_id(N'[dbo].[BugNet_Projects]'))
CREATE STATISTICS [ST_1813581499_2_1_8_9_7] ON [dbo].[BugNet_Projects]([ProjectName], [ProjectId], [ProjectAccessType], [ProjectManagerUserId], [ProjectDisabled])
GO
/****** Object:  Statistic [ST_1813581499_7_1_8_10]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_1813581499_7_1_8_10' and object_id = object_id(N'[dbo].[BugNet_Projects]'))
CREATE STATISTICS [ST_1813581499_7_1_8_10] ON [dbo].[BugNet_Projects]([ProjectDisabled], [ProjectId], [ProjectAccessType], [ProjectCreatorUserId])
GO
/****** Object:  Statistic [ST_1813581499_7_8]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_1813581499_7_8' and object_id = object_id(N'[dbo].[BugNet_Projects]'))
CREATE STATISTICS [ST_1813581499_7_8] ON [dbo].[BugNet_Projects]([ProjectDisabled], [ProjectAccessType])
GO
/****** Object:  Statistic [ST_1813581499_8_9_7_10]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_1813581499_8_9_7_10' and object_id = object_id(N'[dbo].[BugNet_Projects]'))
CREATE STATISTICS [ST_1813581499_8_9_7_10] ON [dbo].[BugNet_Projects]([ProjectAccessType], [ProjectManagerUserId], [ProjectDisabled], [ProjectCreatorUserId])
GO
/****** Object:  Statistic [ST_1813581499_9_1_7]    Script Date: 9/11/2014 9:36:15 PM ******/
if not exists (select * from sys.stats where name = N'ST_1813581499_9_1_7' and object_id = object_id(N'[dbo].[BugNet_Projects]'))
CREATE STATISTICS [ST_1813581499_9_1_7] ON [dbo].[BugNet_Projects]([ProjectManagerUserId], [ProjectId], [ProjectDisabled])
GO


INSERT INTO [dbo].[BugNet_HostSettings] ([SettingName], [SettingValue]) VALUES('GoogleClientId', '')
INSERT INTO [dbo].[BugNet_HostSettings] ([SettingName], [SettingValue]) VALUES('GoogleClientSecret', '')
GO

PRINT N'Dropping [dbo].[BugNet_Languages].[IX_BugNet_Languages]...';


GO
DROP INDEX [IX_BugNet_Languages]
    ON [dbo].[BugNet_Languages];


GO
PRINT N'Dropping [dbo].[BugNet_RelatedIssues].[IX_BugNet_RelatedIssues]...';


GO
DROP INDEX [IX_BugNet_RelatedIssues]
    ON [dbo].[BugNet_RelatedIssues];


GO
PRINT N'Dropping on [dbo].[BugNet_UserProfiles].[ReceiveEmailNotifications]...';


GO
ALTER TABLE [dbo].[BugNet_UserProfiles] DROP CONSTRAINT [DF__BugNet_Us__Recei__56D3D912];


GO
PRINT N'Dropping [dbo].[DF_Bugnet_DefaultValuesVisibility_AffectedMilestoneVisivility]...';


GO
ALTER TABLE [dbo].[BugNet_DefaultValuesVisibility] DROP CONSTRAINT [DF_Bugnet_DefaultValuesVisibility_AffectedMilestoneVisivility];


GO
PRINT N'Dropping on [dbo].[BugNet_ProjectCategories].[Disabled]...';


GO
ALTER TABLE [dbo].[BugNet_ProjectCategories] DROP CONSTRAINT [DF__BugNet_Pr__Disab__1ABEEF0B];


GO
PRINT N'Dropping on [dbo].[BugNet_ProjectMilestones].[MilestoneCompleted]...';


GO
ALTER TABLE [dbo].[BugNet_ProjectMilestones] DROP CONSTRAINT [DF__BugNet_Pr__Miles__131DCD43];


GO
PRINT N'Dropping on [dbo].[BugNet_UserProjects].[SelectedIssueColumns]...';


GO
ALTER TABLE [dbo].[BugNet_UserProjects] DROP CONSTRAINT [DF__BugNet_Us__Selec__2DD1C37F];


GO
PRINT N'Altering [dbo].[BugNet_DefaultValuesVisibility]...';


GO
ALTER TABLE [dbo].[BugNet_DefaultValuesVisibility]
    ADD [StatusEditVisibility]            BIT CONSTRAINT [DF_Bugnet_DefaultValuesVisibility_StatusEditVisibility] DEFAULT ((1)) NOT NULL,
        [OwnedByEditVisibility]           BIT CONSTRAINT [DF_Bugnet_DefaultValuesVisibility_OwnedByEditVisibility] DEFAULT ((1)) NOT NULL,
        [PriorityEditVisibility]          BIT CONSTRAINT [DF_Bugnet_DefaultValuesVisibility_PriorityEditVisibility] DEFAULT ((1)) NOT NULL,
        [AssignedToEditVisibility]        BIT CONSTRAINT [DF_Bugnet_DefaultValuesVisibility_AssignedToEditVisibility] DEFAULT ((1)) NOT NULL,
        [PrivateEditVisibility]           BIT CONSTRAINT [DF_Bugnet_DefaultValuesVisibility_PrivateEditVisibility] DEFAULT ((1)) NOT NULL,
        [CategoryEditVisibility]          BIT CONSTRAINT [DF_Bugnet_DefaultValuesVisibility_CategoryEditVisibility] DEFAULT ((1)) NOT NULL,
        [DueDateEditVisibility]           BIT CONSTRAINT [DF_Bugnet_DefaultValuesVisibility_DueDateEditVisibility] DEFAULT ((1)) NOT NULL,
        [TypeEditVisibility]              BIT CONSTRAINT [DF_Bugnet_DefaultValuesVisibility_TypeEditVisibility] DEFAULT ((1)) NOT NULL,
        [PercentCompleteEditVisibility]   BIT CONSTRAINT [DF_Bugnet_DefaultValuesVisibility_PercentCompleteEditVisibility] DEFAULT ((1)) NOT NULL,
        [MilestoneEditVisibility]         BIT CONSTRAINT [DF_Bugnet_DefaultValuesVisibility_MilestoneEditVisibility] DEFAULT ((1)) NOT NULL,
        [EstimationEditVisibility]        BIT CONSTRAINT [DF_Bugnet_DefaultValuesVisibility_EstimationEditVisibility] DEFAULT ((1)) NOT NULL,
        [ResolutionEditVisibility]        BIT CONSTRAINT [DF_Bugnet_DefaultValuesVisibility_ResolutionEditVisibility] DEFAULT ((1)) NOT NULL,
        [AffectedMilestoneEditVisibility] BIT CONSTRAINT [DF_Bugnet_DefaultValuesVisibility_AffectedMilestoneEditVisibility] DEFAULT ((1)) NOT NULL;


GO
PRINT N'Starting rebuilding table [dbo].[BugNet_UserProfiles]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_BugNet_UserProfiles] (
    [UserName]                                NVARCHAR (50)  NOT NULL,
    [FirstName]                               NVARCHAR (100) NULL,
    [LastName]                                NVARCHAR (100) NULL,
    [DisplayName]                             NVARCHAR (100) NULL,
    [IssuesPageSize]                          INT            NULL,
    [PreferredLocale]                         NVARCHAR (50)  NULL,
    [LastUpdate]                              DATETIME       NOT NULL,
    [SelectedIssueColumns]                    NVARCHAR (50)  NULL,
    [ReceiveEmailNotifications]               BIT            CONSTRAINT [DF_BugNet_UserProfiles_RecieveEmailNotifications] DEFAULT ((1)) NOT NULL,
    [PasswordVerificationToken]               NVARCHAR (128) NULL,
    [PasswordVerificationTokenExpirationDate] DATETIME       NULL,
    CONSTRAINT [tmp_ms_xx_constraint_PK_BugNet_UserProfiles] PRIMARY KEY CLUSTERED ([UserName] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[BugNet_UserProfiles])
    BEGIN
        INSERT INTO [dbo].[tmp_ms_xx_BugNet_UserProfiles] ([UserName], [FirstName], [LastName], [DisplayName], [IssuesPageSize], [PreferredLocale], [LastUpdate], [SelectedIssueColumns], [ReceiveEmailNotifications], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate])
        SELECT   [UserName],
                 [FirstName],
                 [LastName],
                 [DisplayName],
                 [IssuesPageSize],
                 [PreferredLocale],
                 [LastUpdate],
                 [SelectedIssueColumns],
                 [ReceiveEmailNotifications],
                 [PasswordVerificationToken],
                 [PasswordVerificationTokenExpirationDate]
        FROM     [dbo].[BugNet_UserProfiles]
        ORDER BY [UserName] ASC;
    END

DROP TABLE [dbo].[BugNet_UserProfiles];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_BugNet_UserProfiles]', N'BugNet_UserProfiles';

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_constraint_PK_BugNet_UserProfiles]', N'PK_BugNet_UserProfiles', N'OBJECT';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Creating [dbo].[DF_Bugnet_DefaultValuesVisibility_AffectedMilestoneVisibility]...';


GO
ALTER TABLE [dbo].[BugNet_DefaultValuesVisibility]
    ADD CONSTRAINT [DF_Bugnet_DefaultValuesVisibility_AffectedMilestoneVisibility] DEFAULT ((1)) FOR [AffectedMilestoneVisibility];


GO
PRINT N'Creating [dbo].[DF_BugNet_ProjectCategories_Disabled]...';


GO
ALTER TABLE [dbo].[BugNet_ProjectCategories]
    ADD CONSTRAINT [DF_BugNet_ProjectCategories_Disabled] DEFAULT ((0)) FOR [Disabled];


GO
PRINT N'Creating [dbo].[DF_BugNet_ProjectMilestones_Completed]...';


GO
ALTER TABLE [dbo].[BugNet_ProjectMilestones]
    ADD CONSTRAINT [DF_BugNet_ProjectMilestones_Completed] DEFAULT ((0)) FOR [MilestoneCompleted];


GO
PRINT N'Creating [dbo].[DF__BugNet_Us__Selec__7E42ABEE]...';


GO
ALTER TABLE [dbo].[BugNet_UserProjects]
    ADD CONSTRAINT [DF__BugNet_Us__Selec__7E42ABEE] DEFAULT ((0)) FOR [SelectedIssueColumns];


GO
PRINT N'Altering [dbo].[BugNet_DefaultValView]...';


GO

ALTER VIEW [dbo].[BugNet_DefaultValView]
AS
SELECT     dbo.BugNet_DefaultValues.DefaultType, dbo.BugNet_DefaultValues.StatusId, dbo.BugNet_DefaultValues.IssueOwnerUserId, 
                      dbo.BugNet_DefaultValues.IssuePriorityId, dbo.BugNet_DefaultValues.IssueAffectedMilestoneId, dbo.BugNet_DefaultValues.ProjectId, 
                      ISNULL(OwnerUsers.UserName, N'none') AS OwnerUserName, ISNULL(OwnerUsersProfile.DisplayName, N'none') AS OwnerDisplayName, 
                      ISNULL(AssignedUsers.UserName, N'none') AS AssignedUserName, ISNULL(AssignedUsersProfile.DisplayName, N'none') AS AssignedDisplayName, 
                      dbo.BugNet_DefaultValues.IssueAssignedUserId, dbo.BugNet_DefaultValues.IssueCategoryId, dbo.BugNet_DefaultValues.IssueVisibility, 
                      dbo.BugNet_DefaultValues.IssueDueDate, dbo.BugNet_DefaultValues.IssueProgress, dbo.BugNet_DefaultValues.IssueMilestoneId, 
                      dbo.BugNet_DefaultValues.IssueEstimation, dbo.BugNet_DefaultValues.IssueResolutionId, dbo.BugNet_DefaultValuesVisibility.StatusVisibility, 
                      dbo.BugNet_DefaultValuesVisibility.PriorityVisibility, dbo.BugNet_DefaultValuesVisibility.OwnedByVisibility, 
                      dbo.BugNet_DefaultValuesVisibility.AssignedToVisibility, dbo.BugNet_DefaultValuesVisibility.PrivateVisibility, 
                      dbo.BugNet_DefaultValuesVisibility.CategoryVisibility, dbo.BugNet_DefaultValuesVisibility.DueDateVisibility, 
                      dbo.BugNet_DefaultValuesVisibility.TypeVisibility, dbo.BugNet_DefaultValuesVisibility.PercentCompleteVisibility, 
                      dbo.BugNet_DefaultValuesVisibility.MilestoneVisibility, dbo.BugNet_DefaultValuesVisibility.ResolutionVisibility, 
                      dbo.BugNet_DefaultValuesVisibility.EstimationVisibility, dbo.BugNet_DefaultValuesVisibility.AffectedMilestoneVisibility, 
                      dbo.BugNet_DefaultValues.OwnedByNotify, dbo.BugNet_DefaultValues.AssignedToNotify,
					  dbo.BugNet_DefaultValuesVisibility.StatusEditVisibility, 
                      dbo.BugNet_DefaultValuesVisibility.PriorityEditVisibility, dbo.BugNet_DefaultValuesVisibility.OwnedByEditVisibility, 
                      dbo.BugNet_DefaultValuesVisibility.AssignedToEditVisibility, dbo.BugNet_DefaultValuesVisibility.PrivateEditVisibility, 
                      dbo.BugNet_DefaultValuesVisibility.CategoryEditVisibility, dbo.BugNet_DefaultValuesVisibility.DueDateEditVisibility, 
                      dbo.BugNet_DefaultValuesVisibility.TypeEditVisibility, dbo.BugNet_DefaultValuesVisibility.PercentCompleteEditVisibility, 
                      dbo.BugNet_DefaultValuesVisibility.MilestoneEditVisibility, dbo.BugNet_DefaultValuesVisibility.ResolutionEditVisibility, 
                      dbo.BugNet_DefaultValuesVisibility.EstimationEditVisibility, dbo.BugNet_DefaultValuesVisibility.AffectedMilestoneEditVisibility
FROM         dbo.BugNet_DefaultValues LEFT OUTER JOIN
                      dbo.Users AS OwnerUsers ON dbo.BugNet_DefaultValues.IssueOwnerUserId = OwnerUsers.UserId LEFT OUTER JOIN
                      dbo.Users AS AssignedUsers ON dbo.BugNet_DefaultValues.IssueAssignedUserId = AssignedUsers.UserId LEFT OUTER JOIN
                      dbo.BugNet_UserProfiles AS AssignedUsersProfile ON AssignedUsers.UserName = AssignedUsersProfile.UserName LEFT OUTER JOIN
                      dbo.BugNet_UserProfiles AS OwnerUsersProfile ON OwnerUsers.UserName = OwnerUsersProfile.UserName LEFT OUTER JOIN
                      dbo.BugNet_DefaultValuesVisibility ON dbo.BugNet_DefaultValues.ProjectId = dbo.BugNet_DefaultValuesVisibility.ProjectId
GO
PRINT N'Refreshing [dbo].[BugNet_GetIssuesByProjectIdAndCustomFieldView]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[BugNet_GetIssuesByProjectIdAndCustomFieldView]';


GO
PRINT N'Refreshing [dbo].[BugNet_IssuesView]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[BugNet_IssuesView]';


GO
PRINT N'Refreshing [dbo].[BugNet_ProjectsView]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[BugNet_ProjectsView]';


GO
PRINT N'Refreshing [dbo].[BugNet_UserView]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[BugNet_UserView]';


GO
PRINT N'Refreshing [dbo].[BugNet_IssueAssignedToCountView]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[BugNet_IssueAssignedToCountView]';


GO
PRINT N'Refreshing [dbo].[BugNet_IssueCommentsView]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[BugNet_IssueCommentsView]';


GO
PRINT N'Altering [dbo].[BugNet_DefaultValues_Set]...';


GO
ALTER PROCEDURE [dbo].[BugNet_DefaultValues_Set]
	@Type nvarchar(50),
	@ProjectId Int,
	@StatusId Int,
	@IssueOwnerUserName NVarChar(255),
	@IssuePriorityId Int,
	@IssueAssignedUserName NVarChar(255),
	@IssueVisibility int,
	@IssueCategoryId Int,
	@IssueAffectedMilestoneId Int,
	@IssueDueDate int,
	@IssueProgress Int,
	@IssueMilestoneId Int,
	@IssueEstimation decimal(5,2),
	@IssueResolutionId Int,
	@StatusVisibility		 Bit,
	@OwnedByVisibility		 Bit,
	@PriorityVisibility		 Bit,
	@AssignedToVisibility	 Bit,
	@PrivateVisibility		 Bit,
	@CategoryVisibility		 Bit,
	@DueDateVisibility		 Bit,
	@TypeVisibility			 Bit,
	@PercentCompleteVisibility Bit,
	@MilestoneVisibility	Bit, 
	@EstimationVisibility	 Bit,
	@ResolutionVisibility	 Bit,
	@AffectedMilestoneVisibility Bit,
	@StatusEditVisibility		 Bit,
	@OwnedByEditVisibility		 Bit,
	@PriorityEditVisibility		 Bit,
	@AssignedToEditVisibility	 Bit,
	@PrivateEditVisibility		 Bit,
	@CategoryEditVisibility		 Bit,
	@DueDateEditVisibility		 Bit,
	@TypeEditVisibility			 Bit,
	@PercentCompleteEditVisibility Bit,
	@MilestoneEditVisibility	Bit, 
	@EstimationEditVisibility	 Bit,
	@ResolutionEditVisibility	 Bit,
	@AffectedMilestoneEditVisibility Bit,
	@OwnedByNotify Bit,
	@AssignedToNotify Bit
AS
DECLARE @IssueAssignedUserId	UNIQUEIDENTIFIER
DECLARE @IssueOwnerUserId		UNIQUEIDENTIFIER

SELECT @IssueOwnerUserId = UserId FROM Users WHERE UserName = @IssueOwnerUserName
SELECT @IssueAssignedUserId = UserId FROM Users WHERE UserName = @IssueAssignedUserName
BEGIN
	BEGIN TRAN
		DECLARE @defVisExists int
		SELECT @defVisExists = COUNT(*) 
		FROM BugNet_DefaultValuesVisibility
			WHERE BugNet_DefaultValuesVisibility.ProjectId = @ProjectId
				IF(@defVisExists>0)
					BEGIN
						UPDATE BugNet_DefaultValuesVisibility
						SET 								
							StatusVisibility = @StatusVisibility,			
							OwnedByVisibility = @OwnedByVisibility,				
							PriorityVisibility = @PriorityVisibility,			
							AssignedToVisibility = @AssignedToVisibility,			
							PrivateVisibility= @PrivateVisibility,			
							CategoryVisibility= @CategoryVisibility,			
							DueDateVisibility= @DueDateVisibility,				
							TypeVisibility	= @TypeVisibility,				
							PercentCompleteVisibility = @PercentCompleteVisibility,		
							MilestoneVisibility	= @MilestoneVisibility,			
							EstimationVisibility = @EstimationVisibility,			
							ResolutionVisibility = @ResolutionVisibility,
							AffectedMilestoneVisibility = @AffectedMilestoneVisibility,
							StatusEditVisibility = @StatusEditVisibility,			
							OwnedByEditVisibility = @OwnedByEditVisibility,				
							PriorityEditVisibility = @PriorityEditVisibility,			
							AssignedToEditVisibility = @AssignedToEditVisibility,			
							PrivateEditVisibility= @PrivateEditVisibility,			
							CategoryEditVisibility= @CategoryEditVisibility,			
							DueDateEditVisibility= @DueDateEditVisibility,				
							TypeEditVisibility	= @TypeEditVisibility,				
							PercentCompleteEditVisibility = @PercentCompleteEditVisibility,		
							MilestoneEditVisibility	= @MilestoneEditVisibility,			
							EstimationEditVisibility = @EstimationEditVisibility,			
							ResolutionEditVisibility = @ResolutionEditVisibility,
							AffectedMilestoneEditVisibility = @AffectedMilestoneEditVisibility	
					WHERE ProjectId = @ProjectId							
					END
				ELSE
					BEGIN
					INSERT INTO BugNet_DefaultValuesVisibility
					VALUES 
					(
						@ProjectId				 ,  
						@StatusVisibility		 ,
						@OwnedByVisibility		 ,
						@PriorityVisibility		 ,
						@AssignedToVisibility	 ,
						@PrivateVisibility		 ,
						@CategoryVisibility		 ,
						@DueDateVisibility		 ,
						@TypeVisibility			 ,
						@PercentCompleteVisibility,
						@MilestoneVisibility	,	 
						@EstimationVisibility	 ,
						@ResolutionVisibility	,
						@AffectedMilestoneVisibility,
						@StatusEditVisibility		 ,
						@OwnedByEditVisibility		 ,
						@PriorityEditVisibility		 ,
						@AssignedToEditVisibility	 ,
						@PrivateEditVisibility		 ,
						@CategoryEditVisibility		 ,
						@DueDateEditVisibility		 ,
						@TypeEditVisibility			 ,
						@PercentCompleteEditVisibility,
						@MilestoneEditVisibility	,	 
						@EstimationEditVisibility	 ,
						@ResolutionEditVisibility	,
						@AffectedMilestoneEditVisibility	  					
					)
					END


		DECLARE @defExists int
		SELECT @defExists = COUNT(*) 
			FROM BugNet_DefaultValues
			WHERE BugNet_DefaultValues.ProjectId = @ProjectId
		
		IF (@defExists > 0)
		BEGIN
			UPDATE BugNet_DefaultValues 
				SET DefaultType = @Type,
					StatusId = @StatusId,
					IssueOwnerUserId = @IssueOwnerUserId,
					IssuePriorityId = @IssuePriorityId,
					IssueAffectedMilestoneId = @IssueAffectedMilestoneId,
					IssueAssignedUserId = @IssueAssignedUserId,
					IssueVisibility = @IssueVisibility,
					IssueCategoryId = @IssueCategoryId,
					IssueDueDate = @IssueDueDate,
					IssueProgress = @IssueProgress,
					IssueMilestoneId = @IssueMilestoneId,
					IssueEstimation = @IssueEstimation,
					IssueResolutionId = @IssueResolutionId,
					OwnedByNotify = @OwnedByNotify,
					AssignedToNotify = @AssignedToNotify
				WHERE ProjectId = @ProjectId
		END
		ELSE
		BEGIN
			INSERT INTO BugNet_DefaultValues 
				VALUES (
					@ProjectId,
					@Type,
					@StatusId,
					@IssueOwnerUserId,
					@IssuePriorityId,
					@IssueAffectedMilestoneId,
					@IssueAssignedUserId,
					@IssueVisibility,
					@IssueCategoryId,
					@IssueDueDate,
					@IssueProgress,
					@IssueMilestoneId,
					@IssueEstimation,
					@IssueResolutionId,
					@OwnedByNotify,
					@AssignedToNotify 
				)
		END
	COMMIT TRAN
END
GO
PRINT N'Altering [dbo].[BugNet_User_GetUsersByProjectId]...';


GO
ALTER PROCEDURE [dbo].[BugNet_User_GetUsersByProjectId]
	@ProjectId Int,
	@ExcludeReadonlyUsers bit
AS
SELECT DISTINCT U.UserId, U.UserName, FirstName, LastName, DisplayName FROM 
	Users U
JOIN BugNet_UserProjects
	ON U.UserId = BugNet_UserProjects.UserId
JOIN BugNet_UserProfiles
	ON U.UserName = BugNet_UserProfiles.UserName
JOIN  Memberships M 
	ON U.UserId = M.UserId
LEFT JOIN BugNet_UserRoles UR
	ON U.UserId = UR.UserId 
LEFT JOIN BugNet_Roles R
	ON UR.RoleId = R.RoleId AND R.ProjectId = @ProjectId
WHERE
	BugNet_UserProjects.ProjectId = @ProjectId 
	AND M.IsApproved = 1
	AND (@ExcludeReadonlyUsers = 0 OR @ExcludeReadonlyUsers = 1 AND R.RoleName != 'Read Only')
ORDER BY DisplayName ASC
GO
PRINT N'Altering [dbo].[BugNet_ProjectCategories_CreateNewCategory]...';


GO
ALTER PROCEDURE [dbo].[BugNet_ProjectCategories_CreateNewCategory]
  @ProjectId int,
  @CategoryName nvarchar(100),
  @ParentCategoryId int
AS
IF NOT EXISTS(SELECT CategoryId  FROM BugNet_ProjectCategories WHERE LOWER(CategoryName)= LOWER(@CategoryName) AND ProjectId = @ProjectId)
BEGIN
	INSERT BugNet_ProjectCategories
	(
		ProjectId,
		CategoryName,
		ParentCategoryId
	)
	VALUES
	(
		@ProjectId,
		@CategoryName,
		@ParentCategoryId
	)
	RETURN SCOPE_IDENTITY()
END
RETURN -1
GO
PRINT N'Altering [dbo].[BugNet_ProjectIssueTypes_CanDeleteIssueType]...';


GO
ALTER PROCEDURE [dbo].[BugNet_ProjectIssueTypes_CanDeleteIssueType]
	@IssueTypeId INT
AS

SET NOCOUNT ON

DECLARE
	@ProjectId INT,
	@Count INT
	
SET @ProjectId = (SELECT ProjectId FROM BugNet_ProjectIssueTypes WHERE IssueTypeId = @IssueTypeId)

SET @Count = 
(
	SELECT COUNT(*)
	FROM BugNet_Issues
	WHERE (IssueTypeId = @IssueTypeId)
	AND ProjectId = @ProjectId
)

IF(@Count = 0)
	RETURN 1
ELSE
	RETURN 0
GO
PRINT N'Altering [dbo].[BugNet_ProjectPriorities_CanDeletePriority]...';


GO
ALTER PROCEDURE [dbo].[BugNet_ProjectPriorities_CanDeletePriority]
	@PriorityId INT
AS

SET NOCOUNT ON

DECLARE
	@ProjectId INT,
	@Count INT
	
SET @ProjectId = (SELECT ProjectId FROM BugNet_ProjectPriorities WHERE PriorityId = @PriorityId)

SET @Count = 
(
	SELECT COUNT(*)
	FROM BugNet_Issues
	WHERE (IssuePriorityId = @PriorityId)
	AND ProjectId = @ProjectId
)

IF(@Count = 0)
	RETURN 1
ELSE
	RETURN 0
GO
PRINT N'Altering [dbo].[BugNet_ProjectResolutions_CanDeleteResolution]...';


GO
ALTER PROCEDURE [dbo].[BugNet_ProjectResolutions_CanDeleteResolution]
	@ResolutionId INT
AS

SET NOCOUNT ON

DECLARE
	@ProjectId INT,
	@Count INT
	
SET @ProjectId = (SELECT ProjectId FROM BugNet_ProjectResolutions WHERE ResolutionId = @ResolutionId)

SET @Count = 
(
	SELECT COUNT(*)
	FROM BugNet_Issues
	WHERE (IssueResolutionId = @ResolutionId)
	AND ProjectId = @ProjectId
)

IF(@Count = 0)
	RETURN 1
ELSE
	RETURN 0
GO
PRINT N'Altering [dbo].[BugNet_ProjectStatus_CanDeleteStatus]...';


GO
ALTER PROCEDURE [dbo].[BugNet_ProjectStatus_CanDeleteStatus]
	@StatusId INT
AS

SET NOCOUNT ON

DECLARE
	@ProjectId INT,
	@Count INT
	
SET @ProjectId = (SELECT ProjectId FROM BugNet_ProjectStatus WHERE StatusId = @StatusId)

SET @Count = 
(
	SELECT COUNT(*)
	FROM BugNet_Issues
	WHERE (IssueStatusId = @StatusId)
	AND ProjectId = @ProjectId
)

IF(@Count = 0)
	RETURN 1
ELSE
	RETURN 0
GO
PRINT N'Refreshing [dbo].[BugNet_DefaultValues_GetByProjectId]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[BugNet_DefaultValues_GetByProjectId]';


GO
PRINT N'Refreshing [dbo].[BugNet_IssueAttachment_GetIssueAttachmentById]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[BugNet_IssueAttachment_GetIssueAttachmentById]';


GO
PRINT N'Refreshing [dbo].[BugNet_IssueAttachment_GetIssueAttachmentsByIssueId]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[BugNet_IssueAttachment_GetIssueAttachmentsByIssueId]';


GO
PRINT N'Refreshing [dbo].[BugNet_IssueComment_GetIssueCommentById]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[BugNet_IssueComment_GetIssueCommentById]';


GO
PRINT N'Refreshing [dbo].[BugNet_IssueComment_GetIssueCommentsByIssueId]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[BugNet_IssueComment_GetIssueCommentsByIssueId]';


GO
PRINT N'Refreshing [dbo].[BugNet_IssueHistory_GetIssueHistoryByIssueId]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[BugNet_IssueHistory_GetIssueHistoryByIssueId]';


GO
PRINT N'Refreshing [dbo].[BugNet_IssueNotification_GetIssueNotificationsByIssueId]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[BugNet_IssueNotification_GetIssueNotificationsByIssueId]';


GO
PRINT N'Refreshing [dbo].[BugNet_IssueWorkReport_GetIssueWorkReportsByIssueId]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[BugNet_IssueWorkReport_GetIssueWorkReportsByIssueId]';


GO
PRINT N'Refreshing [dbo].[BugNet_Project_GetMemberRolesByProjectId]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[BugNet_Project_GetMemberRolesByProjectId]';


GO
PRINT N'Refreshing [dbo].[BugNet_ProjectMailbox_GetMailboxById]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[BugNet_ProjectMailbox_GetMailboxById]';


GO
PRINT N'Refreshing [dbo].[BugNet_ProjectMailbox_GetMailboxByProjectId]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[BugNet_ProjectMailbox_GetMailboxByProjectId]';


GO
PRINT N'Refreshing [dbo].[BugNet_ProjectMailbox_GetProjectByMailbox]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[BugNet_ProjectMailbox_GetProjectByMailbox]';


GO
PRINT N'Refreshing [dbo].[BugNet_ProjectNotification_GetProjectNotificationsByProjectId]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[BugNet_ProjectNotification_GetProjectNotificationsByProjectId]';


GO
PRINT N'Refreshing [dbo].[BugNet_ProjectNotification_GetProjectNotificationsByUsername]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[BugNet_ProjectNotification_GetProjectNotificationsByUsername]';


GO
PRINT N'Refreshing [dbo].[BugNet_Query_GetQueriesByUserName]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[BugNet_Query_GetQueriesByUserName]';


GO
PRINT N'Refreshing [dbo].[BugNet_User_GetUserNameByPasswordResetToken]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[BugNet_User_GetUserNameByPasswordResetToken]';


GO
PRINT N'Refreshing [dbo].[BugNet_Issue_GetIssueById]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[BugNet_Issue_GetIssueById]';


GO
PRINT N'Refreshing [dbo].[BugNet_Issue_GetIssueCategoryCountByProject]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[BugNet_Issue_GetIssueCategoryCountByProject]';


GO
PRINT N'Refreshing [dbo].[BugNet_Issue_GetIssueMilestoneCountByProject]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[BugNet_Issue_GetIssueMilestoneCountByProject]';


GO
PRINT N'Refreshing [dbo].[BugNet_Issue_GetIssuePriorityCountByProject]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[BugNet_Issue_GetIssuePriorityCountByProject]';


GO
PRINT N'Refreshing [dbo].[BugNet_Issue_GetIssuesByAssignedUserName]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[BugNet_Issue_GetIssuesByAssignedUserName]';


GO
PRINT N'Refreshing [dbo].[BugNet_Issue_GetIssuesByCreatorUserName]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[BugNet_Issue_GetIssuesByCreatorUserName]';


GO
PRINT N'Refreshing [dbo].[BugNet_Issue_GetIssuesByOwnerUserName]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[BugNet_Issue_GetIssuesByOwnerUserName]';


GO
PRINT N'Refreshing [dbo].[BugNet_Issue_GetIssuesByProjectId]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[BugNet_Issue_GetIssuesByProjectId]';


GO
PRINT N'Refreshing [dbo].[BugNet_Issue_GetIssuesByRelevancy]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[BugNet_Issue_GetIssuesByRelevancy]';


GO
PRINT N'Refreshing [dbo].[BugNet_Issue_GetIssueStatusCountByProject]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[BugNet_Issue_GetIssueStatusCountByProject]';


GO
PRINT N'Refreshing [dbo].[BugNet_Issue_GetIssueTypeCountByProject]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[BugNet_Issue_GetIssueTypeCountByProject]';


GO
PRINT N'Refreshing [dbo].[BugNet_Issue_GetMonitoredIssuesByUserName]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[BugNet_Issue_GetMonitoredIssuesByUserName]';


GO
PRINT N'Refreshing [dbo].[BugNet_Issue_GetOpenIssues]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[BugNet_Issue_GetOpenIssues]';


GO
PRINT N'Refreshing [dbo].[BugNet_IssueAttachment_ValidateDownload]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[BugNet_IssueAttachment_ValidateDownload]';


GO
PRINT N'Refreshing [dbo].[BugNet_Project_GetRoadMapProgress]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[BugNet_Project_GetRoadMapProgress]';


GO
PRINT N'Refreshing [dbo].[BugNet_ProjectCategories_GetCategoriesByProjectId]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[BugNet_ProjectCategories_GetCategoriesByProjectId]';


GO
PRINT N'Refreshing [dbo].[BugNet_ProjectCategories_GetCategoryById]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[BugNet_ProjectCategories_GetCategoryById]';


GO
PRINT N'Refreshing [dbo].[BugNet_ProjectCategories_GetChildCategoriesByCategoryId]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[BugNet_ProjectCategories_GetChildCategoriesByCategoryId]';


GO
PRINT N'Refreshing [dbo].[BugNet_ProjectCategories_GetRootCategoriesByProjectId]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[BugNet_ProjectCategories_GetRootCategoriesByProjectId]';


GO
PRINT N'Refreshing [dbo].[BugNet_Project_GetAllProjects]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[BugNet_Project_GetAllProjects]';


GO
PRINT N'Refreshing [dbo].[BugNet_Project_GetProjectByCode]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[BugNet_Project_GetProjectByCode]';


GO
PRINT N'Refreshing [dbo].[BugNet_Project_GetProjectById]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[BugNet_Project_GetProjectById]';


GO
PRINT N'Refreshing [dbo].[BugNet_Project_GetProjectsByMemberUsername]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[BugNet_Project_GetProjectsByMemberUsername]';


GO
PRINT N'Refreshing [dbo].[BugNet_Project_GetPublicProjects]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[BugNet_Project_GetPublicProjects]';


GO
PRINT N'Refreshing [dbo].[BugNet_Issue_GetIssueUserCountByProject]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[BugNet_Issue_GetIssueUserCountByProject]';


GO
PRINT N'Update complete.';


GO