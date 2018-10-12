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

npm run gulp "vscode-win32-$env:BUILDARCH-min"
npm run gulp "vscode-win32-$env:BUILDARCH-copy-inno-updater"
npm run gulp "vscode-win32-$env:BUILDARCH-system-setup"
npm run gulp "vscode-win32-$env:BUILDARCH-user-setup"
npm run gulp "vscode-win32-$env:BUILDARCH-archive"

$env:npm_config_arch = $preexistingNpmArch
Set-Location ..
