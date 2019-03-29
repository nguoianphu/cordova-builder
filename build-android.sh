#!/bin/bash -v

set -e

cd www

phonegap version

echo "Adding Plugins"
phonegap plugin list

echo "Building apk for Android"
phonegap build android --release

#cd ..
cd $TRAVIS_BUILD_DIR
# HOME="/home/travis"
# TRAVIS_BUILD_DIR="/home/travis/build/nguoianphu/cordova-builder"
# TRAVIS_REPO_SLUG="nguoianphu/cordova-builder"

echo "Built the following apk(s):"
# app-release-unsigned.apk
ls -la platforms/android/app/build/outputs/apk/release
