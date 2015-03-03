#!/bin/bash
. ./demo-env.sh

#getInfo infinispan .NetworkSettings.IPAddress
#test=$(getInfo infinispan .NetworkSettings.IPAddress)
#echo $test +"TTT"
getInfo() 
{
      echo  `cat ./containers_info/$1_info.json | ./jq $2`
}

deleteBracket()
{
   json_info=$(cat ./$1_info.txt)
   len=$((${#json_info}-2))
   echo ${json_info:1:${len}} > ./containers_info/$1_info.json
   rm ./$1_info.txt
   echo "$1_info.json is saved"

}

# Create folder to store containers information
echo "# Create folder to store containers information" 
echo "============================================================================"
if [ ! -d $KHAN_HOME/containers_info ]; then
   mkdir -p $KHAN_HOME/containers_info
   echo "$KHAN_HOME/containers_info folder is created"
else
   echo " $KHAN_HOME/containers_info folder is existed." 
   echo "This folder will store container detail information."
fi
echo $LINE_BLANK


# Create a shared folder which will be used for deploying sample application
echo "# Create a shared folder which will be used for deploying sample application"
echo "============================================================================"
if [ ! -d ~/khan_session_demo/applications ]; then
   mkdir -p ~/khan_session_demo/applications
   echo "~/khan_session_demo/applications folder is created"
else 
   echo "~/khan_session_demo/applications folder is existed." 
   echo "This folder will be used for shared application folder."
fi
echo $LINE_BLANK

# Check if docker daemon is running
echo "# Check if docker daemon is running"
echo "============================================================================"
if (! ps -ef|grep "/usr/bin/docker" |grep -v 'grep' &> /dev/null  )
then
   echo "Docker is not running!!"
   echo "Trying to start docker daemon"		
   service docker start &> ./error.log

   if [ $? -eq "1" ];then
      echo "Docker is successfully started!"
   else
      echo "There are some problems to start docker up such as permissions"
      echo "Please check ./error.log"
      exit
   fi
fi

echo $LINE_BLANK
#Download jq
Processor=$(uname -p)
echo "# Checking if jq file exist.."
echo "============================================================================"
if [ ! -f ./jq ]; then
   if [ $Processor == x86_64 ]; then
      echo "64bit"
      wget http://stedolan.github.io/jq/download/linux64/jq 
   else
      echo "32bit"
      wget http://stedolan.github.io/jq/download/linux32/jq
   fi
else
   echo "jq is already downloaded"
fi
chmod +x ./jq

echo $LINE_BLANK
#Get docker images 
# - Weblogic
# - Wildfly
# - Infinispan
echo "# Pulling docker images"
echo "============================================================================"
# weblogic images
if (docker images |grep ljhiyh/centos65 |grep weblogic1213-demo)
then 
   echo "Weblogic images is exist"
else
   echo "Weblogic images is not exist. It is pulling from docker hub now..."
   docker pull ljhiyh/centos65:weblogic1213
fi

# wildfly images
if (docker images |grep ljhiyh/centos65 |grep wildfly8-demo)
then 
   echo "Wildfly images is exist"
else
   echo "Wildfly images is not exist. It is pulling from docker hub now..."
   docker pull ljhiyh/centos65:wildfly8
fi

# infinispan images
if (docker images |grep ljhiyh/centos65 |grep infinispan711-demo)
then 
   echo "Infinispan images is exist"
else
   echo "Infinispan images is not exist. It is pulling from docker hub now..."
   docker pull ljhiyh/centos65:infinispan711
fi

echo $LINE_BLANK
