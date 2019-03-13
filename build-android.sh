#!/bin/bash -v

set -e

echo "Set up Capacitor"
npm install @capacitor/core @capacitor/cli --save
npx cap add android
npx cap sync
npx cap copy

echo "Build Android apks"
./gradlew tasks
./gradlew assembleDebug

echo "Built the following apk(s):"
find . -name '*.apk'