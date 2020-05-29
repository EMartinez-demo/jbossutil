#!/bin/bash
sudo systemctl start wildfly
sudo systemctl status wildfly
sudo systemctl enable wildfly
sudo ufw allow 8080/tcp
