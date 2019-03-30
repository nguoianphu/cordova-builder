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
cp -R $TRAVIS_BUILD_DIR/platforms/android/app/build/outputs/apk/release/* $TRAVIS_BUILD_DIR/
cd $TRAVIS_BUILD_DIR
ls -la

echo "Signing an App"

echo "Generate the keytool"
#keytool -genkey -v -keystore android.keystore -alias android-app-key -keyalg RSA -keysize 2048 -validity 10000 -storepass ${MY_ZIP_PASSWORD} -noprompt
keytool -genkey -v -noprompt \
 -alias android-app-key \
 -keystore android.keystore \
 -keyalg RSA -keysize 2048 -validity 10000 \
 -storepass ${MY_ZIP_PASSWORD} \
 -keypass ${MY_ZIP_PASSWORD} \
 -dname "CN=play.nguoianphu.com, OU=ID, O=NGUOIANPHU, L=HOCHIMINH, S=HOCHIMINH, C=VN"

echo "Sign the APK with the key we just created"
jarsigner -verbose \
    -sigalg SHA1withRSA \
    -digestalg SHA1 \
    -storepass ${MY_ZIP_PASSWORD} \
    -keystore android.keystore app-release-unsigned.apk android-app-key

echo "Optimize the APK file with the zipalign tool and also rename it to reflect the signing."
sudo apt install zipalign -y
zipalign -v 4 app-release-unsigned.apk app-release.apk
ls -la
