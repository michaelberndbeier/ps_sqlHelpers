Param([Parameter(ValueFromPipeline=$true)] $queryFilesFolder, [switch] $prod, [switch] $sup, [switch] $int, [switch] $tst, [switch] $dev)


Get-ChildItem -Path $queryFilesFolder -Filter "*.sql" | 
    Select-Object -ExpandProperty FullName |
    foreach-object { exp-where.ps1 -queryFile $_ -prod:$prod -sup:$sup -int:$int -tst:$tst -dev:$dev }
