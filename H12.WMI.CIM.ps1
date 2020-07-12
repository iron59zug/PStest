# gwmi: [–namespace root\cimv2] = default path, [-class/-property] = position 1
Get-wmiobject –namespace root\cimv2 –class win32_desktop # == gwmi win32_desktop 
# WMI explorer, FOSS+portable: wmie2, Sapien: CIM Explorer

#eg.1 which class for finding the ip of an NIC, can it handle DHCP refresh?
class: \\IP32015IKB\ROOT\CIMV2:Win32_NetworkAdapterConfiguration
method: RenewDHCPLease 

#eg.2 get services & show name, status, startup mod, user; tip: gsv cannot get startup mod
gwmi win32_service | select name,status,startmode,startname | ft

#eg.3 get installed hotfix w/ gwmi, tip: ‘quickfix engineering’
gwmi Win32_QuickFixEngineering

#eg.4 list PCname, OS build n°, OS description(caption), BIOS sn:
gwmi Win32_...
