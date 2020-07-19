# ipcsv, new ou, new gg, add user

param (
    $csvpath = "$psscriptroot\path\to.csv",
    $delimiter = ';',
    $root = 'Choco',
    $defaultpw = "${root}1234")

Clear-Host
Import-Module ActiveDirectory
$users = Import-Csv $csvpath -Delimiter $delimiter
Write-Output "`nusers imported from $csvpath"


$addn = (Get-ADDomain).DistinguishedName 
New-ADOrganizationalUnit -Name $root -path $addn -ProtectedFromAccidentalDeletion $false
$rdn = (Get-ADOrganizationalUnit -Filter 'name -like $root').DistinguishedName
Write-Output "root OU created: $rdn `n"


$ggr = "GG_$root"
New-ADGroup -Name $ggr -DisplayName "GG everyone" -GroupCategory Security -GroupScope Global `
    -Description "everybody from csv"
$ggrdn = (Get-ADGroup -Filter 'name -like $ggr').DistinguishedName
Write-Output "`nGG $root created: $ggrdn`n"


$accpw = ConvertTo-SecureString $defaultpw -AsPlainText -Force
foreach ($user in $users) {
    $name = $user.Name
	$sname = $user.Surename
   	$gname = $user.GivenName
	$uname = $user.sAMAccountName
    $title = $user.Title
    $dep = $user.Department  
    $company = $user.Company
    $upname = $user.userPrincipalName
    $mail = $user.Mail


    $ddn = (Get-ADOrganizationalUnit -Filter 'name -like $dep').DistinguishedName
    if ($ddn -eq $null){
        New-ADOrganizationalUnit -Name $dep -path $rdn -ProtectedFromAccidentalDeletion $false
        Write-Output "OU $dep created"}
        else {Write-Output "OU $dep exists: $ddn"}
# $ddn and $ggddn work differently ???
    $ggd = "GG_$dep"
    $ggddn = (Get-ADGroup -Filter 'name -like $ggd').DistinguishedName
    if ($ggddn -eq $null){
        New-ADGroup -Name $ggd -GroupCategory Security -GroupScope Global
        $ggddn = (Get-ADGroup -Filter 'name -like $ggd').DistinguishedName # why extra line needed?
        Write-Output "GG $dep created"}
        else {Write-Output "GG $dep exists: $ggddn"}


    $path = (Get-ADOrganizationalUnit -Filter 'name -like $dep').DistinguishedName
    New-ADUser  -SamAccountName $uname -UserPrincipalName $upname `
        -Name $name -Surname $sname -GivenName $gname -Title $title `
        -Department $dep -Company $company -EmailAddress $mail `
        -path $path -AccountPassword $accpw -Enabled $true
    Write-Output "$uname account ready"

    
    Add-ADGroupMember -Identity $ggddn -Members $uname
    Add-ADGroupMember -Identity $ggrdn -Members $uname
    Write-Output "joined $ggr, $ggd `n"
}

