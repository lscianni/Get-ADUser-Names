# Get a CSV list of active directory users
# -----------------------------------------------------------------------------
# Copyright (c) 2019, Louis Scianni
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
# 1. Redistributions of source code must retain the above copyright notice, this
#    list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright notice,
#    this list of conditions and the following disclaimer in the documentation
#    and/or other materials provided with the distribution.
#
#THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
#ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
#WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
#DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
#ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
#(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
#LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
#ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
#(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
#SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
#The views and conclusions contained in the software and documentation are those
#of the authors and should not be interpreted as representing official policies,
#either expressed or implied, of the get_ad_username project.
# -----------------------------------------------------------------------------
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



    
