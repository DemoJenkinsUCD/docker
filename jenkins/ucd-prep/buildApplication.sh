#!/bin/sh

id=$(udclient -username ${USERNAME} -password ${PASSWORD} -weburl ${UCD_URL} createApplication /var/jenkins_home/ucd-prep/application-demo.json | jq '.id')

echo $id

sed "s/\$applicationId/$id/g" /var/jenkins_home/ucd-prep/application-process-demo.tmp > /var/jenkins_home/ucd-prep/application-process-demo.json

udclient -username ${USERNAME} -password ${PASSWORD} -weburl ${UCD_URL} addComponentToApplication -application hello-world -component hello-service
udclient -username ${USERNAME} -password ${PASSWORD} -weburl ${UCD_URL} addComponentToApplication -application hello-world -component hello-ui

udclient -username ${USERNAME} -password ${PASSWORD} -weburl ${UCD_URL} createApplicationProcess /var/jenkins_home/ucd-prep/application-process-demo.json
