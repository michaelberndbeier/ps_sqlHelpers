param(
 [Parameter(ValueFromPipeline=$true)]
 $query)
$dataSource = "someServer\someInstance"
$database = "someDEVDB"
 
sql-readOnly.ps1 $dataSource $database $query
