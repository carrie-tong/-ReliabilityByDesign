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
FROM     Definition.ProjectStatus ps
WHERE (ps.Name = 'Approved') OR
           (ps.Name = 'Conditionally Approved') OR
           (ps.Name = 'Rejected') OR
           (ps.Name = 'Stage 1 complete') OR
           (ps.Name = 'Stage 2 complete')
GO




