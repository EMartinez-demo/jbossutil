#!/bin/bash
usageFunction () {
        echo "USAGE: $0 deploymentName deploy=[true|false]"
        exit 1
}

if [ "$#" -ne 2 ]; then
        usageFunction
fi

deploymentName=$1
deployUndeploy=$2

/opt/wildfly/bin/jboss-cli.sh --user=admin-wildfly --password=changeme --connect --commands="deployment-info --name=${deploymentName}"
jbossResult=$?
deployTrue=$(echo $deployUndeploy | awk -F "=" '{print $2}')
deployTrue="${deployTrue,,}"
if [[ "$deployTrue" == "true" ]] && [ $jbossResult -eq 0 ]; then
        echo "Successful deployment of ${deploymentName}."
        exit 0
fi
if [[ "$deployTrue" == "true" ]] && [ $jbossResult -eq 1 ]; then
        echo "Failed deployment of ${deploymentName}."
        exit $jbossResult
fi
if [[ "$deployTrue" == "false" ]] && [ $jbossResult -eq 1 ]; then
        echo "${deploymentName} is not currently deployed."
        exit 0
fi

usageFunction

