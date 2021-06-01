/*

% HIGH risk assessment
# HIGH RBD assessments
# MEDIUM RBD assessments
# LOW RBD assessments
# NO-RISK RBD assessments
Total RBD assessments
Time to complete assessment - HIGH
Time to complete assessment - MEDIUM
Time to complete assessment - LOW
Time to complete assessment - NO-RISK

*/
declare @startdate datetime, @enddate datetime

select @startdate = '20210101', @enddate = getdate()

-- assessments for each risk level
select b.startmonth, b.sortorder, 2 as KPISort, b.RiskName + ' RBD assessments' as KPIName, 
       coalesce(count(distinct a.ProjectID),0) as KPIValue, 
	   null as Target, null as OverTarget, max(b.NoTargetName) as TargetName
from (

SELECT n.[mirnumber]
      ,[ServiceName]
      ,[RootCause]
      ,[ImpactMonthDate]
      ,[impactcount]
      ,[FirstImpactDate]
  FROM [NuRemedy].[METRICS_MIR].[vMajorIncidentSeriveSummary] n