PRINT '1.6.339.0.SqlDataProvider.sql'
GO

SET NOEXEC OFF
GO
SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
SET XACT_ABORT ON
GO

BEGIN TRANSACTION
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

PRINT N'Dropping [dbo].[BugNet_UserCustomFieldSelection_GetCustomFieldSelectionsByCustomFieldId]'
GO
IF OBJECT_ID(N'[dbo].[BugNet_UserCustomFieldSelection_GetCustomFieldSelectionsByCustomFieldId]', 'P') IS NOT NULL
DROP PROCEDURE [dbo].[BugNet_UserCustomFieldSelection_GetCustomFieldSelectionsByCustomFieldId]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

PRINT N'Dropping [dbo].[BugNet_UserCustomFieldSelection_GetCustomFieldSelectionById]'
GO
IF OBJECT_ID(N'[dbo].[BugNet_UserCustomFieldSelection_GetCustomFieldSelectionById]', 'P') IS NOT NULL
DROP PROCEDURE [dbo].[BugNet_UserCustomFieldSelection_GetCustomFieldSelectionById]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

PRINT N'Dropping [dbo].[BugNet_UserCustomFieldSelection_DeleteCustomFieldSelection]'
GO
IF OBJECT_ID(N'[dbo].[BugNet_UserCustomFieldSelection_DeleteCustomFieldSelection]', 'P') IS NOT NULL
DROP PROCEDURE [dbo].[BugNet_UserCustomFieldSelection_DeleteCustomFieldSelection]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

PRINT N'Dropping [dbo].[BugNet_UserCustomFieldSelection_CreateNewCustomFieldSelection]'
GO
IF OBJECT_ID(N'[dbo].[BugNet_UserCustomFieldSelection_CreateNewCustomFieldSelection]', 'P') IS NOT NULL
DROP PROCEDURE [dbo].[BugNet_UserCustomFieldSelection_CreateNewCustomFieldSelection]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

PRINT N'Dropping [dbo].[BugNet_UserCustomField_UpdateCustomField]'
GO
IF OBJECT_ID(N'[dbo].[BugNet_UserCustomField_UpdateCustomField]', 'P') IS NOT NULL
DROP PROCEDURE [dbo].[BugNet_UserCustomField_UpdateCustomField]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

PRINT N'Dropping [dbo].[BugNet_UserCustomField_SaveCustomFieldValue]'
GO
IF OBJECT_ID(N'[dbo].[BugNet_UserCustomField_SaveCustomFieldValue]', 'P') IS NOT NULL
DROP PROCEDURE [dbo].[BugNet_UserCustomField_SaveCustomFieldValue]
GO 
IF @@ERROR <> 0 SET NOEXEC ON
GO

PRINT N'Dropping [dbo].[BugNet_UserCustomField_GetCustomFieldsByUserId]'
GO
IF OBJECT_ID(N'[dbo].[BugNet_UserCustomField_GetCustomFieldsByUserId]', 'P') IS NOT NULL
DROP PROCEDURE [dbo].[BugNet_UserCustomField_GetCustomFieldsByUserId]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

PRINT N'Dropping [dbo].[BugNet_UserCustomField_GetCustomFields]'
GO
IF OBJECT_ID(N'[dbo].[BugNet_UserCustomField_GetCustomFields]', 'P') IS NOT NULL
DROP PROCEDURE [dbo].[BugNet_UserCustomField_GetCustomFields]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

PRINT N'Dropping [dbo].[BugNet_UserCustomField_GetCustomFieldById]'
GO
IF OBJECT_ID(N'[dbo].[BugNet_UserCustomField_GetCustomFieldById]', 'P') IS NOT NULL
DROP PROCEDURE [dbo].[BugNet_UserCustomField_GetCustomFieldById]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

PRINT N'Dropping [dbo].[BugNet_UserCustomField_DeleteCustomField]'
GO
IF OBJECT_ID(N'[dbo].[BugNet_UserCustomField_DeleteCustomField]', 'P') IS NOT NULL
DROP PROCEDURE [dbo].[BugNet_UserCustomField_DeleteCustomField]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

PRINT N'Dropping [dbo].[BugNet_UserCustomField_CreateNewCustomField]'
GO
IF OBJECT_ID(N'[dbo].[BugNet_UserCustomField_CreateNewCustomField]', 'P') IS NOT NULL
DROP PROCEDURE [dbo].[BugNet_UserCustomField_CreateNewCustomField]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

PRINT N'Dropping [dbo].[BugNet_UserCustomFieldSelection_Update]'
GO
IF OBJECT_ID(N'[dbo].[BugNet_UserCustomFieldSelection_Update]', 'P') IS NOT NULL
DROP PROCEDURE [dbo].[BugNet_UserCustomFieldSelection_Update]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

IF OBJECT_ID('[dbo].[UsersOpenAuthData]') IS NULL
BEGIN
    PRINT 'Creating [dbo].[UsersOpenAuthData]';
    EXEC('CREATE TABLE [dbo].[UsersOpenAuthData] (
    [ApplicationName]    NVARCHAR (128) NOT NULL,
    [MembershipUserName] NVARCHAR (128) NOT NULL,
    [HasLocalPassword]   BIT            NOT NULL,
    PRIMARY KEY CLUSTERED ([ApplicationName] ASC, [MembershipUserName] ASC));');
END
IF @@ERROR <> 0 SET NOEXEC ON
GO

IF OBJECT_ID('[dbo].[UsersOpenAuthAccounts]') IS NULL
BEGIN
    PRINT 'Creating [dbo].[UsersOpenAuthAccounts]';
    EXEC('CREATE TABLE [dbo].[UsersOpenAuthAccounts] (
    [ApplicationName]    NVARCHAR (128) NOT NULL,
    [ProviderName]       NVARCHAR (128) NOT NULL,
    [ProviderUserId]     NVARCHAR (128) NOT NULL,
    [ProviderUserName]   NVARCHAR (MAX) NOT NULL,
    [MembershipUserName] NVARCHAR (128) NOT NULL,
    [LastUsedUtc]        DATETIME       NULL,
    PRIMARY KEY CLUSTERED ([ApplicationName] ASC, [ProviderName] ASC, [ProviderUserId] ASC),
    CONSTRAINT [OpenAuthUserData_Accounts] FOREIGN KEY ([ApplicationName], [MembershipUserName]) REFERENCES [dbo].[UsersOpenAuthData] ([ApplicationName], [MembershipUserName]) ON DELETE CASCADE);');
END
IF @@ERROR <> 0 SET NOEXEC ON
GO

IF OBJECT_ID('[dbo].[BugNet_UserCustomFieldTypes]') IS NULL
BEGIN
    PRINT 'Creating [dbo].[BugNet_UserCustomFieldTypes]';
    EXEC('CREATE TABLE [dbo].[BugNet_UserCustomFieldTypes](
		[CustomFieldTypeId] [int] IDENTITY(1,1) NOT NULL,
		[CustomFieldTypeName] [nvarchar](50) NOT NULL,
		CONSTRAINT [PK_BugNet_UserCustomFieldTypes] PRIMARY KEY CLUSTERED ([CustomFieldTypeId] ASC));');
END
IF @@ERROR <> 0 SET NOEXEC ON
GO

IF OBJECT_ID('[dbo].[BugNet_UserCustomFields]') IS NULL
BEGIN
    PRINT 'Creating [dbo].[BugNet_UserCustomFields]';
    EXEC('CREATE TABLE [dbo].[BugNet_UserCustomFields](
		[CustomFieldId] [int] IDENTITY(1,1) NOT NULL,
		[CustomFieldName] [nvarchar](50) NOT NULL,
		[CustomFieldRequired] [bit] NOT NULL,
		[CustomFieldDataType] [int] NOT NULL,
		[CustomFieldTypeId] [int] NOT NULL,
		CONSTRAINT [PK_BugNet_UserCustomFields] PRIMARY KEY CLUSTERED ([CustomFieldId] ASC));');

	EXEC('ALTER TABLE [dbo].[BugNet_UserCustomFields] WITH CHECK ADD CONSTRAINT [FK_BugNet_UserCustomFields_BugNet_UserCustomFieldType] FOREIGN KEY([CustomFieldTypeId]) REFERENCES [dbo].[BugNet_UserCustomFieldTypes] ([CustomFieldTypeId]) ON DELETE CASCADE')
	EXEC('ALTER TABLE [dbo].[BugNet_UserCustomFields] CHECK CONSTRAINT [FK_BugNet_UserCustomFields_BugNet_UserCustomFieldType]')
END
IF @@ERROR <> 0 SET NOEXEC ON
GO

IF OBJECT_ID('[dbo].[BugNet_UserCustomFieldSelections]') IS NULL
BEGIN
    PRINT 'Creating [dbo].[BugNet_UserCustomFieldSelections]';
    EXEC('CREATE TABLE [dbo].[BugNet_UserCustomFieldSelections](
		[CustomFieldSelectionId] [int] IDENTITY(1,1) NOT NULL,
		[CustomFieldId] [int] NOT NULL,
		[CustomFieldSelectionValue] [nvarchar](255) NOT NULL,
		[CustomFieldSelectionName] [nvarchar](255) NOT NULL,
		[CustomFieldSelectionSortOrder] [int] NOT NULL,
		CONSTRAINT [PK_BugNet_UserCustomFieldSelections] PRIMARY KEY CLUSTERED ([CustomFieldSelectionId] ASC));');
	
	EXEC('ALTER TABLE [dbo].[BugNet_UserCustomFieldSelections] ADD CONSTRAINT [DF_BugNet_UserCustomFieldSelections_CustomFieldSelectionSortOrder] DEFAULT ((0)) FOR [CustomFieldSelectionSortOrder]')
	EXEC('ALTER TABLE [dbo].[BugNet_UserCustomFieldSelections] WITH CHECK ADD CONSTRAINT [FK_BugNet_UserCustomFieldSelections_BugNet_UserCustomFields] FOREIGN KEY([CustomFieldId]) REFERENCES [dbo].[BugNet_UserCustomFields] ([CustomFieldId]) ON DELETE CASCADE')
	EXEC('ALTER TABLE [dbo].[BugNet_UserCustomFieldSelections] CHECK CONSTRAINT [FK_BugNet_UserCustomFieldSelections_BugNet_UserCustomFields]')
END
IF @@ERROR <> 0 SET NOEXEC ON
GO

IF OBJECT_ID('[dbo].[BugNet_UserCustomFieldValues]') IS NULL
BEGIN
    PRINT 'Creating [dbo].[BugNet_UserCustomFieldValues]';
    EXEC('CREATE TABLE [dbo].[BugNet_UserCustomFieldValues](
		[CustomFieldValueId] [int] IDENTITY(1,1) NOT NULL,
		[UserId] [uniqueidentifier] NOT NULL,
		[CustomFieldId] [int] NOT NULL,
		[CustomFieldValue] [nvarchar](max) NOT NULL,
		CONSTRAINT [PK_BugNet_UserCustomFieldValues] PRIMARY KEY CLUSTERED ([CustomFieldValueId] ASC));');

	EXEC('ALTER TABLE [dbo].[BugNet_UserCustomFieldValues]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_UserCustomFieldValues_BugNet_UserCustomFields] FOREIGN KEY([CustomFieldId]) REFERENCES [dbo].[BugNet_UserCustomFields] ([CustomFieldId])')
	EXEC('ALTER TABLE [dbo].[BugNet_UserCustomFieldValues] CHECK CONSTRAINT [FK_BugNet_UserCustomFieldValues_BugNet_UserCustomFields]')
	EXEC('ALTER TABLE [dbo].[BugNet_UserCustomFieldValues]  WITH CHECK ADD  CONSTRAINT [FK_BugNet_UserCustomFieldValues_BugNet_Users] FOREIGN KEY([UserId]) REFERENCES [dbo].[Users] ([UserId]) ON DELETE CASCADE')
	EXEC('ALTER TABLE [dbo].[BugNet_UserCustomFieldValues] CHECK CONSTRAINT [FK_BugNet_UserCustomFieldValues_BugNet_Users]')
END
IF @@ERROR <> 0 SET NOEXEC ON
GO

PRINT 'Creating [dbo].[BugNet_UserCustomField_CreateNewCustomField]';
EXEC('CREATE PROCEDURE [dbo].[BugNet_UserCustomField_CreateNewCustomField]
	@CustomFieldName NVarChar(50),
	@CustomFieldDataType Int,
	@CustomFieldRequired Bit,
	@CustomFieldTypeId Int
AS
IF NOT EXISTS(SELECT CustomFieldId FROM BugNet_UserCustomFields WHERE LOWER(CustomFieldName) = LOWER(@CustomFieldName) )
BEGIN
	INSERT BugNet_UserCustomFields
	(
		CustomFieldName,
		CustomFieldDataType,
		CustomFieldRequired,
		CustomFieldTypeId
	)
	VALUES
	(
		@CustomFieldName,
		@CustomFieldDataType,
		@CustomFieldRequired,
		@CustomFieldTypeId
	)

	RETURN scope_identity()
END
RETURN 0');
IF @@ERROR <> 0 SET NOEXEC ON
GO

PRINT 'Creating [dbo].[BugNet_UserCustomField_DeleteCustomField]';
EXEC('CREATE PROCEDURE [dbo].[BugNet_UserCustomField_DeleteCustomField]
	@CustomFieldIdToDelete INT
AS

SET XACT_ABORT ON

BEGIN TRAN
	/*Copied from BugNet_ProjectCustomField_DeleteCustomField but this field not point at BugNet_UserCustomField_DeleteCustomField, the field should be renamed in BugNet_QueryClauses? */
	/*DELETE
	FROM BugNet_QueryClauses
	WHERE CustomFieldId = @CustomFieldIdToDelete*/
	
	DELETE 
	FROM BugNet_UserCustomFieldValues 
	WHERE CustomFieldId = @CustomFieldIdToDelete
	
	DELETE 
	FROM BugNet_UserCustomFields 
	WHERE CustomFieldId = @CustomFieldIdToDelete
COMMIT');
IF @@ERROR <> 0 SET NOEXEC ON
GO

PRINT 'Creating [dbo].[BugNet_UserCustomField_GetCustomFieldById] ';
EXEC('CREATE PROCEDURE [dbo].[BugNet_UserCustomField_GetCustomFieldById] 
	@CustomFieldId Int
AS

SELECT
	Fields.CustomFieldId,
	Fields.CustomFieldName,
	Fields.CustomFieldDataType,
	Fields.CustomFieldRequired,
	'''' CustomFieldValue,
	Fields.CustomFieldTypeId
FROM
	BugNet_UserCustomFields Fields
WHERE
	Fields.CustomFieldId = @CustomFieldId');
IF @@ERROR <> 0 SET NOEXEC ON
GO

PRINT 'Creating [dbo].[BugNet_UserCustomField_GetCustomFields]';
EXEC('CREATE PROCEDURE [dbo].[BugNet_UserCustomField_GetCustomFields] 
AS

SELECT
	Fields.CustomFieldId,
	Fields.CustomFieldName,
	Fields.CustomFieldDataType,
	Fields.CustomFieldRequired,
	'''' CustomFieldValue,
	Fields.CustomFieldTypeId
FROM
	BugNet_UserCustomFields Fields');
IF @@ERROR <> 0 SET NOEXEC ON
GO

PRINT 'Creating [dbo].[BugNet_UserCustomField_GetCustomFieldsByUserId] ';
EXEC('CREATE PROCEDURE [dbo].[BugNet_UserCustomField_GetCustomFieldsByUserId] 
	@UserId UNIQUEIDENTIFIER
AS

SELECT
	Fields.CustomFieldId,
	Fields.CustomFieldName,
	Fields.CustomFieldDataType,
	Fields.CustomFieldRequired,
	ISNULL(CustomFieldValue,'''') CustomFieldValue,
	Fields.CustomFieldTypeId
FROM
	BugNet_UserCustomFields Fields
	LEFT OUTER JOIN BugNet_UserCustomFieldValues FieldValues ON (Fields.CustomFieldId = FieldValues.CustomFieldId AND FieldValues.UserId = @UserId)');
IF @@ERROR <> 0 SET NOEXEC ON
GO

PRINT 'Creating [dbo].[BugNet_UserCustomField_SaveCustomFieldValue]';
EXEC('CREATE PROCEDURE [dbo].[BugNet_UserCustomField_SaveCustomFieldValue]
	@UserId UNIQUEIDENTIFIER,
	@CustomFieldId Int, 
	@CustomFieldValue NVarChar(MAX)
AS
UPDATE 
	BugNet_UserCustomFieldValues 
SET
	CustomFieldValue = @CustomFieldValue
WHERE
	UserId = @UserId
	AND CustomFieldId = @CustomFieldId

IF @@ROWCOUNT = 0
	INSERT BugNet_UserCustomFieldValues
	(
		UserId,
		CustomFieldId,
		CustomFieldValue
	)
	VALUES
	(
		@UserId,
		@CustomFieldId,
		@CustomFieldValue
	)');
IF @@ERROR <> 0 SET NOEXEC ON
GO

PRINT 'Creating [dbo].[BugNet_UserCustomField_UpdateCustomField]';
EXEC('CREATE PROCEDURE [dbo].[BugNet_UserCustomField_UpdateCustomField]
	@CustomFieldId Int,
	@CustomFieldName NVarChar(50),
	@CustomFieldDataType Int,
	@CustomFieldRequired Bit,
	@CustomFieldTypeId Int
AS
UPDATE 
	BugNet_UserCustomFields 
SET
	CustomFieldName = @CustomFieldName,
	CustomFieldDataType = @CustomFieldDataType,
	CustomFieldRequired = @CustomFieldRequired,
	CustomFieldTypeId = @CustomFieldTypeId
WHERE 
	CustomFieldId = @CustomFieldId');
IF @@ERROR <> 0 SET NOEXEC ON
GO

PRINT 'Creating [dbo].[BugNet_UserCustomFieldSelection_CreateNewCustomFieldSelection]';
EXEC('CREATE PROCEDURE [dbo].[BugNet_UserCustomFieldSelection_CreateNewCustomFieldSelection]
	@CustomFieldId INT,
	@CustomFieldSelectionValue NVARCHAR(255),
	@CustomFieldSelectionName NVARCHAR(255)
AS

DECLARE @CustomFieldSelectionSortOrder int
SELECT @CustomFieldSelectionSortOrder = ISNULL(MAX(CustomFieldSelectionSortOrder),0) + 1 FROM BugNet_UserCustomFieldSelections

IF NOT EXISTS(SELECT CustomFieldSelectionId FROM BugNet_UserCustomFieldSelections WHERE CustomFieldId = @CustomFieldId AND LOWER(CustomFieldSelectionName) = LOWER(@CustomFieldSelectionName) )
BEGIN
	INSERT BugNet_UserCustomFieldSelections
	(
		CustomFieldId,
		CustomFieldSelectionValue,
		CustomFieldSelectionName,
		CustomFieldSelectionSortOrder
	)
	VALUES
	(
		@CustomFieldId,
		@CustomFieldSelectionValue,
		@CustomFieldSelectionName,
		@CustomFieldSelectionSortOrder
		
	)

	RETURN scope_identity()
END
RETURN 0');
IF @@ERROR <> 0 SET NOEXEC ON
GO

PRINT 'Creating [dbo].[BugNet_UserCustomFieldSelection_DeleteCustomFieldSelection]';
EXEC('CREATE PROCEDURE [dbo].[BugNet_UserCustomFieldSelection_DeleteCustomFieldSelection]
	@CustomFieldSelectionIdToDelete INT
AS

SET XACT_ABORT ON

DECLARE
	@CustomFieldId INT

SET @CustomFieldId = (SELECT TOP 1 CustomFieldId 
						FROM BugNet_UserCustomFieldSelections 
						WHERE CustomFieldSelectionId = @CustomFieldSelectionIdToDelete)

BEGIN TRAN
	UPDATE BugNet_UserCustomFieldValues
	SET CustomFieldValue = NULL
	WHERE CustomFieldId = @CustomFieldId
							
	DELETE 
	FROM BugNet_UserCustomFieldSelections 
	WHERE CustomFieldSelectionId = @CustomFieldSelectionIdToDelete
COMMIT TRAN');
IF @@ERROR <> 0 SET NOEXEC ON
GO

PRINT 'Creating [dbo].[BugNet_UserCustomFieldSelection_GetCustomFieldSelectionById]';
EXEC('CREATE PROCEDURE [dbo].[BugNet_UserCustomFieldSelection_GetCustomFieldSelectionById] 
	@CustomFieldSelectionId Int
AS


SELECT
	CustomFieldSelectionId,
	CustomFieldId,
	CustomFieldSelectionName,
	rtrim(CustomFieldSelectionValue) CustomFieldSelectionValue,
	CustomFieldSelectionSortOrder
FROM
	BugNet_UserCustomFieldSelections
WHERE
	CustomFieldSelectionId = @CustomFieldSelectionId
ORDER BY CustomFieldSelectionSortOrder');
IF @@ERROR <> 0 SET NOEXEC ON
GO

PRINT 'Creating [dbo].[BugNet_UserCustomFieldSelection_GetCustomFieldSelectionsByCustomFieldId]';
EXEC('CREATE PROCEDURE [dbo].[BugNet_UserCustomFieldSelection_GetCustomFieldSelectionsByCustomFieldId] 
	@CustomFieldId Int
AS


SELECT
	CustomFieldSelectionId,
	CustomFieldId,
	CustomFieldSelectionName,
	rtrim(CustomFieldSelectionValue) CustomFieldSelectionValue,
	CustomFieldSelectionSortOrder
FROM
	BugNet_UserCustomFieldSelections
WHERE
	CustomFieldId = @CustomFieldId
ORDER BY CustomFieldSelectionSortOrder');
IF @@ERROR <> 0 SET NOEXEC ON
GO

PRINT 'Creating [dbo].[BugNet_UserCustomFieldSelection_Update]';
EXEC('CREATE PROCEDURE [dbo].[BugNet_UserCustomFieldSelection_Update]
	@CustomFieldSelectionId INT,
	@CustomFieldId INT,
	@CustomFieldSelectionName NVARCHAR(255),
	@CustomFieldSelectionValue NVARCHAR(255),
	@CustomFieldSelectionSortOrder INT
AS

SET XACT_ABORT ON
SET NOCOUNT ON

DECLARE 
	@OldSortOrder INT,
	@OldCustomFieldSelectionId INT,
	@OldSelectionValue NVARCHAR(255)

SELECT TOP 1 
	@OldSortOrder = CustomFieldSelectionSortOrder,
	@OldSelectionValue = CustomFieldSelectionValue
FROM BugNet_UserCustomFieldSelections 
WHERE CustomFieldSelectionId = @CustomFieldSelectionId

SET @OldCustomFieldSelectionId = (SELECT TOP 1 CustomFieldSelectionId FROM BugNet_UserCustomFieldSelections WHERE CustomFieldSelectionSortOrder = @CustomFieldSelectionSortOrder  AND CustomFieldId = @CustomFieldId)

UPDATE 
	BugNet_UserCustomFieldSelections
SET
	CustomFieldId = @CustomFieldId,
	CustomFieldSelectionName = @CustomFieldSelectionName,
	CustomFieldSelectionValue = @CustomFieldSelectionValue,
	CustomFieldSelectionSortOrder = @CustomFieldSelectionSortOrder
WHERE 
	CustomFieldSelectionId = @CustomFieldSelectionId
	
UPDATE BugNet_UserCustomFieldSelections 
SET CustomFieldSelectionSortOrder = @OldSortOrder
WHERE CustomFieldSelectionId = @OldCustomFieldSelectionId

/* 
	this will not work very well with regards to case sensitivity so
	we only will care if the value is somehow different than the original
*/
IF (@OldSelectionValue != @CustomFieldSelectionValue)
BEGIN
	UPDATE BugNet_UserCustomFieldValues
	SET CustomFieldValue = @CustomFieldSelectionValue
	WHERE CustomFieldId = @CustomFieldId AND CustomFieldValue = @OldSelectionValue
END');
IF @@ERROR <> 0 SET NOEXEC ON
GO

COMMIT TRANSACTION
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

DECLARE @Success AS BIT
SET @Success = 1
SET NOEXEC OFF

IF (@Success = 1) PRINT 'The database update succeeded'
ELSE BEGIN
	IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION
	PRINT 'The database update failed'
END
GO