param( $dataSource = $(throw "Bitte angeben, ansonsten weiß ich nicht was Sie meinen"), 
$database = $(throw "Bitte angeben, ansonsten weiß ich nicht was Sie meinen"), 
$query = $(throw "Bitte angeben, ansonsten weiß ich nicht was Sie meinen"))
 
$connectionString = "Server=$dataSource;ApplicationIntent=ReadOnly;Database=$database;Integrated Security=True;"
 
 
# Aufbau der Verbindung
$connection = New-Object System.Data.SqlClient.SqlConnection
$connection.ConnectionString = $connectionString
$connection.Open()
$command = $connection.CreateCommand()
$command.CommandText = $query
$command.CommandTimeout = 720
 
# Ausführen der Anweisung
$result = $command.ExecuteReader()
 
# Anzeigen des Ergebnisses
$table = new-object "System.Data.DataTable"
$table.Load($result)

$table
