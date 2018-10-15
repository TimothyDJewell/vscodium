if ($env:SHOULD_BUILD -ne 'yes') {
    return;
}

$preexistingNpmArch = $env:npm_config_arch
if ($env:BUILDARCH -eq 'ia32') {
    $env:npm_config_arch = 'ia32'
}

Set-Location vscode

yarn
bash ../customize_product_json.sh
bash ../undo_telemetry.sh

# Install the dev dependencies, but build for production
$env:NODE_ENV = 'production'

yarn run gulp "vscode-win32-$env:BUILDARCH-min"
yarn run gulp "vscode-win32-$env:BUILDARCH-copy-inno-updater"
yarn run gulp "vscode-win32-$env:BUILDARCH-system-setup"
yarn run gulp "vscode-win32-$env:BUILDARCH-user-setup"
yarn run gulp "vscode-win32-$env:BUILDARCH-archive"

$env:npm_config_arch = $preexistingNpmArch
Set-Location ..
