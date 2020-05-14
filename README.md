# Legal Disclaimer
This script is an example script and is not supported under any Zerto support program or service. The author and Zerto further disclaim all implied warranties including, without limitation, any implied warranties of merchantability or of fitness for a particular purpose.

In no event shall Zerto, its authors or anyone else involved in the creation, production or delivery of the scripts be liable for any damages whatsoever (including, without limitation, damages for loss of business profits, business interruption, loss of business information, or other pecuniary loss) arising out of the use of or the inability to use the sample scripts or documentation, even if the author or Zerto has been advised of the possibility of such damages. The entire risk arising out of the use or performance of the sample scripts and documentation remains with you.

# vCenter-Stat-Collection
This script is designed to query the vCenter leveraging PowerCLI module to gather statistical information about virtual machines including the VM name, vCPU, RAM, volumes, volume path, and guest OS. This information will then be formatted and output into HTML. For those would prefer CSV there is an option at the bottom of the script that just needs the comment line removed. 

# Prerequisites
This script is required to be run as Administrator

# Environment Requirements 
- PowerShell 5.1+


In Script Variables
- vCenter IP 
- vCenter Username
- vCenter Password

# Running Script
Once the necessary configuration requirements have been completed the script can be run one time or as a scheduled task on the script host 
