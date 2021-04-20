USE [ReliabilityAssessmentDb_DEV]
GO

/****** Object:  View [ReliabilityAssessment].[v_ActiveProjectStatus]    Script Date: 20/04/2021 11:23:13 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [ReliabilityAssessment].[vActiveProjectStatus]
AS
SELECT ProjectStatusId, Name
FROM     Definition.ProjectStatus
WHERE (Definition.ProjectStatus.Name = 'Approved') OR
           (Definition.ProjectStatus.Name = 'Conditionally Approved') OR
           (Definition.ProjectStatus.Name = 'Rejected') OR
           (Definition.ProjectStatus.Name = 'Stage 1 complete') OR
           (Definition.ProjectStatus.Name = 'Stage 2 complete')
GO




