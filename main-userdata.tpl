#!/bin/bash

sudo hostnamectl set-hostname ${new_hostname} && 
sudo apt-get install -y apt-transport-https software-properties-common wget &&
#sudo wget --no-check-certificate -q -O /usr/share/keyrings/grafana.key https://apt.grafana.com/gpg.key &&
#sudo apt-key add gpg.key &&
sudo wget -q -O - https://packages.grafana.com/gpg.key | gpg --dearmor | sudo tee /usr/share/keyrings/grafana.gpg > /dev/null &&
#echo "deb [signed-by=/usr/share/keyrings/grafana.key] https://apt.grafana.com stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list &&
echo "deb [signed-by=/usr/share/keyrings/grafana.gpg] https://packages.grafana.com/oss/deb stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list &&
sudo apt-get -y update &&
sudo apt-get -y install grafana &&
sudo systemctl daemon-reload &&
sudo systemctl start grafana-server && 
sudo systemctl enable grafana-server.service

