$Env:UnityPath = "C:\Program Files\Unity\Hub\Editor\$Env:UNITY_VERSION\Editor\Unity.exe"

Write-Host "entrypoint.ps1: Activate Unity"
& "$PSScriptRoot\activate.ps1"

# Import any necessary registry keys, ie: location of windows 10 sdk
# No guarantee that there will be any necessary registry keys, ie: tvOS
Get-ChildItem -Path c:\regkeys -File | Foreach {reg import $_.fullname}

# Register the Visual Studio installation so Unity can find it
regsvr32 C:\ProgramData\Microsoft\VisualStudio\Setup\x64\Microsoft.VisualStudio.Setup.Configuration.Native.dll

Write-Host "entrypoint.ps1: Build the project"
& "$PSScriptRoot\build.ps1"

Write-Host "entrypoint.ps1: Free the seat for the activated license"
& "$PSScriptRoot\return_license.ps1"
