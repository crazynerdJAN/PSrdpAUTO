#In some cases you need to open a lot of RDP to work with. To make this easy i wrote a script


#Import Hostname from CSV document
$Hostname = Import-Csv "C:\Hostname.csv" -delimiter ";" | select Hostname

#Create secure string
$SecurePassword = Read-Host -Prompt "Please enter your password" -AsSecureString 

$User = "Admin"

#Create PSCredentialobject
$Credentials = New-Object System.Management.Automation.PSCredential `
     -ArgumentList $User, $SecurePassword
#Store as plaintext to work with
$Password = $Credentials.GetNetworkCredential().Password 

write-host "RDP is opening"

for ($i=0; $i -lt $Hostname.length; $i++){
  
    $Server=$Hostname.Hostname[$i]
    cmdkey /generic:TERMSRV/$Server /user:$User /pass:$Password
    mstsc /v:$Server
    Start-Sleep -Seconds 5
    }
    


