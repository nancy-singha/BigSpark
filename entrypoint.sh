#!/bin/bash
# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements. See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License. You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

export SPARK_MASTER_PORT=7077

# run spark 
cd /usr/local/spark/bin

. "/load-spark-env.sh"

if [ "$SPARK_ROLE" == "SPARK-MASTER" ];
then
	./spark-class org.apache.spark.deploy.master.Master

elif [ "$SPARK_ROLE" == "SPARK-WORKER" ];
then
	./spark-class org.apache.spark.deploy.worker.Worker spark://`hostname`:$SPARK_MASTER_PORT
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