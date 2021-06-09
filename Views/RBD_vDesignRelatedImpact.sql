



SELECT [mirnumber]
      ,[ServiceName]
      ,[RootCause]
      ,[ImpactMonthDate]
      ,[impactcount]
      ,[FirstImpactDate]
  FROM [NuRemedy].[METRICS_MIR].[vMajorIncidentSeriveSummary] n

  EXCEPT 

  SELECT [mirnumber]
      ,[ServiceName]
      ,[RootCause]
      ,[ImpactMonthDate]
      ,[impactcount]
      ,[FirstImpactDate]
  FROM [NuRemedy].[METRICS_MIR].[vMajorIncidentSeriveSummary] n
  WHERE n.ServiceName = 'Change' 
        or n.ServiceName ='External Event' 
		or n.ServiceName ='No Root Cause'
		or n.ServiceName = 'Process'
		or n.ServiceName = 'Release'
		or n.ServiceName = ' '
		or n.ServiceName = 'Under Invesitigation'
		or n.ServiceName = 'Other'

		or n.RootCause = 'Building'
		or n.RootCause = 'Environment'
		or n.RootCause = 'Loss Of Redundancy'
		or n.RootCause = ' '
		or n.RootCause = 'No Service Impact'
		or n.RootCause = 'Not Yet Classified'
		or n.RootCause = 'Service TBD'
		or n.RootCause =  'No Root Cause Found'


