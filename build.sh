#!/bin/bash

if [[ "$SHOULD_BUILD" == "yes" ]]; then
  cd vscode

  if [[ "$BUILDARCH" == "ia32" ]]; then
    export npm_config_arch=ia32
  fi

  yarn
  ../customize_product_json.sh
  ../undo_telemetry.sh

  export NODE_ENV=production

  if [[ "$TRAVIS_OS_NAME" != "osx" ]]; then
    # microsoft adds their apt repo to sources
    # unless the app name is code-oss
    # as we are renaming the application to vscodium
    # we need to edit a line in the post install template
    sed -i "s/code-oss/vscodium/" resources/linux/debian/postinst.template
  fi

  if [[ "$TRAVIS_OS_NAME" == "osx" ]]; then
    npm run gulp vscode-darwin-min
  elif [[ "$BUILDARCH" == "ia32" ]]; then
    npm run gulp vscode-linux-ia32-min
    npm run gulp vscode-linux-ia32-build-deb
    npm run gulp vscode-linux-ia32-build-rpm
    unset npm_config_arch
  else
    npm run gulp vscode-linux-x64-min
    npm run gulp vscode-linux-x64-build-deb
    npm run gulp vscode-linux-x64-build-rpm
  fi

  cd ..
fi