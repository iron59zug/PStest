Alias           nsn -> New-PSSession
Alias           icm -> Invoke-Command                                                                                                      
Alias           ipsn -> Import-PSSession                                                                                                   

#





# 7. import cmds of ServerManager from remote pc, use "rem" as prefix:
$sn = nsn remote_pc_name -cr dom_name\user_name
icm –command {ipmo ServerManager} –session $sn
ipsn -s $session –m ServerManager –prefix rem
