# AD 

New-ADUser -Department:"Valgturne" -DisplayName:"Donald Trump" -GivenName:"Donald" -Name:"Donald Trump" -Office:"New York" -Path:"OU=IT,DC=Adatum,DC=com" -SamAccountName:"dt" -Server:"LON-DC1.Adatum.com" -Surname:"Trump" -Type:"user"
# Set-ADAccountPassword -Identity:"CN=Donald Trump,OU=IT,DC=Adatum,DC=com" -NewPassword:"System.Security.SecureString" -Reset:$true -Server:"LON-DC1.Adatum.com"
Enable-ADAccount -Identity:"CN=Donald Trump,OU=IT,DC=Adatum,DC=com" -Server:"LON-DC1.Adatum.com"
Set-ADAccountControl -AccountNotDelegated:$false -AllowReversiblePasswordEncryption:$false -CannotChangePassword:$false -DoesNotRequirePreAuth:$false -Identity:"CN=Donald Trump,OU=IT,DC=Adatum,DC=com" -PasswordNeverExpires:$false -Server:"LON-DC1.Adatum.com" -UseDESKeyOnly:$false
Set-ADUser -ChangePasswordAtLogon:$false -Identity:"CN=Donald Trump,OU=IT,DC=Adatum,DC=com" -Server:"LON-DC1.Adatum.com" -SmartcardLogonRequired:$false

# remoting 
# kan også anvendes til at forbinde til en hyper-v maskine

hostname
whoami

Get-vm

$credential=Get-Credential
$credential
$credential.GetType()
# vi vil gerne forbinde til Lon-CL1 - vi bruger VMName parameter (det er hyper-v navnet)
Enter-PSSession -VMName Lon-CL1 -Credential $credential

Get-Command -Module activedirectory

Get-Command -Module activedirectory | Measure-Object

(Get-Command -Module activedirectory).count

get-command -noun aduser

# vi søger efter en user via identity
Get-ADUser -Identity dt # samaccountname

get-aduser -Identity S-1-5-21-4534338-1127018997-2609994386-4101

get-aduser -Identity 'CN=Donald Trump,OU=IT,DC=Adatum,DC=com'

get-aduser dt

# filter parameteren for get-aduser - den forstår powershell sammenlignings udtryk
# tjek altid for en cmdlet hvilken syntaks filter forventer dvs -eq 'jensen' eller ='%jensen%' til lighed etc
get-aduser -Filter "surname -like 't*'" | select surname,givenname

# alle users i ad
get-aduser -Filter *

get-aduser -Filter "surname -like 't*' -or givenname -like 's*'" | select surname,givenname

Get-aduser dt

Get-aduser dt | select *

Get-aduser dt | fl *

Get-aduser dt | select *

# Ad er lidt specielt mht properties
# vi skal eksplicit fortælle hvilke ekstra vi gerne vil have med udover de få som er default

Get-ADUser dt -Properties department,office

Get-ADUser dt -Properties *

# nu skal alle brugere med et efternavn med T flytte til office New York

Get-ADUser -Filter "surname -like 't*'" | Set-ADUser -Office "New York"
# ups office ser ud til at mangle
get-aduser -Filter "office -eq 'New York'" | select givenname,surname,office

get-aduser -Filter "office -eq 'New York'" -Properties office | select givenname,surname,office

get-aduser -Filter * -Properties office | where office -eq 'New York'

# vi skal lave en bruger i ad

$value = Read-host -Prompt 'Indtast noget'
$password=Read-host -Prompt 'Indtast password' -AsSecureString

New-ADUser -Name "Kamala Harris" -GivenName Kamala -Surname Harris -SamAccountName kh -Office Washington -Department Valgturne -AccountPassword $password -Enabled $true

Get-ADUser kh

get-aduser dt -Properties * | gm

# en gruppe 

New-ADGroup -Name Aalborg -GroupCategory Security -GroupScope Global -Path "OU=IT,DC=Adatum,DC=com"

get-aduser dt

Get-ADGroup -Identity Aalborg

Add-ADGroupMember -Identity Aalborg -Members dt,kh

Get-ADGroupMember Aalborg

# 

New-ADOrganizationalUnit -Name Dev -Path "OU=IT,DC=Adatum,DC=com"

Get-ADOrganizationalUnit "OU=dev,OU=IT,DC=Adatum,DC=com"

Get-ADUser kh


# vi flytter harris til vores nye ou

Move-ADObject -Identity 'CN=Kamala Harris,CN=Users,DC=Adatum,DC=com' -TargetPath "OU=dev,OU=IT,DC=Adatum,DC=com"

get-aduser kh


















