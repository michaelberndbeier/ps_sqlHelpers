param(
 [Parameter(ValueFromPipeline=$true)]
 $query)
$dataSource = "someServer\someInstance"
$database = "somePRODDB"

sql-readOnly.ps1 $dataSource $database $query
