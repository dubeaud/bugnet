-- Reference Data for BugNet_Languages 
MERGE INTO BugNet_Languages AS Target 
USING (VALUES 
	('en-US', 'English (United States)', 'en'),
	('es-ES', 'Spanish (Spain)', 'en-US'),
	('nl-NL', 'Dutch (Netherlands)', 'en-US'),
	('it-IT', 'Italian (Italy)', 'en-US'),
	('ru-RU', 'Russian (Russia)', 'en-US'),
	('ro-RO', 'Romanian (Romania)', 'en-US'),
	('fr-CA', 'French (Canadian)', 'en-US')
) 
AS Source ([CultureCode], [CultureName], [FallbackCulture]) 
ON Target.CultureCode = Source.CultureCode
-- update matched rows 
WHEN MATCHED THEN 
UPDATE SET CultureName = Source.CultureName, FallbackCulture = Source.FallbackCulture
-- insert new rows 
WHEN NOT MATCHED BY TARGET THEN 
INSERT (CultureCode, CultureName, FallbackCulture) 
VALUES (CultureCode, CultureName, FallbackCulture) 
-- delete rows that are in the target but not the source 
WHEN NOT MATCHED BY SOURCE THEN 
DELETE;