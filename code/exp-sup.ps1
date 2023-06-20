param( [Parameter(ValueFromPipeline=$true)] $queryFilePath )

exp-sql.ps1 -queryFilePath $queryFilePath -sqlProvider sql-sup.ps1