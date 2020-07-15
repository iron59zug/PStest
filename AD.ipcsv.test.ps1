# ipcsv, new ou, new gg, add user

Import-Module ActiveDirectory
param (
    $csvpath = 'H:\GebruikerslijstChoco.csv',
    $users = Import-Csv $csvpath -Delimiter ';',
    $addn = (Get-ADDomain).DistinguishedName,
    $ou0 = Choco )
New-ADOrganizationalUnit -Name $ou0 -path $addn -WhatIf
$newou2 = Get-ADOrganizationalUnit -Filter 'name -like "$ou0"' -property name # idea2
$newou1 = (Get-ADOrganizationalUnit -Filter 'name -like "$ou0"').DistinguishedName # idea1

foreach ($user in $users) {
    $dep = $user.Department 
    $oudc = $user.Path
New-ADOrganizationalUnit -Name $dep -path $newou -WhatIf }

foreach ($user in $company) {
    $name = $user.Name
    $sname = $user.Surename
    $gname = $user.GivenName
    $uname = $user.sAMAccountName
    $title = $user.Title
    $dep = $user.Department  
    $company = $user.Company
    $upname = $user.userPrincipalName
    $mail = $user.Mail
    $oudc = $user.Path
        
New-ADOrganizationalUnit -Name $dep -path $oudc -WhatIf

New-ADUser -SamAccountName $uname -UserPrincipalName $upname `
    -Name $name -Surname $sname -GivenName $gname -Title $title `
    -Department $dep -Company $company -EmailAddress $mail `
    -path $oudc -WhatIf

New-ADGroup -Name "GG$dep" -GroupCategory Security -GroupScope Global -WhatIf 
New-ADGroup -Name "GGall" -GroupCategory Security -GroupScope Global -WhatIf 

Add-ADGroupMember -Identity "GGall" -Members $uname -WhatIf
}

Add-ADGroupMember -Identity "GG$dep" -Members -WhatIf
