if ($env:SHOULD_BUILD -ne 'yes') {
    return;
}

$env:NODE_ENV = 'production'
$preexistingNpmArch = $env:npm_config_arch
if ($env:BUILDARCH -eq 'ia32') {
    $env:npm_config_arch = 'ia32'
}

Set-Location vscode

yarn
bash ../customize_product_json.sh
bash ../undo_telemetry.sh

Write-Output "APPDATA: '$env:APPDATA'"
Write-Output "YARN GLOBAL BIN $(yarn global bin)"
Write-Output "YARN GLOBAL DIR $(yarn global dir)"
Write-Output "NPM ROOT: $(npm root -g)"
Write-Output "Recording NPM locations:"
Get-ChildItem "$env:APPDATA\npm" | Write-Output
Write-Output "Recording other possible NPM locations:"
Get-ChildItem "$env:APPDATA\npm\node_modules" | Write-Output
Write-Output "Recording npm root"
Get-ChildItem "$(npm root -g)" | Write-Output

Write-Output "Recording yarn bin location"
Get-ChildItem "$(yarn global bin)" | Write-Output
Write-Output "Recording yarn dir location"
Get-ChildItem "$(yarn global dir)" | Write-Output

npm run gulp "vscode-win32-$env:BUILDARCH-min"
npm run gulp "vscode-win32-$env:BUILDARCH-copy-inno-updater"
npm run gulp "vscode-win32-$env:BUILDARCH-system-setup"
npm run gulp "vscode-win32-$env:BUILDARCH-user-setup"
npm run gulp "vscode-win32-$env:BUILDARCH-archive"

$env:npm_config_arch = $preexistingNpmArch
Set-Location ..
