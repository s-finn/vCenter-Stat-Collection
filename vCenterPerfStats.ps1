# Legal Disclaimer:
#----------------------
#This script is an example script and is not supported under any Zerto support program or service.
#The author and Zerto further disclaim all implied warranties including, without limitation, any implied warranties of merchantability or of fitness for a particular purpose.
#In no event shall Zerto, its authors or anyone else involved in the creation, production or delivery of the scripts be liable for any damages whatsoever (including, without 
#limitation, damages for loss of business profits, business interruption, loss of business information, or other pecuniary loss) arising out of the use of or the inability 
#to use the sample scripts or documentation, even if the author or Zerto has been advised of the possibility of such damages.  The entire risk arising out of the use or 
#performance of the sample scripts and documentation remains with you.

$vCenterIP = "vCenterIp"
$vCenterUser = "vCenterUser"
$vCenterPassword = "vCenterPassword"

#Comment out lines 7-12 if PowerCLI module is installed 
If ((Get-Module -Name VMware.PowerCLI -List) -eq $null){
    [Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurtityProtcolType]::Tls12
    install-module -Name VMware.PowerCLI -Scope CurrentUser -confirm:$false -allowClobber
} Else {
    'PowerCli Module Installed'
}

Set-PowerCliConfiguration -InvalidCertificateAction Ignore
connect-viserver -server $vCenterIp -user $vCenterUser -Password $vCenterPassword

$vms = Get-VM | Select-Object Name, NumCpu, MemoryGb, UsedSpaceGb, ProvisionedSpaceGb, Guest


$allvms = foreach($vm in $vms){
   
   $disks = (Get-VMGuest $VM.Name).Disks | ForEach-Object {
        [pscustomobject]@{
        Capacity = $_.CapacityGb
        FreeSpace = $_.FreeSpaceGB
        Path = $_.Path
        
        }
   }

    foreach($disk in $disks){
        [pscustomobject]@{
            VmName = $vm.Name
            Num = $vm.NumCpu
            Memory = $vm.MemoryGB
            VMUsedSpace = [System.Math]::Round($vm.UsedSpaceGb, 2)
            VMProvisionedSpace = [System.Math]::Round($vm.ProvisionedSpaceGb, 2)
            VolumeCapacity = [System.Math]::Round($disk.capacity, 2)
            VolumeFreeSpace = [System.Math]::Round($disk.freespace, 2)
            VolumePath = $disk.path
            Guest = $vm.Guest
            }
    }

  }

#Optional Export to CSV
#$allvms | Export-Csv "c:\PerfStats\VMStats.htm" -noTypeInformation

$Header = @"
<style>
TABLE {border-width: 1px; border-style: solid; border-color: black; border-collapse: collapse;}
TH {border-width: 1px; padding: 3px; border-style: solid; border-color: black; background-color: #BA0C25;}
TD {border-width: 1px; padding: 3px; border-style: solid; border-color: black;}
</style>
"@
  
$allvms | convertTo-html -head $Header | out-file C:\perfstats\VMThinThick.htm

Disconnect-viserver -server $vCenterIp -confirm:$false


