param( [Parameter(ValueFromPipeline=$true)] $queryFilePath )

exp-sql.ps1 -queryFilePath $queryFilePath -sqlProvider sql-prod.ps1