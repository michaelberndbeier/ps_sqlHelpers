param(
 [Parameter(ValueFromPipeline=$true)]
 $query)
$dataSource = "someServer\someInstance"
$database = "someINTDB"
 
sql-readOnly.ps1 $dataSource $database $query
