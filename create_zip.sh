#!/bin/bash

if [[ "$SHOULD_BUILD" == "yes" ]]; then
  if [[ "$TRAVIS_OS_NAME" == "osx" ]]; then
    cd VSCode-darwin
    zip -r ../VSCode-darwin-${LATEST_MS_TAG}.zip ./*
  elif [[ "$APPVEYOR_OS_NAME" == "windows" ]]; then
    echo "Available directories:"
    ls -d */
    cd VSCode-win32-x64
    echo "Directory contents"
    ls
  else
    cd VSCode-linux-x64
    tar czf ../VSCode-linux-x64-${LATEST_MS_TAG}.tar.gz .
  fi

  cd ..
fi