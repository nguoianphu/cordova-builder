#!/bin/bash -v

echo "Exit immediately if a command exits with a non-zero status."
set -e
echo "Don't print all commands"
set +x

echo "Travis CI set up"

npm install
npm install -g codecov
cordova platform add osx