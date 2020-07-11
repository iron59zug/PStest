# hashtable, {scriptblok}, $_=placehouder for object from pipeline to Select-Object
# .=only part/column that match expression is needed
ipcsv c:\path\to\file.csv | Select-Object *, @{l='label';e={$_.expression}} | new-ADuser -path 'ou=MyOU,DC=me,DC=local'
# => create new column/property 'label', w/ value from expression column

# get pc_names to pipeline:
Get-ADComputer –filter * -searchbase ’ou=some_ou,dc=some_dc,dc=local’ | Select-Object –ExpandProperty Name

# eg.1 get-hot -com expect string, get-adc give ADcomputer-type w/ Name-property as string:
get-hotfix –computername (get-adcomputer –filter * -searchbase “ou=...,dc=...” | select-object –expand name)
# eg.2 WRONG: get-hot accept NO ADcomputer-type via pipeline:
Get-adc –filter * -searchbase “ou=some_ou,dc=some_dc,dc=intra” | Get-Hotfix
help get-hotfix -full

# eg.3 get-adc give ADcomp-type, select get+rename Name-property-string to computername-property-string
get-adc –filter * -searchbase “ou=myOU,dc=me,dc=net” | select @{l=’computername’;e={$_.name}} | get-hotfix

# eg.4 WRONG: select give string but get-wmi -class accept NO pipeline input
Get-adc –filter * -searchbase “...ou,dc...” | Select @{l=’computername’;e={$_.name}} | Get-WmiObject –class Win32_BIOS

# eg.5 list all running processes on all PCs in an AD
gps -com (get-adc -filter * | selec -exp name) # idea 1 ok
get-adc | select –expandproperty name | gps # idea 2 to verify
