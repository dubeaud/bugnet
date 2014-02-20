
/**********************************************************************/
/* CreateUser.SQL */
/* Creates a user and makes the user a member of db roles */
/* This script runs against the User database */
/* Supports SQL Server and SQL AZURE */
/**********************************************************************/


-- Create database user and map to login

CREATE USER PlaceholderForDbUsername FOR LOGIN PlaceholderForDbUsername;
GO
EXEC sp_addrolemember 'db_owner', PlaceholderForDbUsername;
GO