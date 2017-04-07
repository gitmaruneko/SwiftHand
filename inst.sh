#!/bin/bash
set -x
export ADK_ROOT=/home/maruneko/Android/Sdk
export JAVA_HOME=/usr/lib/jvm/jdk1.7.0_51
java -jar /home/maruneko/myData/git/SwiftHand/src/front-end/target/front-end-0.1-jar-with-dependencies.jar $1 /home/maruneko/myData/git/SwiftHand/src/front-end/resource/swifthand.keystore /home/maruneko/myData/git/SwiftHand/src/shared/target/shared-0.1.jar
