USE [ReliabilityAssessmentDb_DEV]
GO

/****** Object:  View [dbo].[vNumbers]    Script Date: 13/05/2021 2:38:46 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[vNumbers] as
select a.number + b.number + c.number as number
from
( 
select 1 as number
union 
select 2
union
select 3
union
select 4
union
select 5
union
select 6
union
select 7
union
select 8
union
select 9
union
select 10 ) a
cross join
(  
select 10 as number
union
select 0 
union 
select 20
union
select 30
union
select 40
union
select 50
union
select 60
union
select 70
union
select 80
union
select 90 ) b
cross join
(  
select 100 as number
union
select 0
union
select 200
union
select 300
union
select 400
union
select 500
union
select 600
union
select 700
union
select 800
union
select 900 ) c
GO


