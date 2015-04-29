SELECT 'ALTER TABLE [' + DEMO.[Schema] + '].[' + DEMO.TableName + '] DROP COLUMN [timestamp]'
	 FROM
(SELECT
       p.name AS [PublicationName],
	   a.objid AS	[ObjectID],
	   ss.name AS [Schema],
	   st.name AS [TableName],
	   sc.name AS [ColumnName],
	   sty.name AS [DataType]

	   
	FROM dbo.syspublications p
		INNER JOIN dbo.sysarticles a ON  a.pubid = p.pubid
		INNER JOIN  sys.tables st ON st.object_id = a.objid
		INNER JOIN sys.schemas ss ON ss.schema_id = st.schema_id
		INNER JOIN sys.columns sc ON sc.object_id = a.objid
		INNER JOIN sys.types sty ON sty.system_type_id = sc.system_type_id
		 
		
				) AS DEMO

	WHERE 
		demo.ObjectID NOT IN (SELECT object_ID FROM sys.columns SC
		INNER JOIN SYS.types sty ON sty.system_type_id = sc.system_type_id
		WHERE sty.name = 'timestamp')

		GROUP BY DEMO.[Schema],DEMO.TableName