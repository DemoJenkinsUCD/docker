#!/bin/sh

udclient -username ${USERNAME} -password ${PASSWORD} -weburl ${UCD_URL} createResource ${JENKINS_HOME}/ucd-prep/resource-$1-environment.json
udclient -username ${USERNAME} -password ${PASSWORD} -weburl ${UCD_URL} createResource ${JENKINS_HOME}/ucd-prep/resource-$1-tomcat.json
