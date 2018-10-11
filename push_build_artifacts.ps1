$artifacts = @{
    ".\vscode\.build\win32-$env:BUILDARCH\system-setup\VSCodeSetup.exe" =
        "VSCode-win32-$env:BUILDARCH-$env:LATEST_MS_TAG-system-setup.exe";
    ".\vscode\.build\win32-$env:BUILDARCH\user-setup\VSCodeSetup.exe" =
        "VSCode-win32-$env:BUILDARCH-$env:LATEST_MS_TAG-user-setup.exe";
    ".\vscode\.build\win32-$env:BUILDARCH\archive\VSCode-win32-$env:BUILDARCH.zip" =
        "VSCode-win32-$env:BUILDARCH-$env:LATEST_MS_TAG.zip";
}

$missingArtifacts = $artifacts.Keys | Where-Object { !(Test-Path $_) }
if ($missingArtifacts) {
    throw "Missing expected artifact(s):`r`n$($missingArtifacts -join "`r`n")";
}

$artifacts.GetEnumerator() | ForEach-Object {
    Push-AppveyorArtifact $_.Key -FileName $_.Value
}
