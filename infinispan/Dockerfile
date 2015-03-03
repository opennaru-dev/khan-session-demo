# This Dockerfile is based on what jboss officially provided

FROM ljhiyh/centos65:infinispan711

# Maintainer
# ----------
MAINTAINER Jooho Lee <ljhiyh@gmail.com>

# Environment variables required for this build (do NOT change)

# Set the INFINISPAN_SERVER_HOME env variable
ENV INFINISPAN_HOME /home/jhouse/infinispan
# Set the INFINISPAN_SERVER_HOME env variable
ENV INFINISPAN_SERVER_HOME /home/jhouse/infinispan/infinispan-server
# Set the INFINISPAN_VERSION env variable
ENV INFINISPAN_VERSION 7.1.1.Final
# Set the INFINISPAN_PKG env variable
ENV INFINISPAN_PKG  infinispan-server-$INFINISPAN_VERSION-bin.zip
# Set JAVA_HOME env variable
ENV JAVA_HOME /usr/lib/jvm/java-1.7.0-openjdk-1.7.0.65.x86_64
# Set CONFIG_JVM_ARGS env variable(it is for linux bug)
ENV CONFIG_JVM_ARGS -Djava.security.egd=file:/dev/./urandom
# Set ROOT_PW env variable
ENV ROOT_PW redhat
# Set INFINISPAN_PW env variable
ENV INFINISPAN_PW infinispan
# Set INFINISPAN_CACHE_CLI env variable
ENV INFINISPAN_CACHE_CLI khan-cache-add.cli

# Expose Infinispan server ports
EXPOSE 8080 8181 9990 11211 11222
# Run Infinispan server and bind to all interface
#CMD ["bin/clustered.sh"]
CMD ["/bin/bash"]
