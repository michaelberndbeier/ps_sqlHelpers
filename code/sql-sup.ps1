param(
 [Parameter(ValueFromPipeline=$true)]
 $query )
$dataSource = "someServer\someInstance"
$database = "someSUPDB"
 
sql-readOnly.ps1 $dataSource $database $query
