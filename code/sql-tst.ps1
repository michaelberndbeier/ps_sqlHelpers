param(
 [Parameter(ValueFromPipeline=$true)]
 $query)
$dataSource = "someServer\someInstance"
$database = "someTSTDB"
 
sql-readOnly.ps1 $dataSource $database $query
