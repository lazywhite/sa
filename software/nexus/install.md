1. wget https://sonatype-download.global.ssl.fastly.net/nexus/3/nexus-3.0.0-03-unix.tar.gz
2. etc/org.sonatype.nexus.cfg
3. bin/nexus start;  admin:admin123
4. .m2/settings.xml
```
<settings xmlns="http://maven.apache.org/SETTINGS/1.0.0"
xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0
http://maven.apache.org/xsd/settings-1.0.0.xsd">
<mirrors>
<mirror>
<id>nexus</id>
<mirrorOf>*</mirrorOf>
<name>Nexus</name>
<url>http://nexus.test.com/repository/maven-public/</url>
</mirror>
</mirrors>
</settings>
```


## Concept
1. blob storage
2. repo
    group
    proxy
    hosted
        allow redeploy
3. repo asset and components
    


## Usage
1. proxy and registry for docker images
2. proxy and registry for npm package
3. proxy and registry for jar package


## Topic
### upload jar to maven repository
```
mvn deploy:deploy-file -DgroupId=com.huacloud.jar -DartifactId=sqljdbc4 -Dversion=1.0.0 -Dpackaging=jar -Dfile=sqljdbc4.jar -DrepositoryId=snapshots -Durl=http://222.197.188.5:9000/nexus/content/repositories/snapshots
```
