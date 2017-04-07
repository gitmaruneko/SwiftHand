#!/bin/bash
set -x
export ADK_ROOT=/home/maruneko/Android/Sdk
export JAVA_HOME=/usr/lib/jvm/jdk1.7.0_51
java -jar /home/maruneko/myData/git/SwiftHand/src/back-end/target/back-end-0.1-jar-with-dependencies.jar ${*:1}
if (($? > 0));then
	cat USAGE
fi
