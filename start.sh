#!/bin/bash
export CATALINA_HOME=/usr/share/tomcat7
export CATALINA_BASE=/var/lib/tomcat7
LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CATALINA_HOME/lib
export LD_LIBRARY_PATH

mkdir /certs

# Set up our solr certs
if [ ! -f "/certs/solr.pem" ]; then
  openssl genrsa -out /certs/solr.key 2048 && \
  openssl req -new -x509 -key /certs/solr.key -out /certs/solr.crt -days 365 -subj "/C=US/ST=Massachusetts/L=Northampton/O=inRESONANCE/OU=iR/CN=solr" && \
  cat /certs/solr.crt /certs/solr.key > /certs/solr.pem
fi

# Start listening, lurking, waiting
incrond

# Start tomcat
/usr/share/tomcat7/bin/catalina.sh run
