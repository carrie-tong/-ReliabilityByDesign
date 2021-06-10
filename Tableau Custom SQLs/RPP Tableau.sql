select  cast(t.projectid as varchar(10)) as RppID, cast(tp.createdon as date) as CreateDate, 
        t. fdleadnetops as [NetOps Lead], t.englvlnetops as [NetOps Engagement Level], t.nextstepnetops as RPPStatus,
        t. fdleadrel as [Reliability Lead], t.englvlrel as [Reliability Engagement Level], t.nextsteprel as [Reliability RPP Status],
        dateadd(day, -datepart(day, cast(tp.createdon as date))+1, cast(tp.createdon as date)) as Month, tp.submitter_name as Submitter, tp.name as RPPName, t.decision as Decision
		---t.primenetops as [NetOps Prime]
from [dbo].[vw_tefd_projects_details] t left join [dbo].[vw_tefd_projects] tp
on t.projectid = tp.id
where (t. fdleadnetops like 'Stuart%' and (t.englvlnetops like 'Standard%' or t.englvlnetops like  'high%')
and t.nextstepnetops like 'Proceed%' and (tp.createdon >= '2021-01-01' and tp.createdon < '2021-04-30')and t.decision = 'Proceed')
OR
(t. fdleadrel like 'Stuart%' and (t.englvlrel like 'Standard%' or t.englvlrel like  'high%')
and t.nextsteprel like 'Proceed%' and (tp.createdon >= '2021-04-30')and t.decision = 'Proceed' )

