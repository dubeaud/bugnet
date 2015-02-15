/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/

PRINT 'Adding look up data'
:r .\Data.Permissions.sql

:r .\Data.ProjectCustomFieldTypes.sql

:r .\Data.RequiredFieldList.sql

:r .\Data.Languages.sql

:r .\Data.HostSettings.sql

:r .\Data.Roles.sql