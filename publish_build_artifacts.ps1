function PushBuildArtifact {
  param([string]$SourceFile, [string]$DestinationFile)
  if (Test-Path ".\vscode\.build\$SourceFile") {
    Push-AppveyorArtifact ".\vscode\.build\$SourceFile" -FileName $DestinationFile
  } else {
    Write-Error "Unable to find artifact for $DestinationFile"
  }
}

$params = @{
    'SourceFile' = "win32-$env:BUILDARCH\system-setup\VSCodeSetup.exe";
    'DestinationFile' = "VSCode-win32-$env:BUILDARCH-$env:LATEST_MS_TAG-system-setup.exe";
}
PushBuildArtifact @params

$params = @{
    'SourceFile' = "win32-$env:BUILDARCH\user-setup\VSCodeSetup.exe";
    'DestinationFile' = "VSCode-win32-$env:BUILDARCH-$env:LATEST_MS_TAG-user-setup.exe";
}
PushBuildArtifact @params

$params = @{
    'SourceFile' = "win32-$env:BUILDARCH\archive\VSCode-win32-$env:BUILDARCH.zip";
    'DestinationFile' = "VSCode-win32-$env:BUILDARCH-$env:LATEST_MS_TAG.zip";
}
PushBuildArtifact @params