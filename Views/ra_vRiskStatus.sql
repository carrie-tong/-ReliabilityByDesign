USE ReliabilityAssessmentDb
GO

DROP VIEW ReliabilityAssessment.vRiskStatus
GO

CREATE VIEW ReliabilityAssessment.vRiskStatus
AS
SELECT p.ProjectId AS ProjectID, p.Name AS ProjectName, 
       vp.Name AS ProjectStatus, COALESCE(a.Name, 'NoRisk') AS RiskLevel, p.AssessmentScore as AssessmentScore, p.RppNumber,

	   CAST(p.LastUpdateDateTimeOffset AS date) AS LastUpdateDate,
	   CAST(p.CreateDateTimeOffset AS date) AS CreateDate,
	   DATEDIFF(day, p.CreateDateTimeOffset,p.LastUpdateDateTimeOffset) as TimeToCompletAssessment,

	   --CAST(DATEADD(MONTH, DATEDIFF(MONTH, 0, p.CreateDateTimeOffset), 0)AS date) AS YearMonth,
       dateadd(day, -datepart(day, cast(p.CreateDateTimeOffset as date))+1, cast(p.CreateDateTimeOffset as date)) as MonthY
	   
FROM   ReliabilityAssessment.Project p

		   INNER JOIN ReliabilityAssessment.vActiveProjectStatus vp
		   ON p.StatusId = vp.ProjectStatusId 

		   LEFT JOIN Definition.AssessmentRisk a
		   ON (p.AssessmentScore >=a.MinValue
				AND p.AssessmentScore <=a.MaxValue )
		   OR (a.MinValue is null and p.AssessmentScore <= a.MaxValue)
		   OR (a.MaxValue is null and p.AssessmentScore >= a.MinValue)

GO
--



