param( [Parameter(ValueFromPipeline=$true)] $queryFilePath,
    [string]$sqlProvider,
 $exportFolderPath= ".\data"
 )

 $queryFile = get-item $queryFilePath -ErrorAction Stop
 $query = $queryFile | cat -raw

 $regex = "-\w*"
 $regexMatch = [Regex]::Match($sqlProvider, $regex)
 $queryDB = $regexMatch.Value -replace '-' 

 

 $exportFolder = get-item $exportFolderPath -ErrorAction Stop

 $dateTimeSuffix = get-date -Format "yyyyMMdd_hhmm"
 $resultFileName = $queryFile.BaseName + '_' + $queryDB + "_" + $dateTimeSuffix + '.csv'
 $exportFile = Join-Path -path $exportFolderPath -ChildPath $resultFileName
 
 Function Pass_Through {
Param(
    [string]$Cmd,
    [string]$Arguments
)
 Process{[scriptblock]::Create("`$input|$cmd $arguments").Invoke()}

}

$result = $query | Pass_Through -Cmd $sqlProvider -Arguments '' 

if($result -ne "")
{
    $result | Export-Csv -NoTypeInformation -UseCulture -Encoding Default -Path $exportFile
}
 
