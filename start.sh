#!/bin/bash
cd /opt/render/project/src && mvn clean package -DskipTests
cp target/PRJ301_YouTube-1.0-SNAPSHOT.war /opt/render/project/src/target/ROOT.war
java -jar /opt/render/project/src/target/ROOT.war
