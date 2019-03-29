#!/bin/bash -v

set -e

cd www

phonegap version

echo "Adding Plugins"
phonegap plugin list

echo "Building apk for Android"
phonegap build android --release

cd ..
pwd
export
echo "Built the following apk(s):"
ls -la
ls -la platforms/android/app/build/outputs/apk/
