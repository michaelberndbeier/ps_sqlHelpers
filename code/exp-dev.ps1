param( [Parameter(ValueFromPipeline=$true)] $queryFilePath )

exp-sql.ps1 -queryFilePath $queryFilePath -sqlProvider sql-dev.ps1