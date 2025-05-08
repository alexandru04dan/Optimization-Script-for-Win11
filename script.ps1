# Check if the script is running as Administrator
If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    # If not running as Administrator, re-launch the script with elevated privileges
    Write-Host "This script requires Administrator privileges."
    Read-Host -Prompt "Press Enter to grant Administrator privileges."
    $arguments = "& '" + $myinvocation.MyCommand.Definition + "'"
    Start-Process powershell -ArgumentList $arguments -Verb runAs
    Exit
}

# Optional: Create System Restore Point --planned to release--
# Write-Host "Creating Restore Point..."
# Checkpoint-Computer -Description "Before Win11 Optimization" -RestorePointType "MODIFY_SETTINGS"
# Pause

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