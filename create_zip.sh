#!/bin/bash

if [[ "$SHOULD_BUILD" == "yes" ]]; then
  if [[ "$TRAVIS_OS_NAME" == "osx" ]]; then
    cd VSCode-darwin
    zip -r ../VSCode-darwin-${LATEST_MS_TAG}.zip ./*
  elif [[ "$CI_WINDOWS" == "True" ]]; then
    cd VSCode-win32-x64
    7z a ../VSCode-win32-x64-${LATEST_MS_TAG}.zip ./*
  else
    cd VSCode-linux-x64
    tar czf ../VSCode-linux-x64-${LATEST_MS_TAG}.tar.gz .
  fi

  cd ..
fi