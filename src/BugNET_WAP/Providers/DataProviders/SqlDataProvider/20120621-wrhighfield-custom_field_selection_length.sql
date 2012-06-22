IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[BugNet_ProjectCustomFieldSelection_CreateNewCustomFieldSelection]') AND type in (N'P', N'PC'))
DROP PROCEDURE [BugNet_ProjectCustomFieldSelection_CreateNewCustomFieldSelection]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[BugNet_ProjectCustomFieldSelection_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [BugNet_ProjectCustomFieldSelection_Update]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [BugNet_ProjectCustomFieldSelection_CreateNewCustomFieldSelection]
	@CustomFieldId INT,
	@CustomFieldSelectionValue NVARCHAR(255),
	@CustomFieldSelectionName NVARCHAR(255)
AS

DECLARE @CustomFieldSelectionSortOrder int
SELECT @CustomFieldSelectionSortOrder = ISNULL(MAX(CustomFieldSelectionSortOrder),0) + 1 FROM BugNet_ProjectCustomFieldSelections

IF NOT EXISTS(SELECT CustomFieldSelectionId FROM BugNet_ProjectCustomFieldSelections WHERE CustomFieldId = @CustomFieldId AND LOWER(CustomFieldSelectionName) = LOWER(@CustomFieldSelectionName) )
BEGIN
	INSERT BugNet_ProjectCustomFieldSelections
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
RETURN 0


GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [BugNet_ProjectCustomFieldSelection_Update]
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
FROM BugNet_ProjectCustomFieldSelections 
WHERE CustomFieldSelectionId = @CustomFieldSelectionId

SET @OldCustomFieldSelectionId = (SELECT TOP 1 CustomFieldSelectionId FROM BugNet_ProjectCustomFieldSelections WHERE CustomFieldSelectionSortOrder = @CustomFieldSelectionSortOrder  AND CustomFieldId = @CustomFieldId)

UPDATE 
	BugNet_ProjectCustomFieldSelections
SET
	CustomFieldId = @CustomFieldId,
	CustomFieldSelectionName = @CustomFieldSelectionName,
	CustomFieldSelectionValue = @CustomFieldSelectionValue,
	CustomFieldSelectionSortOrder = @CustomFieldSelectionSortOrder
WHERE 
	CustomFieldSelectionId = @CustomFieldSelectionId
	
UPDATE BugNet_ProjectCustomFieldSelections 
SET CustomFieldSelectionSortOrder = @OldSortOrder
WHERE CustomFieldSelectionId = @OldCustomFieldSelectionId

/* 
	this will not work very well with regards to case sensitivity so
	we only will care if the value is somehow different than the original
*/
IF (@OldSelectionValue != @CustomFieldSelectionValue)
BEGIN
	UPDATE BugNet_ProjectCustomFieldValues
	SET CustomFieldValue = @CustomFieldSelectionValue
	WHERE CustomFieldId = @CustomFieldId
END

GO

BEGIN TRANSACTION
SET QUOTED_IDENTIFIER ON
SET ARITHABORT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.BugNet_ProjectCustomFieldSelections
	DROP CONSTRAINT FK_BugNet_ProjectCustomFieldSelections_BugNet_ProjectCustomFields
GO
COMMIT

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BugNet_ProjectCustomFieldSelections
	DROP CONSTRAINT DF_BugNet_ProjectCustomFieldSelections_CustomFieldSelectionSortOrder
GO
CREATE TABLE dbo.Tmp_BugNet_ProjectCustomFieldSelections
	(
	CustomFieldSelectionId int NOT NULL IDENTITY (1, 1),
	CustomFieldId int NOT NULL,
	CustomFieldSelectionValue nvarchar(255) NOT NULL,
	CustomFieldSelectionName nvarchar(255) NOT NULL,
	CustomFieldSelectionSortOrder int NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_BugNet_ProjectCustomFieldSelections ADD CONSTRAINT
	DF_BugNet_ProjectCustomFieldSelections_CustomFieldSelectionSortOrder DEFAULT ((0)) FOR CustomFieldSelectionSortOrder
GO
SET IDENTITY_INSERT dbo.Tmp_BugNet_ProjectCustomFieldSelections ON
GO
IF EXISTS(SELECT * FROM dbo.BugNet_ProjectCustomFieldSelections)
	 EXEC('INSERT INTO dbo.Tmp_BugNet_ProjectCustomFieldSelections (CustomFieldSelectionId, CustomFieldId, CustomFieldSelectionValue, CustomFieldSelectionName, CustomFieldSelectionSortOrder)
		SELECT CustomFieldSelectionId, CustomFieldId, CONVERT(nvarchar(255), CustomFieldSelectionValue), CONVERT(nvarchar(255), CustomFieldSelectionName), CustomFieldSelectionSortOrder FROM dbo.BugNet_ProjectCustomFieldSelections WITH (HOLDLOCK TABLOCKX)')
GO
SET IDENTITY_INSERT dbo.Tmp_BugNet_ProjectCustomFieldSelections OFF
GO
DROP TABLE dbo.BugNet_ProjectCustomFieldSelections
GO
EXECUTE sp_rename N'dbo.Tmp_BugNet_ProjectCustomFieldSelections', N'BugNet_ProjectCustomFieldSelections', 'OBJECT' 
GO
ALTER TABLE dbo.BugNet_ProjectCustomFieldSelections ADD CONSTRAINT
	PK_BugNet_ProjectCustomFieldSelections PRIMARY KEY CLUSTERED 
	(
	CustomFieldSelectionId
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.BugNet_ProjectCustomFieldSelections ADD CONSTRAINT
	FK_BugNet_ProjectCustomFieldSelections_BugNet_ProjectCustomFields FOREIGN KEY
	(
	CustomFieldId
	) REFERENCES dbo.BugNet_ProjectCustomFields
	(
	CustomFieldId
	) ON UPDATE  NO ACTION 
	 ON DELETE  CASCADE 
	
GO
COMMIT
GO

UPDATE BugNet_ProjectCustomFieldSelections
SET CustomFieldSelectionValue = RTRIM(LTRIM(CustomFieldSelectionValue)),
	CustomFieldSelectionName = RTRIM(LTRIM(CustomFieldSelectionName))