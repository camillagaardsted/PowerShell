
# Vores første scripts
# forfatter:Camilla Gaardsted
# dette script skal oprette en folder, hvis den ikke findes
# og ellers skrive ud til brugeren at den allerede findes
Param(
    [Parameter(Mandatory=$true)]$foldername 
    , $antal = 5  # har en default værdi
    , $dnsname
)

$rootpath='C:\Powershellkursus\'

# vi har både split og join 
$fuldesti=join-path -Path $rootpath -ChildPath $foldername

# get-command -noun path

$folderenFindes=Test-Path -Path $fuldesti

if ($folderenFindes)
{
    Write-Host "$fuldesti folderen findes allerede"    
}
else{
    mkdir $fuldesti
}

Test-Connection -ComputerName $dnsname -Count $antal

