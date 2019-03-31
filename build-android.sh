#!/bin/bash -v

set -e

cd www

phonegap version

echo "Adding Plugins"
phonegap plugin list

echo "Building apk for Android"
phonegap build android --release

echo "Built the following apk(s):"
cp -R $TRAVIS_BUILD_DIR/platforms/android/app/build/outputs/apk/release/* $TRAVIS_BUILD_DIR/
cd $TRAVIS_BUILD_DIR
ls -la

echo "Signing an App"

echo "Generate a Private Certificate by keytool"
keytool -genkey -v -noprompt \
 -alias android-app-key \
 -keystore android.keystore \
 -keyalg RSA -keysize 2048 -validity 10000 \
 -storepass ${MY_ZIP_PASSWORD} \
 -keypass ${MY_ZIP_PASSWORD} \
 -dname "CN=nguoianphu.com, OU=NA, O=Company, L=HOCHIMINH, S=HOCHIMINH, C=VN"

echo "Sign the APK with the key we just created"
jarsigner -verbose \
    -sigalg SHA1withRSA \
    -digestalg SHA1 \
    -storepass ${MY_ZIP_PASSWORD} \
    -keystore android.keystore app-release-unsigned.apk android-app-key

echo "Optimize the APK file with the zipalign tool and also rename it to reflect the signing."
cd /usr/local/android-sdk/build-tools/${BUILD_TOOLS_VERSION}/
./zipalign -v 4 $TRAVIS_BUILD_DIR/app-release-unsigned.apk $TRAVIS_BUILD_DIR/app-release.apk
ls -la
cd $TRAVIS_BUILD_DIR/
ls -la
