

Import-Module PSFramework
Import-Module dbatools



$categories = "Instance","Server"
$instance = Get-Content -Path "C:\PSScripts\server-list.txt"
$HostName=$instance

$HostName= $instance.Replace("\AXAPTA","")

Set-DbaPowerPlan -ComputerName $HostName -PowerPlan 'High Performance'
Set-DbaSpConfigure -SqlInstance $instance -Name 'DefaultBackupCompression' -Value 1
Set-DbaSpConfigure -SqlInstance $instance -Name 'RemoteDacConnectionsEnabled' -Value 1
Set-DbaSpConfigure -SqlInstance $instance -Name 'MaxDegreeOfParallelism' -Value 1
Set-DbaSpConfigure -SqlInstance $instance -Name 'OptimizeAdhocWorkloads' -Value 1


