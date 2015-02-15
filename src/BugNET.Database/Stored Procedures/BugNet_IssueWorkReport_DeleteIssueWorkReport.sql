CREATE PROCEDURE [dbo].[BugNet_IssueWorkReport_DeleteIssueWorkReport]
	@IssueWorkReportId int
AS
DELETE 
	BugNet_IssueWorkReports
WHERE
	IssueWorkReportId = @IssueWorkReportId
