# oef voor server met Active Directory

# 1. module voor Group Policy activeren + rapport opvragen met alle GP objecten
# rapport opslaan in html + openen in browser
Get-command –module GroupPolicy

# 2. activeer module ServerManager; zoek benaming van + installeer Powershell ISE feature
Get-WindowsFeature 
Add-WindowsFeature


# 3. Bekijk module TroubleshootingPack op Win10 client: activeer + zoek beschikbare commando’s.
# bv. printers controleren: definitie van een troubleshooting pack hebben + uitvoeren
