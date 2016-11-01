## install android-sdk on linux

## update sdk 
```
## update android sdk
android list sdk -a |grep 23.0.3 # output sdk with index
android update sdk -a -u -t <index>

## install com.android.support package
android list sdk -a|grep -i 'support'
android update sdk -a -u -t 163
```

## gradle
```
build.gradle


apply plugin: 'com.android.application'

buildscript {
    repositories {
        mavenCentral()
    }
    dependencies {
        classpath 'com.android.tools.build:gradle:2.1.0'
    }
}
apply plugin: 'com.android.application'

dependencies {
    compile fileTree(dir: 'libs', include: '*.jar')
    compile files('libs/Msc.jar')
        repositories {
            jcenter()
        }
        compile('org.piwik.sdk:piwik-sdk:1.0.2') {
            exclude module: 'support-annotations'
        }
}

android {

    signingConfigs {
        release {
            keyAlias 'androiddebugkey'
            keyPassword 'android'
            storeFile file('./androidpos.jks')
            storePassword 'android'
        }
    }


    compileSdkVersion 21
    buildToolsVersion "23.0.3"

    compileOptions {
        sourceCompatibility JavaVersion.VERSION_1_7
        targetCompatibility JavaVersion.VERSION_1_7
    }

    lintOptions {
        abortOnError false
        checkReleaseBuilds false
    }

    buildTypes {
        release {
            minifyEnabled false
            proguardFiles getDefaultProguardFile('proguard-android.txt'), 'proguard-rules.pro'
            // 不显示Log
            buildConfigField "boolean", "LOG_DEBUG", "false"
            // 移除无用的resource文件
            shrinkResources false
            signingConfig signingConfigs.release
        }
    }

    sourceSets {
        main {
            manifest.srcFile 'AndroidManifest.xml'
            java.srcDirs = ['src']
            resources.srcDirs = ['src']
            aidl.srcDirs = ['src']
            renderscript.srcDirs = ['src']
            res.srcDirs = ['res']
            assets.srcDirs = ['assets']
        }

        // Move the tests to tests/java, tests/res, etc...
        instrumentTest.setRoot('tests')

        // Move the build types to build-types/<type>
        // For instance, build-types/debug/java, build-types/debug/AndroidManifest.xml, ...
        // This moves them out of them default location under src/<type>/... which would
        // conflict with src/ being used by the main source set.
        // Adding new build types or product flavors should be accompanied
        // by a similar customization.
        debug.setRoot('build-types/debug')
        release.setRoot('build-types/release')
    }

    sourceSets {
        main {
            jniLibs.srcDirs = ['libs']
        }
    }
}
```

