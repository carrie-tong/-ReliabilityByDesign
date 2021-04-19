USE [ReliabilityAssessmentDb_DEV]
GO

--DROP VIEW [ReliabilityAssessment].[vRiskStatus]
--GO

CREATE VIEW [ReliabilityAssessment].[vRiskStatus]
AS
SELECT ReliabilityAssessment.Project.ProjectId AS ProjectID, ReliabilityAssessment.Project.Name AS ProjectName, 
       Definition.ProjectStatus.Name AS ProjectStatus, COALESCE(Definition.AssessmentRisk.Name, 'NULL') AS RiskLevel,

	   CAST(ReliabilityAssessment.Project.LastUpdateDateTimeOffset AS date) AS 'LastUpdateDate',
	   CAST(ReliabilityAssessment.Project.CreateDateTimeOffset AS date) AS 'CreateDate',
	   DATEDIFF(day, ReliabilityAssessment.Project.CreateDateTimeOffset,ReliabilityAssessment.Project.LastUpdateDateTimeOffset) as TimeToCompletAssessment

FROM   ReliabilityAssessment.Project
		   INNER JOIN Definition.ProjectStatus 
		   ON ReliabilityAssessment.Project.StatusId = Definition.ProjectStatus.ProjectStatusId 

		   LEFT JOIN [Definition].[AssessmentRisk] 
		   ON ([ReliabilityAssessment].[Project].[AssessmentScore] >=[Definition].[AssessmentRisk].[MinValue]
				AND [ReliabilityAssessment].[Project].[AssessmentScore] <=[Definition].[AssessmentRisk].[MaxValue] )
		   OR ([Definition].[AssessmentRisk].[MinValue] is null and [ReliabilityAssessment].[Project].[AssessmentScore] <= [Definition].[AssessmentRisk].[MaxValue])
		   OR ([Definition].[AssessmentRisk].[MaxValue] is null and [ReliabilityAssessment].[Project].[AssessmentScore] >= [Definition].[AssessmentRisk].[MinValue])
		  
WHERE (Definition.ProjectStatus.Name = 'Approved') OR
           (Definition.ProjectStatus.Name = 'Conditionally Approved') OR
           (Definition.ProjectStatus.Name = 'Rejected') OR
           (Definition.ProjectStatus.Name = 'Stage 1 complete') OR
           (Definition.ProjectStatus.Name = 'Stage 2 complete')

GO



