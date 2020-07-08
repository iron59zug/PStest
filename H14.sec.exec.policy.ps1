# set execution policy to RemoteSigned:
Set-ExecutionPolicy -e RemoteSigned; Get-ExecutionPolicy -l
<#default -scope LocalMachine < CurrentUser < Process < UserPolicy < MachinePolicy
                  reg:HKLM       reg:HKCU   $env:PSE.P.   gpo:CU       gpo:allU    #>
