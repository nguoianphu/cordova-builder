#!/bin/bash -v

set -e

echo "Set up Capacitor"
npm install @capacitor/core @capacitor/cli --save
npx cap add android
npx cap sync
npx cap copy
npx cap open

echo "Build Android apks"
gradle tasks
gradle assembleDebug

echo "Built the following apk(s):"
find . -name '*.apk'