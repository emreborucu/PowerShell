$instance = Get-Content -Path "C:\PSScripts\server-list.txt"


Invoke-DbaQuery -SqlInstance $instance -Database "master" -File "C:\PSScripts\query.txt"
