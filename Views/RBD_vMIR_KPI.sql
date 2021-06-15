
declare @startdate datetime, @enddate datetime
select @startdate = '20210101', @enddate = getdate()

select count(distinct(mirnumber)) as KPI,
dateadd(day, -datepart(day, cast(m.ImpactMonthDate as date))+1, cast(m.ImpactMonthDate as date)) as MonthYear,
'Total # design-related incidents' as KPIName, 40 as Target
from 
(
SELECT [mirnumber]
--      ,[ServiceName]
--      ,[RootCause]
,min([ImpactMonthDate]) as ImpactMonthDate
     ,sum([impactcount]) as impactcount 
,min([FirstImpactDate]) as FirstImpactDate
  FROM [NuRemedy].[METRICS_MIR].[RBD_vDesignRelatedImpact] n
  group by n.mirnumber
--  order by mirnumber
  ) m
  
 -- [NuRemedy].[METRICS_MIR].[RBD_vDesignRelatedImpact] m
where ImpactMonthDate >= @startdate and ImpactMonthDate<=@enddate
group by m.ImpactMonthDate

union
select avg(impactcount) as KPI,
dateadd(day, -datepart(day, cast(m.ImpactMonthDate as date))+1, cast(m.ImpactMonthDate as date)) as MonthYear,
'Average # customers impacted by design' as KPIName, 350 as Target
from
(
SELECT [mirnumber]
--      ,[ServiceName]
--      ,[RootCause]
,min([ImpactMonthDate]) as ImpactMonthDate
     ,sum([impactcount]) as impactcount 
,min([FirstImpactDate]) as FirstImpactDate
  FROM [NuRemedy].[METRICS_MIR].[RBD_vDesignRelatedImpact] n
  group by n.mirnumber
--    order by mirnumber
  ) m
  --[NuRemedy].[METRICS_MIR].[RBD_vDesignRelatedImpact] m
where ImpactMonthDate >= @startdate and ImpactMonthDate<=@enddate
group by m.ImpactMonthDate

union
select count(distinct case when impactcount>1000 then mirnumber else null end) as KPI,
dateadd(day, -datepart(day, cast(m.ImpactMonthDate as date))+1, cast(m.ImpactMonthDate as date)) as MonthYear,
'Total # design-related incidents with customer impact >1000' as KPIName, 5 as Target
from 
(
SELECT [mirnumber]
--      ,[ServiceName]
--      ,[RootCause]
,min([ImpactMonthDate]) as ImpactMonthDate
     ,sum([impactcount]) as impactcount 
,min([FirstImpactDate]) as FirstImpactDate
  FROM [NuRemedy].[METRICS_MIR].[RBD_vDesignRelatedImpact] n
  group by n.mirnumber
--    order by mirnumber
  ) m
  --[NuRemedy].[METRICS_MIR].[RBD_vDesignRelatedImpact] m
where ImpactMonthDate >= @startdate and ImpactMonthDate<=@enddate
group by m.ImpactMonthDate

order by 3,2,1

