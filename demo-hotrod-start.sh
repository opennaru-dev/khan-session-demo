#!/bin/bash
. ./demo-common-start.sh

# Clear demo docker containers
 ./demo-stop.sh &> /dev/null

#docker run 
echo "# Running docker containers"
echo "============================================================================"
echo "Run infinispan container"
cd $KHAN_HOME/infinispan
./docker-start.sh

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
docker inspect infinispan >./infinispan_info.txt
deleteBracket infinispan

docker inspect weblogic >./weblogic_info.txt
deleteBracket weblogic

docker inspect wildfly >./wildfly_info.txt
deleteBracket wildfly


echo $LINE_BLANK
#Configure infinispan
echo "# Configuring each software for demo"
echo "============================================================================"
echo "Configuring infinispan..." 
docker exec infinispan /home/jhouse/infinispan/infinispan-server/bin/clustered.sh  -b $(getInfo infinispan .NetworkSettings.IPAddress)  &
sleep 10
docker exec infinispan /home/jhouse/infinispan/infinispan-server/bin/jboss-cli.sh --file=./khan-cache-add.cli -c

echo "Running Infinispan"
docker exec infinispan /home/jhouse/infinispan/infinispan-server/bin/jboss-cli.sh --command=":restart" -c &> /dev/null

echo $LINE_BLANK
echo "Running weblogic..." 
docker exec weblogic /home/jhouse/oracle/wls12130/domains/weblogic-test-server/bin/startWebLogic.sh  &
#docker exec weblogic /home/jhouse/oracle/wls12130/wlserver/common/bin/wlst.sh -skipWLSModuleScanning /home/jhouse/oracle/update-wls-ip.py
#docker exec weblogic /home/jhouse/oracle/wls12130/domains/weblogic-test-server/bin/startWebLogic.sh -b $(getInfo infinispan .NetworkSettings.IPAddress)  &

echo "Running wildfly..." 
docker exec wildfly /home/jhouse/wildfly/bin/standalone.sh  -b $(getInfo wildfly .NetworkSettings.IPAddress)  &
#docker exec wildfly /home/jhouse/wildfly/bin/standalone.sh  -b $(getInfo wildfly .NetworkSettings.IPAddress)  &

echo "Deploying application"
docker exec wildfly rm /home/jhouse/wildfly/standalone/deployments/.
docker exec wildfly /home/jhouse/wildfly/git/khan-session-sample/khan-session-hc-sample1/target/hcsession1.war /home/jhouse/wildfly/standalone/deployments/.

echo "Demo ready!!"
