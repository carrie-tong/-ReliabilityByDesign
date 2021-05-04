select  t.projectid as ProejctID, cast(tp.createdon as date) as CreateDate, t. fdleadnetops as Manager, t.englvlnetops as EngagementLevel, t.nextstepnetops as RPPStatus
from [dbo].[vw_tefd_projects_details] t left join [dbo].[vw_tefd_projects] tp
on t.projectid = tp.id
where t. fdleadnetops like 'Stuart%' and (t.englvlnetops like 'Standard%' or t.englvlnetops like  'high%')
and t.nextstepnetops like 'Proceed%'
