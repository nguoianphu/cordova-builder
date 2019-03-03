# Cordova builder
# on the cloud with Github and Travis-CI

[![Build Status](https://travis-ci.org/nguoianphu/cordova-builder.svg?branch=master)](https://travis-ci.org/nguoianphu/cordova-builder)

## How does it work?
__Each commit will be__
- Built by Travis-ci
- Deployed the APK file to Github Release and tag at https://github.com/nguoianphu/cordova-builder/releases

## How to use it?

Just __Fork__ it and do some below steps

---

### Connect your repo to Travis-CI

https://docs.travis-ci.com/user/tutorial/

### Android version

Edit the values in ```.travis.yml``` if you want to upgrade Android SDK

```
  - ANDROID_VERSION=26.0.2
  - BUILD_TOOLS_VERSION=26.0.2
```

### Github Release deployment

- Replace all ```nguoianphu``` with your account name in the ```.travis.yml```, i.e.

```
deploy:
  provider: releases
  api_key:
    secure: $YOUR_API_KEY_ENCRYPTED
  file: "$HOME/build/nguoianphu/cordova-builder/platforms/android/app/build/outputs/apk/debug/app-debug.apk"
  skip_cleanup: true
```

- Generate a new __Personal access tokens__

Go to https://github.com/settings/tokens/new

Create a new Token with at least these permissions

```
repo:status         Access commit status
repo_deployment     Access deployment status
public_repo         Access public repositories
```

Copy the Token for below step

- Add the Token to Travis-CI

Go to Travis-ci setting, i.e.        https://travis-ci.org/nguoianphu/cordova-builder/settings

In the __Environment Variables__ section, add a variable name ```YOUR_API_KEY_ENCRYPTED``` and the value you get from Github step above

 ### The www folder
 is cloned from the Cordova Phonegap template https://github.com/phonegap/phonegap-template-hello-world
 
You can overwrite the www with your HTML5 files. Remember to correct the __www/config.xml__.

Don't want people get your __private__ HTML5?

```
git fetch --all
git checkout -b password origin/password
```

Now zipping your ```www``` __private__ folder to the ```www.zip``` with a password, e.g ```MyP44ssw0rd```

Put the ```www.zip``` into the repo

Add the password ```MyP44ssw0rd``` to Travis-CI

Go to Travis-ci setting, i.e.        https://travis-ci.org/nguoianphu/cordova-builder/settings

In the __Environment Variables__ section, add a variable name ```MY_ZIP_PASSWORD``` and the value ```MyP44ssw0rd```

```
git add .
git commit -m"Build HTML5 with password"
git push origin password
```


## Let push some thing and check :) 



### Reference

- https://github.com/samlsso/Calc
- https://docs.travis-ci.com