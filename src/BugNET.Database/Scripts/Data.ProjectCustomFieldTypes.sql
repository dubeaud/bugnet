-- Reference Data for ProjectCustomFieldTypes
MERGE INTO ProjectCustomFieldTypes AS Target 
USING (VALUES 
   (1, N'Text'),
   (2, N'Drop Down List'),
   (3, N'Date'),
   (4, N'Rich Text'),
   (5, N'Yes / No'),
   (6, N'User List')
) 
AS Source (ProjectCustomFieldTypeId, CustomFieldTypeName) 
ON Target.ProjectCustomFieldTypeId = Source.ProjectCustomFieldTypeId 
-- update matched rows 
WHEN MATCHED THEN 
UPDATE SET CustomFieldTypeName = Source.CustomFieldTypeName 
-- insert new rows 
WHEN NOT MATCHED BY TARGET THEN 
INSERT (ProjectCustomFieldTypeId, CustomFieldTypeName) 
VALUES (ProjectCustomFieldTypeId, CustomFieldTypeName) 
-- delete rows that are in the target but not the source 
WHEN NOT MATCHED BY SOURCE THEN 
DELETE;

