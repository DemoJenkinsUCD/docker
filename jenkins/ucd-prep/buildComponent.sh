#!/bin/sh

id=$(udclient -username ${USERNAME} -password ${PASSWORD} -weburl ${UCD_URL} createComponent /var/jenkins_home/ucd-prep/component-$1.json | jq '.id')

echo $id

sed "s/\$componentId/$id/g" /var/jenkins_home/ucd-prep/component-process-$1.tmp > /var/jenkins_home/ucd-prep/component-process-$1.json

udclient -username ${USERNAME} -password ${PASSWORD} -weburl ${UCD_URL} createComponentProcess /var/jenkins_home/ucd-prep/component-process-$1.json
