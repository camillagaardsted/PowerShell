# Dag 1 PowerShel kursus

# Hjælpekommandoer
# 1) Get-Help
# vi kan søge bredt efter cmdlets
# vi kan slå hjælpeartikel op for en specfik cmdlet

Get-Help process

get-help Get-Process

Get-Process

get-help get-process -Online

Get-Process

notepad

Get-Process

Get-Process

get-process -Id 7020

get-process -id 7020,2416

get-process -Name notepad

get-process -Name notepad,chrome

Get-command process

get-command ipconfig

Get-command -noun process

# whatIf er en switch parameter 
# det betyder den ikke skal have nogen inputværdi
Stop-Process -Id 7020 -WhatIf

Stop-Process -Id 7020

Get-Process -Name notepad

Get-process notepad 

Get-process notepad

# ups det ryger til name parameteren
Get-process 8084

get-help get-process -Parameter name

stop-process

get-help Stop-Process -online

get-process notepad

stop-process 8084

# Nyt eksempel

Get-EventLog

get-help get-eventlog -Online

Get-eventlog -List

Get-eventlog -AsString

Get-EventLog -LogName Application -Newest 10 -EntryType Error

get-eventlog -LogName Application -InstanceId 5973,2003

# her tolkes application som parameter 0 og 5973,2003 som parameter 1
get-eventlog Application 5973,2003

# powershell har en masse about artikler
Get-help about_*

get-help about_aliases -ShowWindow

Get-Alias

dir

# den kan anvendes i andre sammenhænge end kun til filer
Get-ChildItem

# dir er alias for Get-Childitem og svarer til dir
# men den skal selvfølgelig have sine parametre som powershell input
# /s for rekursivt hedder -recurse
dir -Recurse

get-alias -Definition Get-ChildItem

New-Alias -Name n -Value notepad

n

#############################################
# 
#############################################

update-help

# tip omkring wildcards 
# alt som starter med wi:
Get-Process -Name wi*
# alt hvor wi er som start, slut eller inde i ordet:
Get-Process -Name *wi*

# Ekstra opgaver:
# søg i browser på: az 40 powershell lab
# https://github.com/MicrosoftLearning
#/AZ-040T00-Automating-Administration-with-PowerShell
#/tree/master/Instructions/Labs

# Vi fortsætter 10.32

# alle opgaver til kurset som ekstra opgaver er her:
# https://github.com/MicrosoftLearning/AZ-040T00-Automating-Administration-with-PowerShell/tree/master/Instructions/Labs

######################################################
#
######################################################

get-help service

Get-Service -Name WinRM

get-service -DisplayName 'Windows Remote Management (WS-Management)'

get-service -DisplayName 'Windows Remote Management (WS-Management)'


# variable
$antal = 5
$logname='application'
$location='swedencentral'
$instanceId = 5973

get-eventlog -LogName Application -EntryType Error -Newest $antal
Get-EventLog $logname $instanceId -Newest $antal

Get-EventLog -LogName $logname -InstanceId $instanceId -Newest $antal


# hvad er forskellen på gåseøjne " og enkelt pling '
$antal = 5

Write-Host "Powershell er et objektorienteret sprog"
Write-Host 'Powershell er et objektorienteret sprog'

write-host "Antal er $antal"

write-host 'Antal er $antal'

$logname='application' # det er en string
$logname.GetType()

write-host "Lognavnet er $logname og det er fint!"

$antal='5'
$antal.gettype()

$antal=5
$antal.gettype()

[int]$antal=32
$antal='femogtyve'

# hvis udtrykket er mere kompliceret end bare en direkte variabel, så sæt parenteser for at hjælpe powershell til at evaluere/udregne det

$logname='application'
# antal bogstaver i application er 11 - det fortæller length
$logname.Length

write-host "Lognavnet er $logname og det har $($logname.length) bogstaver i sig"

# fletning af variable og værdier

$maelkepris=12.4578
# en double - en decimal tal
$maelkepris.gettype()

"Prisen på en liter mælk er:$maelkepris"
# f for format
"Prisen på en liter mælk er:{0} og logname er {1}" -f $maelkepris,$logname
# kode for 2 decimaler N2 - N for numeric
"Prisen på en liter mælk er:{0:N2} og logname er {1}" -f $maelkepris,$logname

Get-Service -Name winrm,efs,bits -ComputerName localhost

# Visual Studio er den foretrukne editor til at arbejde med Powershell
# den er cross platform
# og den fungerer med både powershell 5 og powershell 7

# version af powershell
$PSversionTable

# PowerShell 7
# Get-WmiObject cmdlet findes ikke, men man kan køre den - og så starter ps5 en session
# computername er fjernet fra f.eks. get-service og fra get-process etc - pga forældet teknologi til remote opkald
# Anvend i stedet invoke-command - den anvender remoting og har selvfølgelig computername

####################################################
# PowerShell pipeline
####################################################

Get-computerinfo | Select-Object logonserver

get-service efs | Select-Object -Property name,status

# member - det er alle properties og funktioner
# som vores objekt har
# dvs her alle egenskaber og funktioner for en service
# og den fortæller også typen - det er klasse navnet:
# TypeName: System.ServiceProcess.ServiceController
get-service efs | Get-Member

Get-service efs | Select-Object -Property name,starttype

get-service efs | select name,StartType

get-service efs | select -Property *

# select-object
# kan udvælge og håndplukke de properties vi gerne vil se
# vi kan finde de properties som vi kan vælge mellem via get-member/google klassen

Get-Date 

Get-Date | select *

Get-Date | select year

Get-Date | select year, month

$year=get-date | select year

$year.gettype()

# klip overskriften af og håndter year direkte bare som et heltal dvs en int

$year = Get-Date | select -ExpandProperty year
$year.gettype()

$dato=Get-Date

$dato.gettype()
$dato.Year

(Get-date).year

ipconfig

Get-NetIPAddress | select IPAddress

# vi skal finde nogle processer
# som starter med c
# vi skal vise info om processerne
# firmaet bag, memory forbrug (WS), hvornår er den startet

Get-Process c*  | Get-Member

Get-Process c*  | select name,Company,StartTime,WS

Get-Process c*

# antal elementer på listen
(Get-Process c*).count
(Get-Process c*).length
# lidt snyd at man kan det her, for det er ikke en egenskab på listen af processer
(Get-Process c*).StartTime

Get-Process c* | select -ExpandProperty starttime

# select kan også bruges til at beregne en property som vi selv skræddersyr

# vi skal finde WS i MB for processer med w

get-process w* | select name,ws

# vi skal finde WS i KB for processer med w
# vi har ingen kolonne som hedder ws/1024... så den er bare tom her
get-process w* | select name,ws/1024

# $_ er objektet vi piper over - en ad gangen
# $ $_. så kommer vi ind til alle metoder og properties for vores objekt
get-process w* | select name,{$_.ws/1024}
#
get-process w* | select name,{$_.ws/1KB}
# hvordan kan vi give kolonnen et pænt navn i stedet for den hedder $_.ws/1MB ?
get-process w* | select name,{$_.ws/1MB},ws

get-process w*

# vi har brug for at kende et begreb i powershell
# som hedder en dictionary


# den består af en key og value - parvis
$server_dictionary=@{'LON-Dc1'='172.16.1.1';
                      'LON-CL1'='172.16.1.12';
                      'LON-SQL'='172.16.1.15';
                      'LON-DC2'='172.16.1.17';
}
$server_dictionary['Lon-dc1']

# her får vi et array - dvs en simpel liste i powershell med index som starter med 0
$computerNames='Lon-DC1','LON-DC2','LON-CL1','LON-SQL'
$computerNames

$computerNames[0]
$computerNames[1]

$server_dictionary=@{'LON-Dc1'='172.16.1.1';
                      'LON-CL1'='172.16.1.12';
                      'LON-SQL'='172.16.1.15';
                      'LON-DC2'='172.16.1.17';
}

get-process w* | select name,@{name='WS I MB'; # kolonnenavn
                               expression={$_.ws/1MB}} #udtrykket i beregningen for værdi der skal vises i kolonnen

#########################
# Frokost til 12.40

# vi vil have 2 decimaler på vores ws i mb
$tal=12.4567
"{0:N2}" -f $tal

get-process w* | select name,@{name='WS I MB'; # kolonnenavn
                               expression={"{0:N2}" -f ($_.ws/1MB)}} #udtrykket i beregningen for værdi der skal vises i kolonnen
# 
$value="12,4567"

$value.Length
$value.Replace(',','!')

$value.Replace(',','.')
$value

get-process w* | select name,@{name='WS I MB'; # kolonnenavn
                               expression={("{0:N2}" -f ($_.ws/1MB)).replace(',','.')}} #udtrykket i beregningen for værdi der skal vises i kolonnen

# lidt mere om dato tid

$ligenu=Get-Date

# year er en property
$ligenu.year
# gm er alias for get-member 
$ligenu | gm

$om3maaneder=$ligenu.AddMonths(3)

# lidt mere om replace

# specialtegn som skal erstattes

$tekst='Ærø er en; ø'
$tekst.Replace('Æ','AE').replace('ø','oe')
# NB replace fra .NET er case sensitiv
$tekst.Replace('æ','AE').replace('ø','oe')

# powershell har også sin egen replace
# og den er IKKE case sensitiv
$tekst -replace "æ","ae"

$ipaddresse='172.16.1.14'

$ipaddresse.Replace('.',':')
# pas lidt på med den - den laver default regex søgning dvs punktum her er bare et vilkårligt tegn
$ipaddresse -replace '.',':'
$ipaddresse -replace '\.',':'

# year er en property
$ligenu.year
# gm er alias for get-member 
$ligenu | gm

$om3maaneder=$ligenu.AddMonths(3)

$om3maaneder

$om3maaneder - $ligenu

$ligenu=Get-Date
$om3maaneder - $ligenu

$tidsforskel=$om3maaneder - $ligenu
# timespan er typen dvs klassen til en tidsforskel
$tidsforskel | gm

$tidsforskel.Days

($om3maaneder - $ligenu).days

$services = Get-service s*

$services.gettype()

$services

$services[0].Name

$services[5].Name

Get-service s* | select -Index 5

Get-service s* | select -Index 0
# med select kan vi håndplukke fra collection hvilke index vi gerne vil se
Get-service s* | select -Index 5

Get-service s* | select -Index 5,0

Get-service s* | select *
# first og last
Get-service s* | select -First 3
# first og last og index er gode til smugkigge og studere lidt i det udtræk vi får via en Get- cmdlet
Get-service s* | select -First 1 -Property * -Skip 2

# gm fortæller hvilke properties vi har
get-service | gm

get-service | select name, S*

# Opgaver til jer 
# Module 3 Lab A Select-Object 

$christmas=Get-Date -Month 12 -Day 24

# tip her 
# dir cmdlet forstår wildcard for path parameter
# dvs
dir C:\Windows\System32\*.dll

# sortering i powershell
# her de største værdier for ws først
get-process w* | Sort-Object ws -Descending

############################################
cls
############################################
# Module 3 Where-Object  - filtrering af vores objekter i pipeline
############################################

# vi har brug for at kunne sammenligne i powershell

$tal1=25
$tal2=37
# > send det ned i en fil (klassisk gammel syntaks også fra dos...)
# ups vi fik en fil her med navnet 25 og indhold 37...
$tal2 > $tal1

n 25
# giver true
$tal2 -gt $tal1
# $True og $False er indbygget i powershell 
$True

# dvs alle sammenligninger med operatorer i powershell
# er via bindestreg dvs -gt, -lt, 

$tal1 -eq $tal2

$script='powershell'
$scriptsprog='PowerShell'
# -eq er IKKE case sensitiv
$script -eq $scriptsprog

$script -ceq $scriptsprog

get-help about_com*

# læs om alle comparison operators her:
get-help about_Comparison_Operators

# vi skal finde alle services med w som er kørende 


get-service w* | 
        Where-Object -Property status -eq -Value running

get-service w* | 
        Where-Object -Property status -eq -Value stopped


# vi kan skrive det kortere sådan her:

get-service w* | where status -eq running 

get-help where -Parameter value
get-help where -Parameter property

# den simple where 
# den kan kun håndtere et krav
# dvs vi sammenligner med en specifik property
get-process s* | where ws -gt 100000KB

# list alle services med w som har et navn på 5 bogstaver

Get-Service w* | where name.length -eq 5

# vi skal have fat i den avancerede where - den kan ALT!

# {} - så tuborg betyder vi laver en scriptblok
# det er en stump powershell kode
get-service w* | where -FilterScript {$_.Name.Length -eq 5}

# den avancerede where er også den vi skal bruge
# hvis vi har mere end et krav

# list processer som har ws over en hvis værdi
# og cputid også over en hvis værdi

Get-Process | select -first 10

Get-Process | where cpu -gt 40
# vi må gerne udelade at skrive filterscript
# for det tolkes som position 0
# powershell opdager ud fra typen om position 0 er filterscript eller property
Get-Process | where {$_.cpu -gt 40 -and $_.ws -gt 150000Kb}
Get-Process | where cpu -gt 40

get-service w* | where -FilterScript {$_.Name.Length -eq 5}

get-help where -Parameter property
get-help where -Parameter filterscript

# pause til 14.31

# vi kan stille betingelser
# A -and  B er streng - det kræver at både A og B er opfyldt
Get-Process | where {$_.cpu -gt 40 -and $_.ws -gt 150000Kb}


# A -or  B er mere lempelig - det kræver bare at A ELLER B er opfyldt
Get-Process | where {$_.cpu -gt 40 -or $_.ws -gt 150000Kb}

# PowerShell er helt forfærdelig mht flere krav
# fordi den bare evaluerer fra venstre mod højre
# sæt gerne parenteser og test det af

# # hyper-v rollen er installeret på vores maskine

get-command -module hyper-v 

get-command -noun vm

get-vm

Start-VM lon-dc1

start-vm lon-cl1,lon-sql


get-vm | gm
# powershell kan godt forstå '00:00:30' som timespan på 30 sekunder
get-vm | where uptime -gt '00:00:30'

$timespan=New-TimeSpan -Seconds 30

get-vm | where uptime -gt $timespan


$timespan=New-TimeSpan -Minutes 3

get-vm | where uptime -gt $timespan

# uptime over 3 min og memory over 6000

get-vm | where {$_.Uptime -gt (New-TimeSpan -Minutes 3) -and $_.MemoryAssigned -gt 6000MB}

# liste exe filer
dir C:\Windows\System32\*.exe

# like bruger vi til tekstsammenligning med wildcard * 
"ipconfig.exe" -like '*.exe'

"ipconfig.exe" -like '*.dll'

dir C:\Windows\System32 | where name -like '*.exe'
dir C:\Windows\System32\*.exe

# where opgaver 








