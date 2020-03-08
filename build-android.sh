#!/bin/bash -v

echo "Exit immediately if a command exits with a non-zero status."
set -e
echo "Don't print all commands"
set +x

cd www

echo "Adding Platforms"
cordova platform add android
cordova platforms ls

echo "Adding Plugins"
cordova plugin ls

echo "Building apk for Android"
cordova build android

echo "Built the following apk:"
# app-release-unsigned.apk
cp -R $TRAVIS_BUILD_DIR/platforms/android/app/build/outputs/apk/debug/* $TRAVIS_BUILD_DIR/
cd $TRAVIS_BUILD_DIR
ls -la
# cd $TRAVIS_BUILD_DIR
