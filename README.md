# Cordova builder
# on the cloud with Github and Travis-CI

[![Build Status](https://travis-ci.org/nguoianphu/cordova-builder.svg?branch=master)](https://travis-ci.org/nguoianphu/cordova-builder)

## How does it work?
__Each commit will be__
- Built by Travis-ci.org
- Deployed the APK file to Github Release and tag at https://github.com/nguoianphu/cordova-builder/releases

## How to use it?

Just __Fork__ it and do some below steps

---

### Connect your repo to Travis-CI

https://docs.travis-ci.com/user/tutorial/

### Android version

Edit the values in ```.travis.yml``` if you want to upgrade Android SDK

```
  - ANDROID_VERSION=28.0.3
  - BUILD_TOOLS_VERSION=28.0.3
```

### Github Release deployment

- Install travis command line

	https://github.com/travis-ci/travis.rb#installation

- Run travis Github Release
	
	```travis setup releases --force```
	
	Read more https://docs.travis-ci.com/user/deployment/releases/
	
	Add ```skip_cleanup: true``` into your ```.travis.yml```
	


### The www folder
 is cloned from the Cordova Phonegap template https://github.com/phonegap/phonegap-template-hello-world

You can overwrite the www with your HTML5 files. Remember to correct the __www/config.xml__.

Don't want people get your __private__ HTML5?

#### Wait, these steps are just for fun. We can extract ther .APK files and get the www :)

```
git fetch --all
git checkout -b password origin/password
```

Now zipping your ```www``` __private__ folder to the ```www.zip``` with a password, e.g ```MyP44ssw0rd```

```
zip -er www.zip www
```

or providing your password in the command

```
zip -P MyP44ssw0rd -r www.zip www
```

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
