USE [ReliabilityAssessmentDb_DEV]
GO

DECLARE	@return_value int

EXEC	@return_value = [ReliabilityAssessment].[RbdDashboard]

SELECT	'Return Value' = @return_value

GO
