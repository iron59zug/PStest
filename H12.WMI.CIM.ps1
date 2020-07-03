# gwmi: [–namespace root\cimv2] = default path, [-class/-property] = position 1
Get-wmiobject –namespace root\cimv2 –class win32_desktop # == gwmi win32_desktop 

# 1. which class can be used to get the ip of an NIC? can it handle DHCP refresh?
class: \\IP32015IKB\ROOT\CIMV2:Win32_NetworkAdapterConfiguration
method: RenewDHCPLease 

# 2. get services & show name, status, startup mod, user; tip: gsv cannot get startup mod
gwmi win32_service | select name,status,startmode,startname | ft
