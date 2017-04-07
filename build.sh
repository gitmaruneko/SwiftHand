#!/bin/bash

# WARNING: Please assign proper contents and uncomment following four export statements.
export ADK_ROOT=/home/maruneko/Android/Sdk
export JAVA_HOME=/usr/lib/jvm/jdk1.7.0_51
export GUAVA_VERSION=17.0
export DX_VERSION=23.0.3

DOLLAR="\$"
declare -a arr=("ADK_ROOT" "JAVA_HOME" "GUAVA_VERSION" "DX_VERSION")
for varname in "${arr[@]}"
do
	eval VAR="$DOLLAR$varname"
	if [[ -z "$VAR" ]]; then
		echo "[build.sh] ERROR: \$$varname unset!" 
                exit 1;
	fi
done

IS="inst.sh"
TS="test.sh"

cd src
mvn package 
if (($? > 0)); then
	print "[build.sh] Maven build script failed"
	exit 2;
fi
cd ..

SWIFT_ROOT=$PWD

#create execution script
FRONT_END_PATH="src/front-end/target/front-end-0.1-jar-with-dependencies.jar"
KEY_PATH="src/front-end/resource/swifthand.keystore"
SHARED_PATH="src/shared/target/shared-0.1.jar"

BACK_END_PATH="src/back-end/target/back-end-0.1-jar-with-dependencies.jar"

echo "[build.sh] Generating inst.sh instrumentation script"

echo "#!/bin/bash" > $IS
echo "set -x" >> $IS
echo "export ADK_ROOT=$ADK_ROOT" >> $IS
echo "export JAVA_HOME=$JAVA_HOME" >> $IS
echo "java -jar $SWIFT_ROOT/$FRONT_END_PATH \$1 $SWIFT_ROOT/$KEY_PATH $SWIFT_ROOT/$SHARED_PATH" >> $IS
chmod 700 $IS

echo "[build.sh] Generating test.sh GUI testing script"

echo "#!/bin/bash" > $TS
echo "set -x" >> $TS
echo "export ADK_ROOT=$ADK_ROOT" >> $TS
echo "export JAVA_HOME=$JAVA_HOME" >> $TS
echo "java -jar $SWIFT_ROOT/$BACK_END_PATH \${*:1}" >> $TS
echo "if ((\$? > 0));then" >>$TS
echo "	cat USAGE" >> $TS
echo "fi" >> $TS
chmod 700 $TS
