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
       select dateadd(month,n.number-1,@startdate) as startmonth, dateadd(month,n.number,@startdate) as endmonth,
              r.*
       from dbo.vnumbers n
       cross join [ReliabilityAssessment].[vRisk] r
       where n.number between 1 and datediff(month,@startdate,@enddate) + 1
       ) b
left join [ReliabilityAssessment].[vRiskStatus] a
on b.startmonth = a.MonthY
and b.riskcode = a.RiskLevel
group by b.startmonth, b.sortorder, b.RiskName
union
-- total assessments
select b.startmonth, 1, 3 as KPISort, 'Total RBD assessments' as KPIName, 
       coalesce(count(distinct a.ProjectID),0) as ProjectCount, 
	   max(b.OverdueDaysTarget) as Target, null as OverTarget, max(b.NoTargetName) as TargetName
from (
       select dateadd(month,n.number-1,@startdate) as startmonth, dateadd(month,n.number,@startdate) as endmonth,
              r.*
       from dbo.vnumbers n
       cross join [ReliabilityAssessment].[vRisk] r
       where n.number between 1 and datediff(month,@startdate,@enddate) + 1
       ) b
left join [ReliabilityAssessment].[vRiskStatus] a
on b.startmonth = a.MonthY
and b.riskcode = a.RiskLevel
group by b.startmonth
union
-- % high risk
select b.startmonth, 1, 1 as KPISort, '% HIGH Risk assessments' as KPIName, 
       sum(case when a.RiskLevel = 'HIGH' then 1 else 0 end)/(count(*)*1.0) as ProjectCount, 
	   max(b.HighTarget) as Target, 
	   case when sum(case when a.RiskLevel = 'HIGH' then 1 else 0 end)/(count(*)*1.0)> 0.05 then 1 else 0 end as OverTarget, 
	   min(b.HighPercentTargetName) as TargetName
from (
       select dateadd(month,n.number-1,@startdate) as startmonth, dateadd(month,n.number,@startdate) as endmonth,
              r.*
       from dbo.vnumbers n
       cross join [ReliabilityAssessment].[vRisk] r
       where n.number between 1 and datediff(month,@startdate,@enddate) + 1
       ) b
left join [ReliabilityAssessment].[vRiskStatus] a
on b.startmonth = a.MonthY
group by b.startmonth
union
-- time to complete days
select b.startmonth, b.sortorder, 4 as KPISort, b.RiskName + + ' Time to complete AVG' as KPILabel, 
       avg(a.TimeToCompletAssessment) as ProjectCount, 
	   avg(case when b.sortorder = 1 then 14 when b.sortorder = 2 then 8 else 6 end) as Target, 
	   case when avg(a.TimeToCompletAssessment) > avg(case when b.sortorder = 1 then 14 when b.sortorder = 2 then 8 else 6 end) then 1 else 0 end as OverTarget,
	   max(b.DayTargetName) as TargetName
from (
       select dateadd(month,n.number-1,@startdate) as startmonth, dateadd(month,n.number,@startdate) as endmonth,
              r.*
       from dbo.vnumbers n
       cross join [ReliabilityAssessment].[vRisk] r
       where n.number between 1 and datediff(month,@startdate,@enddate) + 1
       ) b
left join [ReliabilityAssessment].[vRiskStatus] a
on b.startmonth = a.MonthY
and b.riskcode = a.RiskLevel
group by b.startmonth, b.RiskName, b.SortOrder

union
-- time to complete  total average days
select b.startmonth, 1, 5 as KPISort,  'Average RBD Cycle Time' as KPILabel, 
       avg(a.TimeToCompletAssessment) as KPIValue, 
	   avg(9) as Target, 
	   case when avg(a.TimeToCompletAssessment)*1.0 <= 9 then 0 else 1 end as OverTarget,
	   max(b.DayTargetName) as TargetName
from (
       select dateadd(month,n.number-1,@startdate) as startmonth, dateadd(month,n.number,@startdate) as endmonth,
              r.*
       from dbo.vnumbers n
       cross join [ReliabilityAssessment].[vRisk] r
       where n.number between 1 and datediff(month,@startdate,@enddate) + 1
       ) b
left join [ReliabilityAssessment].[vRiskStatus] a
on b.startmonth = a.MonthY
and b.riskcode = a.RiskLevel
group by b.startmonth
order by 1, 3, 2, 4, 5,6, 7, 8
