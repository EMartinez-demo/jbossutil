#!/bin/bash
echo "Hello let's install JBOSS"
date
echo "Update apt"
sudo apt-get update
apRes=$?
echo "apt update result $apRes"
echo "get jdk"
sudo apt-get install default-jdk
apRes=$?
echo "apt install default-jek result $apRes"
sudo groupadd -rf wildfly
apRes=$?
echo "create wildfly group result $apRes"
sudo useradd -r -g wildfly -d /opt/wildfly -s /sbin/nologin/ wildfly
apRes=$?
sudo groups wildfly
apRes=$?
echo "create wildfly user in wildfly group result $apRes"
Version_Number=16.0.0.Final
echo "Version Number to retrieve $Version_Number"
wget https://download.jboss.org/wildfly/$Version_Number/wildfly-$Version_Number.tar.gz -P /tmp
apRes=$?
echo "Download result wildfly $apRes"
sudo tar xf /tmp/wildfly-$Version_Number.tar.gz -C /opt
sudo ln -sf /opt/wildfly-$Version_Number /opt/wildfly
apRes=$?
echo "create link to wildfly with no version number $apRes"
echo "extract result $apRes"
sudo chown -RH wildfly: /opt/wildfly
apRes=$?
echo "wildfly user owns wildfly folder result $apRes"
sudo mkdir -p /etc/wildfly
apRes=$(ls /etc/wildfly)
echo "etc wildfly directory $apRes"
sudo cp /opt/wildfly/docs/contrib/scripts/systemd/wildfly.conf /etc/wildfly
apRes=$?
echo "copy config file result $apRes"
sudo cp /opt/wildfly/docs/contrib/scripts/systemd/launch.sh /opt/wildfly/bin
apRes=$?
echo "copy launch script result $apRes"
sudo sh -c 'chmod +x /opt/wildfly/bin/*.sh'
sudo cp /opt/wildfly/docs/contrib/scripts/systemd/wildfly.service /etc/systemd/system/
sudo systemctl daemon-reload
date
echo "Hello let's be done with JBOSS"

