Import-Module PSFramework
Import-Module dbatools

$categories = "Instance","Server"
$instance = "DEVCOMMONTR"
##$instance = Get-Content -Path "C:\PSScripts\server-list.txt"

$exluded_checks = "IdentityUsage","FKCKTrusted","DuplicateIndex","UnusedIndex","DisabledIndex","SymmetricKeyEncryptionLevel","AsymmetricKeySize","MaintenanceSolution","LogShipping", "QueryStoreEnabled","Agent","DatabaseCollation","InValidDatabaseOwner","SqlBrowserServiceAccount"

$result = Invoke-DbcCheck -SqlInstance $instance -ComputerName $instance -AllChecks -ExcludeCheck $exluded_checks -PassThru | Convert-DbcResult -Label "LCW_SQLPester_Check"

$result | Write-DbaDataTable -SqlInstance "LCWSUNYONGENDB" -Database "SunucuYonetimGenel" -Table "SQLPester_TestResults" -Schema "dbo"