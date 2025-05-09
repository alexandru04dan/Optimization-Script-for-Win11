Currently this is a project of mine, please do not run this on your device as it may cause bugs.


Although, if you are brave enough to test it yourself, paste the following in your terminal:

```iwr https://raw.githubusercontent.com/alexandru04dan/Optimization-Script-for-Win11/master/script.ps1 -OutFile "$env:TEMP\win11.ps1"; Start-Process powershell -Verb RunAs -ArgumentList "-ep Bypass -File `"$env:TEMP\win11.ps1`""
```


v1.0:
- Creates a backup point
- Makes changes to the power plan mode
