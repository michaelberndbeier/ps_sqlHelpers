Param([Parameter(ValueFromPipeline=$true)] $queryFile, [switch] $prod, [switch] $sup, [switch] $int, [switch] $tst, [switch] $dev)

if($prod)
{
    exp-prod.ps1 -queryFilePath $queryFile   
}
if($sup)
{
    exp-sup.ps1 -queryFilePath $queryFile   
}
if($int)
{
    exp-int.ps1 -queryFilePath $queryFile   
}
if($tst)
{
    exp-tst.ps1 -queryFilePath $queryFile   
}
if($dev)
{
    exp-dev.ps1 -queryFilePath $queryFile   
}

