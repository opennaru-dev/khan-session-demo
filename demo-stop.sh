. ./demo-env.sh
echo "Stop infinispan container"
cd $KHAN_HOME/infinispan
./docker-stop.sh

echo "Stop weblogic container"
cd $KHAN_HOME/weblogic
./docker-stop.sh

echo "Stop wildfly container"
cd $KHAN_HOME/wildfly
./docker-stop.sh
