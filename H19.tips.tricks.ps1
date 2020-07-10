# 2. get application logs, group by day of week

Get-EventLog Application | ft Index,@{l='DoW';e={$_.TimeGenerated.DayOfWeek}},TimeGenerated,Message -GroupBy {$_.TimeGenerated.DayOfWeek}
# NOT OK

# idea 1: more hash tables
Get-EventLog Application -n 5000
$DoW = @{l='DoW';e={$_.TimeGenerated.DayOfWeek}}

# idea 2: pipeline orders
Get-EventLog | sort | ft -gr
