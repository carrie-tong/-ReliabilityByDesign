



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
  WHERE n.RootCause = 'Change' 
        or n.RootCause ='External Event' 
		or n.RootCause ='No Root Cause'
		or n.RootCause = 'Process'
		or n.RootCause = 'Release'
		or n.RootCause = ' '
		or n.RootCause = 'Under Invesitigation'
		or n.RootCause = 'Other'

		or n.ServiceName = 'Building'
		or n.ServiceName = 'Environment'
		or n.ServiceName = 'Loss Of Redundancy'
		or n.ServiceName = ' '
		or n.ServiceName = 'No Service Impact'
		or n.ServiceName = 'Not Yet Classified'
		or n.ServiceName = 'Service TBD'
		or n.ServiceName =  'No Root Cause Found'


