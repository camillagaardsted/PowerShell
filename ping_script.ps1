# Demo - vi laver et lille script som tester en connection

<#
.Synopsis
   Kort forklaring omkring vores funktion
.DESCRIPTION
   Her kommer den lange sang som forklarer hvad funktionen gør
.EXAMPLE
   Example of how to use this cmdlet
.EXAMPLE
   Another example of how to use this cmdlet
.INPUTS
   Inputs to this cmdlet (if any)
.OUTPUTS
   Output from this cmdlet (if any)
.NOTES
   General notes
.COMPONENT
   The component this cmdlet belongs to
.ROLE
   The role this cmdlet belongs to
.FUNCTIONALITY
   The functionality that best describes this cmdlet
#>
function Get-DnsInfoTest
{
    Param(
        $dnsname='dr.dk'
        ,$pingAntal = 4
    )
    Test-Connection -ComputerName $dnsname -Count $pingAntal
}


Get-DnsInfoTest -dnsname dr.dk -pingAntal 5
Get-DnsInfoTest -dnsname google.com -pingAntal 3