# 1. Maak een CliXML referentiebestand aan met daarin de gegevens van de services van je toestel. 
gsv | export-clixml refsv.xml;
# Pas nu voor enkele services de status aan: start een service waarvoor de startup op manueel staat 
gsv | where-object {$_.StartType -eq "Manual"}; start-service Xbox* -c
# en stop even de ‘Print Spooler’ 
get-service -n sp*; stop-service spooler
<# Gebruik Compare-Object (Diff) commando om het ref te vergelijken met de huidige situatie van de services. 
bij de property parameter meer dan 1 gegeven opgeven: #>
diff -r refsv.xml -d (gsv) -p status,name

# 2. Wat gebeurt er: 
Get-Service | Export-CSV services.csv | Out-File lijst.txt
write-out "txt is leeg want export-csv geeft geen resultaat naar het scherm"

<# 3. Je kan een lijst van services opvragen en via piping doorgeven aan Stop-service. Dit om
deze services te stoppen. Welke andere manieren heb je nog om een service te stoppen, zou
je het ook kunnen zonder gebruik te maken van Get-service? #>
gsv -n abc | stop-service
spsv abc

# 4. Wat zou je moeten doen om een bestand te maken waar de gegevens niet door een komma
# maar wel door een puntkomma gescheiden worden. Hoe zou je dit doen met Export-CSV? 
epcsv -d ";" #-Delimiter

# 5. In Windows wordt er gebruik gemaakt van landinstellingen om onder andere het
# lijstscheidingsteken te bepalen. Hoe kan je aan Export-CSV duidelijk maken dat moet
# gebruik gemaakt worden van het scheidingsteken ingesteld door het systeem in plaats van een komma?
epcsv -u #-UseCulture

# 6. Export-CliXML en Export-CSV kunnen gegevens wijzigen op een computer. Hoe kan 
# je voorkomen dat deze programma’s een bestaand bestand overschrijven?
epcsv -append # add output to the end of the file
epcsv -NoClobber # no overwrite
# -force will overwrite read-only file

# 7. Als je gebruik maakt van Export-CSV dan begint het resultaat met als eerste lijn een
# commentaarlijn (start met #). Hoe kan je deze lijn weglaten bij opmaken van het bestand?
epcsv -NoTypeInformation
