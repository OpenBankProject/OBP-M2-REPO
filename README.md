# OBP-M2-REPO

OpenBankProject Maven Repository


Use in project
--------------

Add the GitHub repository to the POM file of the project:

      <repository>
        <id>git-OpenBankProject</id>
        <name>OpenBankProject Git based repo</name>
        <url>https://github.com/OpenBankProject/OBP-M2-REPO/master/</url>
      </repository>



Add version to properties in POM file of the project:

      <obp-ri.version>2016.11-RC1-SNAPSHOT</obp-ri.version>



Add dependencies to the POM file of the project:

      <dependency>
        <groupId>com.tesobe.obp</groupId>
        <artifactId>obp-ri-core</artifactId>
        <version>${obp-ri.version}</version>
      </dependency>
      <dependency>
        <groupId>com.tesobe.obp</groupId>
        <artifactId>obp-ri-kafka</artifactId>
        <version>${obp-ri.version}</version>
      </dependency>
      <dependency>
        <groupId>com.tesobe.obp</groupId>
        <artifactId>obp-ri-transport</artifactId>
        <version>${obp-ri.version}</version>
      </dependency>



Maintenance
-----------


Edit install2repo.sh and set correct version, which should match version 
of already installed OBP-JVM in local maven repo (~/.m2/ directory).

Execute script:

    ./install2repo.sh

Add all new files to git, commit and push to repo:

    git add -A .
    git commit -a
    git push


