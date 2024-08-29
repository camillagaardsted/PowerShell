# Dag 2 PowerShell kursus

# Dagens plan
    # repetition
    # AD
    # lidt omkring remoting
    # Foreach
    # Export af data - skrivning til en fil
    # if statement
    # scripts - ps1 filer
    # lidt om execution policy
    # function

    ############################################################
# Tre hjælpecmdlets - de tre vigtigste i powershell
# Get-Help
# Get-Command
# Get-Member

# Get-Member
# gm er alias for get-member
# vi piper til den - det vi piper er objekter
# gm fortæller datatypen
# gm fortæller hvilke members dvs hvilke properties/egenskaber og metoder/funktioner vi har for vores objekt
mkdir tirsdag 
new-item -ItemType Directory C:\Powershellkursus\tirsdag2 
# vi har to objekt typer her Directory og File
# TypeName: System.IO.FileInfo
# System.IO.DirectoryInfo
dir C:\Powershellkursus | gm

get-command mkdir


dir C:\Powershellkursus | gm -Name isreadonly


# $services bliver et array med 5 elementer
$services=Get-service | select -first 5

# select-object
    # vi kan udvælge specifikke properties vi gerne vil se 
    # vi kan udvælge first, last, skip 
    # vi kan lave expandproperty - dvs folde en property ud 
    # vi kan lave vores egen kolonne f.eks. beregne antal timer en maskine har kørt etc via grim syntaks med hashtable/dictionary
Get-service | select -first 5

Get-service | gm

Get-service | select -first 5 -Property name, status, StartType,DependentServices

get-process w* | select name,@{name='WS I MB'; # kolonnenavn
                               expression={"{0:N2}" -f ($_.ws/1MB)}} #udtrykket i beregningen for værdi der skal vises i kolonnen

# n for name og e for expression
# label virker også som name
get-process w* | select name,@{n='WS I MB'; # kolonnenavn
                               e={"{0:N2}" -f ($_.ws/1MB)}} #udtrykket i beregningen for værdi der skal vises i kolonnen

# her synes powershell det er fint og vise det i en tabel
Get-service | select -first 5 -Property name, status, StartType,DependentServices

# her vælger ps for os at vise det i en liste altså vores objekter
Get-service | select -first 5 -Property name, s*,DependentService

Get-service |select -first 5 | ft -Property name, s*,DependentService

# ft er alias for format-table
get-alias ft

Get-service |select -first 5 | Format-Table -Property name, s*,DependentService

# DEN KÆMPE STORE FORSKEL PÅ SELECT OG FT 
# Format-Table skal I tænke som slutproduktet der er pænt formateret
# dvs det er ikke meningen at vi piper videre - ned i en fil er fint - den pæne tekst
# fordi I har ikke objekter længere efter format-table - I har tekst

Get-service |select -first 5 | Format-Table -Property name, s*,DependentService | Sort-Object name -Descending

Get-service |select -first 5 | select -Property name, s*,DependentService | Sort-Object name -Descending

# her har vi alle de properties som vores objekter indeholder
# Selected.System.ServiceProcess.ServiceController
Get-service |select -first 5 | select -Property name, s*,DependentService | gm
# her er typen 
# Microsoft.PowerShell.Commands.Internal.Format.FormatEndData
Get-service |select -first 5 | ft -Property name, s*,DependentService | gm


# format-table
# format-list

# format-list 
# kan lave det her med højrestilling af tal under hinanden
# den har nemlig ekstra ting den kan forstå i dictionary

# select kan IKKE forstå align
get-process w* | select name,@{name='WS I MB'; # kolonnenavn
                               expression={"{0:N2}" -f ($_.ws/1MB)};
                               align='right'} 



get-process w* | ft name,@{name='WS I MB'; # kolonnenavn
                               expression={"{0:N2}" -f ($_.ws/1MB)};
                               align='right'} 


# where-object
# alias er where
# hvilke objekter er vi interesseret i?
# vi kan udvælge dem ud fra sammenligninger for properties værdier

# den simple where kan kun lave en sammenligning med en property for objektet

Get-service |select -first 5 | where status -eq running

Get-service |select -first 5 | ? status -eq running

get-alias -Definition where-object

get-alias ?

# den avancerede where - den kan alt 
# flere krav og mere komplicerede udtryk
Get-service | where {$_.Name.Length -eq 5 -and $_.Status -eq 'running'}
# $PSItem er også lovligt som navn for det objekt vi piper over
Get-service | where {$PSItem.Name.Length -eq 5 -and $Psitem.Status -eq 'running'}

###############################################################################
# loops i Powershell via foreach
###############################################################################

# vi kan lave lister i powershell med tal
# via range operator (..)

1 .. 5

$tal=27
"Vi kan flette variable ind i tekst $tal"


1 .. 5 | ForEach-Object {"Folder$_"}

# foreach-object er en cmdlet som kan udføre en scriptblok
# for hver eneste objekt som vi piper til den 

# vi vil lave 10 foldere  som hedder folder1, folder2, etc

1 .. 10 | ForEach-Object {mkdir "C:\Powershellkursus\folder$_"}
# foran stillede 0'er
1 .. 10 | ForEach-Object {mkdir ("C:\Powershellkursus\folder{0:000}" -f $_ )}

# vi skal kryptere nogle filer
# vi har ingen cmdlet til det direkte i powershell
get-help crypt

new-item -Path C:\Powershellkursus -Name Data -ItemType Directory

cd C:\Powershellkursus\Data

# vi laver nogle filer

new-item -Name hemmelig.txt -Value "selve indholdet af filen og det er hemmeligt!"
new-item -Name hemmelig2.txt -Value "selve indholdet af filen og det er hemmeligt!"

dir

dir | gm

get-service efs

$files=dir


$files[0].Encrypt()
$files[0].Decrypt()
# vi skal kryptere alle filer i vores folder

dir | ForEach-Object {$_.encrypt()}

dir | ForEach-Object {$_.decrypt()}

# vi skal kryptere filerne og sætte dem readonly

dir | ForEach-Object {$_.encrypt(); $_.IsReadOnly=$True}

dir | select name,IsReadOnly

# vi skal den anden vej - de skal dekrypteres og ikke være readonly

dir | ForEach-Object {$_.IsReadOnly=$False; $_.decrypt() }

dir | ForEach {$_.IsReadOnly=$False; $_.decrypt() }

# foreach findes også i PowerShell i en syntaks som er et statement
# dvs det ligner mere alm udvikler kode fra .NET

# foreach som statement

$talliste = 1 .. 10
foreach ($tal in $talliste)
{
 write-host "Folder$tal"
   

}

# samme eksempel med filer fra før, men via foreach statement her:

$files=dir

foreach ($file in $files)
{
    $file.encrypt()
    $file.isreadonly=$True
}


# frokost indtil 12.35

#####################################################
# et mere eksempel med foreach
#####################################################

#vi  skal lave foldere og de skal navne som er datoer

# 2024_08_29

# datoer 

get-date

(get-date).year
# flet dato ind nemt i en tekst fra get-date
"{0:yyyy_MM_dd}" -f (get-date)

"logfil{0:yyyy_MM_dd_HH_mm}.log" -f (get-date)

# vi skal lavere foldere klar for hele september måned og oktober

$talListe = 0 .. 60

foreach($tal in $talliste)
{
    $dato=(get-date -Month 9 -Day 1).AddDays($tal)
    mkdir ("{0:yyyy_MM_dd}" -f $dato) | Out-Null
}



$talListe = 0 .. 2

foreach($tal in $talliste)
{
    $dato=(get-date -Month 9 -Day 1).AddDays($tal)
    mkdir ("{0:yyyy_MM_dd}" -f $dato) | Out-Null
}

#################################################################
# 
#################################################################
# hvordan kan vi gemme data/output fra powershell?

# Out-file

get-process | select name, ws, company | Out-File -FilePath C:\Powershellkursus\processer.txt -Encoding utf8

notepad C:\Powershellkursus\processer.txt

# den anden vej - hvordan indlæser vi noget?

Get-Content C:\Powershellkursus\processer.txt

Get-Content C:\Powershellkursus\processer.txt | gm

$indhold=Get-Content C:\Powershellkursus\processer.txt

$indhold.gettype()


# out-file overskriver som default bare en fil
get-process | select name, ws, company -first 5 | Out-File -FilePath C:\Powershellkursus\processer.txt -Encoding utf8


Get-Content C:\Powershellkursus\processer.txt

get-process | select name, ws, company -last 5 | Out-File -FilePath C:\Powershellkursus\processer.txt -Encoding utf8 -Append

Get-Content C:\Powershellkursus\processer.txt

# csv 

get-help csv

# export og import csv - udfører 2 ting - både konvertering og skrivning/læsning til fil

# `t er tabulator som tegn i powershell
get-process | select name, ws, company -last 5 | Export-Csv -Path C:\Powershellkursus\processer.csv -Delimiter "`t" -Encoding UTF8

get-content .\processer.csv
# uden type information
get-process | select name, ws, company -last 5 | Export-Csv -Path C:\Powershellkursus\processer.csv -Delimiter "`t" -Encoding UTF8 -NoTypeInformation

# vi skal importere fra en csv vil 

$processer=Import-Csv .\processer.csv -Delimiter "`t"
# hvis der er type på i første linje i csv, så fortæller gm det her:
$processer | gm

# udfordringen med de andre
# xml, json, html
# er at vi selv skal udføre det som 2 trin
# dvs konvertering 
# skrive/læse filen
# det foregår med convertto/convertfrom

get-help json


get-process | select name, ws, company -last 5 | ConvertTo-json

# vi skal gemme det i en fil
get-process | select name, ws, company -last 5 | ConvertTo-json | Out-File processer.json

# indlæsning af vores json

Get-Content .\processer.json | ConvertFrom-Json

Get-Content .\processer.json | ConvertFrom-Json | gm





















