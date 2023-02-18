# Return the active Unity license
& "$PSScriptRoot\UnityBuildRunner.exe" `
    -batchmode -quit -nographics `
    -username $Env:UNITY_EMAIL `
    -password $Env:UNITY_PASSWORD `
    -returnlicense `
    -projectPath "c:/BlankProject"
