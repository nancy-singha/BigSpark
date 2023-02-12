#!/bin/bash

export SPARK_MASTER_PORT=7077;

# run spark 
cd /usr/local/spark/bin

. "/load-spark-env.sh"

if [[ "SPARK_ROLE" -eq "SPARK-MASTER" ]];
then
    ./spark-class org.apache.spark.deploy.master.Master
	echo "1---master"
fi

if [[ "SPARK_ROLE" -eq "SPARK-WORKER" ]];
then
    ./spark-class org.apache.spark.deploy.worker.Worker spark://`hostname`:$SPARK_MASTER_PORT
	echo "2---worker"
fi

CMD=${1:-"exit 0"}
if [[ "$CMD" -eq "-d" ]];
then
	service sshd stop
	/usr/sbin/sshd -D -d
else
	/bin/bash -c "$*"
fi
