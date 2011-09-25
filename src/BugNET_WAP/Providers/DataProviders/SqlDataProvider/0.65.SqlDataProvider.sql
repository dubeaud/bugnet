CREATE TABLE [dbo].[RelatedBug] (
	[RelatedBugID] [int] IDENTITY (1, 1) NOT NULL ,
	[BugID] [int] NOT NULL ,
	[LinkedBugID] [int] NOT NULL 
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[RelatedBug] ADD 
	CONSTRAINT [PK_BugRelation] PRIMARY KEY  CLUSTERED 
	(
		[RelatedBugID]
	)  ON [PRIMARY] 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE BugNet_RelatedBug_CreateNewRelatedBug
	@BugId Int,
	@LinkedBugId int
AS
IF NOT EXISTS( SELECT RelatedBugId FROM RelatedBug WHERE @BugId = @BugId  AND LinkedBugId = @LinkedBugId)
BEGIN
	INSERT RelatedBug
	(
		BugId,
		LinkedBugId
	)
	VALUES
	(
		@BugId,
		@LinkedBugId
	)
	INSERT RelatedBug
	(
		BugId,
		LinkedBugId
	)
	VALUES
	(
		@LinkedBugId,
		@BugId
	)
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE BugNet_RelatedBug_DeleteRelatedBug
	@BugId Int,
	@LinkedBugId int
AS
DELETE 
	RelatedBug
WHERE
	BugId =  @BugId AND
	LinkedBugId = @LinkedBugId
DELETE 
	RelatedBug
WHERE
	BugId = @LinkedBugId AND
	LinkedBugId = @BugId
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE BugNet_RelatedBug_GetRelatedBugsByBugId
	@BugId int
As
Select * from BugsView join RelatedBug on BugsView.BugId = RelatedBug.LinkedBugId
WHERE RelatedBug.BugId = @BugId
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

