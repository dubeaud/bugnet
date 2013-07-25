-- Reference Data for BugNet_ProjectCustomFieldTypes
SET IDENTITY_INSERT BugNet_ProjectCustomFieldTypes ON 
GO 

MERGE INTO BugNet_ProjectCustomFieldTypes AS Target 
USING (VALUES 
   (1, N'Text'),
   (2, N'Drop Down List'),
   (3, N'Date'),
   (4, N'Rich Text'),
   (5, N'Yes / No'),
   (6, N'User List')
) 
AS Source (CustomFieldTypeId, CustomFieldTypeName) 
ON Target.CustomFieldTypeId = Source.CustomFieldTypeId
-- update matched rows 
WHEN MATCHED THEN 
UPDATE SET CustomFieldTypeName = Source.CustomFieldTypeName 
-- insert new rows 
WHEN NOT MATCHED BY TARGET THEN 
INSERT (CustomFieldTypeId, CustomFieldTypeName) 
VALUES (CustomFieldTypeId, CustomFieldTypeName) 
-- delete rows that are in the target but not the source 
WHEN NOT MATCHED BY SOURCE THEN 
DELETE;

SET IDENTITY_INSERT BugNet_ProjectCustomFieldTypes OFF 
GO 


