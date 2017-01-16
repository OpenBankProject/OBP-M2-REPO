#!/bin/bash

# This script needs to be executed from the same directory:
# ./install2repo.sh

# Set this to version of locally installed 
# package in default ~/.m2/ directory
version=2016.11-RC6-SNAPSHOT

repo_id=git-OpenBankProject

# Uncomment the following line for empty repo install
# NOTE - use only for freshly initialized repo
#rm -rf com/

user=$(whoami)
temp_repo=/tmp/obp-temp-repo-${user}/com/tesobe
rm -rf /tmp/obp-temp-repo-${user}
mkdir -p ${temp_repo}
rsync -a /home/${user}/.m2/repository/com/tesobe/ ${temp_repo}/ 

common_opts="-DrepositoryId=${repo_id} \
             -DgroupId=com.tesobe.obp \
             -DuniqueVersion=false \
             -DupdateReleaseInfo=true \
             -Dversion=${version} \
             -Durl=file://$(pwd)"

mvn deploy:deploy-file ${common_opts} \
 -DartifactId=obp-ri \
 -DgeneratePom=false \
 -Dfile=${temp_repo}/obp/obp-ri/${version}/obp-ri-${version}-tests.jar \
 -DpomFile=${temp_repo}/obp/obp-ri/${version}/obp-ri-${version}.pom

mvn deploy:deploy-file ${common_opts} \
 -DartifactId=obp-ri-core \
 -DgeneratePom=false \
 -Dfile=${temp_repo}/obp/obp-ri-core/${version}/obp-ri-core-${version}.jar \
 -DpomFile=${temp_repo}/obp/obp-ri-core/${version}/obp-ri-core-${version}.pom

mvn deploy:deploy-file ${common_opts} \
 -DartifactId=obp-ri-transport \
 -DgeneratePom=false \
 -Dfile=${temp_repo}/obp/obp-ri-transport/${version}/obp-ri-transport-${version}.jar \
 -DpomFile=${temp_repo}/obp/obp-ri-transport/${version}/obp-ri-transport-${version}.pom

mvn deploy:deploy-file ${common_opts} \
 -DartifactId=obp-ri-kafka \
 -DgeneratePom=false \
 -Dfile=${temp_repo}/obp/obp-ri-kafka/${version}/obp-ri-kafka-${version}.jar \
 -DpomFile=${temp_repo}/obp/obp-ri-kafka/${version}/obp-ri-kafka-${version}.pom

# This is a workaround needed because maven zipps large 
# pom.xml files and forgets to unzip them when downloaded
cd com/tesobe/obp/obp-ri/${version}
export orig=$(ls obp-ri-*.pom)
mv ${orig} ${orig}.zip 
unzip ${orig}.zip 1>/dev/null
rm -f ${orig}.zip 
mv META-INF/maven/com.tesobe.obp/obp-ri/pom.xml ${orig}
rm -rf META-INF
md5sum ${orig} | cut -d' ' -f1 > ${orig}.md5
sha1sum ${orig} | cut -d' ' -f1 > ${orig}.sha1

echo 
echo "DONE"
echo 

