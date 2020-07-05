<#    Web Services for Management (WS-MAN) on http(s) tcp:5985/s:5986
background service: WinRM w/ PS v2+; default: auto-start @server, disable @client
 -> GPO > comp.cfg > admin.templ > win.compo > Windows Remote shell, Windows Remote Management
serialize remote > xml > network > deserialize xml > PS object => NOT real time info 
usable @ >= WinXP, >= PS v2.0    #>
get-help about_remote_troubleshooting # if not in the same domain
Enable-PSRemoting # @remotePC w/ admin priv
Enter-PSSession –computername target_pc_name # one-to-one
get-
get
get-get
