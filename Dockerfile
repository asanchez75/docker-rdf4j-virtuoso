FROM tomcat:8.5

# Import a RDF4J war version containing direct connection to Virtuoso 7.2.4.2 instance
# More information in https://bitbucket.org/asanchez75/rdf4j/wiki/Home
# Thanks to source code provided by yyz1989/rdf4j

MAINTAINER Adam Sanchez "a.sanchez75@gmail.com"

ENV RDF4J_VERSION="2.2"
ENV RDF4J_DATA="/opt/eclipse-rdf4j-${RDF4J_VERSION}/data"
ENV JVM_PARAMS="-Xmx4g"

RUN curl -sS -o /tmp/rdf4j-workbench.war -L https://bitbucket.org/asanchez75/rdf4j/downloads/rdf4j-workbench.war
RUN curl -sS -o /tmp/rdf4j-server.war -L https://bitbucket.org/asanchez75/rdf4j/downloads/rdf4j-server.war

RUN mv /tmp/*.war /usr/local/tomcat/webapps

RUN echo "CATALINA_OPTS=\"\$CATALINA_OPTS \$JVM_PARAMS -Dorg.eclipse.rdf4j.appdata.basedir=\$RDF4J_DATA\"" >> /usr/local/tomcat/bin/setenv.sh

VOLUME ${RDF4J_DATA}

EXPOSE 8080
