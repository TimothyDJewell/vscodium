if (Test-Path vscode -Type Container) {
    git -C vscode fetch --all
}
else {
    git clone 'https://github.com/Microsoft/vscode.git'
}

$latestTagCommit = "$(git -C vscode rev-list --tags --max-count=1)"
$env:LATEST_MS_TAG = "$(git -C vscode describe --tags $latestTagCommit)"
git -C vscode checkout $env:LATEST_MS_TAG
