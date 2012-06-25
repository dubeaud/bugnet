SELECT 

DECLARE @States nvarchar(max)
 SELECT @States =
   STUFF(
   (
     select distinct ',[' + S.StateProvinceCode + ']'
     from BUGNET
     inner join Person.StateProvince S
       on s.StateProvinceID = A.StateProvinceID
     for xml path('')
   ),
   1,1,'')

SELECT     
	i.IssueId, 
	i.ProjectId,
	CF_41.CustomFieldValue AS [Environment], 
	CF_42.CustomFieldValue AS [Special Date],
	CF_43.CustomFieldValue AS [Form]
FROM  BugNet_Issues AS i 
LEFT JOIN BugNet_ProjectCustomFields AS CF_41 ON i.IssueId = CF_41.IssueId 
LEFT JOIN BugNet_ProjectCustomFields AS CF_42 ON i.IssueId = CF_42.IssueId
LEFT JOIN BugNet_ProjectCustomFields AS CF_43 ON i.IssueId = CF_43.IssueId
WHERE (1 = 1) AND (CF_41.CustomFieldId = 41) AND (CF_42.CustomFieldId = 42) AND (CF_43.CustomFieldId = 43)

ALTER VIEW dbo.BugNet_IssueCustomFields_96
AS
SELECT 
	IssueId,
	ISNULL([Environment], '') AS [Environment],
	ISNULL([Special Date], '') AS [Special Date],
	ISNULL([Form], '') AS [Form]
FROM
(
	SELECT 
		pcfv.IssueId,
		pcf.CustomFieldName,
		ISNULL(pcfv.CustomFieldValue, '') AS CustomFieldValue
	FROM BugNet_ProjectCustomFields pcf
	INNER JOIN BugNet_ProjectCustomFieldValues pcfv ON pcf.CustomFieldId = pcfv.CustomFieldId
) data
PIVOT
(
	MAX(CustomFieldValue)
	FOR CustomFieldName
	IN ([Environment], [Special Date], [Form])
) pv

select *
from 
(
	select
		A.AddressID,
		S.StateProvinceCode
	from Person.Address A
	inner join Person.StateProvince S on s.StateProvinceID = A.StateProvinceID
 ) Data
 PIVOT (
   Count(AddressID)
   FOR StateProvinceCode
   IN (
     ' + @States + '
   )
 ) PivotTable