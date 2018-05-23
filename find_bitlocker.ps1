Import-Module ActiveDirectory

Get-ADComputer -Filter 'ObjectClass -eq "computer"'  | foreach-object {
$Computer = $_.name

#Check if the Computer Object exists
$Computer_Object = Get-ADComputer -Filter {cn -eq $Computer} -Property msTPM-OwnerInformation, msTPM-TpmInformationForComputer
if($Computer_Object -eq $null){
Write-Host "Error…"
}

#Check if the computer object has had a BitLocker Recovery Password
$Bitlocker_Object = Get-ADObject -Filter {objectclass -eq 'msFVE-RecoveryInformation'} -SearchBase $Computer_Object.DistinguishedName -Properties 'msFVE-RecoveryPassword' | Select-Object -Last 1
if($Bitlocker_Object.'msFVE-RecoveryPassword'){
$Bitlocker_Key = $Bitlocker_Object.'msFVE-RecoveryPassword'
}else{
$Bitlocker_Key = '<not set>'
}

#Display Output
$strToReport = $Computer + "," + $Bitlocker_Key
Write-Host $strToReport

#Save to Report
$strToReport | Out-File Report.txt -append
}

