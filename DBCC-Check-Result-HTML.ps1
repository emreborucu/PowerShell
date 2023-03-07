clear
$html_template = "<!DOCTYPE html><html><head><title>Database Consistency Check</title>
<style>
body {
    font-family: Arial, Helvetica, sans-serif;
    font-size:12px;
    color: #222;
}
table {    
    border-top: solid 5px #009BA8;
}
table, th, td {
    border-collapse: collapse;
    border-bottom: solid 1px #999;
    border-left: solid 1px #999;
    border-right: solid 1px #999;
    color: black;
}
table th {
    background-color:#f2f2f2;
    padding: 6px 4px;
    text-align:left;
}
table tr {
    line-height: auto;
}
table td{
    font-size: 12px;
    padding: 4px 20px 4px 4px;
    text-align: left;
}
i {font-size: 10px;}</style></head><body>"

$db_name = "RESTORE_Traceparser", "RESTORE_HR_Compensation", "RESTORE_SyncHQ", "RESTORE_TEMAIK", "RESTORE_Retail", "RESTORE_HR_CompensationFlow"

$db_name.ForEach{
    Write-Host $_
    $result = Invoke-DbaQuery -SqlInstance "LCWDBATEST" -Database "master" -Query "DBCC CHECKDB ([$($_)]) WITH MAXDOP = 8, TABLOCK, ALL_ERRORMSGS, TABLERESULTS" -Verbose -As PSObject
    $html_body = $html_template
    $html_body += $result | ConvertTo-Html -PostContent "<br/><i>Generated date: $(Get-Date)</i>" -PreContent "<h3>$($_)</h3>" -Fragment -As Table
    $html_body | Out-File "C:\PSResults\consistency-check\$($_)_CHECKDB.html" -Encoding utf8

}
