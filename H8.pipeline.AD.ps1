# hashtable, {scriptblok}, $_=placehouder for object from pipeline to Select-Object
# .=only part/column that match expression is needed
ipcsv c:\path\to\file.csv | Select-Object *, @{l='label';e={$_.expression}} | new-ADuser -path 'ou=MyOU,DC=me,DC=local'
# => create new column/property 'label', w/ value from expression column


