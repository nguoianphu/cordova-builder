#!/bin/bash -v

set -e

cd www

phonegap version

echo "Adding Plugins"
phonegap plugin list

echo "Building apk for Android"
phonegap build android

echo "Built the following apk(s):"
ls -la $TRAVIS_BUILD_DIR/platforms/android/app/build/outputs/apk/debug
cd ..
# cd $TRAVIS_BUILD_DIR
cp -R $TRAVIS_BUILD_DIR/platforms/android/app/build/outputs/apk/debug/* $TRAVIS_BUILD_DIR/
ls -la $TRAVIS_BUILD_DIR/
