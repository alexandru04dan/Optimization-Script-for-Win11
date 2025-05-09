# Check if the script is running as Administrator
If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    # If not running as Administrator, re-launch the script with elevated privileges
    Write-Host "This script requires Administrator privileges."
    Read-Host -Prompt "Press Enter to grant Administrator privileges."
    $arguments = "& '" + $myinvocation.MyCommand.Definition + "'"
    Start-Process powershell -ArgumentList $arguments -Verb runAs
    Exit
}

#Restore point section
$responseBackup = Read-Host "Do you wish to create a restore point? (y/n)"

$responseBackup = $responseBackup.Trim().ToLower()

if ($responseBackup -eq 'y' -or $responseBackup -eq 'yes') {
    Write-Host "Creating Restore Point..."
    Checkpoint-Computer -Description "Before Win11 Optimization" -RestorePointType "MODIFY_SETTINGS"
    Write-Host "Restore Point created!"
}
elseif ($responseBackup -eq 'n' -or $responseBackup -eq 'no'){
    Write-Host "No restore point created :("
}
else {
    Write-Host "Invalid input. Please enter Y or N."
}

#Change power plan mode section
$responsePowerManagement = Read-Host "Do you wish to change the Power mode to Better effeciency? (NOT RECOMMENDED FOR LAPTOPS) (y/n)"

$responsePowerManagement = $responsePowerManagement.Trim().ToLower()

if ($responsePowerManagement -eq 'y' -or $responsePowerManagement -eq 'yes') {
    Write-Host "Changing power mode"
    powercfg /setactive SCHEME_BALANCED
    powercfg /setacvalueindex SCHEME_BALANCED SUB_PROCESSOR PROCTHROTTLEMIN 100
    powercfg /setacvalueindex SCHEME_BALANCED SUB_PROCESSOR PROCTHROTTLEMAX 100
    powercfg /setacvalueindex SCHEME_BALANCED SUB_PROCESSOR CPMINCORES 100
    powercfg /setacvalueindex SCHEME_BALANCED SUB_PROCESSOR CPMAXCORES 100
    powercfg /setactive SCHEME_BALANCED
    Write-Host "Power mode changes have been made!"
}
elseif ($responsePowerManagement -eq 'n' -or $responsePowerManagement -eq 'no'){
    Write-Host "No power mode changes have been made :("
}
else {
    Write-Host "Invalid input. Please enter Y or N."
}

Read-Host -Prompt "Press Enter to exit"