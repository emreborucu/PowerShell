Import-Module PSFramework
Import-Module dbatools

Set-DbcConfig policy.backup.logmaxminutes -Value 1440
set-DbcConfig policy.backup.fullmaxdays -Value 11520
set-DbcConfig policy.backup.diffmaxhours -Value 2880

Set-DbcConfig policy.dbcc.maxdays -Value 30 

$categories = "Instance","Server"
$instance = Get-Content -Path "C:\PSScripts\server-list.txt"
$HostName=$instance

$HostName= $instance.Replace("\RETAILSTORE","")


##$exluded_checks = "FKCKTrusted","DisabledIndex","SymmetricKeyEncryptionLevel","AsymmetricKeySize","LogShipping", "QueryStoreEnabled","SqlBrowserServiceAccount"
$exluded_checks = "DatabaseGrowthEvent","IdentityUsage","FKCKTrusted","DuplicateIndex","UnusedIndex","DisabledIndex","SymmetricKeyEncryptionLevel","AsymmetricKeySize","MaintenanceSolution","LogShipping", "QueryStoreEnabled","Agent","SqlBrowserServiceAccount"


$result = Invoke-DbcCheck -SqlInstance $instance -ComputerName $HostName -AllChecks -ExcludeCheck $exluded_checks -PassThru | Convert-DbcResult -Label "LCW_SQLPester_Check"

$result | Write-DbaDataTable -SqlInstance "LCWSUNYONGENDB" -Database "SunucuYonetimGenel" -Table "SQLPester_TestResults" -Schema "dbo"