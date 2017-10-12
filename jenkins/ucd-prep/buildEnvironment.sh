#!/bin/sh

lower=$(echo "$1" | tr '[:upper:]' '[:lower:]')
upper=$(echo "$1" | tr '[:lower:]' '[:upper:]')

echo $lower
echo $upper

udclient -username ${USERNAME} -password ${PASSWORD} -weburl ${UCD_URL} createEnvironment -application hello-world -name $1 -color $2
udclient -username ${USERNAME} -password ${PASSWORD} -weburl ${UCD_URL} setEnvironmentProperty -application hello-world -environment $1 -name "tomcat.home" -value "/usr/local/tomcat"
udclient -username ${USERNAME} -password ${PASSWORD} -weburl ${UCD_URL} setEnvironmentProperty -application hello-world -environment $1 -name "tomcat.port" -value "8080"
udclient -username ${USERNAME} -password ${PASSWORD} -weburl ${UCD_URL} setEnvironmentProperty -application hello-world -environment $1 -name "tomcat.start" -value "/usr/local/tomcat/bin/startup.sh"
udclient -username ${USERNAME} -password ${PASSWORD} -weburl ${UCD_URL} setEnvironmentProperty -application hello-world -environment $1 -name "tomcat.url" -value "http://$lower-server"
udclient -username ${USERNAME} -password ${PASSWORD} -weburl ${UCD_URL} createResource ${JENKINS_HOME}/ucd-prep/resource-$lower-service.json
udclient -username ${USERNAME} -password ${PASSWORD} -weburl ${UCD_URL} createResource ${JENKINS_HOME}/ucd-prep/resource-$lower-ui.json
udclient -username ${USERNAME} -password ${PASSWORD} -weburl ${UCD_URL} addEnvironmentBaseResource -application hello-world -environment $1 -resource "/$upper Environment/Tomcat server"



