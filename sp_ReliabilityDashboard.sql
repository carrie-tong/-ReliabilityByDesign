USE [ReliabilityAssessmentDb_DEV]
GO
/****** Object:  StoredProcedure [ReliabilityAssessment].[ReliabilityDashboard]    Script Date: 19/04/2021 5:10:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [ReliabilityAssessment].[ReliabilityDashboard]
as
begin

	select *
	from [ReliabilityAssessment].[vRiskStatus]

end