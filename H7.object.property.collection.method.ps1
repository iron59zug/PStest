# Collection~table, Object~rij, Property~kolom; Method: actie op object bv. start/stop/wait-till-finish...

get-random # 1. random getal genereren
get-date # 2. huidige datum+tijd tonen
# 3. Welk soort object krijg je als resultaat van get-date:
get-date | gm # => System.DateTime
# 4. krijg dit resultaat met #2. : DayOfWeek
get-date | select DayOfWeek

# 5. Geef een lijst vd 50 laatste Security Event Log. Sorteer op datum (oud>nieuw) en index;
# toon index, tijd en bron + sla het op in een bestand.
get-eventlog security -newest 50 | select Index,TimeGenerated,Source,Message | sort time*,index | convertto-csv | out-file log50.csv
