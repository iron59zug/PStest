# hashtable, {scriptblok}, $_=placehouder for object from pipeline to Select-Object
# .=only part/column that match expression is needed
ipcsv c:\path\to\file.csv | Select-Object *, @{l='label';e={$_.expression}} | new-ADuser -path 'ou=MyOU,DC=me,DC=local'
# => create new column/property 'label', w/ value from expression column

# vb/1. get-hot -com verwacht string, get-adc geeft ADcomputer-type met Name-property als string:
get-hotfix –computername (get-adcomputer –filter * -searchbase `
“ou=domain controllers, dc=opleidingen, dc=intra” | select-object –expandproperty name)
# vb/2. FOUT: get-hot aanvaardt geen ADcomputer-type via pipeline:
Get-adcomputer –filter * -searchbase “ou=domain controllers,dc=opleidingen,dc=intra” | Get-Hotfix
help get-hotfix -full

# vb/3. get-adc geeft ADcomp-type door, select haalt en hernoemt Name-property-string tot computername-property-string
get-adcomputer –filter * -searchbase “ou=domain controllers,dc=opleidingen,dc=intra” | 
select-object @{l=’computername’;e={$_.name}} | get-hotfix

# vb/4. FOUT: select geeft een string door maar get-wmi -class aanvaardt niets via pipeline
Get-adcomputer –filter * -searchbase “ou=domain controllers,dc=opleidingen,dc=intra” |
Select-Object @{l=’computername’;e={$_.name}} | Get-WmiObject –class Win32_BIOS

# 5. overzicht van alle lopende processen op alle computers in een AD
gps -com (get-adc -filter * | selec -exp name)
get-adc | select –expandproperty name | gps # to verify
