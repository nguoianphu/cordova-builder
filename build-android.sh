#!/bin/bash -v

set -e

cd www

phonegap version

echo "Adding Platforms"
phonegap install android


echo "Adding Plugins"
phonegap local plugin list

echo "Building apk for Android"
phonegap build android

cd ..
pwd

echo "Built the following apk(s):"
ls -la
ls -la platforms/android/build/outputs/apk/
