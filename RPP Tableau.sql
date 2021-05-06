select  cast(t.projectid as varchar(10)) as RppID, cast(tp.createdon as date) as CreateDate, t. fdleadnetops as NetOpsLead, t.englvlnetops as EngagementLevel, t.nextstepnetops as RPPStatus,
dateadd(day, -datepart(day, cast(tp.createdon as date))+1, cast(tp.createdon as date)) as Month
from [dbo].[vw_tefd_projects_details] t left join [dbo].[vw_tefd_projects] tp
on t.projectid = tp.id
where t. fdleadnetops like 'Stuart%' and (t.englvlnetops like 'Standard%' or t.englvlnetops like  'high%')
and t.nextstepnetops like 'Proceed%'
