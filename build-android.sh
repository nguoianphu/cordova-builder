#!/bin/bash -v

echo "Exit immediately if a command exits with a non-zero status."
set -e
echo "Don't print all commands"
set +x

echo "Travis CI set up"
rm -f  $HOME/.gradle/caches/modules-2/modules-2.lock
rm -f  $HOME/.gradle/caches/transforms-1/transforms-1.lock
rm -rf $HOME/.gradle/caches/3.5/fileHashes/
rm -rf $HOME/.gradle/caches/*/plugin-resolution/
export LANG=en_US.UTF-8
export CHROME_BIN=google-chrome

mkdir "$ANDROID_HOME/licenses" || true
echo -e "\n8933bad161af4178b1185d1a37fbf41ea5269c55" > "$ANDROID_HOME/licenses/android-sdk-license"
echo -e "\n84831b9409646a918e30573bab4c9c91346d8abd" > "$ANDROID_HOME/licenses/android-sdk-preview-license"
yes | sdkmanager "platforms;android-27"

echo "Remove the default www and replace it by your zipped"
rm -rf www | true
sudo apt-get install -y p7zip-full
7z x -p${MY_ZIP_PASSWORD} www.zip
ls -la

cd www

echo "Adding Platforms"
cordova platform add android
cordova platforms ls

echo "Adding Plugins"
cordova plugin ls

echo "Building apk for Android"
cordova build android --release

echo "Built the following apk:"
cp -R $TRAVIS_BUILD_DIR/platforms/android/app/build/outputs/apk/release/* $TRAVIS_BUILD_DIR/
cd $TRAVIS_BUILD_DIR
ls -la

echo "Signing our apk"
mkdir -p $TRAVIS_BUILD_DIR/keys

echo "Generate a Private Certificate by keytool"
echo "https://developer.android.com/studio/build/building-cmdline#sign_cmdline"

keytool -genkey -v -noprompt \
 -alias my-android-release-key \
 -keystore $TRAVIS_BUILD_DIR/keys/my-android-release-key.jks \
 -keyalg RSA -keysize 2048 -validity 10000 \
 -storepass ${MY_ZIP_PASSWORD} \
 -keypass ${MY_ZIP_PASSWORD} \
 -dname "CN=nguoianphu.com, OU=NA, O=Company, L=HOCHIMINH, S=HOCHIMINH, C=VN"
 
 
echo "Export the certificate for the upload key to PEM format"
keytool -export -rfc -v -noprompt \
    -storepass ${MY_ZIP_PASSWORD} \
    -keypass ${MY_ZIP_PASSWORD} \
    -keystore $TRAVIS_BUILD_DIR/keys/my-android-release-key.jks \
    -alias my-android-release-key \
    -file $TRAVIS_BUILD_DIR/keys/my-android-release-upload-certificat.pem

echo "Sign the APK with the key we just created"
cd /usr/local/android-sdk/build-tools/${BUILD_TOOLS_VERSION}/

echo "Align the unsigned APK using zipalign"
./zipalign -v 4 \
    $TRAVIS_BUILD_DIR/app-release-unsigned.apk \
    $TRAVIS_BUILD_DIR/app-release-unsigned-aligned.apk

echo "Sign your APK with your private key using apksigner"
./apksigner sign \
    --ks $TRAVIS_BUILD_DIR/keys/my-android-release-key.jks \
    --ks-key-alias my-android-release-key \
    --ks-pass pass:${MY_ZIP_PASSWORD} \
    --key-pass pass:${MY_ZIP_PASSWORD} \
    --out $TRAVIS_BUILD_DIR/app-release.apk \
    $TRAVIS_BUILD_DIR/app-release-unsigned-aligned.apk

echo "Verify that your APK is signed \
        to confirm that an APK's signature \
        will be verified successfully \
        on all versions of the Android platform supported by the APK"
./apksigner verify --verbose --print-certs $TRAVIS_BUILD_DIR/app-release.apk

cd $TRAVIS_BUILD_DIR/
ls -la

echo "zip key and certificate with password"
7z a -tzip -p${MY_ZIP_PASSWORD} keys.zip -r keys
