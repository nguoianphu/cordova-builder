#!/bin/bash -v

set -e

cd www

echo "Adding Platforms"
cordova platform add android
# cordova platforms ls

echo "Adding Plugins"
cordova plugin add cordova-plugin-whitelist
cordova plugin ls

echo "Building apk for Android"
cordova build android --release

echo "Built the following apk(s):"
# app-release-unsigned.apk
ls -la $TRAVIS_BUILD_DIR/platforms/android/app/build/outputs/apk/release

cd ..
# cd $TRAVIS_BUILD_DIR
