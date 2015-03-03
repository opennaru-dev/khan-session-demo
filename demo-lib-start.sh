#!/bin/bash
. ./demo-common-start.sh
./demo-stop.sh
#docker run 
echo "# Running docker containers"
echo "============================================================================"

echo "Run weblogic container"
cd $KHAN_HOME/weblogic
./docker-start.sh

echo "Run wildfly container"
cd $KHAN_HOME/wildfly
./docker-start.sh

echo $LINE_BLANK
cd $KHAN_HOME
echo "waiting for start up docker containers"
#sleep 3

echo $LINE_BLANK
# Store information of each container to file
echo "# Storing each docker container information"
echo "============================================================================"

docker inspect weblogic >./weblogic_info.txt
deleteBracket weblogic

docker inspect wildfly >./wildfly_info.txt
deleteBracket wildfly


echo $LINE_BLANK
#Configure infinispan
echo "# Configuring each software for demo"
echo "============================================================================"

echo $LINE_BLANK
echo "Running weblogic..." 
docker exec weblogic /home/jhouse/oracle/wls12130/domains/weblogic-test-server/bin/startWebLogic.sh  &
#docker exec weblogic /home/jhouse/oracle/wls12130/wlserver/common/bin/wlst.sh -skipWLSModuleScanning /home/jhouse/oracle/update-wls-ip.py
#docker exec weblogic /home/jhouse/oracle/wls12130/domains/weblogic-test-server/bin/startWebLogic.sh -b $(getInfo infinispan .NetworkSettings.IPAddress)  &

echo "Running wildfly..." 
docker exec wildfly /home/jhouse/wildfly/bin/standalone.sh  -b $(getInfo wildfly .NetworkSettings.IPAddress)  &
#docker exec wildfly /home/jhouse/wildfly/bin/standalone.sh  -b $(getInfo wildfly .NetworkSettings.IPAddress)  &


#Deploy sample application
docker exec wildfly rm /home/jhouse/wildfly/standalone/deployments/.
docker exec wildfly /home/jhouse/wildfly/git/khan-session-sample/khan-session-sample1/target/session1.war /home/jhouse/wildfly/standalone/deployments/.



echo "Demo ready!!"
