# oef voor server met Active Directory

# 1. module voor Group Policy activeren + rapport opvragen met alle GP objecten
# rapport opslaan in html + openen in browser
gmo -l #-ListAvailable
ipmo GroupPolicy; gcm –m GroupPolicy #-module
update-help; help get-gporeport -e #-exemples|-full|-detailed ...
mkdir "%userprofile%\Desktop\tmp"; get-gporeport -all -v -ReportType html -path "%userprofile%\Desktop\tmp\GPOreport.html"

# 2. activeer module ServerManager; zoek benaming van + installeer Powershell ISE feature
gmo -l s*
ipmo ServerManager; gcm -m ServerManager
Get-WindowsFeature p*
Add-WindowsFeature powershell-ise -con

# 3. Bekijk module TroubleshootingPack op Win10 client: activeer + zoek beschikbare commando’s.
gmo -l t*; gcm -m tro*
# bv. printers controleren: definitie van een troubleshooting pack hebben + uitvoeren
help Get-TroubleshootingPack
ls C:\Windows\Diagnostics\System\
# optie 1
cd C:\Windows\diagnostics\system\
Get-TroubleshootingPack Printer | Invoke-TroubleshootingPack
# optie 2
$diagPrint = Get-TroubleshootingPack C:\Windows\diagnostics\system\Printer
Invoke-TroubleshootingPack $diagPrint
