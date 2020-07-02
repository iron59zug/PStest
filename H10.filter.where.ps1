# 1. import ServerManager in Win server + get installed roles & features:
gmo -l s*
ipmo ServerManager; gcm -m ServerManager
Get-WindowsFeature | gm
Get-WindowsFeature | where-object -filterscript {$_.installed -aq $True}
Get-WindowsFeature | where {$_.installstate -eq 'installed'}

<# 2. import AD in Win server, get users w/ PasswordLastSet = $null, only show usernames;
cannot use get-adu -filter as it cannot deal w/ $null #>
ipmo ActiveDirectory; get-adu -filter * | gm
get-adu -filter * | where [-filter] {$_.PasswordLastSet -eq $null} | select [-property] name

# 3. get all installed security update hotfix 
gcm *hot*; help get-hot; get-hotfix | gm
get-hot | where {$_.description -eq "security update"}

# 4. get all update hotfix installed by Administrator:
get-hot | where {$_.description -eq "update" -and $_.Installedby -eq "name_of_admin"}

# 5. get all conhost & svchost processes, tip: no where
gps -name conhost,svchost
