FROM jenkins:1.609.3

COPY src/main/docker/plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/plugins.txt

# ENV VERSION 0.4-SNAPSHOT
# COPY target/kubernetes.hpi /usr/share/jenkins/ref/plugins/kubernetes.hpi
# RUN curl -o /usr/share/jenkins/ref/plugins/kubernetes.hpi \
#  http://repo.jenkins-ci.org/snapshots/org/csanchez/jenkins/plugins/kubernetes/0.4/kubernetes-$VERSION.hpi

# remove executors in master
COPY src/main/docker/master-executors.groovy /usr/share/jenkins/ref/init.groovy.d/

# ENV JAVA_OPTS="-Djava.util.logging.config.file=/var/jenkins_home/log.properties"

# Install some additional dependencies (PHP + Arcanist)
USER root
RUN apt-get update && apt-get install -y php5 php5-cli php5-curl php5-json \
php5-mcrypt php5-sqlite php5-xdebug php5-redis \
&& git clone https://github.com/phacility/libphutil.git /opt/libphutil \
&& git clone https://github.com/phacility/arcanist.git /opt/arcanist
USER jenkins
