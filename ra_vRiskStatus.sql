USE [ReliabilityAssessmentDb_DEV]
GO

DROP VIEW [ReliabilityAssessment].[vRiskStatus]
GO

CREATE VIEW [ReliabilityAssessment].[vRiskStatus]
AS
SELECT ReliabilityAssessment.Project.ProjectId AS ProjectID, ReliabilityAssessment.Project.Name AS ProjectName, 
       ReliabilityAssessment.vActiveProjectStatus.Name AS ProjectStatus, COALESCE(Definition.AssessmentRisk.Name, 'NoRisk') AS RiskLevel,

	   CAST(ReliabilityAssessment.Project.LastUpdateDateTimeOffset AS date) AS 'LastUpdateDate',
	   CAST(ReliabilityAssessment.Project.CreateDateTimeOffset AS date) AS 'CreateDate',
	   DATEDIFF(day, ReliabilityAssessment.Project.CreateDateTimeOffset,ReliabilityAssessment.Project.LastUpdateDateTimeOffset) as TimeToCompletAssessment

FROM   ReliabilityAssessment.Project

		   INNER JOIN ReliabilityAssessment.vActiveProjectStatus
		   ON ReliabilityAssessment.Project.StatusId = ReliabilityAssessment.vActiveProjectStatus.ProjectStatusId 

		   LEFT JOIN [Definition].[AssessmentRisk] 
		   ON ([ReliabilityAssessment].[Project].[AssessmentScore] >=[Definition].[AssessmentRisk].[MinValue]
				AND [ReliabilityAssessment].[Project].[AssessmentScore] <=[Definition].[AssessmentRisk].[MaxValue] )
		   OR ([Definition].[AssessmentRisk].[MinValue] is null and [ReliabilityAssessment].[Project].[AssessmentScore] <= [Definition].[AssessmentRisk].[MaxValue])
		   OR ([Definition].[AssessmentRisk].[MaxValue] is null and [ReliabilityAssessment].[Project].[AssessmentScore] >= [Definition].[AssessmentRisk].[MinValue])

GO



