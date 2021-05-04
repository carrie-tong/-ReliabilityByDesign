USE [ReliabilityAssessmentDb_DEV]
GO

/****** Object:  View [ReliabilityAssessment].[vRisk]    Script Date: 04/05/2021 1:52:49 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
drop view [ReliabilityAssessment].[vRisk]
GO

CREATE VIEW [ReliabilityAssessment].[vRisk] as 

select 'High' as riskcode, 'High Risk' as RiskName, 1 as SortOrder, 14 as OverdueDaysTarget, 0.05 as HighTarget, CONCAT(14, ' days') as DayTargetName, '5%' as HighPercentTargetName, 'n/a' as NoTargetName
		union select 'Med', 'Medium Risk', 2, 8, null, CONCAT(8, ' days'), 'n/a', 'n/a'
		union select 'low', 'Low Risk', 3, 6, null, CONCAT(6, ' days'), 'n/a', 'n/a'
		union select 'norisk', 'No Risk', 4, 6, null, CONCAT(6, ' days'), 'n/a', 'n/a'
GO


