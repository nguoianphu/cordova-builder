#!/bin/bash -v

set -e

cd www

echo "Adding Platforms"
# cordova platform remove android
cordova platform add android
cordova platforms ls

echo "Adding Plugins"
cordova plugin add org.apache.cordova.media
cordova plugin ls

echo "Building apk for Android"
cordova build android
