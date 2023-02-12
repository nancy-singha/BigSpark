#!/bin/bash
export SPARK_MASTER_PORT=7077
echo "xx------------1"
# run spark 
cd /usr/local/spark/bin

. "/load-spark-env.sh"

if [ "$SPARK_ROLE" == "SPARK-MASTER" ];
then
	./spark-class org.apache.spark.deploy.master.Master
	echo "xx-----------2----master"

elif [ "$SPARK_ROLE" == "SPARK-WORKER" ];
then
	./spark-class org.apache.spark.deploy.worker.Worker spark://`hostname`:$SPARK_MASTER_PORT
	echo "xx-----------3------worker"
else
then
	echo "Please select appropriate role. [SPARK-MASTER OR SPARK-WORKER]"
fi

CMD=${1:-"exit 0"}
if [[ "$CMD" == "-d" ]];
then
	service sshd stop
	/usr/sbin/sshd -D -d
else
	/bin/bash -c "$*"
fi
