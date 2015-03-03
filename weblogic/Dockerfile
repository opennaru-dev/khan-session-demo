FROM ljhiyh/centos65:weblogic1213

# Maintainer
# ----------
MAINTAINER Jooho Lee <ljhiyh@gmail.com>

# Environment variables required for this build (do NOT change)
#ENV JAVA_RPM jdk-8u25-linux-x64.rpm
ENV WLS_PKG  wls1213_devzip_update1.zip
ENV ORACLE_HOME /home/jhouse/oracle
ENV WLS_HOME $ORACLE_HOME/wls12130
ENV DOMAIN_NAME weblogic-test-server
ENV BIND_IP 0.0.0.0
ENV JAVA_HOME /usr/lib/jvm/java-1.7.0-openjdk-1.7.0.65.x86_64
ENV WLS_PW jhouse1234
ENV CONFIG_JVM_ARGS -Djava.security.egd=file:/dev/./urandom
ENV ROOT_PW redhat
ENV ORACLE_PW oracle
ENV WLS_DOMAIN_PY create-wls-domain.py


# Expose Node Manager default port, and also default http/https ports for admin console
EXPOSE 5556 7001 7002

# Define default command to start bash. 
#CMD $WLS_HOME"/domains/weblogic-test-server/bin/startWebLogic.sh"
CMD ["/bin/bash"]
