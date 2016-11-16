#!/bin/bash

# This script needs to be executed from the same directory:
# ./install2repo.sh

# Set this to version of locally installed 
# package in default ~/.m2/ directory
version=2016.9-ALPHA11-SNAPSHOT
repo_id=git-OpenBankProject



user=$(whoami)
temp_repo=/tmp/obp-temp-repo-${user}/com/tesobe
rm -rf /tmp/obp-temp-repo-${user}
mkdir -p ${temp_repo}
rsync -a /home/${user}/.m2/repository/com/tesobe/ ${temp_repo}/ 

common_opts="-DrepositoryId=${repo_id} \
             -DgroupId=com.tesobe.obp \
             -DgeneratePom=true \
             -DuniqueVersion=true \
             -DupdateReleaseInfo=true \
             -Dversion=${version} \
             -Durl=file://$(pwd)"

mvn deploy:deploy-file ${common_opts} \
 -DartifactId=obp-ri-core \
 -Dfile=${temp_repo}/obp/obp-ri-core/${version}/obp-ri-core-${version}.jar

mvn deploy:deploy-file ${common_opts} \
 -DartifactId=obp-ri-transport \
 -Dfile=${temp_repo}/obp/obp-ri-transport/${version}/obp-ri-transport-${version}.jar

mvn deploy:deploy-file ${common_opts} \
 -DartifactId=obp-ri-kafka \
 -Dfile=${temp_repo}/obp/obp-ri-kafka/${version}/obp-ri-kafka-${version}.jar

