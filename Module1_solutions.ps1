# 1.1

# Day 1 Powershell course module 1 exercise 2
# 1.2
get-help info
# 1.2 or
get-help computer
# identify the cmdlet you need is Get-ComputerInfo

# 1.5
Get-ComputerInfo
# 1.6
Get-ComputerInfo -Property *windows*

# exercise 3

# 3.1
Get-Help test
# 3.1 or
Get-Help path
# 3.3
Test-Path -Path C:\Windows\System32
# 3.4
Test-Path -Path D:\Windows\System32\ipconfig.exe

# Exercise 4

# 4.1
Get-Help ipaddress
# 4.2
Get-Help -online Get-NetIPAddress
# 4.3
Get-NetIPAddress -AddressFamily IPv6
# 4.4
Get-NetIPAddress -AddressFamily IPv4
# 4.5 # we see that the ethernet is called "vEthernet (External Network)"
Get-NetIPAddress 
# 4.6
Get-NetIPAddress -AddressFamily IPv4 -InterfaceAlias "vEthernet (External Network)"

# 5.1
Get-Command -Module hyper-v
# 5.2 - vhd and vm

# 5.3
Get-Command -noun vhd -module hyper-v

#5.4
Get-Command -noun vm -module hyper-v

# 5.5
Get-VM

# 5.6
Start-VM -Name LON-DC1

# 5.7
Get-VM

# 5.8
Start-VM -Name LON-CL1,NAT

# 6.1
Get-help schedule
# 6.2 - gives error
Disable-ScheduledTask XblGameSaveTask
# 6.3
Get-ScheduledTask
# 6.4
Disable-ScheduledTask XblGameSaveTask -TaskPath \Microsoft\XblGameSave\








