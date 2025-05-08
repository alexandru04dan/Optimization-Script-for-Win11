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
   
Pause