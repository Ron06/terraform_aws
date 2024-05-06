#!/bin/bash

echo "-------------------------START SETUP---------------------------"
sudo apt-get update -y &&
sudo apt-get install -y \
apt-transport-https \
ca-certificates \
curl \
gnupg-agent \
software-properties-common &&
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - &&
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" &&
sudo apt-get update -y &&
sudo apt-get install docker-ce docker-ce-cli containerd.io -y &&
sudo usermod -aG docker ubuntu
sudo chmod 666 /var/run/docker.sock

sudo newgrp docker
sudo apt-get install docker-compose-plugin
sudo systemctl enable docker.service
sudo systemctl start docker.service
cd ~

sudo mkdir airflow-docker
sudo chmod a+rwx airflow-docker
cd airflow-docker
curl -LfO 'https://airflow.apache.org/docs/apache-airflow/2.9.0/docker-compose.yaml' --output docker-compose.yaml
mkdir ./dags ./plugins ./logs
touch .env
echo -e "AIRFLOW_UID=$(id -u)\nAIRFLOW_GID=0" > .env
docker compose up airflow-init
docker compose up
