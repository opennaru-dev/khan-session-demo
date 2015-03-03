. ./docker-env.sh 

for iii in $1 $2 $3

do
	if ( echo $iii | grep "\-host" &> /dev/null ) 
	then
		c_host=`echo $iii | awk -F "=" '{print $2}'`
		if [[ z$c_host == z ]]; then
			echo usage : -host=jboss1
			exit 1
		else
			HOST_NAME=$c_host
		fi
	fi
	if ( echo $iii | grep "\-ip" &> /dev/null )
	then	
		c_ip=`echo $iii | awk -F "=" '{print $2}'`
		if [[ z$c_ip == z ]]; then
			echo usage : -ip=172.17.42.20
			exit 1
		else

			IP=$c_ip
		fi
	fi
        if ( echo $iii | grep "\-cmd" &> /dev/null )
           then
                   c_cmd=`echo $iii | awk -F "=" '{print $2}'`
                   if [[ z$c_cmd == z ]]; then
                          echo usage : -cmd=/bin/bash
                          exit 1
                  else
                          CMD=$c_cmd
                  fi
          fi
done

docker run \
--name="$HOST_NAME" \
-dit -h="$HOST_NAME" \
-P \
-v ~/khan_session_demo/applications:/home/jhouse/oracle/wls12130/domains/weblogic-test-server/autodeploy \
-p 17001:7001  \
$IMAGE  $CMD
