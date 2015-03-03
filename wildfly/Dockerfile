FROM ljhiyh/centos65:wildfly8

# Maintainer
# # ----------
MAINTAINER Jooho Lee <ljhiyh@gmail.com>
# Environment variables required for this build (do NOT change)

# Set the WILDFLY_SERVER_WILDFLY_HOME env variable
ENV WILDFLY_HOME /home/jhouse/wildfly
USER root
# Deploy application
RUN mkdir -p $WILDFLY_HOME/git
#ADD ./deploy-lib.sh $WILDFLY_HOME/git/
WORKDIR $WILDFLY_HOME/git
#RUN ./deploy-lib.sh

RUN git clone https://github.com/opennaru-dev/khan-counter.git && \
    git clone https://github.com/opennaru-dev/khan-session.git && \
    git clone https://github.com/opennaru-dev/khan-session-sample.git
WORKDIR $WILDFLY_HOME/git/khan-counter
RUN mvn install
WORKDIR $WILDFLY_HOME/git/khan-session 
RUN mvn install -DskipTests
WORKDIR $WILDFLY_HOME/git/khan-session-sample
RUN mvn install -DskipTests

EXPOSE 22 8080 9990 9999
CMD ["/bin/bash"]
