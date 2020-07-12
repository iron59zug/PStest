<#    Web Services for Management (WS-MAN) on http(s) tcp:5985/s:5986
background service: WinRM w/ PS v2+; default: auto-start @server, disable @client
 -> GPO > comp.cfg > admin.templ > win.compo > Windows Remote shell, Windows Remote Management
serialize remote > xml > network > deserialize xml > PS object => NOT real time info 
usable @ >= WinXP, >= PS v2.0    #>
get-help about_remote_troubleshooting # if not in the same domain
Enable-PSRemoting # @remotePC w/ admin priv
Enter-PSSession –computername target_pc_name # one-to-one
Invoke-command –computername (cat some.list) -command {some-cmd} # one-to-many; -command == -scriptblock
# def: max. 32PCs at the same time, the rest in waiting list; sol: –throttleLimit

Alias           icm -> Invoke-Command                                                                                                      
<# icm -computername vs some-cmd -computername: 
1. parallel/run at the same time vs one by one
2. w/ vs w/o PSComputername-property
3. WinRM(FW ok) vs .net Framework may have firewall problem
4. cmd runs at remote PCs vs PCs send all data to local PC cmd
5. not real(serialize-deserialize) vs real fonctional result #>

#eg.1 start notepad @remotePC:
etsn rPC_name -cr adm_name 
notepad # running in remotePC background, local console will hang until Ctrl-C

#eg.2 get remote running services with icm, result in columns(format-wide):
icm -comp rPC_name -cr adm_name -sc {gsv | where {$_.Status -eq "running"}} | fw

#eg.3 get remote running process with icm, show the 10 most VM intensive
icm -comp $rname -cr $aname -sc {gps | sort VM -d | ft id,VM,Name | select -f 10}

#eg.4 put remotePC names in txt, get 10 most recent app logs w/ icm
icm -comp (cat rpc.txt) -comm {get-eventl app -n 10}
