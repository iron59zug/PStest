# Win Mgmt Instrumentation on Common Information Model std; namespace > class > instance
# gwmi: [–namespace root\cimv2] = default path, [-class<String>/-property<String[]>] = position 1
Get-wmiobject –namespace root\cimv2 –class win32_desktop # == gwmi win32_desktop 
# WMI explorer, FOSS+portable: wmie2, Sapien: CIM Explorer

<# output can pipe to xxx-object, format/out/export/convertto-xxx 
need all output/methods insto default output: pipe to fl * or gm: #>
gwmi win32_xxx | gm; gwmi win32_xxx | fl *
# filter instances: -filter "abc =<>LIKE 'text %wildcard% \escape' "
gwmi win32_desktop -f "name like '%administrator%'"
# list wmi methods:
gwmi win32_abc -f "prop like '%pattern%'" | gm
# use wmi method => iwmi p0:[-Class]<String> p1:[-Name]<String>
gwmi win32_abc -f "prop like '%pattern%'" | Invoke-WmiMethod -name method_123
gwmi win32_abc -f "prop like '%pattern%'" | foreach {$_.method_123()} # not using iwmi

# gcim: [-classname/-InputObject]<string>/<CIMinstance> = position 0;
# need -credential for remote pc => invoke-command:
icm -sc {Get-CimInstance class_name} -comp rPC_name -cr nw\admin_name
# list all classes in 1 namespace:
get-cimclass -n root\space_name # eg. root\Cimv2

#eg.1 which class for finding the ip of an NIC, can it handle DHCP refresh?
class: \\pcName\ROOT\CIMV2:Win32_NetworkAdapterConfiguration
method: RenewDHCPLease 

#eg.2 get services & show name, status, startup mod, user; tip: gsv cannot get startup mod
gwmi win32_service | select name,status,startmode,startname | ft

#eg.3 get installed hotfix w/ gwmi, tip: ‘quickfix engineering’
gwmi -List 'win32_q*'
gwmi win32_QuickFixEngineering

#eg.4 list PCname, OS build n°, OS description(caption), BIOS sn:
gwmi win32_operatingsystem | ft __SERVER,PSComputerName,BuildNumber,Caption,@{l='Bsn';e={gwmi win32_bios | select -exp seri*}}
