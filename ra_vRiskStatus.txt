USE [ReliabilityAssessmentDb_DEV]
GO

/****** Object:  View [ReliabilityAssessment].[vRiskStatus]    Script Date: 15/04/2021 11:53:26 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

DROP VIEW [ReliabilityAssessment].[vRiskStatus]
GO

CREATE VIEW [ReliabilityAssessment].[vRiskStatus]
AS
SELECT ReliabilityAssessment.Project.ProjectId AS ProjectID, ReliabilityAssessment.Project.Name AS ProjectName, Definition.ProjectStatus.Name AS ProjectStatus, Definition.AssessmentRisk.Name AS RiskLevel
FROM   ReliabilityAssessment.Project INNER JOIN
           Definition.ProjectStatus ON ReliabilityAssessment.Project.StatusId = Definition.ProjectStatus.ProjectStatusId CROSS JOIN
           Definition.AssessmentRisk
WHERE (Definition.ProjectStatus.Name = 'Approved') OR
           (Definition.ProjectStatus.Name = 'Conditionally Approved') OR
           (Definition.ProjectStatus.Name = 'Rejected') OR
           (Definition.ProjectStatus.Name = 'Stage 1 complete') OR
           (Definition.ProjectStatus.Name = 'Stage 2 complete')

GO


