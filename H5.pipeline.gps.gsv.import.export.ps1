# 1. rapporteer de gegevens vd services van je toestel in xml als referentie. 
gsv | export-clixml refsv.xml;
# start een service waarvoor de startup op manueel staat + stop ‘Print Spooler’
gsv | where-object {$_.StartType -eq "Manual"}; start-service Xbox* -c
get-service -n sp*; stop-service spooler
<# Gebruik Compare-Object/Diff commando om het ref te vergelijken met de huidige situatie vd services. 
bij -property parameter meer dan 1 gegeven opgeven: #>
diff -r refsv.xml -d (gsv) -p status,name

# 2. Wat gebeurt er: 
Get-Service | Export-CSV services.csv | Out-File lijst.txt
write-out "txt is leeg want export-csv geeft geen resultaat naar het scherm"

<# 3. Welke manieren heb je om een service te stoppen? #>
gsv -n abc | stop-service
spsv abc

# 4. Wat zou je moeten doen om een bestand te maken waar de gegevens niet door een komma
# maar wel door een puntkomma gescheiden worden. Hoe zou je dit doen met Export-CSV? 
epcsv -d ";" #-Delimiter

# 5. Windows heeft landinstellingen voor o.a. het lijstscheidingsteken. 
# maak aan Export-CSV duidelijk het scheidingsteken vh systeem te gebruiken ipv komma:
epcsv -u #-UseCulture

# 6. Export-CliXML en Export-CSV wijzigen gegevens op computer. Hoe voorkomen een bestaand bestand overschrijven?
epcsv -append # add output to the end of the file
epcsv -NoClobber # no overwrite
# -force will overwrite read-only file

# 7. resultaat van Export-CSV begint een commentaarlijn. Hoe weglaten?
epcsv -NoTypeInformation
