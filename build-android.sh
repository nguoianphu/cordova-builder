#!/bin/bash -v

set -e

cd www

echo "Adding Platforms"
cordova platform add android
cordova platforms ls

echo "Adding Plugins"
cordova plugin ls

echo "Building apk for Android"
cordova build android

echo "Built the following apk(s):"
ls -la $TRAVIS_BUILD_DIR/platforms/android/app/build/outputs/apk/debug
cd ..
# cd $TRAVIS_BUILD_DIR
