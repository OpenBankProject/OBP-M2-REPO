#!/bin/bash

# Set this to version of locally installed 
# package in default ~/.m2/ directory
version=2016.9-ALPHA11-SNAPSHOT



user=$(whoami)
mvn install:install-file \
 -DgroupId=com.tesobe.obp \
 -DartifactId=obp-ri-transport \
 -Dversion=${version} \
 -Dpackaging=jar \
 -Dfile=/home/${user}/.m2/repository/com/tesobe/obp/obp-ri-transport/${version}/obp-ri-transport-${version}.jar \
 -DlocalRepositoryPath=.
mvn install:install-file \
 -DgroupId=com.tesobe.obp \
 -DartifactId=obp-ri-kafka \
 -Dversion=${version} \
 -Dpackaging=jar \
 -Dfile=/home/${user}/.m2/repository/com/tesobe/obp/obp-ri-kafka/${version}/obp-ri-kafka-${version}.jar \
 -DlocalRepositoryPath=.
