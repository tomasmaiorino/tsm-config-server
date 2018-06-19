#!/bin/bash
echo ######################################################
echo parameters branch: $1 port: $2 custom: $3
echo ######################################################
echo
echo ------------------------
echo checkout: git checkout $1
echo ------------------------
echo
git checkout $1

echo
echo ------------------------
echo pulling: git pull origin $1
echo ------------------------
echo
git pull origin $1

echo
echo ------------------------
echo cleaning and installing: mvn clean install
echo ------------------------
echo
mvn clean install

echo
echo ------------------------
echo mvn start: mvn spring-boot:run -Dspring.profiles.active=$2 -Dserver.port=$2 $3
echo ------------------------
echo
mvn spring-boot:run -Dserver.port=$2 $3
