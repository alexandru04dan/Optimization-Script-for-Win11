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
    Write-Host -Prompt "Restore Point created!"
}
elseif ($responseBackup -eq 'n' -or $responseBackup -eq 'no'){
    Write-Host -Prompt "No restore point created :("
}
else {
    Write-Host -Prompt "Invalid input. Please enter Y or N."
}

#Setting power configuration for better performance
powercfg /setactive SCHEME_BALANCED

# Set Minimum and Maximum Processor State to 100%
powercfg /setacvalueindex SCHEME_BALANCED SUB_PROCESSOR PROCTHROTTLEMIN 100
powercfg /setacvalueindex SCHEME_BALANCED SUB_PROCESSOR PROCTHROTTLEMAX 100

# Disable core parking (optional)
powercfg /setacvalueindex SCHEME_BALANCED SUB_PROCESSOR CPMINCORES 100
powercfg /setacvalueindex SCHEME_BALANCED SUB_PROCESSOR CPMAXCORES 100

# Apply the changes
powercfg /setactive SCHEME_BALANCED


powercfg /l

Write-Output "Balanced plan is now optimized for performance without disabling the Windows 11 power slider."
   
Read-Host -Prompt "Press Enter to exit"