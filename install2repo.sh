#!/bin/bash

# This script needs to be executed from the same directory:
# ./install2repo.sh

# Set this to version of locally installed 
# package in default ~/.m2/ directory
version=2016.9-ALPHA11-SNAPSHOT



user=$(whoami)
temp_repo=/tmp/obp-temp-repo-${user}/com/tesobe
rm -rf /tmp/obp-temp-repo-${user}
mkdir -p ${temp_repo}
rsync -a /home/${user}/.m2/repository/com/tesobe/ ${temp_repo}/ 

mvn deploy:deploy-file \
 -DgroupId=com.tesobe.obp \
 -DartifactId=obp-ri-transport \
 -Dversion=${version} \
 -DrepositoryId=git-OpenBankProject \
 -Dfile=${temp_repo}/obp/obp-ri-transport/${version}/obp-ri-transport-${version}.jar \
 -Durl=file://$(pwd)

mvn deploy:deploy-file \
 -DgroupId=com.tesobe.obp \
 -DartifactId=obp-ri-kafka \
 -Dversion=${version} \
 -DrepositoryId=git-OpenBankProject \
 -Dfile=${temp_repo}/obp/obp-ri-kafka/${version}/obp-ri-kafka-${version}.jar \
 -Durl=file://$(pwd)

