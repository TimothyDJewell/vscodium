echo "Sending request to https://api.github.com/repos/vscodium/vscodium/releases/tags/$env:LATEST_MS_TAG"
$GITHUB_RESPONSE = curl -s -H "Authorization: token $GITHUB_TOKEN" "https://api.github.com/repos/vscodium/vscodium/releases/tags/$env:LATEST_MS_TAG"
echo "Github response: ${GITHUB_RESPONSE}"
$VSCODIUM_ASSETS= $GITHUB_RESPONSE | jq '.assets')
echo "VSCodium assets: ${VSCODIUM_ASSETS}"

# if we just don't have the github token, get out fast
if (!$GITHUB_TOKEN) {
  return
}
if (!$VSCODIUM_ASSETS) {
  echo "Release assets do not exist at all, continuing build"
  $env:SHOULD_BUILD = 'yes'
}

$HAVE_SYSTEM_SETUP = $VSCODIUM_ASSETS | jq 'map(.name) | contains(["win32-x64", "system-setup.exe"])'
$HAVE_USER_SETUP = $VSCODIUM_ASSETS | jq 'map(.name) | contains(["win32-x64", "user-setup.exe"])'
$HAVE_WINDOWS_ZIP = $VSCODIUM_ASSETS | jq 'map(.name) | contains(["win32-x64", ".zip"])'
echo "HAVE_SYSTEM_SETUP: $HAVE_SYSTEM_SETUP; HAVE_USER_SETUP: $HAVE_USER_SETUP; HAVE_WINDOWS_ZIP: $HAVE_WINDOWS_ZIP"
echo ($HAVE_SYSTEM_SETUP.GetType())
if (!$HAVE_SYSTEM_SETUP) {
  echo "Building on Windows because we have no system-setup.exe";
  $env:SHOULD_BUILD = 'yes'
}
elseif (!$HAVE_USER_SETUP) {
  echo "Building on Windows because we have no user-setup.exe";
  $env:SHOULD_BUILD = 'yes'
}
elseif (!$HAVE_WINDOWS_ZIP) {
  echo "Building on Windows because we have no ZIP";
  $env:SHOULD_BUILD = 'yes'
}
else {
  echo "Already have all the Windows builds"
}
