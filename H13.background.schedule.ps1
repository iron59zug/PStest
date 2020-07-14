# asynchrony: +: background, -: no interactive user input, no error message on screen

# sajb -scr {cmd} -n name_job -cr dom1\user2
start-job -scr {gsv -comp pc1,pc2} # stil a local job, run locally one pc a time
get-help * -parameter asjob # icm/gwmi/iwmi/... can also use -AsJob
icm -scr {cmd} -comp pc1,pc2,... -asjob # remote job, run parallel @PCs 
# gjb/rcjb get result(s):
get-job; get-job -id 123 | fl * # parent jobs
gjb -id 456 | select -exp childjobs # list child jobs of 1 parent job
receive-job -id 123 -keep # no -keep = delete from cache!
rcjb -name job_name | sort pscomputername | ft -gr pscomputername
# rjb remove job&result: 
Remove-Job (gjb | where {-not $_.hasmoredata})

# Task Scheduler Library> Msft> Win> PS> SchedulerdJobs >= ps3:
Register-ScheduledJob –Name name_job -sc {cmd} -Trigger (New-JobTrigger –Daily –At 3am) `
-ScheduledJobOption (New-ScheduledJobOption –WakeToRun –RunElevated)

# WRONG: don't combine icm and sajb
icm -comm {sajb -scr {cmd}} -comp rPC # send cmd to remote and link cut off immediately, no result back
sajb -comm {icm -scr {cmd} -comp rPC} # job lost if local shell session accidentally closed

#eg.1 job to find all .ps1 files in c:\
sajb -scr {gci -r c:\ -Filter *.ps1}

#eg.2 job to find all .ps1 files in c:\ on remote PCs (list: L:\pcs.txt)
icm -scr {gci -r c:\ -Filter *.ps1} -comp (cat L:\pcs.txt) -AsJob # icm -asjob!!!

#eg.3 job to find last 20 error log, result in clixml, every workday 8am:
$scr= {Get-EventLog System -EntryType error -n 20 | export-clixml c:\path\to.xml}
$dow= "Monday","Tuesday","Wednesday","Thursday","Friday"
$tri= New-JobTrigger –weekly -daysofweek $dow –at 8am
Register-ScheduledJob name_job -scr $scr -tri $tri
Get-ScheduledJob | select * # control entry in Task Scheduler
