# Get a CSV list of ad users
# Louis Scianni
# Released under FreeBSD license
$SWITCH = $ARGS
$FILE = 'ad_users.csv'
$NUM = 0
$help_info = "Create a csv file (Ad_User.csv) containing a list of enabled or disbaled AD users`nArguments:`nENABLED  - list all enabled users`nDisabled - list all disabled users`nALL      - list all users"

if([string]::IsNullOrEmpty($SWITCH)) {
    Write-Host $help_info
}

$Test_File = Test-Path $FILE
if($Test_File -eq $True){
    $NUM++
    $FILE = 'ad_users{0}.csv' -f $NUM
}

if($SWITCH -eq 'enabled') {
    Get-ADUser -Filter {(Enabled -eq $True)} -Properties SamAccountName,Enabled | Select SamAccountName | Export-Csv $FILE -NoType
}elseif ($SWITCH -eq 'disabled') {
    Get-ADUser -Filter {(Enabled -ne $True)} -Properties SamAccountName,Enabled | Select SamAccountName | Export-Csv $FILE -NoType
} elseif ($SWITCH -eq 'all') {
    Get-ADUser -Filter * | Select SamAccountName | Export-Csv $FILE -NoType    
}



    
