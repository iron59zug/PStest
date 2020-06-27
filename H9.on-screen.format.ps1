cd $pshome; geany dotnettypes.format.ps1xml

ft; fl; fw;
# table, list, wide; # use !after! everything, before out-cmdlets
ogv
# Out-GridView will ignore format-cmdlets that follow

gsv | ft -pr @{l='SN';e={$_.Name}},status,disp*
gps | ft -name,@{l='VM-MB';e={$_.VM/1MB -as [int]}}

# 1. get an overview of processes w/ name,id,starttime, put columns close to each other, w/o shorten lines:
gps | ft name,id,starttime -autosize -wrap

# 2. get an overview of processes w/ name,id,virt.mem,phys.mem in KB
gps | ft name,id,@{l='vmkb';e={$_.vm/1kb -as [int]}},pm

# 3. get existing event logs w/ Log Display Name as LogName and 'Minimum Retention days' as RetDays
Get-EventLog -List | gm
Get-EventLog -List | ft @{l='LogName';e={$_.logdisplayname}},@{l='RetDays';e={$_.minimumretentiondays}}

# 4. get an overview of services, group by 1.running 2.stopped
gsv | sort status -desc | ft -gr st*
